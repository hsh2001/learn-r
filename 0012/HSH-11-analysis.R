library(extrafont) 
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

font_import()
theme_set(theme_grey(base_family='D2Coding'))

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

sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_col() + 
  scale_x_discrete(limits = c("young", "middle", "old"))
      
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_col(position = 'stack') + 
  scale_x_discrete(limits = c("young", "middle", "old"))

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_col(position = 'dodge') + 
  scale_x_discrete(limits = c("young", "middle", "old"))

sex_age <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))

head(sex_age)
         

ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + 
  geom_line() 

list_job <- read_excel("0011/Koweps_Codebook.xlsx", col_names = T, sheet = 2)
head(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")

welfare %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))

head(job_income)

top10 <- job_income %>% arrange(desc(mean_income)) %>% head(10)
top10

low10 <- job_income %>% arrange(mean_income) %>% head(10)
low10

ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) + 
  geom_col() +
  coord_flip()

ggplot(data = low10, aes(x = reorder(job, -mean_income), y = mean_income)) + 
  geom_col() +
  coord_flip() +
  ylim(0, 900)

job_male <- welfare %>%
  filter(!is.na(job) & sex == "male") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_male

job_female <- welfare %>%
  filter(!is.na(job) & sex == "female") %>%
  group_by(job) %>%
  summarise(n = n()) %>%
  arrange(desc(n)) %>%
  head(10)

job_female

ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()


ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

class(welfare$religion)
table(welfare$religion)

welfare$religion <- ifelse(welfare$religion == 1, 'yes', 'no')
table(welfare$religion)
qplot(welfare$religion)

class(welfare$marriage)
table(welfare$marriage)

welfare$group_marriage <- ifelse(welfare$marriage == 1, 'marriage', ifelse(welfare$marriage == 3, 'divorce', NA))
table(welfare$group_marriage)
qplot(welfare$group_marriage)  
  
# 종교 유무에 따른 이혼율 표 만들기
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n / tot_group * 100, 1))

religion_marriage

religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n / sum(n) * 100, 1))
  
religion_marriage

divorce <- religion_marriage %>%
  filter(group_marriage == 'divorce') %>%
  select(religion, pct)

divorce

ggplot(data = divorce, aes(x = religion, y = pct)) + 
  geom_col()

# 연령대별 이혼률 표 만들기

ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>%
  group_by(ageg) %>%
  mutate(pct = round(n / sum(n) * 100, 1))

ageg_divorce <- ageg_marriage %>%
  filter(group_marriage == 'divorce') %>%
  select(ageg, pct)

ageg_divorce 

ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) +
  geom_col()

# 청년층을 제외한 이혼률
ageg_divorce <- ageg_marriage %>%
  filter(ageg != 'young' & group_marriage == 'divorce') %>%
  select(ageg, pct)

ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) +
  geom_col()

ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, religion, group_marriage) %>%
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n / tot_group * 100, 1))

ageg_religion_marriage

df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == 'divorce') %>%
  select(ageg, religion, pct)

df_divorce

ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col()

ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = 'dodge') +
  scale_x_discrete(limits = c("young", "middle", "old"))
  




