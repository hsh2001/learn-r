library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
exam <- read.csv('0004/datas/csv_exam.csv')

exam[c(3, 8, 15), 'math'] <- NA
mpg[c(65, 124, 131, 153, 212), 'hwy'] <- NA
table(is.na(exam$math))
table(is.na(mpg$hwy))

mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))

table(is.na(mpg$hwy))
table(is.na(mpg$drv))

mpg %>% 
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

outlier <- data.frame(
  gender = c(1, 2, 1, 3, 2, 1),
  score = c(5, 4, 3, 4, 2, 6)
)

table(outlier$gender)
table(outlier$score)

outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
table(is.na(outlier$gender))

outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
table(is.na(outlier$score))

outlier %>%
  filter(!is.na(gender) & !is.na(score)) %>%
  group_by(gender) %>%
  summarise(mean_score = mean(score))

mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)$stats

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), 'drv'] <- 'k'
mpg[c(29, 43, 129, 203), 'cty'] <- c(3, 4, 39, 42)
table(mpg$cty)

table(mpg$drv)
mpg$drv <-ifelse(mpg$drv %in% c('4', 'f', 'r'), mpg$drv, NA)
table(mpg$drv)
table(is.na(mpg$drv))

boxplot(mpg$cty)$stats

mpg$cty <- ifelse(mpg$cty >= 9 & mpg$cty <= 26, mpg$cty, NA)
boxplot(mpg$cty)

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))
