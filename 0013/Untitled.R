install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")
install.packages("devtools")
install.packages("stringr")
install.packages("wordcloud")
install.packages("extrafont") 
devtools::install_github('haven-jeon/KoNLP', force = TRUE)

library(KoNLP)
library(dplyr)
library(devtools)
library(stringr)
library(wordcloud)
library(RColorBrewer)
library(extrafont) 
library(ggplot2)

font_import(prompt = FALSE)
theme_set(theme_grey(base_family='D2Coding'))

Sys.setenv(JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-14.jdk/Contents/Home")

useNIADic()

txt <- readLines("0013/hiphop.txt")
head(txt)
txt <- str_replace_all(txt, "\\W", " ")

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word, word = Var1, freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top_20 <- df_word %>% arrange(desc(freq)) %>% head(20)

pal <- brewer.pal(8,"Dark2")
set.seed(1234) # 난수 고정

wordcloud(
  words = df_word$word, # 단어
  freq = df_word$freq, # 빈도
  min.freq = 2, # 최소 단어 빈도
  max.words = 200, # 표현 단어 수
  random.order = F, # 고빈도 단어 중앙 배치
  rot.per = .1, # 회전 단어 비율
  scale = c(4, 0.3), # 단어 크기 범위
  colors = pal, # 색깔 목록
  family="D2Coding" # 폰트 지정 
)

pal <- brewer.pal(9,"Blues")[5:9] # 색상 목록 생성
set.seed(1234) # 난수 고정
wordcloud(
  words = df_word$word, # 단어
  freq = df_word$freq, # 빈도
  min.freq = 2, # 최소 단어 빈도
  max.words = 200, # 표현 단어 수
  random.order = F, # 고빈도 단어 중앙 배치
  rot.per = .1, # 회전 단어 비율
  scale = c(4, 0.3), # 단어 크기 범위
  colors = pal, # 색상 목록
  family="D2Coding" # 폰트 지정 
)

twitter <- read.csv(
  "0013/twitter.csv",
  header = T,
  stringsAsFactors = F,
  fileEncoding = "UTF-8"
)

twitter <- rename(
  twitter,
  no = 번호,
  id = 계정이름,
  date = 작성일,
  tw = 내용
)

twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

nouns <- extractNoun(twitter$tw)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word, word = Var1, freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

order <- arrange(top20, freq)$word # 빈도 순서 변수 생성
ggplot(data = top20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) + # 빈도 순서 변수 기준 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3) # 빈도 표시

pal <- brewer.pal(8,"Dark2") # 색상 목록 생성
set.seed(1234) # 난수 고정
wordcloud(
  words = df_word$word, # 단어
  freq = df_word$freq, # 빈도
  min.freq = 10, # 최소 단어 빈도
  max.words = 200, # 표현 단어 수
  random.order = F, # 고빈도 단어 중앙 배치
  rot.per = .1, # 회전 단어 비율
  scale = c(6, 0.2), # 단어 크기 범위
  colors = pal, # 색상 목록
  family="D2Coding" # 폰트 지정 
)

pal <- brewer.pal(9,"Blues")[5:9] # 색상 목록 생성
set.seed(1234) # 난수 고정
wordcloud(
  words = df_word$word, # 단어
  freq = df_word$freq, # 빈도
  min.freq = 10, # 최소 단어 빈도
  max.words = 200, # 표현 단어 수
  random.order = F, # 고빈도 단어 중앙 배치
  rot.per = .1, # 회전 단어 비율
  scale = c(6, 0.2), # 단어 크기 범위
  colors = pal, # 색상 목록
  family="D2Coding" # 폰트 지정 
)