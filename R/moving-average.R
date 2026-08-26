# The input to this function should be a data frame containing stream chemistry data
moving_average <- function(ma) {
  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks"),
    k_mgl = NA,
    mg_mgl = NA,
    ca_mgl = NA,
    nh4n_mgl = NA,
    no3n_mgl = NA
    # Fill in the rest of the ions
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- result$window_start[i] + weeks(9)

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- w1 <= ma$Date & w2 > ma$Date

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- ma$K[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

    mg_window <- ma$Mg[in_window]
    ca_window <- ma$Ca[in_window]
    nh4n_window <- ma$`NH4-N`[in_window]
    no3n_window <- ma$`NO3-N`[in_window]

    # Calculate the mean of each ion concentration and fill in the result
    result$k_mgl[i] <- mean(k_window, na.rm = TRUE)
    result$mg_mgl[i] <- mean(mg_window, na.rm = TRUE)
    result$ca_mgl[i] <- mean(ca_window, na.rm = TRUE)
    result$nh4n_mgl[i] <- mean(nh4n_window, na.rm = TRUE)
    result$no3n_mgl[i] <- mean(no3n_window, na.rm = TRUE)
  }

  # Return the result
  return(result)
}
