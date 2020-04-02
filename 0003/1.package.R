installed.packages("ggplot2")
library(ggplot2)

x <- c("a", "b", "c", "a", "a", "d", "c")
qplot(x)

qplot(data = mpg, x = hwy)
qplot(data = mpg, x = cty)
qplot(data = mpg, x = drv, y = hwy)
qplot(data = mpg, x = drv, y = hwy, geom = "line")
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)
qplot(data = mpg, x = hwy, y = drv, geom = "boxplot", colour = drv)

a <- 1:10
b <- a ^ 3
qplot(a, b)



