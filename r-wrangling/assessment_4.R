library(dslabs)
library(lubridate)
options(digits = 3)

# Question 3

data(brexit_polls)

brexit_polls %>% filter(month(startdate) == 4) %>% nrow

brexit_polls %>% mutate(end_week = round_date(enddate, unit="week")) %>% filter(end_week == '2016-06-12') %>% nrow

# Question 4

brexit_polls %>% mutate(weekday=weekdays(enddate)) %>% 
  count(weekday) %>% 
  arrange(desc(n))

# Question 5

data(movielens)
str(movielens)

movielens <- movielens %>% mutate(date=as_datetime(timestamp))

movielens %>% count(year(date)) %>% arrange(desc(n))

movielens %>% count(hour(date)) %>% arrange(desc(n))

# Quesion 6

library(tidyverse)
library(gutenbergr)
library(tidytext)
options(digits = 3)

gutenberg_metadata

pride_prejudice <- gutenberg_metadata %>% filter(str_detect(title, "Pride and Prejudice"))

# Question 7

gutenberg_works(title == "Pride and Prejudice")

# Question 8

pride_prejudice <- gutenberg_download(1342)

words <- pride_prejudice %>% unnest_tokens(word, text)
nrow(words)

# Question 9

words <- pride_prejudice %>% 
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word)
nrow(words)

# Question 10

words <- pride_prejudice %>% 
  unnest_tokens(word, text) %>%
  filter(!word %in% stop_words$word & !str_detect(word, "\\d+"))
nrow(words)

# Question 11

str(words)
words %>% count(word) %>% filter(n > 100) %>% nrow

words %>% count(word) %>% arrange(desc(n))
 
# Question 12

afinn <- get_sentiments("afinn")
str(afinn)

afinn_sentiments <- words %>% inner_join(afinn, by = "word")
nrow(afinn_sentiments)

afinn_sentiments %>% summarize(positive = length(value[value > 0])/n())

afinn_sentiments %>% filter(value == 4) %>% nrow



