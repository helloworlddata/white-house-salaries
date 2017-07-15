# Senior Policy Advisor
salaries %>% 
  filter(tolower(position) == 'senior policy advisor') %>% 
  arrange(year) %>% 
  group_by(year) %>% 
  top_n(1, salary) %>% 
  ggplot(aes(year, salary)) +
  geom_line()

# Plots for Longest Employeed Staff
for (i in 1:length(longestStaff$employee_name)) {
  print(salaries %>% 
          filter(grepl(longestStaff$employee_name[[i]], employee_name)) %>% 
          ggplot(aes(year, salary)) +
          geom_line() +
          ggtitle(longestStaff$employee_name[[i]]))
}

# Special Assistant Plot
specialAssistant %>% 
  group_by(year) %>% 
  mutate(salary = median(salary)) %>% 
  ggplot(aes(year, salary)) +
  geom_line() +
  ggtitle(specialAssistant$position[[1]])


# Plots of top 10 jobs by count of staff
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

# Bar plots of Men vs Women
salaries %>% 
  group_by(gender, year) %>%
  tally() %>% 
  ggplot(aes(year, n, fill = gender)) +
  geom_bar(stat = 'identity')

# Boxplot of Gender & Salaries
salaries %>%
  group_by(year = as.factor(year)) %>% 
  ggplot(aes(year, salary, fill = gender)) +
  geom_boxplot(alpha = .5) +
  ggtitle('Boxplot: Gender & Salaries')

# Boxplot Male vs Female
salaries %>% 
  ggplot(aes(gender, salary, fill = gender)) +
  geom_point(position=position_jitter(width=.11),col="grey") +
  geom_boxplot(alpha=0.5)

wageGap %>% 
  ggplot(aes(year, wageGap)) +
  geom_line(size = 1.5) +
  ggtitle('Wage Gap - White House Salaries')