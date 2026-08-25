library(tidyverse)

q1_data <- read_csv("Q1.csv")
q2_data <- read_csv("Q2.csv")
q3_data <- read_csv("Q3.csv")
mpr_data <- read_csv("MPR.csv")



# Q1 code ----------------------------------------------------------------


# ions <- c(`NH4-N`, `Ca`, `Mg`, `NO3-N`, `K`)
years <- 1988:1994
year(q1_data$Sample_Date)


clean_q1 <- q1_data |> 
  mutate(Sample_Date = year(Sample_Date)) |> 
  filter(Sample_Date >= 1988 & Sample_Date <= 1994) |> 
  select(Sample_Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |> 
  pivot_longer(
    cols = !Sample_Date, 
    names_to = "Ions", 
    values_to = "Units"
  )


ggplot(
  clean_q1, 
  mapping = aes(
    x = Sample_Date, 
    y = log(Units)
  )
) + 
  geom_point() +
  facet_wrap(~Ions)




# Q2 code ----------------------------------------------------------------


clean_q2 <- q2_data |> 
  mutate(Sample_Date = year(Sample_Date)) |> 
  filter(Sample_Date >= 1988 & Sample_Date <= 1994) |> 
  select(Sample_Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |> 
  pivot_longer(
    cols = !Sample_Date, 
    names_to = "Ions", 
    values_to = "Units"
  )



# Q3 code ----------------------------------------------------------------


clean_q3 <- q3_data |> 
  mutate(Sample_Date = year(Sample_Date)) |> 
  filter(Sample_Date >= 1988 & Sample_Date <= 1994) |> 
  select(Sample_Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |> 
  pivot_longer(
    cols = !Sample_Date, 
    names_to = "Ions", 
    values_to = "Units"
  )



# MPR code ---------------------------------------------------------------


clean_mpr <- mpr_data |> 
  mutate(Sample_Date = year(Sample_Date)) |> 
  filter(Sample_Date >= 1988 & Sample_Date <= 1994) |> 
  select(Sample_Date, `NH4-N`, Ca, Mg, `NO3-N`, K) |> 
  pivot_longer(
    cols = !Sample_Date, 
    names_to = "Ions", 
    values_to = "Units"
  )


# Joining ----------------------------------------------------------------

full_join()