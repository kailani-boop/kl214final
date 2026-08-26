library(tidyverse)

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


for (i in 1:nrow(q1_smoothed)) {
  start_date <- q1_smoothed$window_start[i]
  end_date <- q1_smoothed$window_start[i] + weeks(9)

  k_ranges <- clean_q1$K[
    clean_q1$Date >= start_date &
      clean_q1$Date < end_date
  ]

  mg_ranges <- clean_q1$Mg[
    clean_q1$Date >= start_date &
      clean_q1$Date < end_date
  ]

  ca_ranges <- clean_q1$Ca[
    clean_q1$Date >= start_date &
      clean_q1$Date < end_date
  ]

  nh4n_ranges <- clean_q1$`NH4-N`[
    clean_q1$Date >= start_date &
      clean_q1$Date < end_date
  ]

  no3n_ranges <- clean_q1$`NO3-N`[
    clean_q1$Date >= start_date &
      clean_q1$Date < end_date
  ]

  q1_smoothed$K[i] <- mean(k_ranges, na.rm = TRUE)
  q1_smoothed$Mg[i] <- mean(mg_ranges, na.rm = TRUE)
  q1_smoothed$Ca[i] <- mean(ca_ranges, na.rm = TRUE)
  q1_smoothed$`NH4-N`[i] <- mean(nh4n_ranges, na.rm = TRUE)
  q1_smoothed$`NO3-N`[i] <- mean(no3n_ranges, na.rm = TRUE)
}
q1_smoothed


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
