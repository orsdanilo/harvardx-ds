# Question 1

a <- 2
b <- -1
c <- -4

sol_1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
sol_1

sol_2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)
sol_2

# Question 2

log(1024, base=4)

# Question 3

#install.packages("dslabs")
library(dslabs)
data(movielens)
str(movielens)

# Question 4

nlevels(movielens$genres)
