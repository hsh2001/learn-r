library(readxl)
library(ggplot2)
library(dplyr)

mpg <- as.data.frame(ggplot2::mpg)
midwest <- as.data.frame(ggplot2::midwest)
economics <- as.data.frame(ggplot2::economics)

# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

#배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

#x 축을 제한. 3 ~ 6 사이의 데이터만 보여줌
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

#y 축을 제한. 10 ~ 30 사이의 데이터만 보여줌
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)

# cty와 hwy 간의 관계를 산점도로 그리기
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

# cty와 hwy 간의 관계를 산점도로 그리기
options(scipen = 0)  # 지수로 표현
options(scipen = 99) # 정수로 표현
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + 
  xlim(0, 500000) + 
  ylim(0, 10000)

df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

df_mpg

ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

# x 축을 정렬하고 그래프 그리기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col() #내림차순
ggplot(data = df_mpg, aes(x = reorder(drv, mean_hwy), y = mean_hwy)) + geom_col() #오름차순

# x축 범주 변수, y를 빈도로 그래프로 그리기
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

mpg_suv <- mpg %>%
  filter(class == 'suv') %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

ggplot(
  data = mpg_suv, 
  aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)
) + geom_col()

ggplot(data = mpg, aes(x = class)) + geom_bar()

# 시계열 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

# boxplot
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

ggplot(
  data = mpg %>% filter(class %in% c('compact', 'subcompact', 'suv')),
  aes(x = class, y = cty)
) + geom_boxplot()