installed.packages("readxl")
library(readxl)

datas_path <- "~/Dropbox/git/learn-r-lang/0004/datas"

path <- paste(datas_path, "excel_exam.xlsx", sep = '/')
df_exam <- read_excel(path)
df_exam

path <- paste(datas_path, "excel_exam_novar.xlsx", sep = '/')
df_exam_novar <- read_excel(path, col_names = F)
df_exam_novar

path <- paste(datas_path, "excel_exam_sheet.xlsx", sep = '/')
df_exam_sheet <- read_excel(path, sheet = 3)
df_exam_sheet

path <- paste(datas_path, "csv_exam.csv", sep = '/')
df_csv_exam <- read.csv(path, stringsAsFactors = F)
df_csv_exam

df_midterm <- data.frame(
  english = c(90, 80, 60, 70),
  math = c(50, 60, 100, 20),
  class = c(1, 1, 2, 2),
  name = c("Sam", "Peter", "Smith", "Jane")
)

path <- paste(datas_path, "df_midterm.csv", sep = '/')
write.csv(df_midterm, file = path)

path <- paste(datas_path, "df_midterm.rda", sep = '/')
save(df_midterm, file = path)
rm(df_midterm)

load(path)
df_midterm
