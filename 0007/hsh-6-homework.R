library(ggplot2)
library(dplyr)

midwest <- as.data.frame(ggplot2::midwest)
View(midwest)

# 문제 1
midwest$minor_per_total = (1 - midwest$popadults / midwest$poptotal) * 100

# 문제 2
midwest %>%
  select(minor_per_total, county) %>%
  arrange(desc(minor_per_total)) %>%
  head(5)

# 문제 3
midwest$minor_class <- ifelse(midwest$minor_per_total >= 40, 'large', 
                         ifelse(midwest$minor_per_total >= 30, 'middle', 'small'))

# 문제 4
midwest$asian_per_total <- (midwest$popasian / midwest$poptotal) * 100
midwest %>% 
  select(asian_per_total, state, county) %>%
  arrange(asian_per_total) %>%
  head(10)