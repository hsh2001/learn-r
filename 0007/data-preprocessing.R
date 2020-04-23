library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
exam <- read.csv('0004/datas/csv_exam.csv')

exam %>% 
  group_by(class) %>%
  summarise(
    mean_math = mean(math),
    sum_math = sum(math),
    median_math = median(math),
    sd_math = sd(math),
    n = n()
  )

mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  head(10)

mpg %>%
  group_by(manufacturer) %>%
  filter(class == 'suv') %>%
  mutate(total = hwy + cty) %>%
  summarise(mean = mean(total)) %>%
  arrange(desc(mean)) %>%
  head(5)

mpg %>%
  group_by(class) %>%
  summarise(cty_mean = mean(cty)) %>%
  arrange(desc(cty_mean)) %>%
  head

mpg %>%
  group_by(class) %>%
  summarise(cty_mean = mean(cty))

mpg %>%
  group_by(class) %>%
  summarise(cty_mean = mean(cty)) %>%
  arrange(desc(cty_mean))

mpg %>%
  group_by(manufacturer) %>%
  summarise(hwy_mean = mean(hwy)) %>%
  arrange(desc(hwy_mean)) %>%
  head(3)

mpg %>%
  filter(class == 'compact') %>%
  group_by(manufacturer) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  head

test1 <- data.frame(
  id = c(1, 2, 3, 4, 5),
  midterm = c(60, 80, 70, 90, 85)
)

test2 <- data.frame(
  id = c(1, 2, 3, 4, 5),
  final = c(70, 83, 65, 95, 80)
)

total <- left_join(test1, test2, by = 'id')
total

name <- data.frame(
  class = c(1,2,3,4,5),
  teacher = c('kim', 'lee', 'park', 'choi', 'jung')
)

exam_new <- left_join(exam, name, by = 'class')

group_a <- data.frame(
  id = c(1,2,3,4,5),
  test = c(60, 80, 60 , 100, 30)
)

group_b <- data.frame(
  id = c(6, 7, 8, 9, 10),
  test = c(60, 80, 60 , 100, 30)
)

group_all <- bind_rows(group_a, group_b)

fuel <- data.frame(
  fl = c('c', 'd', 'e', 'p', 'r'),
  price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
  stringAsFactors = F
)

fuel

mpg <- left_join(mpg, fuel, by = 'fl') 

mpg %>% 
  select(model, fl, price_fl) %>%
  head(5)
