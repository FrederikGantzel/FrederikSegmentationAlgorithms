\name{Frederik_Dynprog}
\alias{Frederik_Dynprog}
\title{Dynamic Programming Algorithm (C++ implementation)}
\docType{package}
\description{
Runs the dynamic programming algorithm on an input data vector, and returns the optimal cost matrix
}
\usage{
Frederik_Dynprog(input_data_vector, max_segments)
}
\arguments{
\item{input_data_vector}{the input data vector, must be purely numeric.}

\item{max_segments}{the maximum number of segments that the algorithm will calculate. Must be at least one, but less than the number of data points in the input data vector}
}
\value{
the calculated optimal cost matrix, with dimentions: number of data points x maximum segments
}
\examples{
dataset = c(1,2,3,4,5,6,7,8,9,10)
Frederik_Dynprog(dataset, 5)
}