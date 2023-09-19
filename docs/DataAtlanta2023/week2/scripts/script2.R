3+5
12/7

area_hectares <- 1 # land area in hectares
area_acres <- 2.47*area_hectares # convert to acres
area_acres # print land area in acres


r_length <- 2.5
r_width <- 3.2
r_area <- r_length * r_width
r_area

# change the values of r_length and r_width
r_length <- 7.0
r_width <- 6.5
r_area <- r_length * r_width
r_area

a <- 4
b <- sqrt(a)
b

round(3.14159,0)
round(digits = 2, x =3.14159)
round(2, 3.14159)

hh_members <- c(3, 7, 10, 6)
hh_members

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type

length(hh_members)
length(respondent_wall_type)

typeof(hh_members)
typeof(respondent_wall_type)

str(hh_members)
str(respondent_wall_type)

possessions <- c("bicycle", "radio", "television")
possessions <- c(possessions, "mobile_phone") # add to the end of the vector
possessions <- c("car", possessions) # add to the beginning of the vector
possessions

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
combined_logical <- c(num_logical, char_logical)

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")
respondent_wall_type[1]

more_respondent_wall_type <- respondent_wall_type[c(1, 2, 3, 2, 1, 3)]
more_respondent_wall_type

hh_members <- c(3, 7, 10, 6)
hh_members[c(TRUE, FALSE, TRUE, TRUE)]

hh_members > 5
hh_members[hh_members > 5]

hh_members[hh_members < 4 | hh_members > 7]

hh_members[hh_members >= 4 & hh_members <= 7]

possessions <- c("car", "bicycle", "radio", "television", "mobile_phone")
possessions[possessions == "car" | possessions == "bicycle"] # returns both car and bicycle

possessions[possessions %in% c("car", "bicycle")]

possessions[possessions %in% c("car", "bicycle", "motorcycle", "truck", "boat", "bus")]

rooms <- c(2, 1, 1, NA, 7)
mean(rooms, na.rm = TRUE)

is.na(rooms)
na.omit(rooms)
complete.cases(rooms)

rooms[!is.na(rooms)]
sum(is.na(rooms))

rooms[complete.cases(rooms)]
