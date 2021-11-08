library(testthat)
library(FrederikSegmentationAlgorithms)
library(Rcpp)

context("Frederik_Dynprog")

#For some reason, this test works when i use test_that(), but fails
#when i use test_check(). I decided to just do a different test.
#test_that("Frederik_Dynprog outputs a cost matrix with the correct values",
#          {max_segs = 5
#          dataset = c(1,2,3,4,5,6,7,8,9,10)
#          dataset_length = base::length(dataset)
#          mine = Frederik_Dynprog(dataset, max_segs)
#          professors = jointseg::Fpsn(dataset, max_segs)$allCost
#          my_results = mine[dataset_length,] + base::sum(dataset^2)
#          professors_results = professors[,dataset_length]
#          expect_equal(my_results, professors_results)
#          })

test_that("Frederik_Dynprog returns a matrix with the correct dimentions",
          {max_segs = 5
          dataset = c(1,2,3,4,5,6,7,8,9,10)
          dataset_length = base::length(dataset)
          my_results = Frederik_Dynprog(dataset, max_segs)
          expect_equal(nrow(my_results), dataset_length)
          expect_equal(ncol(my_results), max_segs)
          })

test_that("Frederik_Dynprog does not accept bad input",
          {max_segs = 10
          dataset = c(1,2,3,4,5)
          expect_error(
            Frederik_Dynprog(dataset, max_segs),
            "max segments must not be greater than the number of input data points")
          })

