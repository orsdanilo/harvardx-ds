options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))

# Question 2

titanic %>% filter(!is.na(Age) & !is.na(Sex)) %>%
  ggplot(aes(Age, fill = Sex)) +
  geom_density() +
  facet_grid(Sex ~ .)

titanic %>% filter(!is.na(Age) & !is.na(Sex)) %>%
  ggplot(aes(Age, fill = Sex)) +
  geom_density(alpha = 0.2)

titanic %>% filter(!is.na(Age) & !is.na(Sex)) %>%
  ggplot(aes(Age, fill = Sex)) +
  geom_histogram() +
  facet_grid(Sex ~ .)

# Question 3

params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))

titanic %>% filter(!is.na(Age)) %>% 
  ggplot(aes(sample = Age)) +
  geom_qq(dparams = params) +
  geom_abline()

# Question 4

titanic %>% ggplot(aes(Sex, fill = Survived)) + 
  geom_bar(position = position_dodge())

# Question 5

titanic %>% ggplot(aes(Age, y = ..count.., fill = Survived)) + 
  geom_density(alpha = 0.2)

# Question 6

titanic %>% filter(!Fare == 0) %>%
  ggplot(aes(Survived, Fare)) +
  geom_boxplot() +
  scale_y_continuous(trans = 'log2') +
  geom_jitter(width = 0.1, alpha = 0.2)
  
# Question 7

library(gridExtra)
plot1 <- titanic %>% ggplot(aes(Pclass, fill = Survived)) + geom_bar()
plot2 <- titanic %>% ggplot(aes(Pclass, fill = Survived)) + geom_bar(position = position_fill())
plot3 <- titanic %>% ggplot(aes(Survived, fill = Pclass)) + geom_bar(position = position_fill())
grid.arrange(plot1, plot2, plot3, nrow=3)

# Question 8

titanic %>% ggplot(aes(Age, y = ..count.., fill = Survived)) +
  geom_density(alpha = 0.5, na.rm = TRUE) +
  facet_grid(Sex ~ Pclass)



