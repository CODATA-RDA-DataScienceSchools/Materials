library(tidyverse)
library(here)

interviews <- read_csv(
  here("data", "SAFI_clean.csv"), 
  na = "NULL")

interviews
## Try also
view(interviews)
head(interviews)
tail(interviews)

class(interviews)

dim(interviews)
nrow(interviews)
ncol(interviews)

names(interviews)

str(interviews)
summary(interviews)

glimpse(interviews)

interviews[3,]

head_interviews <- interviews[6:1,]

interviews[,-1]

interviews[-c(7:131),]

interviews["village"]
interviews[,"village"]
interviews[["village"]]
interviews$village

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
levels(respondent_floor_type)
nlevels(respondent_floor_type)
respondent_floor_type
respondent_floor_type <- factor(respondent_floor_type, 
                                levels = c("earth", "cement"))

respondent_floor_type <- fct_recode(respondent_floor_type, brick = "cement")
levels(respondent_floor_type)
respondent_floor_type

respondent_floor_type_ordered <- factor(respondent_floor_type, 
                                        ordered = TRUE)
respondent_floor_type_ordered

as.character(respondent_floor_type)

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990))
as.numeric(year_fct)
as.numeric(as.character(year_fct))  

memb_assoc <- interviews$memb_assoc
memb_assoc <- as.factor(memb_assoc)
memb_assoc

plot(memb_assoc)

## Let's recreate the vector from the data frame column "memb_assoc"
memb_assoc <- interviews$memb_assoc

## replace the missing data with "undetermined"
memb_assoc[is.na(memb_assoc)] <- "undetermined"

## convert it into a factor
memb_assoc <- as.factor(memb_assoc)

## let's see what it looks like
memb_assoc

plot(memb_assoc)

## Rename levels.
memb_assoc <- fct_recode(memb_assoc, No = "no",
                         Undetermined = "undetermined", Yes = "yes")
## Reorder levels. Note we need to use the new level names.
memb_assoc <- factor(memb_assoc, 
          levels = c("No", "Yes", "Undetermined"))
plot(memb_assoc)

str(interviews)
library(lubridate)

dates <- interviews$interview_date
str(dates)


interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <- year(dates)
interviews

view(interviews)

char_dates <- c("7/31/2012", "8/9/2014", "4/30/2016")
str(char_dates)

as_date(char_dates, format = "%d/%m/%y")

str(mdy(char_dates))
