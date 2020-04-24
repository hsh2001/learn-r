library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
exam <- read.csv('0004/datas/csv_exam.csv')

# missing values : 결측치 

df <- data.frame(
  gender = c("M", "F", NA, "M", "F"),
  score = c(5, 4, 3, 4, NA)
)

df

is.na(df)
table(is.na(df))
table(is.na(df$gender))
table(is.na(df$score))

mean(df$score) # NA
sum(df$score) # NA

df_nomiss <- df %>% filter(!is.na(score)) # Remove NA rows
df_nomiss
mean(df_nomiss$score)
sum(df_nomiss$score)
sd(df_nomiss$score)

df_nomiss <- df %>% filter(!is.na(score) & !is.na(gender)) # Remove NA rows
df_nomiss2 <- na.omit(df) # Remove NA rows
df_nomiss
df_nomiss2

mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

exam_na <- exam
exam_na[c(3, 8, 15), 'math'] <- NA
exam_na %>% summarise(
  mean_math = mean(math, na.rm = T),
  sum_math = sum(math, na.rm = T),
  median_math = median(math, na.rm = T)
)

exam_na %>% summarise(mean_math = mean(math))
exam_na %>% summarise(mean_math = mean(math, na.rm = T))