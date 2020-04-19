library(tidyverse)
library(dplyr)
library(dslabs)

# Question 3

d <- read_csv("times.csv")

tidy_data <- d %>% gather(year, time, `2015`:`2017`)
head(tidy_data)

# Question 5

wide_data <- tidy_data %>% spread(year, time)
head(wide_data)

# Question 7

d <- read_csv("times.csv")

tidy_data <- d %>%
  gather(key = "key", value ="value", -age_group) %>%
  separate(col = key, into = c("year", "variable_name"), sep = "_") %>% 
  spread(key = variable_name, value = value)

head(tidy_data)

# Question 9

co2

# Question 10

co2_wide <- data.frame(matrix(co2, ncol = 12, byrow = TRUE)) %>% 
  setNames(1:12) %>%
  mutate(year = as.character(1959:1997))
head(co2_wide)

co2_tidy <- gather(co2_wide, month, co2, -year)
head(co2_tidy)

# Question 11

co2_tidy %>% ggplot(aes(as.numeric(month), co2, color = year)) + geom_line()

# Question 12

data(admissions)
dat <- admissions %>% select(-applicants)
head(dat)

dat_tidy <- spread(dat, gender, admitted)
head(dat_tidy)

# Question 13

tmp <- gather(admissions, key, value, admitted:applicants)
tmp

tmp2 <- unite(tmp, column_name, c(key, gender))
tmp2

# Question 14

tmp3 <- spread(tmp2, column_name, value)
tmp3




