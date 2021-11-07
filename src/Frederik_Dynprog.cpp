
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector Frederik_Dynprog() {

    CharacterVector not_ready = CharacterVector::create( 
      "I haven't really worked on this yet, sorry\n" );

    return not_ready ;
}
