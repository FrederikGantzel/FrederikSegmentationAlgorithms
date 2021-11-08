#include "Frederik_Dynprog.h"

int Frederik_Dynprog(
  const double *data_input_vector, //the input data
  const int n_data_points, //number of data points
  const int max_segments, //maximum segments
  //↑inputs ↓outputs
  double *cost_matrix //the matrix with the costs
) {
  
  if (n_data_points < 1) {
    return ERROR_DATA_VECTOR_MUST_CONTAIN_AT_LEAST_ONE_DATA_POINT;
  }
  if (max_segments < 0) {
    return ERROR_MAX_SEGMENTS_MUST_NOT_BE_LESS_THAN_ZERO;
  }
  
  double cumul_sums_vec[n_data_points];
  cumul_sum(cumul_sums_vec, data_input_vector, n_data_points);
  
  int one_to_ndata_seq[n_data_points];
  seq_from_to(one_to_ndata_seq, 1, n_data_points);
  
  double first_col_cost[n_data_points];
  cost_func(first_col_cost, cumul_sums_vec, one_to_ndata_seq, n_data_points);
  
  for (int i=0; i<n_data_points; i++) {
    cost_matrix[i] = first_col_cost[i];
  }
  
  for (int col=1; col<max_segments; col++) {
    int prev_col = col-1;
    for (int row=col; row<n_data_points; row++) {
      int size = (row-col)+1;
      int poss_last_ends[size];
      seq_from_to(poss_last_ends, prev_col, row);
      
      double all_prev_costs[size];
      for(int i=0; i<size; i++) {
        all_prev_costs[i] = cost_matrix[poss_last_ends[i] + (n_data_points*prev_col)];
      }
      
      int last_segs[size];
      seq_from_to(last_segs, size, 1);
      
      double sums_of_last_seg[size];
      for(int i=0; i<size; i++) {
        sums_of_last_seg[i] = cumul_sums_vec[row] - cumul_sums_vec[poss_last_ends[i]];
      }
      
      double last_costs[size];
      cost_func(last_costs, sums_of_last_seg, last_segs, size);
      
      double total_cost[size];
      for(int i=0; i<size; i++) {
        total_cost[i] = all_prev_costs[i] + last_costs[i];
      }
      
      int best_pick = which_minimum(total_cost, size);
      
      cost_matrix[row + (n_data_points*col)]= total_cost[best_pick];
    }
  }
  
  
  return 0;
}

void cumul_sum(double * result_vector, const double* vector_to_add, int length) {
  result_vector[0] = vector_to_add[0];
  
  for (int i=1; i<length; i++) {
    result_vector[i] = result_vector[i-1] + vector_to_add[i];
  }
}

void seq_from_to(int * result_vector, int from, int to) {
  if (from < to) {
    for (int i=0; i<(to-from)+1; i++) {
      result_vector[i] = from + i;
    }
  }
  else {
    for (int i=0; i<(from-to)+1; i++) {
      result_vector[i] = from - i;
    }
  }
}

void cost_func(double * result_vec, double * cumsum_vec, int * position_vec, int length){
  for(int i; i<length; i++){
    result_vec[i]= (-1*cumsum_vec[i]*cumsum_vec[i])/position_vec[i];
  }
}

int which_minimum(double * search_vector, int size){
  int min_spot = 0;
  
  for (int i=1; i<size; i++) {
    if (search_vector[i] < search_vector[min_spot]) {
      min_spot = i;
    }
  }
  
  return min_spot;
}

