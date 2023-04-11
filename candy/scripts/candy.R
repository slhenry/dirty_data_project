# halloween candy project

library(tidyverse)
library(janitor)
library(here)
library(stringr)
library(readxl)

candy_2015 <- read_xlsx("raw_data/boing-boing-candy-2015.xlsx")
candy_2016 <- read_xlsx("raw_data/boing-boing-candy-2016.xlsx")
candy_2017 <- read_xlsx("raw_data/boing-boing-candy-2017.xlsx")


names(candy_2015)
candy_2015_clean <- clean_names(candy_2015)
candy_2016_clean <- clean_names(candy_2016)

dim(candy_2015_clean)
dim(candy_2016_clean)

# rename some of the column headings to be the same, to avoid extra columns
candy_2016_clean <- candy_2016_clean %>% 
  rename(licorice = licorice_yes_black)

# rename some of the column headings to be the same, to avoid extra columns
candy_2016_clean <- candy_2016_clean %>% 
  rename(bonkers = bonkers_the_candy,
         box_o_raisins = boxo_raisins)

# rename some of the column headings to be the same, to avoid extra columns
candy_2016_clean <- candy_2016_clean %>% 
  rename(dark_chocolate_hershey = dark_chocolate_hersheys)


# add rows from 2016 to the data from 2015
candy_2015_2016 <- bind_rows(candy_2015_clean, candy_2016_clean)
dim(candy_2015_2016)

# clean column headings for candy 2017 dataset
candy_2017_clean <- clean_names(candy_2017)


# candy 2017 column headings all contain "Qx_" prefix, which needs to be removed before binding to the other dataset. 
candy_2017_clean <-str_sub("^[^_]*_",colnames(candy_2017_clean)


# add rpws frp, 2017 to the data from 2015+2016
# candy_all_years <- bind_rows(candy_2015_2016, 

