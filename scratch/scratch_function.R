# load in necessary packages & files
library(tidyverse)
# source my function in the R folder
source("R/moving-average.R")

# read in the data
q1_data <- read_csv("data/Q1.csv")
q2_data <- read_csv("data/Q2.csv")
q3_data <- read_csv("data/Q3.csv")
mpr_data <- read_csv("data/MPR.csv")


# Cleaned Datasets -------------------------------------------------------
# changing sample_date variable to date
# only using the columns with the date and ion types
# only using the dates from 1988 to the end of 1994

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


# Moving Averages --------------------------------------------------------
# calling function that was sourced earlier
q1_ma <- moving_average("BQ1", clean_q1)
q2_ma <- moving_average("BQ2", clean_q2)
q3_ma <- moving_average("BQ3", clean_q3)
mpr_ma <- moving_average("PRM", clean_mpr)


# Plots ------------------------------------------------------------------
# pivoting each moving average dataframe
# plotting it, faceting to arrange the ions, & adding labels

# plot 1
moving_average(clean_q1) |>
  pivot_longer(
    cols = !window_start,
    names_to = "Ions",
    values_to = "Concentration"
  ) |>
  ggplot(
    q1_smoothed,
    mapping = aes(
      x = window_start,
      y = Concentration,
      color = Ions
    )
  ) +
  geom_line() +
  facet_wrap(~Ions, scales = "free", ncol = 1) +
  labs(
    title = "Concentrations of Various Ions Q1",
    x = "Year",
    y = "Concentration"
  )


# plot 2
moving_average(clean_q2) |>
  pivot_longer(
    cols = !window_start,
    names_to = "Ions",
    values_to = "Concentration"
  ) |>
  ggplot(
    q1_smoothed,
    mapping = aes(
      x = window_start,
      y = Concentration,
      color = Ions
    )
  ) +
  geom_line() +
  facet_wrap(~Ions, scales = "free", ncol = 1) +
  labs(
    title = "Concentrations of Various Ions Q2",
    x = "Year",
    y = "Concentration"
  )


# plot 3
moving_average(clean_q3) |>
  pivot_longer(
    cols = !window_start,
    names_to = "Ions",
    values_to = "Concentration"
  ) |>
  ggplot(
    q1_smoothed,
    mapping = aes(
      x = window_start,
      y = Concentration,
      color = Ions
    )
  ) +
  geom_line() +
  facet_wrap(~Ions, scales = "free", ncol = 1) +
  labs(
    title = "Concentrations of Various Ions Q3",
    x = "Year",
    y = "Concentration"
  )


# plot 4
moving_average(clean_mpr) |>
  pivot_longer(
    cols = !window_start,
    names_to = "Ions",
    values_to = "Concentration"
  ) |>
  ggplot(
    q1_smoothed,
    mapping = aes(
      x = window_start,
      y = Concentration,
      color = Ions
    )
  ) +
  geom_line() +
  facet_wrap(~Ions, scales = "free", ncol = 1) +
  labs(
    title = "Concentrations of Various Ions MPR",
    x = "Year",
    y = "Concentration"
  )


# Joining ----------------------------------------------------------------
# bind the cleaned moving averages of each dataset into one dataframe
final_df <- bind_rows(q1_ma, q2_ma, q3_ma, mpr_ma)

# pivot the dataframe
pivoted_final <- pivot_longer(
  final_df,
  cols = k_mgl:no3n_mgl,
  names_to = "Ions",
  values_to = "Concentration"
)

# plot the final dataframe
# adding more things to polish the graph compared to earlier ones
ggplot(
  pivoted_final,
  mapping = aes(
    x = window_start,
    y = Concentration,
    color = site
  )
) +
  geom_line() +
  theme_bw() +
  labs(
    title = "Concentrations of Various Ions Based on Watershed from 1988 to 1994",
    x = "Years",
    y = "Concentration",
    caption = "Concentrations in Bisley, Puerto Rico streams before and after Hurricane Hugo, 9-wk 
    moving averages. (a) calcium, (b) potassium, (c) magnesium, (d) ammonium-N and (e) nitrate-N. 
    The vertical lines mark the time of hurricane disturbance."
  ) +
  facet_wrap(
    ~Ions,
    scales = "free",
    ncol = 1,
    strip.position = "left",
    labeller = as_labeller(c(
      ca_mgl = "Ca mg l^-1",
      k_mgl = "K mg l^-1",
      mg_mgl = "Mg mg l^-1",
      nh4n_mgl = "NH_4-N ug l^-1",
      no3n_mgl = "NO_3-N ug l^-1"
    ))
  ) +
  geom_vline(xintercept = ymd("1989-09-18"), linetype = "dashed") +
  theme(
    plot.caption = element_text(hjust = 0),
    plot.caption.position = "plot"
  )
