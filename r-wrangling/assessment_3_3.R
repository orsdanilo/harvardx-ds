# Question 1

s <- c("5'10", "6'1\"", "5'8inches", "5'7.5")
tab <- data.frame(x = s)

extract(data = tab, col = x, into = c("feet", "inches", "decimal"), 
        regex = "(\\d)'(\\d{1,2})(\\.\\d+)?")

# Question 2

schedule <- data.frame(day = c("Monday", "Tuesday"),
                       staff = c("Mandy, Chris and Laura", "Steve, Ruth and Frank"))
schedule

str_split(schedule$staff, ", | and ")
str_split(schedule$staff, ",\\s|\\sand\\s")

# Question 3

tidy <- schedule %>% 
  mutate(staff = str_split(staff, ", | and ")) %>% 
  unnest()
tidy

# Question 4

dat <- gapminder %>% filter(region == "Middle Africa") %>% 
  mutate(country_short = recode(country, 
                                "Central African Republic" = "CAR", 
                                "Congo, Dem. Rep." = "DRC",
                                "Equatorial Guinea" = "Eq. Guinea"))
dat

# Question 5

library(rvest)
library(tidyverse)
library(stringr)
url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url) %>% html_nodes("table")
polls <- tab[[5]] %>% html_table(fill = TRUE)

polls <- polls %>% setNames(c("dates", "remain", "leave", "undecided", "lead", "samplesize", "pollster", "poll_type", "notes")) %>%
  filter(str_detect(remain, "%"))
nrow(polls)

# Question 6

as.numeric(str_remove(polls$remain, "%")) # Between 0 and 100
as.numeric(polls$remain)/100 # Vector of NAs
parse_number(polls$remain) # Between 0 and 100
str_remove(polls$remain, "%")/100 # Error
as.numeric(str_replace(polls$remain, "%", ""))/100 # OK!
parse_number(polls$remain)/100 # OK!

# Question 7

str_replace(polls$undecided, "N/A", "0")

# Question 8

temp <- str_extract_all(polls$dates, "\\d+\\s[a-zA-Z]+")
end_date <- sapply(temp, function(x) x[length(x)]) # take last element (handles polls that cross month boundaries)
end_date
