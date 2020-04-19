## Initialize

install.packages('ggplot2')
install.packages('dplyr')

library(ggplot2)
library(dplyr)


## 5-1 Q1.

mpg <- as.data.frame(ggplot2::mpg)
mpg_under4 <- mpg %>% filter(displ <= 4)
mpg_more5 <- mpg %>% filter(displ >= 5)

head(mpg_under4)
head(mpg_more5)

mean(mpg_under4$hwy) # under 4 mean
mean(mpg_more5$hwy) # more 5 mean


## 5-1 Q2.

mpg <- as.data.frame(ggplot2::mpg)
mpg_audi <- mpg %>% filter(manufacturer == 'audi')
mpg_toyota <- mpg %>% filter(manufacturer == 'toyota')

head(mpg_audi)
head(mpg_toyota)

mean(mpg_audi$cty) # audi mean
mean(mpg_toyota$cty) # toyota mean


## 5-1 Q3.

mpg <- as.data.frame(ggplot2::mpg)
mpg_target <- mpg %>% filter(
  manufacturer == 'chevrolet' | 
  manufacturer == 'ford' | 
  manufacturer == 'honda'
)

mean(mpg_target$hwy) # target mean


## 5-2 Q1.

mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg %>% select(class, cty)
head(mpg_new)

## 5-2 Q2.

mpg_suv <- mpg_new %>% filter(class == 'suv')
mpg_compact <- mpg_new %>% filter(class == 'compact')
mean(mpg_suv$cty) # suv mean
mean(mpg_compact$cty) # compact mean