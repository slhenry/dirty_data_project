# Dirty data project

# Task 1: Decathlon data 

library(tidyverse)
library(janitor)
library(stringr)

# read in data
decathlon_raw <- readRDS("data/decathlon.rds")

# view data 
head(decathlon_raw)
class(decathlon_raw)
names(decathlon_raw)

# clean heading names
decathlon_clean <- decathlon_raw %>% 
  clean_names()

# find rownames
rownames(decathlon_clean)

# change rownames to a column variable
decathlon_clean <- cbind(rownames(decathlon_clean), data.frame(decathlon_clean, row.names=NULL)) 

# rename the rownames(decathalon_clean) column name to "name"
decathlon_clean <- decathlon_clean %>% 
  rename(name = `rownames(decathlon_clean)`)


# rename the column headings with spelling mistakes
decathlon_clean <- decathlon_clean %>% 
  rename(javelin = javeline)

# rename the column headings to remove x
decathlon_clean <- decathlon_clean %>% 
  rename(hurdle_110m = x110m_hurdle)


# rename the column headings to remove x
decathlon_clean <- decathlon_clean %>% 
  rename(run_100m = x100m,
         run_1500m = x1500m,
         run_400m = x400m)

# change names to lower case
decathlon_clean <- decathlon_clean %>% 
  mutate(name = str_to_lower(name))

# write decathlon_clean into csv file and save
write_csv(decathlon_clean, "data/decathlon_clean.csv", append = FALSE)
