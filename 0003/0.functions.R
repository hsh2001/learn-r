abs(-1234)

abs1 <- c(-1 : -4)
abs1
abs(abs1)

abs2 <- c(-5 : -8)
abs2

df_abs <- data.frame(abs1,abs2)
df_abs
abs(df_abs)

str1 <- c("Hello!", "world", "is", "good!")
str1

length <-nchar(str1) # strlen()
length

str_paste <- paste(str1, collapse = ", ") # concatenate()
str_paste

str1 <- substr(str_paste, 5, 8) # mid()
str1

time_stamp <- c("202003121030", "202003131530", "202003420930")
ts_mmdd <- substr(time_stamp, 5, 8)
ts_mmdd

ts_hhmm <- substr(time_stamp, 9, 12)
ts_hhmm

ts_yyyymm <- substr(time_stamp, 1, 6)
ts_yyyymm
