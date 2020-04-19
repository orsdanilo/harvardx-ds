library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)

nodes <- html_nodes(h, "table")

html_text(nodes[[8]])

html_table(nodes[[21]])

for (i in 1:4){
  print(i)
  print(html_table(nodes[[i]]) %>% as_tibble())
}

# Question 3

tab_1 <- html_table(nodes[[10]], header = TRUE) %>% select(-No. )
tab_1 %>% as_tibble()

tab_2 <- html_table(nodes[[19]], header = TRUE)
tab_2 %>% as_tibble()

tab_3 <- full_join(tab_1, tab_2, by = 'Team')
nrow(tab_3)

# Question 4

library(tidyverse)
url2 <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
j <- read_html(url2)

nodes2 <- html_nodes(j, "table")

# Question 5

for (i in 1:5){
  print(i)
  print(html_table(nodes2[[i]], fill = TRUE) %>% as_tibble())
}
