
Binseg_loss_function = function(dat_sum_squares, dat_sum, data_points_length){
  return(dat_sum_squares - (dat_sum^2 / data_points_length))
}