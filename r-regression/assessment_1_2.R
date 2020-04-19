library(Lahman)
data(Teams)

data <- Teams %>% filter(yearID %in% 1961:2001)

# Question 7

data %>% summarize(r = cor(R/G, AB/G))

# Question 8

data %>% summarize(r = cor(W/G, E/G))

# Question 9

data %>% summarize(r = cor(X2B/G, X3B/G))
