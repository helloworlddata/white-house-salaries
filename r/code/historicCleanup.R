library(rvest)
library(tidyverse)
library(magrittr)

wp01 <- read_html('http://www.washingtonpost.com/wp-srv/onpolitics/transcripts/whitehousesalaries.htm')
wp03 <- read_html('http://www.washingtonpost.com/wp-srv/politics/administration/whbriefing/stafflista.html')
wp04 <- read_html('http://www.washingtonpost.com/wp-srv/politics/administration/whbriefing/stafflista.html')
wp05 <- read_html('http://www.washingtonpost.com/wp-srv/politics/administration/whbriefing/2005stafflista.html')
wp06 <- read_html('http://www.washingtonpost.com/wp-srv/opinions/graphics/2006stafflistsalary.html')
wp07 <- read_html('http://www.washingtonpost.com/wp-srv/opinions/graphics/2007stafflistsalary.html')
wp08 <- read_html('http://www.washingtonpost.com/wp-srv/opinions/graphics/2008stafflistsalary.html')

salaries01 <- wp01 %>% 
  html_nodes('table') %>%
  html_table(fill = TRUE) %>% 
  .[[8]] %>% 
  as.data.frame() %>% 
  mutate(year = 2001) %>% 
  write_csv("../data/raw/2001.csv")

colnames(salaries01) = c("employee_name","position", "salary", "year")

salaries03 <- wp03 %>% 
  html_nodes('table') %>%
  html_table() %>% 
  as.data.frame() %>% 
  mutate(year = 2003) %>% 
  write_csv("../data/raw/2003.csv")
  
colnames(salaries03) = c("lastName","firstName", "position", "salary", "year")

salaries04 <- wp04 %>% 
  html_nodes('table') %>%
  html_table() %>%
  as.data.frame() %>% 
  mutate(year = 2004) %>% 
  write_csv("../data/raw/2004.csv")

colnames(salaries04) = c("lastName","firstName", "position", "salary", "year")

salaries05 <- wp05 %>% 
  html_nodes('table') %>%
  html_table(fill = TRUE) %>% 
  .[[6]] %>% 
  as.data.frame() %>% 
  mutate(year = 2005) %>% 
  write_csv("../data/raw/2005.csv")

colnames(salaries05) = c("name", "position", "salary", "year")

salaries06 <- wp06 %>% 
  html_nodes('table') %>%
  html_table() %>% 
  as.data.frame() %>% 
  mutate(year = 2006) %>% 
  write_csv("../data/raw/2006.csv")

colnames(salaries06) = c("salary", "name", "position", "year")

salaries07 <- wp07 %>% 
  html_nodes('table') %>%
  html_table() %>% 
  as.data.frame() %>% 
  mutate(year = 2007) %>% 
  write_csv("../data/raw/2007.csv")

colnames(salaries07) = c("name", "salary", "position", "year")

salaries08 <- wp08 %>% 
  html_nodes('table') %>%
  html_table() %>% 
  as.data.frame() %>% 
  mutate(year = 2008) %>% 
  write_csv("../data/raw/2008.csv")

colnames(salaries08) = c("name", "salary", "position", "year")

salaries01 %<>% 
  mutate(employee_name = tolower(employee_name),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  filter(!is.na(salary)) %>% 
  select(employee_name, salary, position, year, status)

salaries03 %<>% 
  mutate(employee_name = tolower(paste(lastName, firstName, sep = ", ")),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salaries04 %<>% 
  mutate(employee_name = tolower(paste(lastName, firstName, sep = ", ")),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salaries05 %<>% 
  mutate(employee_name = tolower(name),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salaries06 %<>% 
  mutate(employee_name = tolower(name),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salaries07 %<>% 
  mutate(employee_name = tolower(name),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salaries08 %<>% 
  mutate(employee_name = tolower(name),
         status = if_else(grepl("\\*", salary), "detailee", "employee"),
         salary = as.double(gsub("\\$|\\,|\\*", "", salary)),
         position = tolower(position)) %>% 
  select(employee_name, salary, position, year, status)

salariesNew %<>% 
  select(employee_name, salary, position, year, status)

salaries <- rbind(salariesNew, salaries01, salaries03, salaries04, salaries05, salaries06, salaries07, salaries08)

salaries %<>% 
  mutate(employee_name = tolower(gsub("\\.", "", employee_name)),
         position = tolower(position),
         status = as.factor(tolower(status))) %>% 
  filter(!is.na(salary)) %>% 
  write_csv('../data/compiled/white-house-salariesNew.csv')