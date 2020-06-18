install.packages("plotly")
install.packages("dygraphs")

library(plotly)
library(ggplot2)
library(dygraphs)
library(xts)

economics <- ggplot2::economics
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()
ggplotly(p)

p <- ggplot(data = diamonds, aes(x = cut, fill =  clarity)) + geom_bar(position = "dodge")
ggplotly(p)

dygraph(eco)
dygraph(eco) %>% dyRangeSelector()

# 저축률
eco_a <- xts(economics$psavert, order.by = economics$date)

# 실업자 수
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

eco2 <- cbind(eco_a, eco_b) # 데이터 결합 
colnames(eco2) <- c("psavert", "unemploy")
head(eco2)

dygraph(eco2) %>% dyRangeSelector()
