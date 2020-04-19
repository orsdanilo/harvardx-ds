library(dslabs)
library(dplyr)
data(heights)
options(digits = 3)

# Question 1

avg <- mean(heights$height)
sum(heights$height > avg)

# Question 2

sum(heights$height > avg & heights$sex == "Female")

# Question 3

mean(heights$sex == "Female")

# Question 4

min_height <- min(heights$height)

ind <- match(min_height, heights$height)

heights$sex[ind]

# Question 5

max(heights$height)

x <- ceiling(min(heights$height)):floor(max(heights$height))

sum(! x %in% heights$height)

# Question 6

heights2 <- mutate(heights, ht_cm = height *2.54)
heights2$ht_cm[18]

mean(heights2$ht_cm)

# Question 7

females <- filter(heights2, sex == "Female")
nrow(females)

mean(females$ht_cm)

# Question 8

data(olive)
head(olive)

plot(olive$palmitic, olive$palmitoleic)

hist(olive$eicosenoic)

boxplot(palmitic~region, data = olive)
