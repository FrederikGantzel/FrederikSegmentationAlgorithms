#' Binary Segmentation Loss Function
#'
#' Computes the loss value used for the Binary Segmentation function
#'
#' @param dat_sum_squares the squared sum of all data points
#' @param dat_sum the sum of all data points
#' @param data_points_length number of data points
#' @return the loss value
#' @export
#' @examples
#' ex_vec = c(1,2,3,4,5)
#' Binseg_loss_function(
#' sum(ex_vec^2),
#' sum(ex_vec),
#' length(ex_vec))

Binseg_loss_function = function(dat_sum_squares, dat_sum, data_points_length){
  return(dat_sum_squares - (dat_sum^2 / data_points_length))
}