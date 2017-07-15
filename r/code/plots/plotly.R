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
           geom_line(aes(color = level), size = 1.5)) +
           ggtitle('Assistant To The President - Median Salary')

# National Security Advisor: https://en.wikipedia.org/wiki/National_Security_Advisor_(United_States)
ggplotly(salaries %>% 
           filter(grepl('donilon, to|rice, su|jones, ja|hadley, st|
                        rice, con|flynn, mi|kellogg, ke|mcmaster, h',
                        employee_name)) %>% 
           group_by(year) %>% 
           summarize(medianSalary = median(salary)) %>% 
           ggplot(aes(year, medianSalary)) +
           geom_line(size = 1.5) +
           ggtitle('National Security Advisor - Median Salary'))

# Office Of The First Lady: https://en.wikipedia.org/wiki/Office_of_the_First_Lady_of_the_United_States
ggplotly(salaries %>%
           filter(grepl('lady', position)) %>% 
           group_by(year) %>% 
           summarize(medianSalary = median(salary)) %>% 
           ggplot(aes(year, medianSalary)) +
           geom_line(size = 1.5) +
           ggtitle('Office Of The First Lady - Median Salary'))

# Gender Analysis:
ggplotly(salaries %>%
           filter(status == 'employee') %>% 
           group_by(year, gender) %>%
           summarize(medianSalary = median(salary)) %>% 
           ggplot(aes(year, medianSalary)) +
           geom_line(aes(color = gender), size = 1.5) +
           ggtitle('White House Salaries: Men vs Women'))