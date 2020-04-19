library(dslabs)
library(dplyr)
library(lubridate)
library(caret)
data(reported_heights)

dat <- mutate(reported_heights, date_time = ymd_hms(time_stamp)) %>%
  filter(date_time >= make_date(2016, 01, 25) & date_time < make_date(2016, 02, 1)) %>%
  mutate(type = ifelse(day(date_time) == 25 & hour(date_time) == 8 & between(minute(date_time), 15, 30), "inclass","online")) %>%
  select(sex, type)

y <- factor(dat$sex, c("Female", "Male"))
x <- dat$type

# Question 1

dat %>% group_by(type) %>% summarise(prev=mean(sex=="Female"))

# Question 2

y_hat <- ifelse(x == "online", "Male", "Female") %>% 
  factor(levels = levels(y))
mean(y_hat == y)

# Question 3

table(y_hat, y)

# Question 4

sensitivity(data = y_hat, reference = y)

# Question 5

specificity(data = y_hat, reference = y)

# Question 6

mean(dat$sex == "Female")

# Question 7

data(iris)
iris <- iris[-which(iris$Species=='setosa'),]
y <- iris$Species

set.seed(2)    # if using R 3.6 or later, use set.seed(2, sample.kind="Rounding")
test_index <- createDataPartition(y, times = 1, p = 0.5, list = FALSE)
test <- iris[test_index,]
train <- iris[-test_index,]

# Question 8

for (feat in names(train[,-5])){
  print(feat)
  cutoff <- range(get(feat,train)) %>% {seq(from=.[1], to=.[2], by=0.1)}
  accuracy <- map_dbl(cutoff, function(x){
    y_hat <- ifelse(get(feat,train) > x, "virginica", "versicolor") %>% 
      factor(levels = levels(train[,5]))
    mean(y_hat == train[,5])
  })
  print(max(accuracy))
  best_cutoff <- cutoff[which.max(accuracy)]
  print(best_cutoff)
}

# Question 8 without a for loop

# cutoff <- train[,-5] %>% map(~ seq(from=range(.)[1], to=range(.)[2], by=0.1))
# accuracy <- pmap(cutoff, train[,-5], function(x, y){
#   y_hat <- x %>% map(~ ifelse(y > ., "virginica", "versicolor")) %>% 
#     factor(levels = levels(train[,5]))
#   mean(y_hat == train[,5])
# })
# print(max(accuracy))
# best_cutoff <- cutoff[which.max(accuracy)]
# print(best_cutoff)

# Question 9

y_hat <- ifelse(test$Petal.Length > 4.7, "virginica", "versicolor") %>% 
  factor(levels = levels(test$Species))
mean(y_hat == test$Species)

# Question 10

for (feat in names(test[,-5])){
  print(feat)
  cutoff <- range(get(feat,test)) %>% {seq(from=.[1], to=.[2], by=0.1)}
  accuracy <- map_dbl(cutoff, function(x){
    y_hat <- ifelse(get(feat,test) > x, "virginica", "versicolor") %>% 
      factor(levels = levels(train[,5]))
    mean(y_hat == test[,5])
  })
  print(max(accuracy))
  best_cutoff <- cutoff[which.max(accuracy)]
  print(best_cutoff)
}

# Question 11

plot(iris,pch=21,bg=iris$Species)

y_hat <- ifelse(test$Petal.Length > 4.7 | test$Petal.Width > 1.5, "virginica", "versicolor") %>% 
  factor(levels = levels(test[,5]))
mean(y_hat == test[,5])

