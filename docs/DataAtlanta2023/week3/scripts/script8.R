library(jsonlite)
library(tidyverse)
#install.packages("jsonlite")

json_data <- read_json(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI.json"
)

download.file(
  "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI.json",
  "data/SAFI.json", mode = "wb")

json_data <- read_json("data/SAFI.json")
json_data <- read_json("data/SAFI.json", simplifyVector = TRUE)

json_data %>%
  select(where(is.list)) %>%
  glimpse()

json_data <- json_data %>% as_tibble()
glimpse(json_data)

json_data$F_liv[74]

json_data$F_liv[which(json_data$C06_rooms == 4)]


write_csv(json_data, "data_output/json_data_with_list_columns.csv")
read_csv("data_output/json_data_with_list_columns.csv")

flattened_json_data <- json_data %>% 
  mutate(across(where(is.list), as.character))
flattened_json_data

write_csv(flattened_json_data, "data_output/json_data_with_flattened_list_columns.csv")

write_csv(json_data$F_liv[[1]], "data_output/F_liv_row1.csv")

