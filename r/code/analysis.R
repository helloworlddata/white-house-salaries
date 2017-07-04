library(tidyverse)
library(magrittr)

salaries %<>% 
  mutate(salary = as.double(gsub("\\$|\\,", "", salary)),
         position = tolower(position),
         employee_name = tolower(employee_name))

salaries %>% 
  filter(!is.na(salary)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary),
            meanSalary = mean(salary),
            staffSize = n())

top10 <- salaries %>% 
  filter(year == 2003) %>% 
  arrange(desc(salary)) %>% 
  top_n(10, salary)

press <- salaries %>% 
  filter(grepl("press secretary", position)) %>% 
  group_by(position, year) %>% 
  summarize(count = n(),
            medianSalary = median(salary)) %>% 
  add_tally(count)

salaries %>% 
  filter(tolower(position) == 'senior policy advisor') %>% 
  arrange(year) %>% 
  group_by(year) %>% 
  top_n(1, salary) %>% 
  ggplot(aes(year, salary)) +
  geom_line()

salaries %>% 
  filter(!is.na(status), year == 2015) %>% 
  ggplot(aes(status, salary)) +
  geom_boxplot()

salaries %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line()

fifteeners <- salaries %>% 
  group_by(employee_name) %>% 
  summarize(years = n()) %>% 
  filter(years == 15)

for (i in 1:length(fifteeners$employee_name)) {
  print(salaries %>% 
    filter(grepl(fifteeners$employee_name[[i]], employee_name)) %>% 
    ggplot(aes(year, salary)) +
    geom_line() +
    ggtitle(fifteeners$employee_name[[i]]))
}

yearCount <- salaries %>% 
  group_by(employee_name) %>% 
  summarize(years = n()) %>% 
  arrange(desc(years))

yearCount %>% 
  group_by(years) %>% 
  summarize(n = n())

positions <- salaries %>% 
  group_by(position) %>% 
  summarize(n = n(),
            count = n_distinct(year)) %>% 
  arrange(desc(n))

specialAssistant <- salaries %>% 
  filter(position == 'special assistant to the president and associate counsel to the president')

specialAssistant %>% 
  group_by(year) %>% 
  mutate(salary = median(salary)) %>% 
  ggplot(aes(year, salary)) +
  geom_line() +
  ggtitle(specialAssistant$position[[1]])

# assistant <- 
for(p in 1:10) {
  print(salaries %>% 
          # filter(grepl('assistant to the president', position)) %>% 
          filter(grepl(positions$position[[p]], position)) %>% 
          group_by(year) %>% 
          # group_by(position) %>% 
          # summarize(n = n())
          mutate(salary = median(salary)) %>% 
          ggplot(aes(year, salary)) +
          geom_line() +
          ggtitle(positions$position[[p]]))
}