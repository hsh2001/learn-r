
##########################

num <- c(1 : 6)

##########################

matrix(num, nrow = 2, ncol = 3)
matrix(num, nrow = 3, ncol = 2)
matrix(num, nrow = 2, ncol = 3, byrow = T)

array(num, dim = c(2, 2, 3))

num <- seq(1 : 7)
array(num, dim = c(2, 2, 4))

##########################

list1 <- list(c(1 : 5), "Sun", "Moon", "Star")
list1

str(list1)

##########################

id <- c(1 : 5)
gender <- c("F", "F", "M", "M", "F")
age <- c(19, 20, 19, 22, 23)
area <- c("Seoul", "New York", "Deagu", "Asan", "Cheonan")

df <- data.frame(id, gender, age, area)
df

df <- data.frame(id, age, gender, area)
df

##########################

ceiling(3.8)
ceiling(-3.8)
floor(3.8)
floor(-3.8)

##########################

round(2.5) # (=2) go to the even digit!

##########################
