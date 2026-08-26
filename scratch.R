library(tidyverse)
source("R/moving-average.R")

q1_data <- read_csv("Q1.csv")
q2_data <- read_csv("Q2.csv")
q3_data <- read_csv("Q3.csv")
mpr_data <- read_csv("MPR.csv")


# Q1 code ----------------------------------------------------------------

# ions <- c(`NH4-N`, `Ca`, `Mg`, `NO3-N`, `K`)
window_start <- seq(ymd("1988-01-01"), ymd("1994-12-31"), by = "9 weeks")

clean_q1 <- q1_data |>
  mutate(Date = Sample_Date) |>
  select(Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Date >= "1988-01-01" & Date <= "1994-12-31")


K <- NA
Mg <- NA
Ca <- NA
`NH4-N` <- NA
`NO3-N` <- NA

q1_smoothed <- tibble(
  window_start,
  K,
  Mg,
  Ca,
  `NH4-N`,
  `NO3-N`
)


source("R/moving-average.R")
moving_average(clean_q1)


q1_smoothed |>
  pivot_longer(
    cols = !window_start,
    names_to = "Ions",
    values_to = "Concentration"
  ) |>
  ggplot(
    q1_smoothed,
    mapping = aes(
      x = window_start,
      y = log(Concentration)
    )
  ) +
  geom_line() +
  facet_wrap(~Ions) +
  labs(
    title = "Concentrations of Various Ions",
    x = "Year",
    y = "Log Transformation of Conc."
  )


# Q2 code ----------------------------------------------------------------

clean_q2 <- q2_data |>
  mutate(Year = year(Sample_Date)) |>
  select(Year, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Year >= 1988 & Year <= 1994) |>
  pivot_longer(
    cols = !Year,
    names_to = "Ions",
    values_to = "Units"
  )

ggplot(
  clean_q2,
  mapping = aes(
    x = Year,
    y = Units
  )
) +
  geom_point() +
  facet_wrap(~Ions)


# Q3 code ----------------------------------------------------------------

clean_q3 <- q3_data |>
  mutate(Year = year(Sample_Date)) |>
  select(Year, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Year >= 1988 & Year <= 1994) |>
  pivot_longer(
    cols = !Year,
    names_to = "Ions",
    values_to = "Units"
  )


# MPR code ---------------------------------------------------------------

clean_mpr <- mpr_data |>
  mutate(Year = year(Sample_Date)) |>
  select(Year, `NH4-N`, Ca, Mg, `NO3-N`, K) |>
  filter(Year >= 1988 & Year <= 1994) |>
  pivot_longer(
    cols = !Year,
    names_to = "Ions",
    values_to = "Units"
  )

# Joining ----------------------------------------------------------------

moving_average(clean_q1)
