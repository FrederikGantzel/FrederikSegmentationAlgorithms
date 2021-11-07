
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List rcpp_hello_world() {

    CharacterVector x = CharacterVector::create( "h", "i" )  ;
    NumericVector y   = NumericVector::create( 0.0, 1.0 ) ;
    CharacterVector lag = CharacterVector::create("skyd mig");
    List z            = List::create( x, y, lag ) ;

    return z ;
}
