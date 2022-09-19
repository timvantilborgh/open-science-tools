# Simulate dataset for workshop: "Tools to make science more open"
# FOWOP 2022 meeting - Brussels
# Author: Tim Vantilborgh

# Load packages
library(faux)

# Set seed
set.seed(4458623)

# Simulate data for a factorial design
between = list(condition=c(workshop = "Workshop condition",
                           control = "Control condition"))
within = list(time = c("pretest",
                       "posttest"))
mu = data.frame(
  workshop = c(4.20, 5.89),
  control = c(4.11, 4.51),
  row.names = within$time
)
df = sim_design(within, between,
                n = 40, mu = mu,
                sd = 1.5, r=.5)

df$gender = sample(c("male", "female"), 80, replace=T, prob=c(0.40, 0.60))
df$age = rnorm(80, mean=40, sd=8)
df$consc1 = rnorm(80, mean=5, sd=1)
df$consc2 = df$consc1 + rnorm(80, mean=0, sd=0.5)
df$conscientiousness = rowMeans(df[c("consc1", "consc2")])
df$delta = df$posttest - df$pretest

write_csv2(df, file="220908_simulated-data.csv")
