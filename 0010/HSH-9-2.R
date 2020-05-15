library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

raw_welfare <- read.spss(
  file = "0010/Koweps_hpc10_2015_beta1.sav",
  to.data.frame = T
)

welfare <- raw_welfare
