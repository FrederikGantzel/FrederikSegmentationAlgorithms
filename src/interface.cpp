#include "Frederik_Dynprog.h"

// [[Rcpp::export]]
NumericMatrix Frederik_Dynprog_interface
  (NumericVector input_data_vector,
   int max_segments) {
  
  int n_data_points = input_data_vector.length();
  
  NumericMatrix cost_matrix( n_data_points, max_segments);
  std::fill(cost_matrix.begin(), //fill with NA's
            cost_matrix.end(),
            NumericVector::get_na());
  
  int status_code = Frederik_Dynprog(
    &input_data_vector[0],
    n_data_points,
    max_segments,
    &cost_matrix[0]);
  
  return cost_matrix;
  
}
