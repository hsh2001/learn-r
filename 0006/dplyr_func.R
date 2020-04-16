install.packages('dplyr')
library(dplyr)

exam <- read.csv('0004/datas/csv_exam.csv')
exam %>% filter(class == 1) # 1반만 
exam %>% filter(class == 2) # 2반만 
exam %>% filter(class != 3) # 3반만
exam %>% filter(math > 50) # 수학점수가 50점 초과
exam %>% filter(math < 50) # 수학점수가 50점 미만
exam %>% filter(english >= 80) # 수학점수가 50점 미만
exam %>% filter(class == 2 & english >= 80) # 2반이고 영어점수가 80점 이상
exam %>% filter(math >= 90 | english >= 90) # 수학이나 영어 점수가 90점 이상
exam %>% filter(class == 1 | class == 3 | class == 5) # 1, 3, 5반만
exam %>% filter(class %in% c(1, 3, 5)) # 위와 동일

class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)
mean(class1$math) # 1반의 수학 점수 평균
mean(class2$math) # 2반의 수학 점수 평균

exam %>% select(math) # 수학점수만 
exam %>% select(english) # 영어점수만
exam %>% select(class, math, english) # 반, 수학점수, 영어점수 추출
exam %>% select(-math, -english) # 수학점수를 제외한 나머지를 추출

exam %>% 
  filter(class == 1) %>% 
  select(english)  # 1반의 영어점수만 추출

exam %>%
  select(id, math) %>%
  head # id, math 만 6행 출력


