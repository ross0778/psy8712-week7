# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(lubridate)
library(GGally)
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



# Visualization
ggpairs(week7_tbl %>% 
          select(starts_with("q")))

week7_tbl %>% 
  ggplot(aes(x = timeStart, y = q1)) +
  geom_point() + 
  labs(x = "Date of Experiment", y = "Q1 Score")


week7_tbl %>% 
  ggplot(aes(x = q1, y = q2, color = gender)) +
  geom_jitter() +
  labs(x = "q1", y = "q2", color = "Participant Gender")

week7_tbl %>% 
  ggplot(aes(x = q1, y = q2)) +
  geom_jitter() +
  facet_wrap(~ gender) +
  labs(x = "Score on Q1", y = "Score on Q2")


week7_tbl %>% 
  ggplot(aes(x = gender, y = timeSpent)) +
  geom_boxplot() +
  labs(x = "Gender", y = "Time Elapsed (mins)")


week7_tbl %>% 
  ggplot(aes(x = q5, y = q7, group = condition, color = condition)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition") +
  theme(legend.position = "bottom",
        legend.background = element_rect(fill = grey(0.875)))
