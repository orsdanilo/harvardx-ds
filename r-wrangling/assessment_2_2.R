library(Lahman)
top <- Batting %>% 
  filter(yearID == 2016) %>%
  arrange(desc(HR)) %>%    # arrange by descending HR count
  slice(1:10)    # take entries 1-10
top %>% as_tibble()

Master %>% as_tibble()

# Question 5

top_names <- top %>%  left_join(Master) %>%
  select(playerID, nameFirst, nameLast, HR)

# Question 6

Salaries %>% as_tibble()

top_salary <- Salaries %>% filter(yearID == 2016) %>%
  right_join(top_names) %>%
  select(nameFirst, nameLast, teamID, HR, salary)

# Question 7

AwardsPlayers %>% as_tibble()

AwardsPlayers %>% 
  filter(yearID == 2016) %>% 
  semi_join(top_names) %>%
  as_tibble()

AwardsPlayers %>% 
  filter(yearID == 2016) %>% 
  anti_join(top_names) %>%
  distinct(playerID) %>%
  nrow()

