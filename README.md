# FrederikSegmentationAlgorithms
Segmentation algorithms for CS599 "Unsipervised Learning" R package project 2, NAU, Fall semester 2021

## Installation
run the following R commands:
if(!requireNamespace("remotes"))install.packages("remotes")
remotes::install_github("FrederikGantzel/FrederikSegmentationAlgorithms")

## Usage
Provides two different segmentation algorithms.

Frederik_Binseg is a binary segmentation algorithm that takes a numeric data vector, the maximum number of segments as input, and outputs a vector that contains the loss values for model sizes form 1 up to the maximum number of segments. Some example code:

data_set = iris[,2]

Frederik_Binseg(data_set, 5)


Frederik_Dynprog (C++ version) and Rcpp_Dynprog (Rcpp version) are two versions of the same Dynamic Programming algorithm. It takes a numeric data vector, the maximum number of segments as input, and outputs the optimal cost matrix used in this algorithm. Some example code:

data_set = iris[,2]

Rcpp_Dynprog(data_set, 5)

Frederik_Dynprog(data_set, 5)
