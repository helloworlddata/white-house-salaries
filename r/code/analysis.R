salaries %>%
  group_by(president, party, term) %>% 
  summarize(medianSalary = median(salary),
            meanSalary = mean(salary))

salaries %>% 
  filter(!is.na(salary)) %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary),
            meanSalary = mean(salary),
            staffSize = n())

salaries %>% 
  group_by(year) %>% 
  summarize(medianSalary = median(salary)) %>% 
  ggplot(aes(year, medianSalary)) +
  geom_line()

top10 <- salaries %>% 
  arrange(desc(salary)) %>% 
  top_n(10, salary)

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

longestStaff <- salaries %>% 
  group_by(employee_name) %>% 
  summarize(years = n()) %>% 
  filter(years == 16)

for (i in 1:length(longestStaff$employee_name)) {
  print(salaries %>% 
    filter(grepl(longestStaff$employee_name[[i]], employee_name)) %>% 
    ggplot(aes(year, salary)) +
    geom_line() +
    ggtitle(longestStaff$employee_name[[i]]))
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

## Office Analysis

# Counselor To The President: https://en.wikipedia.org/wiki/Counselor_to_the_President
ggplotly(salaries %>% 
                   filter(grepl('bartlett, dan|gillespie, ed|rouse, pe|
                                podesta, jo|conway, kel|bannon, ste', 
                                employee_name)) %>% 
                   group_by(year) %>% 
                   summarize(medianSalary = median(salary)) %>% 
                   ggplot(aes(year, medianSalary)) +
                   geom_line(size = 1.5) +
                   ggtitle('Counselor To The President - Median Salary'))

# White House Chief of Staff: https://en.wikipedia.org/wiki/List_of_White_House_Chiefs_of_Staff
ggplotly(salaries %>% 
                   filter(grepl('card, an|bolten, jo|emanuel, ra|rouse, pe|
                                daley, bi|lew, ja|mcdonough, de|priebus, re',
                                employee_name)) %>% 
                   group_by(year) %>% 
                   summarize(medianSalary = median(salary)) %>% 
                   ggplot(aes(year, medianSalary)) +
                   geom_line(size = 1.5) +
                   ggtitle('Chief of Staff - Median Salary'))

# Executive Office of The President: 
# https://en.wikipedia.org/wiki/Executive_Office_of_the_President_of_the_United_States
ggplotly(salaries %>% 
                   filter(grepl('assistant to the president', position)) %>%
                   mutate(level = ifelse(grepl('^assistant', position), 'senior assistant', 
                                         ifelse(grepl('^special', position), 
                                                'special assistant', 'deputy assistant'))) %>% 
                   group_by(year, level) %>%
                   summarize(n = n(), 
                       medianSalary = median(salary)) %>% 
                   ggplot(aes(year, medianSalary)) +
                   geom_line(aes(color = level)))

# National Security Advisor: https://en.wikipedia.org/wiki/National_Security_Advisor_(United_States)
ggplotly(salaries %>% 
                   filter(grepl('donilon, to|rice, su|jones, ja|hadley, st|
                                rice, con|flynn, mi|kellogg, ke|mcmaster, h',
                                employee_name)) %>% 
                   group_by(year) %>% 
                   summarize(medianSalary = median(salary)) %>% 
                   ggplot(aes(year, medianSalary)) +
                   geom_line() +
                   ggtitle('National Security Advisor - Median Salary'))

ggplotly(salaries %>%
                  filter(grepl('lady', position)) %>% 
                  group_by(year) %>% 
                  summarize(medianSalary = median(salary)) %>% 
                  ggplot(aes(year, medianSalary)) +
                  geom_line() +
                  ggtitle('Office Of The First Lady - Median Salary'))

# White House Counsel: https://en.wikipedia.org/wiki/White_House_Counsel
counselToPresident <- salaries %>% 
  filter(grepl('miers, ha|fielding, fr|craig, gr|bauer|ruemmler|
               eggleston|mcgahn', employee_name)) %>% 
  group_by(year) %>% 
  summarize(count = n()) %>% 
  arrange(year)

## Gender Analysis
salaries %>% 
  group_by(gender) %>%
  tally() %>% 
  ggplot(aes(gender, n)) +
  geom_bar(stat = 'identity')

salaries %>% 
  filter(year == 2017, status == 'employee') %$% 
  t.test(salary[gender == 'male'], salary[gender == 'female'])

salaries %>% 
  ggplot(aes(gender, salary, fill = gender)) +
  geom_point(position=position_jitter(width=.11),col="grey") +
  geom_boxplot(alpha=0.5)

ggplotly(salaries %>%
           filter(status == 'employee') %>% 
           group_by(year, gender) %>%
           summarize(medianSalary = median(salary)) %>% 
           ggplot(aes(year, medianSalary)) +
           geom_line(aes(color = gender)) +
           ggtitle('White House Salaries: Men vs Women'))