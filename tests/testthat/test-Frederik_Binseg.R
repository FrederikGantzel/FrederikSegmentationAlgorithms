library(testthat)
library(FrederikSegmentationAlgorithms)

context("Frederik_Binseg")

test_that("Frederik_Binseg outputs costs vector with the correct values",
          {max_segs = 5
          dataset = sample(rep(1:2, l=nrow(iris)))
          my_results = Frederik_Binseg(dataset, max_segs)
          professors_results = binsegRcpp::binseg_normal(dataset, max_segs)$loss
          expect_equal(my_results, professors_results)
          })