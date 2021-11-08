library(testthat)
library(FrederikSegmentationAlgorithms)

context("Rcpp_Dynprog")

test_that("Rcpp_Dynprog outputs a cost matrix with the correct values",
          {max_segs = 5
          dataset = sample(rep(1:2, l=nrow(iris)))
          N = length(dataset)
          mine = Rcpp_Dynprog(dataset, max_segs)
          professors = jointseg::Fpsn(dataset, max_segs)$allCost
          my_results = mine[N,] + sum(dataset^2)
          professors_results = professors[,N]
          expect_equal(my_results, professors_results)
          })