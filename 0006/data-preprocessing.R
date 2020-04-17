library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
exam <- read.csv('0004/datas/csv_exam.csv')

exam %>% arrange(math) # 수학 점수를 기준으로 오름차순 정렬
exam %>% arrange(science) # 과학 점수를 기준으로 오름차순 정렬

exam %>% arrange(desc(math)) # 수학 점수를 기준으로 내림차순 정렬
exam %>% arrange(desc(science)) # 과학 점수를 기준으로 내림차순 정렬

exam %>% arrange(class, math) # class, math 오름차순 정렬

mpg %>% 
  filter(manufacturer == 'audi') %>%
  arrange(desc(hwy)) %>%
  head(5)

exam %>%
  mutate(
    total = math + english + science, 
    mean = total / 3
  ) %>%
  head

exam %>%
  mutate(
    test = ifelse(science >= 60, 'pass', 'fail')
  ) %>%
  head

exam %>%
  mutate(total = math + english + science) %>%
  arrange(total)  %>%
  head

exam %>%
  mutate(
    total = math + english + science, 
    mean = total / 3,
    test = ifelse(mean >= 60, 'p', 'f')
  ) %>%
  arrange(class, desc(test))

mpg_new  <- mpg %>% mutate(total = cty + hwy) 

mpg_new %>% 
  mutate(mean = total / 2) %>% 
  arrange(desc(mean)) %>% 
  head(3)

mpg %>% 
  mutate(total = cty + hwy, mean = total / 2) %>% 
  arrange(desc(mean)) %>% 
  head(3)