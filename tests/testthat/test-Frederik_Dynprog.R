library(testthat)
library(FrederikSegmentationAlgorithms)

context("Frederik_Dynprog")

test_that("Frederik_Dynprog outputs a cost matrix with the correct values",
          {max_segs = 5
          dataset = sample(rep(1:2, l=nrow(iris)))
          N = length(dataset)
          mine = Frederik_Dynprog(dataset, max_segs)
          professors = jointseg::Fpsn(dataset, max_segs)$allCost
          my_results = mine[N,] + sum(dataset^2)
          professors_results = professors[,N]
          expect_equal(my_results, professors_results)
          })

test_that("Frederik_Dynprog does not accept bad input",
          {max_segs = 10
          dataset = c(1,2,3,4,5)
          expect_error(
            Frederik_Dynprog(dataset, max_segs),
            "max segments must not be greater than the number of input data points")
          })

