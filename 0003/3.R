score <- c(80, 60, 70, 50, 90)
mean_score <- mean(score)

class_num <- c(1, 1, 2, 3)
name <- c("박새로이", "조이서", "장근원", "장근수")
eng_score <- c(95, 80, 65, 70)
math_score <- c(56, 90, 55, 88)

df_mdterm <- data.frame(class_num, name, eng_score, math_score)
df_mdterm

mean_eng <- c("영어점수 평균", mean(df_mdterm$eng_score))
mean_math <- c("영어점수 평균", mean(df_mdterm$math_score))

mean_eng
mean_math

fruit_name <- c("사과", "딸기", "수박")
price <- c(1800, 1500, 3000)
sell_num <- c(24, 38, 13)

df_fruit <- data.frame(fruit_name, price, sell_num)
df_fruit

price_maen <- c("과일 가격 평균", mean(df_fruit$price))
sell_num_maen <- c("판매량 평균", mean(df_fruit$sell_num))

price_maen
sell_num_maen