install.packages('ggplot2')
install.packages('dplyr')
library(ggplot2)
library(dplyr)

df <- as.data.frame(ggplot2::midwest)
View(df)
head(df)
tail(df)
dim(df)
str(df)
summary(df)

df <- rename(df, total=poptotal)
df <- rename(df, asian=popasian)
head(df)

df$asian_per_total <- 100 * df$asian / df$total
hist(df$asian_per_total)

asian_mean <- mean(df$asian_per_total)
asian_mean

df$asian_size_grade <- ifelse(df$asian_per_total > asian_mean, 'large', 'small')
table(df$asian_size_grade)
qplot(df$asian_size_grade)
