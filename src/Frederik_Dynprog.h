#include <Rcpp.h>
using namespace Rcpp;

#define ERROR_MAX_SEGMENTS_MUST_NOT_BE_LESS_THAN_ZERO 1

CharacterVector Frederik_Dynprog
  (NumericVector input_data_vector,
   int max_segments);