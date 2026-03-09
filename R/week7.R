# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
#library calls
#library calls

# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv") %>% 
  mutate(gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female")),
         condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")),
         timeStart = ymd_hms(timeStart),
         timeEnd = ymd_hms(timeEnd)
         ) %>% 
  filter(q6 == 1) %>% 
  select(-q6) %>% 
  mutate(timeSpent = as.numeric(difftime(timeEnd, timeStart, units = "mins")))
