# loading relevant packages
library(tidyverse)

# reading the data in
q1_data <- read_csv("data/Q1.csv")
q2_data <- read_csv("data/Q2.csv")
q3_data <- read_csv("data/Q3.csv")
mpr_data <- read_csv("data/MPR.csv")

# source the moving average function in R folder
source("R/moving-average.R")


# Cleaning the datasets:
# rename the sample date column
# keeping only the date and relevant ion columns
# filtering the date from the start of 1988 to the end of 1994

# q1 cleaned
clean_q1 <- q1_data |>
  mutate(Date = Sample_Date) |>
  select(Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Date >= "1988-01-01" & Date <= "1994-12-31")

# q2 cleaned
clean_q2 <- q2_data |>
  mutate(Date = Sample_Date) |>
  select(Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Date >= "1988-01-01" & Date <= "1994-12-31")

# q3 cleaned
clean_q3 <- q3_data |>
  mutate(Date = Sample_Date) |>
  select(Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Date >= "1988-01-01" & Date <= "1994-12-31")

# mpr cleaned
clean_mpr <- mpr_data |>
  mutate(Date = Sample_Date) |>
  select(Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Date >= "1988-01-01" & Date <= "1994-12-31")


# Calculate the 9 week moving average for each cleaned dataset
q1_ma <- moving_average("BQ1", clean_q1)
q2_ma <- moving_average("BQ2", clean_q2)
q3_ma <- moving_average("BQ3", clean_q3)
mpr_ma <- moving_average("PRM", clean_mpr)


# Combining and pivoting the moving averages of the cleaned datasets
final_df <- bind_rows(q1_ma, q2_ma, q3_ma, mpr_ma)

pivoted_final <- pivot_longer(
  final_df,
  cols = k_mgl:no3n_mgl,
  names_to = "Ions",
  values_to = "Concentration"
)


# Create a new csv to reference in paper qmd
write_csv(pivoted_final, "output/cleaned_data.csv")
