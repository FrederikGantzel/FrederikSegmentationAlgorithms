#include <Rcpp.h>
using namespace Rcpp;

#define ERROR_DATA_VECTOR_MUST_CONTAIN_AT_LEAST_ONE_DATA_POINT 1
#define ERROR_MAX_SEGMENTS_MUST_BE_GREATER_THAN_ZERO 2
#define ERROR_MAX_SEGMENTS_MUST_NOT_BE_GREATER_THAN_NDATA 3

void cumul_sum(double * result_vector, const double* vector_to_add, int length);
int which_minimum(double * search_vector, int size);
void seq_from_to(int * result_vector, int from, int to);
void cost_func(double * result_vec, double * cumsum_vec, int * position_vec, int length);


int normal_cpp_dynprog(
    const double *data_input_vector, //the input data
    const int n_data_points, //number of data points
    const int max_segments, //maximum segments
    //↑inputs ↓outputs
    double *cost_matrix //the matrix with the costs
);