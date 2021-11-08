library(testthat)
library(FrederikSegmentationAlgorithms)
if(!require("jointseg")) {
  install.packages("jointseg")
}
library(jointseg)

context("Frederik_Dynprog")

test_that("Frederik_Dynprog outputs a cost matrix with the correct values",
          {max_segs = 5
          dataset = sample(rep(1:2, l=nrow(iris)))
          N = length(dataset)
          my_results = Frederik_Dynprog(dataset, max_segs)
          professors_results = Fpsn(dataset, max_segs)$allCost
          expect_equal(my_results[N,] + sum(dataset^2),
                       professors_results[,N])
          })

test_that("Frederik_Dynprog does not accept bad input",
          {max_segs = 10
          dataset = c(1,2,3,4,5)
          expect_error(
            Frederik_Dynprog(dataset, max_segs),
            "max segments must not be greater than the number of input data points")
          })

