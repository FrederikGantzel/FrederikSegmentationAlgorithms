
#include <Rcpp.h>
using namespace Rcpp;

NumericVector cumul_sum(NumericVector x);
NumericVector cost_func(NumericVector cumsum_vec, NumericVector position_vec);
int which_minimum(NumericVector x);
  

// [[Rcpp::export]]
NumericMatrix Rcpp_Dynprog
  (NumericVector input_data_vector,
   int max_segments) {

  int n_data = input_data_vector.length();
  
  NumericMatrix cost_mat( n_data, max_segments);
  std::fill(cost_mat.begin(), //fill with NA's
            cost_mat.end(),
            NumericVector::get_na());
  NumericVector cumsum(cumul_sum(input_data_vector));
  NumericVector loc(n_data);
  std::iota(loc.begin(), loc.end(),1);
  
  cost_mat(_,0)= cost_func(cumsum, loc);
  
  for(int i=1; i<max_segments; i++){
    int prev_i = i-1;
    for (int ii = i; ii<n_data; ii++){
      int size = (ii-i)+1;
      NumericVector pos_last_end(size);
      
      std::iota(pos_last_end.begin(), pos_last_end.end(), prev_i);
      Rcout << pos_last_end << "\n";
      
      NumericVector all_prev_costs(size);
      for(int iii=0; iii<size; iii++) {
        all_prev_costs[iii] = cost_mat(pos_last_end[iii],prev_i);
      }
      
      NumericVector rev_pos_last_end(size);
      std::iota(rev_pos_last_end.begin(), rev_pos_last_end.end(),1);  // might  be prev_i instead of ii
      std::reverse(rev_pos_last_end.begin(), rev_pos_last_end.end());
      
      NumericVector last_seg_sums(size);
      
      for (int iii = 0; iii< size; iii++){
        last_seg_sums[iii] = cumsum[ii] - cumsum[pos_last_end[iii]];
      }
      
      NumericVector last_costs = cost_func(last_seg_sums, rev_pos_last_end);
      
      NumericVector tot_cost(size);
      for (int iii = 0; iii< size; iii++){
        tot_cost[iii] = all_prev_costs[iii] + last_costs[iii];
      }
      
      int best_option = which_minimum(tot_cost);  // index of minimum val

      cost_mat(ii,i)= tot_cost[best_option] ;
      
    }
  }
  
  return cost_mat;
}

NumericVector cumul_sum(NumericVector x){
  // initialize an accumulator variable
  double acc = 0;
  
  // initialize the result vector
  NumericVector res(x.size());
  
  for(int i = 0; i < x.size(); i++){
    acc += x[i];
    res[i] = acc;
  }
  return res;
}

NumericVector cost_func(NumericVector cumsum_vec, NumericVector position_vec){
  NumericVector Cost_vec(cumsum_vec.length());
  for(int i; i<cumsum_vec.length(); i++){
    Cost_vec[i]= (-1*pow(cumsum_vec[i],2))/position_vec[i];
  }
  return Cost_vec;
}

int which_minimum(NumericVector x){
  NumericVector::iterator it = std::min_element(x.begin(),x.end());
  return it - x.begin();
}
