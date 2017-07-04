# Counselor To The President: https://en.wikipedia.org/wiki/Counselor_to_the_President

plotly::ggplotly(salaries %>% 
  filter(grepl('bartlett, dan|gillespie, ed|rouse, pe|podesta, jo|conway, kel|bannon, ste', employee_name)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line(size = 1.5) +
  ggtitle('Counselor To The President - Median Salary'))

# White House Chief of Staff: https://en.wikipedia.org/wiki/List_of_White_House_Chiefs_of_Staff
plotly::ggplotly(salaries %>% 
  filter(grepl('card, an|bolten, jo|emanuel, ra|rouse, pe|daley, bi|lew, ja|mcdonough, de|priebus, re', employee_name)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line(size = 1.5) +
  ggtitle('Chief of Staff - Median Salary'))

# Executive Office of The President: 
# https://en.wikipedia.org/wiki/Executive_Office_of_the_President_of_the_United_States
assistant <- plotly::ggplotly(salaries %>% 
  filter(grepl('assistant to the president', position)) %>%
  mutate(level = ifelse(grepl('^assistant', position), 'senior assistant', 
                ifelse(grepl('^special', position), 'special assistant', 'deputy assistant'))) %>% 
  group_by(year, level) %>%
  summarize(n = n(), 
            medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line(aes(color = level)))

# National Security Advisor: https://en.wikipedia.org/wiki/National_Security_Advisor_(United_States)
nationalSecurityAdvisor <- plotly::ggplotly(salaries %>% 
  # filter(grepl('national security advisor', position))
  filter(grepl('donilon, to|rice, su|jones, ja|hadley, st|rice, con|flynn, mi|kellogg, ke|mcmaster, h', employee_name)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line() +
  ggtitle('National Security Advisor - Median Salary'))


firstLady <- plotly::ggplotly(salaries %>%
  filter(grepl('lady', position)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line() +
  ggtitle('Office Of The First Lady - Median Salary'))

# White House Counsel: https://en.wikipedia.org/wiki/White_House_Counsel
counselToPresident <- salaries %>% 
  filter(grepl('counsel to the president', position)) %>% 
  #filter(grepl('miers, ha|fielding, fr|craig, gr|bauer|ruemmler|eggleston|mcgahn', employee_name))
  group_by(year) %>% 
  summarize(count = n()) %>% 
  arrange(year)

length <- salaries %>% 
  group_by(employee_name) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count)) %>% 
  top_n(20)

for(n in 1:length(length$employee_name)){
  print(salaries %>% 
          filter(employee_name == length$employee_name[[n]]) %>% 
          ggplot(aes(year, salary)) +
          geom_line(size = 1.5) +
          ggtitle(paste(length$employee_name[[n]], '-', 
                        salaries$position[
                          salaries$employee_name == length$employee_name[[n]]], sep = " ")))
}

temp <- salaries %>% 
  filter(year == 2017)
#filter(grepl('calligrapher', position)) %>% 
arrange(year)

position2017 <- temp %>% 
  group_by(position) %>% 
  summarize(count = n(), 
            medianSalary = median(salary)) %>% 
  arrange(desc(count))