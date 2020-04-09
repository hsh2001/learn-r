install.packages('readxl')
install.packages('ggplot2')
install.packages('dplyr')
library(readxl)
library(ggplot2)
library(dplyr)

df_exam <- read.csv('0005/datas/csv_exam.csv')
df_exams

head(df_exam) # default = 6
head(df_exam, 10)

tail(df_exam) # default = 6
tail(df_exam, 8)

View(df_exam)

dim(df_exam)

str(df_exam)

summary(df_exam)
# Median: 중간값
# 1st Qu.: 4등분한 것중 첫번째의 마지막 값 (1/4 지점) 
# 3rd Qu.: 4등분한 것중 3번째의 마지막 값 (3/4 지점)


mpg <- as.data.frame(ggplot2::mpg)
View(mpg)

df_data <- data.frame(
  var1 = c(1,2,1),
  var2 = c(2,3,2)
)

df_new_data <- df_data

df_new_data <- rename(df_new_data, v1 = var1)
df_new_data <- rename(df_new_data, v2 = var2)
df_new_data

mpg_new <- mpg
mpg_new <- rename(mpg_new, city=cty)
mpg_new <- rename(mpg_new, highway=hwy)
head(mpg)
head(mpg_new)

df_data <- data.frame(
  var1 = c(4, 3, 8),
  var2 = c(2, 6, 1)
)

df_data$v_sum <- df_data$var1 + df_data$var2
df_data$v_mean <- (df_data$v_sum) / 2
str(df_data)

mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)
mean(mpg$total)
