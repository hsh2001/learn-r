library(ggplot2)
library(dplyr)

## 1. 데이터를 읽고 전처리하기.
## 한글로 작성된 데이터여서 변수 이름을 이해하기 쉬운 영어로 변환하기.
## 인코딩 형식이 euc-kr인 것을 주의하기.
## 마지막 행에 있는 결측치 제거하기.

# CSV 파일 읽어오기
read_data <- read.csv(
  'midterm_exam/Incheon-line-2-electricity-usage.csv', 
  fileEncoding = 'euc-kr'
)

# 변수 이름을 사용하기 쉽게 바꾸기
electricity_usage <- data.frame(
  month = read_data$월별,
  usage2017 = read_data$"X2017년.전력사용량.kWh",
  usage2018 = read_data$"X2018년.전력사용량.kWh",
  usage_increase = read_data$"전년대비증감...",
  fee2017 = read_data$"X2017년.전기요금.원.",
  fee2018 = read_data$"X2018년전기요금.원.",
  fee_increase = read_data$"전년대비증감....1"
)

# 더 이상 사용하지 않는 변수 삭제하기
rm(read_data)

electricity_usage <- electricity_usage %>% 
  # 결측치 제거하기
  filter(!is.na(usage_increase)) %>%
  # 문자열 데이터를 숫자로써 해석하기.
  # gsub 함수: 문자열을 수정할 때 사용함.
  # as.numeric 함수: 문자열을 숫자로 해석함.
  mutate(
    month = as.numeric(gsub("월", "", month)),
    usage2017 = as.numeric(gsub(",", "", usage2017)),
    usage2018 = as.numeric(gsub(",", "", usage2018)),
    fee2017 = as.numeric(gsub(",", "", fee2017)),
    fee2018 = as.numeric(gsub(",", "", fee2018))
  )

# 데이터 형식을 확인하기
str(electricity_usage)

## 2. 전기 사용량이 어떻게 변하고 있을까?

## 전년 대비 증감의 평균은 어떻까?
mean(electricity_usage$usage_increase) # -3.4275

## 증감의 평균이 0보다 작다면 전년보다 전기를 덜 사용했다는 뜻일까?
sum(electricity_usage$usage2018) - sum(electricity_usage$usage2017) # -1901107
sum(electricity_usage$fee2018) - sum(electricity_usage$fee2017) # -431498990

## 이를 통해 2017년 대비 2018년 전기를 약 3.4% 덜 사용했으며
## 그 양은 1901107KWh 이고 요금은 약 4억원이 줄어들었다.

## 3. 한달에 사용하는 전기와 그에 따른 요금은 얼마일까?
## 전기 사용량과 요금의 평균으로 추론해볼 수 있다.
mean_usage <- (mean(electricity_usage$usage2018) + mean(electricity_usage$usage2017)) / 2 # 4750863
mean_fee <- (mean(electricity_usage$fee2018) + mean(electricity_usage$fee2017)) / 2 # 627469965
mean_usage # 4750863
mean_fee # 627469965
## 2017년과 2018년 기준, 한 달에 약 475만KWh를 사용하며 요금은 약 6억원이다.

## 4. 1KWh 당 가격은 얼마일까?
fee_per_kwh <- mean_fee / mean_usage
fee_per_kwh # 132.0749
## 약 132원이다.

## 5. 월별 전기 사용량을 그래프로 그리기.
# 월과 년도를 합쳐서 month에 할당한다.
usage2017 <- electricity_usage %>% 
  mutate(
    month = paste('2017/', month, sep = ''),
    usage = usage2017
  ) %>%
  select(month, usage)

usage2018 <- electricity_usage %>% 
  mutate(
    month = paste('2018/', month, sep = ''),
    usage = usage2018
  ) %>%
  select(month, usage)

# 2017년과 2018년의 데이터를 합친다.
elec_usage_month <- bind_rows(usage2017, usage2018)

# 그래프 그리기
qplot(data = elec_usage_month, x = month, y = usage)
