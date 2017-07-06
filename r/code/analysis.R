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
  filter(!is.na(status), year == 2015) %>% 
  ggplot(aes(status, salary)) +
  geom_boxplot()

longestStaff <- salaries %>% 
  group_by(employee_name) %>% 
  summarize(years = n()) %>% 
  filter(years == 16)

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

## Office Analysis:
# White House Counsel: https://en.wikipedia.org/wiki/White_House_Counsel
counselToPresident <- salaries %>% 
  filter(grepl('miers, ha|fielding, fr|craig, gr|bauer|ruemmler|
               eggleston|mcgahn', employee_name)) %>% 
  group_by(year) %>% 
  summarize(count = n()) %>% 
  arrange(year)

## Gender Analysis
salaries %>% 
  filter(status == 'employee') %$% 
  t.test(salary[gender == 'male'], salary[gender == 'female'])

wageGap <- salaries %>% 
  group_by(year) %>% 
  summarize(wageGap = 
              round(((median(salary[gender == 'female'])/40) /
                       (median(salary[gender == 'male'])/40) * 100), 2),
            mensMedianSalary = median(salary[gender == 'male']),
            womensMedianSalary = median(salary[gender == 'female']))