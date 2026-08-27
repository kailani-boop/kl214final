library(tidyverse)
source("R/moving-average.R")

q1_data <- read_csv("Q1.csv")
q2_data <- read_csv("Q2.csv")
q3_data <- read_csv("Q3.csv")
mpr_data <- read_csv("MPR.csv")


# Cleaned Datasets -------------------------------------------------------

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

moving_average(clean_q1)
moving_average(clean_q2)
moving_average(clean_q3)
moving_average(clean_mpr)

# Plots ------------------------------------------------------------------

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
