
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector Frederik_Dynprog
  (NumericVector input_data_vector,
   int max_segments) {

    CharacterVector not_ready = CharacterVector::create( 
      "I haven't really worked on this yet, sorry\n" );

    return not_ready ;
}
