install.packages('ggplot')
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)
mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)
mean(mpg$total)

summary(mpg$total)
hist(mpg$total)

mpg$test <- ifelse(mpg$total >= 25, "pass", "fail")
mpg$test1 <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg)

table(mpg$test)
table(mpg$test1)

qplot(mpg$test)
qplot(mpg$test1)

mpg$grade  <- ifelse(mpg$total >= 30, 'A', ifelse(mpg$total >= 20, 'B', 'C'))
mpg$grade1 <- ifelse(mpg$total >= 30, 'A', 
                     ifelse(mpg$total >= 25, 'B', 
                            ifelse(mpg$total >= 20, 'C', 'D')))

View(mpg)
