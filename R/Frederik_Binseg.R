
Frederik_Binseg = function(vector_with_data, max_segments) {
  
  library("data.table")
  
  input_data_length = length(vector_with_data)
  whole_loss =  Binseg_loss_function(sum(vector_with_data^2),
                     sum(vector_with_data),
                     input_data_length)
  
  #data frame to keep track of segments. Initialized as containing
  #only one segments, that is, the entire dataset
  segments = data.frame(seg_start = 1,
                        seg_end = input_data_length,
                        seg_loss = whole_loss,
                        cut_loss_dec = NA,
                        optimal_cut_loc = NA,
                        left_seg_loss = NA,
                        right_seg_loss = NA)
  
  Square_loss_vals = vector()
  
  for (cutnr in 1:max_segments) {
    
    Square_loss_vals[cutnr] = whole_loss
    
    #check if we have not calculated optimal cut location for any segments
    for (segment_nr in 1:cutnr) {
      #if so, calculate optimal cut location and square loss for that location
      if (is.na(segments[segment_nr, "optimal_cut_loc"])) {
        this_segment = data.table(logratio = vector_with_data[
          segments[segment_nr, "seg_start"]:segments[segment_nr, "seg_end"]])
        seg_length = nrow(this_segment)
        if(seg_length < 2) {
          #can't split this
          segments[segment_nr, "cut_loss_dec"] = 0
        }
        else {
          
          this_segment[, cumul_data := cumsum(logratio)]
          
          possible_cuts = data.table(
            first_seg_end = seq(1, seg_length-1))
          
          this_segment[, cumul_square := cumsum(logratio^2)]
          possible_cuts[, first_seg_loss := {
            this_segment[
              first_seg_end,
              Binseg_loss_function(cumul_square, cumul_data, first_seg_end)
            ]  
          }]
          
          possible_cuts[, cumul_data_after := {
            this_segment[.N, cumul_data] - this_segment[first_seg_end, cumul_data]
          }]
          
          possible_cuts[, cumul_square_after := {
            this_segment[.N, cumul_square]-
              this_segment[first_seg_end, cumul_square]
          }]
          
          possible_cuts[, data_points_after := nrow(this_segment) - first_seg_end]
          
          possible_cuts[, second_seg_loss := {
            Binseg_loss_function(cumul_square_after, cumul_data_after, data_points_after)
          }]
          
          possible_cuts[, decreases := {
            segments[segment_nr, "seg_loss"] - (first_seg_loss + second_seg_loss)
          }]
          
          
          largest_dec = which.max(possible_cuts$decreases)
          segments[segment_nr, "left_seg_loss"] =
            possible_cuts$first_seg_loss[largest_dec]
          segments[segment_nr, "right_seg_loss"] =
            possible_cuts$second_seg_loss[largest_dec]
          segments[segment_nr, "cut_loss_dec"] =
            possible_cuts$decreases[largest_dec]
          segments[segment_nr, "optimal_cut_loc"] =
            largest_dec + segments[segment_nr, "seg_start"] - 1
        }
        
      }
    }
    
    segment_to_cut = which.max(segments$cut_loss_dec)
    old_start = segments[segment_to_cut, "seg_start"]
    old_end = segments[segment_to_cut, "seg_end"]
    cut_here = segments[segment_to_cut, "optimal_cut_loc"]
    left_seg_loss = segments[segment_to_cut, "left_seg_loss"]
    right_seg_loss = segments[segment_to_cut, "right_seg_loss"]
    whole_loss = whole_loss -
      segments[segment_to_cut, "cut_loss_dec"]
    
    segments[segment_to_cut, ] = c(old_start, cut_here, left_seg_loss,
                                   NA, NA, NA, NA)
    segments[cutnr+1, ] = c(cut_here+1, old_end, right_seg_loss,
                            NA, NA, NA, NA)
  }
  
  return(Square_loss_vals)
  
}