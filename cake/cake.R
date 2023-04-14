library(tidyverse)
library(here)
library(janitor)


# read in data
cake_raw <- read_csv(here("raw_data/cake-ingredients-1961.csv"))
cake_code <- read_csv(here("raw_data/cake_ingredient_code.csv"))
                     
# pivot cake_raw to long format
cake_long <- cake_raw %>% 
  pivot_longer(cols = AE: ZH,
               names_to = "ingredient_code",
               values_to = "amount")


# join the cake code into the longer format table
cake_join <- full_join(
  cake_long, cake_code, by = c("ingredient_code" = "code")
)


# clean up dataset
clean_names(cake_join)

cake_clean <- cake_join %>% 
  select(Cake, amount, ingredient, measure) %>% 
  filter(!is.na(amount)) 

#clean up cakes further
cake_clean %>% 
  rename(cake = Cake) %>% 
  mutate(ingredient = case_match(ingredient, "Sour cream cup" ~ "sour cream", .default = ingredient),
         measure = if_else(is.na(measure) & ingredient == "sour cream", "cup", "measure"))

# write file to csv in cleaned data
write.csv(cake_clean, "raw_data/cake_clean.csv", row.names = FALSE)
                     