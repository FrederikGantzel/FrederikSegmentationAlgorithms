#include "Frederik_Dynprog.h"

// [[Rcpp::export]]
NumericMatrix Frederik_Dynprog
  (NumericVector input_data_vector,
   int max_segments) {
  
  int n_data_points = input_data_vector.length();
  
  NumericMatrix cost_matrix( n_data_points, max_segments);
  std::fill(cost_matrix.begin(), //fill with NA's
            cost_matrix.end(),
            NumericVector::get_na());
  
  int status_code = normal_cpp_dynprog(
    &input_data_vector[0],
    n_data_points,
    max_segments,
    &cost_matrix[0]);
  
  if (status_code == ERROR_DATA_VECTOR_MUST_CONTAIN_AT_LEAST_ONE_DATA_POINT) {
    stop("input data vector must contain at least one data point");
  }
  if (status_code == ERROR_MAX_SEGMENTS_MUST_BE_GREATER_THAN_ZERO) {
    stop("max segments must be greater than 0");
  }
  if (status_code == ERROR_MAX_SEGMENTS_MUST_NOT_BE_GREATER_THAN_NDATA) {
    stop("max segments must not be greater than the number of input data points");
  }
  
  return cost_matrix;
  
}
