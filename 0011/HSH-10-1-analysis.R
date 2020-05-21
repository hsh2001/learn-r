library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

raw_welfare <- read.spss(
  file = "0010/data/Koweps_hpc10_2015_beta1.sav",
  to.data.frame = T
)

str(raw_welfare)

welfare <- raw_welfare
welfare <- welfare %>% rename(
  sex = h10_g3, # 성별
  birth = h10_g4, # 출생년도
  marriage = h10_g10, # 혼인 상태
  religion = h10_g11, # 종교
  income = p1002_8aq1, #월급
  code_job = h10_eco9, # 직업 코드
  code_region = h10_reg7, # 지역 코드
)

# 분석. 성별에 따라 월급이 다를까?
class(welfare$sex)
table(welfare$sex)

qplot(welfare$sex) # default bins = 30
qplot(welfare$sex, bins = 3)

welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
qplot(welfare$sex)

class(welfare$income)
summarise(welfare$income)
qplot(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

welfare$income <- ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))

sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()

welfare %>%
  filter(!is.na(income)) %>%
  ggplot(aes(sex, income)) +
  geom_jitter(col = "pink") +
  geom_boxplot(alpha = .7, col = "cyan")

class(welfare$birth)
summarise(welfare$birth)
qplot(welfare$birth)

welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

welfare$age <- 2015 - welfare$birth + 1
summarise(welfare$age)
qplot(welfare$age)

age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young", ifelse(age < 60, "middle", "old")))

table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))
