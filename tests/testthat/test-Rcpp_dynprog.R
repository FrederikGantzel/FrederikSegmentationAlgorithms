library(testthat)
library(FrederikSegmentationAlgorithms)
if(!require("jointseg")) {
  install.packages("jointseg")
}
library(jointseg)

context("Rcpp_Dynprog")

test_that("Rcpp_Dynprog outputs a cost matrix with the correct values",
          { max_segs = 5
          dataset = sample(rep(1:2, l=nrow(iris)))
          N = length(dataset)
          my_results = Rcpp_Dynprog(dataset, max_segs)
          professors_results = Fpsn(dataset, max_segs)$allCost
          expect_equal(my_results[N,] + sum(dataset^2),
                       professors_results[,N])
          })