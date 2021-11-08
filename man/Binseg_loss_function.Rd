\name{Binseg_loss_function}
\alias{Binseg_loss_function}
\title{Binary Segmentation Loss Function}
\docType{package}
\description{
Computes the loss value used for the Binary Segmentation function
}
\usage{
Binseg_loss_function(dat_sum_squares, dat_sum, data_points_length)	
}
\arguments{
\item{dat_sum_squares}{the squared sum of all data points}

\item{dat_sum}{the sum of all data points}

\item{data_points_length}{number of data points}
}
\value{
the loss value
}
\examples{
ex_vec = c(1,2,3,4,5)
Binseg_loss_function(
sum(ex_vec^2),
sum(ex_vec),
length(ex_vec))
}