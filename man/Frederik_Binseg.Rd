\name{Frederik_Binseg}
\alias{Frederik_Binseg}
\title{Binary Segmentation Algorithm}
\docType{package}
\description{
Runs the binary segmentation algorithm on an input data vector, and returns loss values for each model size
}
\usage{
Frederik_Binseg(vector_with_data, max_segments)	
}
\arguments{
\item{vector_with_data}{the input data vector, must be purely numeric.}

\item{max_segments}{the maximum number of segments that the algorithm will calculate. Must be at least one, but less than the number of data points in the input data vector}
}
\value{
a vector with length max_segments, that contains the loss values for model sizes form 1 up to max_segments
}
\examples{
dataset = c(1,2,3,4,5,6,7,8,9,10)
Frederik_Binseg(dataset, 5)
}