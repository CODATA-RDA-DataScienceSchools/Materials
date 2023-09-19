## load the tidyverse
library(tidyverse)
library(here)

interviews <- read_csv(here("data", "SAFI_clean.csv"), na = "NULL")

## inspect the data
interviews

## preview the data
view(interviews)

interviews %>%
  select(key_ID, village, interview_date, instanceID)

interviews %>%
  filter(village == "Chirodzo") %>%
  select(key_ID, village, interview_date, instanceID) %>%
  sample_n(size = 10)

interviews_wide <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  pivot_wider(names_from = respondent_wall_type,
              values_from = wall_type_logical,
              values_fill = list(wall_type_logical = FALSE))

interviews_long <- interviews_wide %>%
  pivot_longer(cols = c(burntbricks, cement, muddaub, sunbricks),
               names_to = "respondent_wall_type",
               values_to = "wall_type_logical") %>%
  filter(wall_type_logical) %>%
  select(-wall_type_logical)

interviews_items_owned <- interviews %>%
  separate_rows(items_owned, sep = ";") %>%
  replace_na(list(items_owned = "no_listed_items")) %>%
  mutate(items_owned_logical = TRUE) %>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical = FALSE))

nrow(interviews_items_owned)

interviews_items_owned %>%
  filter(television) %>%
  group_by(village) %>%
  count(bicycle)

interviews_items_owned %>%
  mutate(number_items = rowSums(select(., bicycle:car))) %>%
  group_by(village) %>%
  summarize(mean_items = mean(number_items))

interviews_months_lack_food <- interviews %>%
  separate_rows(months_lack_food, sep = ";") %>%
  mutate(months_lack_food_logical  = TRUE) %>%
  pivot_wider(names_from = months_lack_food,
              values_from = months_lack_food_logical,
              values_fill = list(months_lack_food_logical = FALSE))

interviews_months_lack_food %>%
  mutate(number_months = rowSums(select(., Jan:May))) %>%
  group_by(memb_assoc) %>%
  summarize(mean_months = mean(number_months))

interviews_plotting <- interviews %>%
  ## pivot wider by items_owned
  separate_rows(items_owned, sep = ";") %>%
  ## if there were no items listed, changing NA to no_listed_items
  replace_na(list(items_owned = "no_listed_items")) %>%
  mutate(items_owned_logical = TRUE) %>%
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical = FALSE)) %>%
  ## pivot wider by months_lack_food
  separate_rows(months_lack_food, sep = ";") %>%
  mutate(months_lack_food_logical = TRUE) %>%
  pivot_wider(names_from = months_lack_food,
              values_from = months_lack_food_logical,
              values_fill = list(months_lack_food_logical = FALSE)) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Jan:May))) %>%
  mutate(number_items = rowSums(select(., bicycle:car)))

write_csv(interviews_plotting, file = "data_output/interviews_plotting.csv")
