
# INTRODUCTION ------------------------------------------------------------


# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

## Under Files tab -> click on New Project -> 
## New Directory -> New Project ->
## Type "my_project" as directory name -> Create Project

## Under Files tab -> click on New Folder -> create new folder called "data"
   # Alternatively, you can type dir.create("data")
   # Use this folder to store raw data
   # Always keep your raw data raw!
   # Separate processed data from raw data
   # Create another directory for data_output, fig_output and scripts

## Create new R script in your working directory -> click on symbol -> R Script -> my_script.R
  # Move the script to the scripts directory

## Your working directory should look like:

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# CREATING OBJECTS --------------------------------------------------------

# Type the following in the CONSOLE:

## Get output from R by typing math in console
3 + 5
12 / 7

## Assign values to objects
   # Give it a name
   # Assignment operator <- (Alt + "-")
   # Value
weight_kg <- 55 
   # assigns value on right to object on left, i.e. 55 goes into weight_kg
   # no output is printed in console -> stored in memory (Environment)
   
   # To print the value, type the name of the object:
weight_kg
 
   # R is case-sensitive, i.e. x is different from X
   # don't use names of functions, such as c, mean, etc.
   # avoid dots -> many functions in R with dots in their names (special meaning)
   # names can't start with numbers
   # use a consistent style

# Convert weight from kg to pounds
2.2 * weight_kg

# Change a variable's value
weight_kg <- 57.5
2.2 * weight_kg

# Assigning a value to one variable does not change values of other variables
# Let's store the animal's weight in pounds in a new variable
weight_lb <- 2.2 * weight_kg
2.2 * weight_kg -> weight_lb # alternative

# Now change weight_kg to 100
weight_kg <- 100

# What will the value of weight_lb be? 126.5 or 220?
weight_lb

## Saving your code
# Up to now, your code has been in the console
# Not useful for reproducibility
# Save the script as my_script.R

## Comments (Ctrl + Shift + c)
   # Anything to the right of # symbol will be ignored by R
   # Useful to make notes/explanations in your scripts

# CHALLENGE 1 -------------------------------------------------------------

# 1.1. Run the following code and indicate what the values 
# are after each statement:

mass <- 47.5            
# mass = 47.5

age  <- 122
# age = 122

mass_index <- mass/age
# mass_index = 0.389

mass <- mass * 2.0
# mass = 95

mass_index
# mass_index = 0.389 #it didn't change - need to rerun line 92

# . -----------------------------------------------------------------------

# . -----------------------------------------------------------------------
# . PRESENTATION
# . -----------------------------------------------------------------------

# FUNCTIONS AND THEIR ARGUMENTS -------------------------------------------

a <- 9 # assign value of 9 to the object a
b <- sqrt(a) 

# value of a is given to sqrt() function
# function calculates square root and returns the value
# which is then assigned to the variable b

b

# return value doesn't need to be numerical or a single item
# it can be a set of things, or even a dataset

# Each function's arguments are different
# If arguments are left out, default values are used, called "options"
# Options alter the way a function operates, e.g. ignore "bad values"


# Let's try a function that can take multiple arguments
round(3.14159)

# we called the round function with only one argument and it returned the value 3
# it was rounded to the nearest whole number
# if you want a different number of digits, look at the arguments or look at the help
args(round)
?round
# specify the number of digits you want
round(3.14159, digits = 2)
# if you provide arguments in the exact same order as they are defined, you don't have
# to name them
round(3.14159, 2)
# if you provide arguments in a different order than they are defined, you have to name them
round(digits = 2, x = 3.14159)


# VECTORS AND DATA TYPES --------------------------------------------------

# Vector = most common and basic data type in R
# Contains series of values (numbers or characters)
# Use the concatenate function to assign series of values
weight_g <- c(50, 60, 65, 82)  # create a vector of animal weights
weight_g

# A vector can also contain characters
animals <- c("mouse", "rat", "dog") # quotes are essential
animals

# Inspect the content of a vector
length(weight_g) # tells you how many elements are in a particular vector
length(animals)

# All the elements are the same type of data
class(weight_g)
class(animals)

# To get an overview of the structure of an object and its elements
str(weight_g)
str(animals)

# Use the c() function to add elements to a vector
weight_g
weight_g <- c(weight_g, 90) # add to the end of the vector
weight_g <- c(30, weight_g) # add to the beginning of the vector
weight_g <- c(weight_g[1:3], 63, weight_g[4:6]) # add to the middle of the vector
weight_g <- append(weight_g, 70, after = 5) # add to the middle of the vector


# CHALLENGE 2 -------------------------------------------------------------

# 2.1. What will happen in each of the following examples
# (hint: use class() to check data type or look at the environment)

num_char <- c(1, 2, 3, "a")
# class(num_char) # character

num_logical <- c(1, 2, 3, TRUE)
# class(num_logical) # numeric

char_logical <- c("a", "b", "c", TRUE)
# class(char_logical) # character

tricky <- c(1, 2, 3, "4")
# class(tricky) # character

# Answer: R converted the content of the vector to find a common denominator
# Converting objects from one class into another = coercion
# Conversions happen according to a hierarchy
# e.g. logical -> numeric -> character <- logical

# . -----------------------------------------------------------------------

# SUBSETTING VECTORS ------------------------------------------------------

# Extract one or several values
animals <- c("mouse", "rat", "dog", "cat")
animals[2]
animals[c(3, 2)]
# R indices start at 1
# Other languages count from 0

# Repeat indices to create an object with more elements
more_animals <- animals[c(1,2,3,2,1,4)]
more_animals

## Conditional subsetting
# Use a logical vector to select the element with the same index
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]
# Get logicals with TRUE for indices that meet a specific condition
weight_g > 50
# So we can use this to select values above 50:
weight_g[weight_g > 50]
# Can combine multiple tests using & (both conditions true)
weight_g[weight_g >= 30 & weight_g <= 35]
# or | (at least one condition is true)
weight_g[weight_g < 30 | weight_g > 50]

# Search for the vector in certain strings:
animals
animals[animals == "cat" | animals == "rat"]
animals %in% c("rat", "cat", "dog", "duck", "goat")
animals[animals %in% c("rat", "cat", "dog", "duck", "goat")]


# CHALLENGE 3 -------------------------------------------------------------

# 3.1. Can you figure out why "four" > "five" returns TRUE
# when you run the following code?

"four" > "five"

# When using ">" or "<" on strings, R compares their alphabetical order
# Here "four" comes after "five", and therefore the above statement returns "TRUE"

# . -----------------------------------------------------------------------


# Other types of vectors:
# logical = TRUE or FALSE
# integer = 2L
# complex = 1 + 4i (real and imaginary parts)
# raw = bitstreams

# Vectors are one of many data structures in R
# Other data structures:
# lists
# matrices
# data frames
# factors
# arrays

# . -----------------------------------------------------------------------
# . PRESENTATION
# . -----------------------------------------------------------------------

# MISSING DATA ------------------------------------------------------------

# Missing data are represented in vectors as NA
# Most functions will return NA if your data contains missing values

# To ignore missing values when doing calculations, use na.rm = TRUE
heights <- c(2, 4, 4, NA, 6)
heights
mean(heights)
max(heights)
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)

# Extract those elements which are NOT missing values
heights[!is.na(heights)]

# Remove incomplete cases
na.omit(heights)
# First line of output = all cases that are not NA
# Second line of output = positions of deleted values
# Third line of output = class of deleted values

# Extract those elements which are complete cases
heights[complete.cases(heights)]



# CHALLENGE 4 -------------------------------------------------------------

# 4.1. Use the following vector (heights in inches) and create a new vector
# (called "heights_no_na") with NAs removed.

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

heights_no_na <- heights[!is.na(heights)] 
# or
heights_no_na <- na.omit(heights)
# or
heights_no_na <- heights[complete.cases(heights)]


# 4.2. Calculate the median (using the median() function) of the new heights_no_na vector.

median(heights_no_na)


# 4.3. How many people in the set are taller than 67 inches?
# Hint: Use conditional subsetting and the length() function

heights_above_67 <- heights_no_na[heights_no_na > 67]
length(heights_above_67)

# . -----------------------------------------------------------------------


# LOADING AND INSPECTING DATA ---------------------------------------------

## Download the survey data to the data sub-directory
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv")

# Load the tidyverse package
library(tidyverse) 
# If you get an error: could not find function "read_csv",
# load the tidyverse package again.

# (1) Load the data via command line
surveys <- read_csv("data/portal_data_joined.csv") # OR

# (2) Load the data via command line
surveys <- read_csv(file.choose()) #OR

# (3) Load the data using the interface
# In Environment window -> Import Dataset -> Browse for the file -> 
# Change the name to `surveys` and select Yes for headers before importing #OR

# (4) Load the data using the interface
# In Files window -> browse for file -> click on file ->
# Import Dataset -> same options as (3)

# No output, because assignments don't display anything

# . -----------------------------------------------------------------------
# . PRESENTATION
# . -----------------------------------------------------------------------

# Let's check that our data has been loaded
surveys

# Let's check the top 6 lines of this data frame
head(surveys)
head(surveys, n = 10)
View(surveys) # uppercase V

## We are studying the species and weight of animals caught in plots in our study area.
## Dataset is stored as a comma separated value (CSV) file.
## Each row = information for a single animal; each column = variable
## NB! Use the read_csv2 function if you are using different field separators
## Use the read_tsv() function for tab separated data files and
## read_delim() for less common formats.

### WHAT ARE DATA FRAMES? ###
## It's a data structure for most tabular data
## We use it for statistics and plotting
## It can be created by hand using functions or imported with read_csv() or read_table()
## Data is represented in the format of a table where columns = vectors 
## (all have the same length and each vector contains the same type of data)

## Look at the size of the data
dim(surveys) 
# dimensions: no. of rows; no. of columns

nrow(surveys) 
# no. of rows

ncol(surveys) 
# no. of clumns

## Look at the content
head(surveys)
# first 6 rows

tail(surveys)
# last 6 rows

## Look at the names
names(surveys)
# column names

rownames(surveys)
# row names

## Look at summary of data
str(surveys) 
# structure of the object and information about the class, length and content of each column

summary(surveys)
# summary statistics for each column


# CHALLENGE 5 -------------------------------------------------------------


# Based on output of str(surveys), answer the following:
str(surveys)

# 5.1. What is the data structure of the object surveys?  
# dataframe

# 5.2. How many rows and columns are in this object?  
# 34786 rows, 13 columns

# . -----------------------------------------------------------------------


# INDEXING AND SUBSETTING DATA FRAMES -------------------------------------

surveys[1, 1]  # 1st element in 1st column
surveys[1, 6]  # 1st element in 6th column
surveys[, 1]  # 1st column
surveys[1]  # 1st column
surveys[1:3, 7]  # 1st 3 elements in 7th column
surveys[3, ]  # 3rd element for all columns
head_Surveys <- surveys[1:6, ]  # same as head(surveys)
head_Surveys


# Exclude certain parts of a data frame
surveys[, -1]  # the whole data frame except 1st column
surveys[-(7:34786), ]  # same as head(surveys)

# Subset columns by names
surveys["species_id"]  # data.frame
surveys[, "species_id"]   # data.frame 
surveys[["species_id"]]   # vector  
surveys$species_id    # vector


# CHALLENGE 6 -------------------------------------------------------------

# 6.1. Create a `data.frame` (`surveys_200`) containing only the
#    200th observation of the `surveys` dataset.
surveys_200 <- surveys[200, ]  # extract observations from row 200

# 6.2. Notice how `nrow(surveys)` gave you the number of rows in a `data.frame`?
#    6.2.1. Use that number to pull out just that last row in the data frame (surveys).
n_rows <- nrow(surveys)  # get the number of rows in surveys dataset: 34786
surveys_last <- surveys[n_rows, ]  # get the last row by using previous answer

#    6.2.2. Compare that with what you see as the last row using `tail()` 
#         to make sure it's meeting expectations.
tail(surveys, n = 1)  # compare this with previous result

# 6.3. Use `nrow()` to extract the row that is in the middle of the data frame.
#    Store the content of this row in an object named `surveys_middle`.
surveys_middle <- surveys[n_rows/2, ]

# 6.4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
#   `head(surveys)` keeping just the first through 6th rows of the surveys dataset.
surveys[-(7:n_rows),]

# . -----------------------------------------------------------------------

# FACTORS -----------------------------------------------------------------

## When we did str(surveys), we saw several columns consisting of numeric data (col_double)
## Several columns contained character data (col_character) which should be categorical
## R has a special class for working with categorical data, called factor
## Factors can only contain a pre-defined set of values, known as levels (by default sorted alphabetically)
## Factors are stored as integers and have labels (text) associated with these unique integers
## Factors can be ordered or unordered
## While factors look like character vectors, they are actually treated as integers

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# Let's create a factor with 3 levels
animal_sizes <- factor(c("M", "S", "S", "M", "L", "M"))  # c = concatenate
# R will assign 1 to the level 'L', 2 to 'M', and 3 to 'S'

# Check this level assignment
levels(animal_sizes)  # check the levels, i.e. L, M, S

# Check number of levels
nlevels(animal_sizes)  # check the number of levels, i.e. 3
animal_sizes  # [1] M S S M L M - before ordering - levels: L M S

# Sometimes the order of the factors does not matter, 
# other times you might want to specify the order (e.g. low, medium, high)
# Let's reorder the levels
animal_sizes <- factor(animal_sizes, levels = c("S", "M", "L"))
animal_sizes  # [1] M S S M L M - after ordering - levels: S M L
# In R's memory these factors are represented by integers (1,2,3)


## Converting factors

# Convert a factor to a character vector
as.character(animal_sizes)  

# To convert factors to numbers...
# 1st convert factors to characters, then to numbers
year_fct <- factor(c(1990, 1983, 1977, 1998, 1990)) 
as.numeric(year_fct)  #wrong!!!
as.numeric(as.character(year_fct))  #works...
as.numeric(levels(year_fct))[year_fct]  #recommended way
# 1. obtain all the factor levels using levels(year_fct)
# 2. convert levels to numeric values using as.numeric(levels(year_fct))
# 3. access numeric values using the integers of the vector year_fct

## Renaming factors

# When your data is stored as a factor, you can use the plot() function to get a quick glance at it.

# Let's convert the sex variable from character to factor
surveys$sex <- factor(surveys$sex)

# no. of observations represented by each factor level
plot(surveys$sex)  # bar plot of number of females and males (by default, NA values excluded)

# Let's pull out the data on sex 
sex_data <- surveys$sex
head(sex_data)  # view first few lines
levels(sex_data)  # view levels (missing data not shown as a level)

# Let's add the NA values
sex_data <- addNA(sex_data)
plot(sex_data) # No label for the missing data

levels(sex_data) 
levels(sex_data)[3] <- "undetermined"  # use indexing and replace NA with "undetermined"
levels(sex_data)
head(sex_data)
plot(sex_data)


# CHALLENGE 7 -------------------------------------------------------------

# 7.1. Rename "F" and "M" to "female" and "male", respectively

levels(sex_data)[1] <- "female"
levels(sex_data)[2] <- "male"

# OR rename both at the same time
levels(sex_data)[1:2] <- c("female", "male")

# OR recode the levels by name
levels(sex_data) <- list(female = "F", male = "M")

# 7.2. Check that the levels have been renamed
levels(sex_data)

plot(sex_data)

# 7.3. Recreate the bar plot such that "undetermined" is first (before "female")
sex_data_ordered <- factor(sex_data, levels = c("undetermined", "female", "male"))
plot(sex_data_ordered)

# . -----------------------------------------------------------------------

# CHALLENGE 8 -------------------------------------------------------------

# Instead of creating a data frame with read.csv(), you can create your own using data.frame()

# 8.1. The following code has a few mistakes. Try to fix it. 
# missing quotes in 'animals' column
# missing entry in 'feel' column
# missing one comma in 'weight' column

# Now fix the code:
animal_data <- data.frame(animal=c("dog", "cat", "sea cucumber", "sea urchin"),
                          feel=c("furry", "squishy", "spiny", "smooth"),
                          weight=c(45, 8, 1.1, 0.8))
animal_data


# 8.2. Can you predict the class for each of the columns in the following example?
     # Check your guesses using `str(country_climate)`:

country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1))

str(country_climate)

#      8.2.1. Are they what you expected? Why? Why not?
#      No - almost all variables are characters

#      8.2.2. What would you need to change to ensure that each column had the
#        accurate data type?
#      Remove the quotes around numbers and logicals and make sure data type is the same for each vector.

# Be aware of the automatic conversion of data types!
# The coersion rule goes logical -> numeric -> character <-logical.

# 1. remove quotes in temperature and northern_hemisphere
# 2. replace 1 by TRUE in has_kangaroo column


# . -----------------------------------------------------------------------

# FORMATTING DATES --------------------------------------------------------

# One common issue: converting date and time information 
# into a variable that is appropriate and usable during analyses

# Store each component of your date separately, like the 'surveys' dataset
str(surveys)

## Install and load the tidyverse package

# Install package via command line
install.packages("tidyverse") # only install a package ONCE

# Install package via interface
# Package -> Install -> Type name of package(s) -> Install 

# Load the tidyverse and lubridate packages

# Load the package via command line
library(tidyverse)  # load the package every time you start a new R session
# If it gives an error that it requires another package, just install and load that specific package
library(lubridate) # part of tidyverse package

# Load the package via interface
# Check the box next to the name of the installed package in the package manager window

# Create a date object and inspect the structure
my_date <- ymd("2015-01-01")
str(my_date)
# The ymd() function takes a vector representing year, month and day
# and converts it to a Date vector that is recognized by R

# Paste the year, month and day separately - get the same result
my_date <- ymd(paste("2015", "1", "1", sep = "-"))
str(my_date)

# Let's apply the paste function to the surveys dataset
# Create character vector from year, month and day columns
paste(surveys$year, surveys$month, surveys$day, sep = "-")
# sep indicates the character to use to separate each component

# Create a date vector using the ymd() function
ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

# Note: there are also a dmy, mdy, ydm, etc. functions - depending on order of your dates

# Now add this date vector as new date column in surveys
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
str(surveys) # notice the new column, with 'date' as the class

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# Inspect the new column
summary(surveys$date)
# Something went wrong! Some dates are missing

# Let's investigate where they are coming from
# Identify the rows in our data frame that are failing
# Extract the columns year, month and day
is.na(surveys$date)
surveys[is.na(surveys$date)] # Error - R doesn't know which columns you want to return.
missing_dates <- surveys[is.na(surveys$date), c("year", "month", "day")]
head(missing_dates)

# Why did these dates fail to parse?
# April (month 4) and September (month 9) only has 30 days, not 31

# Let's fix this:
# Separately (one by one)
surveys$day[surveys$month == 4 & surveys$day == 31] <- 30

surveys$day[surveys$month == 9 & surveys$day == 31] <- 30

# OR simultaneously
surveys$day[surveys$month == 4 | surveys$month == 9 & surveys$day == 31] <- 30

# Remember that columns don't automatically update like Excel, so redo date column
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))

# DATA MANIPULATION USING dplyr AND tidyr ---------------------------------

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

## Read in the original data
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)
surveys

## Selecting columns and filtering rows

# Select specific columns
select(surveys, plot_id, species_id, weight)

# To select all columns EXCEPT certain ones, use "-"
select(surveys, -record_id, -species_id)

# Choose rows based on specific criteria or conditions
filter(surveys, year == 1995)

# What if you want to select and filter at the same time?
# 1. use intermediate steps
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)
# clutter up your workspace
# hard to keep track of multiple steps

# 2. use nested functions
surveys_sml <- select(filter(surveys, weight < 5), species_id, sex, weight)
# difficult to read
# R evaluates the expression from the inside out (first filtering, then selecting)

# 3. use pipes - recommended way!

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# Pipes

surveys %>%  # Shortcut = Ctrl + Shift + M
  filter(weight < 5) %>%
  select(species_id, sex, weight)

# create a new object with the smaller version of the data
surveys_sml <- surveys %>%
  filter(weight < 5) %>%
  select(species_id, sex, weight)

surveys_sml

# pipes let you take output of one function and use as input for the next function

# CHALLENGE 9 -------------------------------------------------------------

# Using pipes, subset the survey data to include individuals collected before
# 1995 and retain only columns "year", "sex", and "weight"

surveys %>%
  filter(year < 1995) %>%
  select(year, sex, weight)


# . -----------------------------------------------------------------------


## Mutate

# Create new columns based on values in existing columns

surveys %>%
  mutate(weight_kg = weight / 1000)

surveys %>%
  mutate(weight_kg = weight / 1000) %>%
  head()
# the first few rows are full of NAs

# remove NAs by using filter()
surveys %>%
  filter(!is.na(weight)) %>%
  mutate(weight_kg = weight / 1000) %>%
  head()


# CHALLENGE 10 ------------------------------------------------------------

# Create a new data frame from survey data with the following:
#       * New column called "hindfoot_cm" containing the hindfoot_length values (currently in mm) converted to centimeters
#       * In the hindfoot_cm column, there are no NAs and all values are less than 3
#       * Only keep the species_id and hindfoot_half columns

surveys_hindfoot_cm <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%  # first remove missing hindfoot_length values
  mutate(hindfoot_cm = hindfoot_length / 10) %>%  # create new column
  filter(hindfoot_cm < 3) %>%  # only keep values less than 3
  select(species_id, hindfoot_cm)  # only keep two columns

surveys_hindfoot_cm

# . -----------------------------------------------------------------------

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# SPLIT-APPLY-COMBINE ANALYSIS --------------------------------------------

# Split data into groups > apply some analysis to each group > combine results
# Do this using the group_by() function
# Summarize() function is often used together with group_by()
# It collapses each group into a single-row summary of that group

# Calculate the mean weight by sex
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight))

# Calculate the mean weight by sex - remove NA
surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))
# dplyr changed data.frame to tbl_df and only prints first few rows

# You can also group by multiple columns
surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>%
  tail()

# Alternative: First remove missing values (NA) for weight before calculating summary statistics
surveys %>%
  filter(!is.na(weight)) %>%  
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight)) %>%
  tail()

# If you want to display more data, use the print() function
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight)) %>%
  print(n = 50)

# Once data is grouped, you can summarize multiple variables simultaneously
# Example, calculate the mean and minimum weight for each species for each sex
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight))  

## Arrange()
# Sort data to put the species with the lowest weight first
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(min_weight)

# You can also sort in descending order
surveys %>%
  filter(!is.na(weight)) %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight),
            min_weight = min(weight)) %>%
  arrange(desc(min_weight))

## Counting
# Count the number of observations for each variable or combination of variables
surveys %>%
  count(sex)

# Count is shorthand for group_by and summarise
surveys %>%
  group_by(sex) %>% 
  summarize(total = n())

# Count provides the sort argument for convenience
surveys %>%
  count(sex, sort = TRUE)

# Count a combination of variables
surveys %>%
  count(sex, species) 

# To sort the table (with multiple variables), use the arrange() function
surveys %>%
  count(sex, species) %>%
  arrange(species, desc(n))


# CHALLENGE 11 ------------------------------------------------------------

# 11.1. How many individuals were caught in each "plot_type" surveyed?
surveys %>%
  count(plot_type)

# 11.2. Use group_by() and summarize() to find the mean, min, and max 
#    hindfoot_length for each species ID (using species_id). Also add
#    the number of observations (hint: see ?n).
surveys %>%
  filter(!is.na(hindfoot_length)) %>%  # first remove missing values
  group_by(species_id) %>%
  summarize(
    mean_hindfoot_length = mean(hindfoot_length),
    min_hindfoot_length = min(hindfoot_length),
    max_hindfoot_length = max(hindfoot_length),
    total = n())

# 11.3. What was the heaviest animal measured in each year?

# Solution 1

surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year, species_id) %>% 
  summarise(weight_max = max(weight)) %>% 
  filter(weight_max == max(weight_max))

# Solution 2

surveys %>%
  filter(!is.na(weight)) %>%  # remove missing values
  group_by(year) %>%
  filter(weight == max(weight)) %>%
  arrange(year) %>%
  select(year, species_id, weight) %>% 
  slice(1)

# . -----------------------------------------------------------------------


# RESHAPING WITH pivot_longer AND pivot_wider ----------------------------------------

# Remember the 4 rules of defining tidy data:
# 1. Each variable has its own column
# 2. Each observation has its own row
# 3. Each value must have its own cell
# 4. Each type of observational unit forms a table

# What if instead of comparing records, 
# we wanted to compare the different mean weight 
# of each genus between plots?

# This means the values of the genus column would 
# become the names of column variables and the cells 
# would contain the values of the mean weight observed on each plot.

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# First filter observations and variables of interest,
# then create a new variable for the mean_weight

surveys_gw <- surveys %>%   # create new variable
  filter(!is.na(weight)) %>%   # remove missing weight
  group_by(plot_id, genus) %>% 
  summarize(mean_weight = mean(weight))  # create mean_weight column

str(surveys_gw)

# Use pivot_wider() to transform surveys to find the mean weight of each genus in each plot over the entire survey period
surveys_gw %>% 
  pivot_wider(names_from = genus,
              values_from = mean_weight)

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# First filter observations and variables of interest,
# then create a new variable for the mean_weight

surveys_gw <- surveys %>%   # create new variable
  filter(!is.na(weight)) %>%   # remove missing weight
  group_by(plot_id, genus) %>% 
  summarize(mean_weight = mean(weight))  # create mean_weight column

str(surveys_gw)

# Use pivot_wider() to reshape the data

surveys_wide <- surveys_gw %>% 
  pivot_wider(names_from = genus,
              values_from = mean_weight)

surveys_wide

# Use pivot_longer() to recreate the surveys_gw data frame.
surveys_long <- surveys_wide %>%
  pivot_longer(names_to = "genus", values_to = "mean_weight", cols = -plot_id)

surveys_long
# Note that now the NA genera are included in the long format data frame. 

# CHALLENGE 12 ------------------------------------------------------------

# 12.1. Pivot the surveys data frame with `year` as columns, 
#    `plot_id` as rows, and 
#    the values are the number of unique genera per plot. 
#    You will need to summarize before reshaping, and 
#    use the function `n_distinct` to get the number of unique types of a genera. 
#    It's a powerful function! See `?n_distinct` for more information.

surveys_wide_genera <- surveys %>%
  group_by(plot_id, year) %>%
  summarize(n_genera = n_distinct(genus)) %>%
  pivot_wider(names_from = year,
              values_from = n_genera)

head(surveys_wide_genera)

# 12.2. Now take that data frame, and gather() it again, 
#    so each row is a unique `plot_id` by `year` combination

surveys_wide_genera %>%
  pivot_longer(names_to = "year",
               values_to = "n_genera",
               cols = -plot_id)

# 12.3. The `surveys` data set contains two columns of measurement - 
#    `hindfoot_length` and `weight`.  
#    This makes it difficult to do things like look at the 
#    relationship between mean values of each measurement 
#    per year in different plot types. Let's walk through 
#    a common solution for this type of problem. 

#    First, use `pivot_longer()` to create a dataset where 
#    we have a column called `measurement` and a `value` 
#    column that takes on the value of either `hindfoot_length` 
#    or `weight`. Hint: You'll need to specify which columns 
#    will be part of the reshape.

surveys_long <- surveys %>%
  pivot_longer(names_to = "measurement",
  	values_to = "value",
  	cols = c(hindfoot_length, weight))

surveys_long

#    With this new dataset, calculate the average 
#    of each `measurement` in each `year` for each different 
#    `plot_type`. Then `pivot_wider` them into a data set with 
#    a column for `hindfoot_length` and `weight`. 

surveys_long %>%
  group_by(year, measurement, plot_type) %>%
  summarize(mean_value = mean(value, na.rm = TRUE)) %>%
  pivot_wider(names_from = measurement,
              values_from = mean_value)

# . -----------------------------------------------------------------------


# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# EXPORTING DATA ----------------------------------------------------------

## Subset the data and remove all missing data, i.e. clean your data

surveys_clean <- surveys %>%
  filter(!is.na(weight),           # remove missing (NA) weight
         !is.na(hindfoot_length),  # remove missing (NA) hindfoot_length
         !is.na(sex))              # remove missing (blank cells) sex


# We are interested in plotting how species abundance have changed through time
# Remove observations for rare species (observed less than 50 times)
species_counts <- surveys_clean %>%
  count(species_id) %>% 
  filter(n >= 50)

# Only keep the most common species
surveys_complete <- surveys_clean %>%
  filter(surveys_clean$species_id %in% species_counts$species_id)
# use dim(surveys_complete) to check that there are 30463 rows and 13 columns

## Save the surveys_complete dataset as a CSV file in your data_output folder
write_csv(surveys_complete, path = "data_output/surveys_complete.csv")


# DATA VISUALIZATION WITH ggplot2 -----------------------------------------

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

## Plotting with ggplot2
library(tidyverse)

# Use the 'surveys_complete' data set that we exported in the previous step
# If not still in the workspace, load the data
surveys_complete <- read_csv("data_output/surveys_complete.csv")

# Bind the plot to a specific data frame
ggplot(data = surveys_complete)  
# ggplot() creates a coordinate system that you can add layers to
# output: grey block
# If you get an error about "invalid graphics state", run "dev.off()" in the console

# define mapping (aesthetics (aes)), by selecting variables to be plotted
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length))  
# output: grey block + gridlines + axes

# add geoms_(points/lines/bars) graphical representation of data in plot
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()   # "+" must be at end of each line containing a layer
# The + sign is used to add new layers
# It must be placed at the end of the line containing the previous layer

## Assign the plot to a variable to create a plot template
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))  
# no output - just assigned to object

# Draw the plot
surveys_plot + geom_point()

# This is the correct syntax for adding layers
surveys_plot +     # "+" at the end of each line
  geom_point()

# This will not add the new layer
surveys_plot
+ geom_point()    # "+" on the wrong line

# Scatter plots can be useful for small datasets
# It may show patterns, i.e. x is associated with y
# It may also display clusters, as you can see in this plot

# For large datasets, overplotting of points can be a limitation
# Handle this by using hexagonal binning of observations

install.packages("hexbin")
library(hexbin)

surveys_plot +
  geom_hex()
# The plot space is tessellated (covered) into hexagons
# Each hexagon is colored according to number of observations


# BUILDING PLOTS ITERATIVELY ----------------------------------------------

# Define dataset to use, lay the axes and choose a geom
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

# Start modifying the plot to extract more information
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)
# alpha adds transparency to avoid overplotting - lower alpha = more transparency

# Add color for all the points
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "blue")

# Add a color to each genus in the plot differently
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = genus))

# We can also specify the colors directly inside the global mapping
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point(alpha = 0.1)

# Global vs local mappings
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_point(alpha = 0.1, color = "blue") # local mapping overrides global mapping

# We can change the geom layer and colors can still be determined by genus
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, color = genus)) +
  geom_jitter(alpha = 0.1)


# CHALLENGE 13 ------------------------------------------------------------

# Create a scatter plot of weight over genus
# with the plot_type variable showing in different colors

ggplot(data = surveys_complete,
	mapping = aes(x = genus, y = weight)) +
  geom_point(aes(color = plot_type))


# . -----------------------------------------------------------------------


## Boxplot

## Boxplot = visual shorthand for distribution of values

# Visualize distribution of weight within each genus
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = weight)) +
  geom_boxplot()

# box stretches from the 25th percentile of the distribution to the 75th percentile
# also known as IQR (interquartile range)
# line in middle of boxplot = median (50th percentile) of distribution
# distribution may be symmetric about the median, or skewed to one side
# whiskers go to further non-outlier points
# outliers = values > 1.5 * IQR (measured from edges of box)

# Add points to the boxplot - better idea of number of measurements and
# of their distribution
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")
# Boxplot is behind the jitter

# Redraw previous graph so that boxplot is on top of jitter
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot(alpha = 0)
# Jitter is behind the boxplot


# CHALLENGE 14 ------------------------------------------------------------

# 14.1. Boxplots are useful summaries, but hide the *shape* of the distribution.
# Replace the boxplot with a violin plot to see the shape; see geom_violin()
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = weight)) +
  geom_violin()

# 14.2. Change the scale of the axis to better distribute observations; see scale_y_log10()
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = weight)) +
  geom_violin() +
  scale_y_log10()

# 14.3. Create boxplot for distribution of hindfoot_length for each genus
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.1) # you don't have to add jitter...

# 14.4. Add color to the datapoints according to the plot from which the sample was
# taken (plot_id)
# Hint: check class for plot_id - change from integer to factor
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = hindfoot_length)) +
  geom_boxplot(aes(color = plot_id)) +
  geom_jitter(alpha = 0.3)
# This doesn't work... because plot_id is currently an integer

# Check the class for 'plot_id'
class(surveys_complete$plot_id) # numeric

# Change the class from integer to factor and plot data again
ggplot(data = surveys_complete,
       mapping = aes(x = genus, y = hindfoot_length)) +
  geom_boxplot(aes(color = as.factor(plot_id))) +
  geom_jitter(alpha = 0.3)

# 14.5. Why does this change how R makes the graph?
# Answer: ggplot2 treats integer and numeric values as continuous, 
# and it treats factors and characters as discrete (categorical).

# Discrete variables = values that are clearly distinguishable and
# disconnected from each other; also called categorical variables
# Examples: plot_id, sex, species_id, genus, species, taxa, plot_type

# Continuous variables = values that are not clearly distinguishable
# i.e. for any two possible values of the variable, it is always
# possible to find another value that lies between them
# Examples: weight, hindfoot_length
# Note: a continuous variable can be categorised by using as.factor()


# . -----------------------------------------------------------------------


## Plotting time series data

# Calculate number of counts per year for each genus
yearly_counts <- surveys_complete %>%
  count(year, genus)

yearly_counts

# Visualize timelapse data as a line plot with year on x axis and counts on y axis
ggplot(data = yearly_counts,
       mapping = aes(x = year, y = n)) +
  geom_line()
# This doesn't work, because we plot data for all species together

# Draw a line for each genus by modifying aesthetic function
ggplot(data = yearly_counts,
       mapping = aes(x = year, y = n, group = genus)) +
  geom_line()

# Add colors to distinguish genera in the plot
ggplot(data = yearly_counts,
       mapping = aes(x = year, y = n, color = genus)) +
  geom_line()


## Faceting
# Split one plot into multiple plots based on a factor in the dataset

# Make one plot for a time series for each genus
ggplot(data = yearly_counts,
       mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

# Split the line in each plot by sex of each genus measured
yearly_sex_counts <- surveys_complete %>%
  count(year, genus, sex)

yearly_sex_counts

# Make a faceted plot by splitting further by sex (within a single plot)
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus))

# CHALLENGE 15 ------------------------------------------------------------

# Create a plot that depicts how the average weight of each genus changes
# through the years

yearly_weight <- surveys_complete %>%
  group_by(year, genus) %>%
  summarize(avg_weight = mean(weight))

# Option 1

ggplot(data = yearly_weight,
	   mapping = aes(x = year, y = avg_weight, color = genus)) +
	geom_line()

# Option 2

ggplot(data = yearly_weight,
       mapping = aes(x = year, y = avg_weight)) +
  geom_line() +
  facet_wrap(facets = vars(genus))


# . -----------------------------------------------------------------------


## Facet grid - specify how you want your plots arranged

# Compare how weights of males and females changed through time

# Organise panels by both rows and columns
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(sex), cols = vars(genus))

# Organise the panels only by rows
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(rows = vars(genus))

# Organise panels only by columns
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_grid(cols = vars(genus))
# Customization
# ggplot2 cheat sheet https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf


## ggplot2 themes

# Set the background to white and remove the grid to make plots more readable
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(facets = vars(genus)) +
  theme_bw() +
  theme(panel.grid = element_blank())


# Complete list of themes is available at
# https://ggplot2.tidyverse.org/reference/ggtheme.html

# Journal themes
# Package ggthemes allows you to choose specific journal styles
# https://jrnold.github.io/ggthemes/reference/index.html

# ggplot2 extensions website
# https://www.ggplot2-exts.org/

# Change names of axes and add a title
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw()

# Improve readability of axes names by changing size and font
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(text = element_text(size = 16))


# Change orientation of labels and adjust them to not overlap (use an angle)
ggplot(data = yearly_sex_counts,
       mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text = element_text(size = 16))

# Save the theme changes as an object to apply them to other plots in the future
grey_theme <- theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
                          axis.text.y = element_text(colour = "grey20", size = 12),
                          text = element_text(size = 16))

ggplot(surveys_complete,
       mapping = aes(x = genus, y = hindfoot_length)) +
  geom_boxplot() +
  grey_theme


# CHALLENGE 16 ------------------------------------------------------------

# Try to improve one of the plots generated in
# this exercise or make one of your own

# Some ideas:
# Change the thickness of the lines
# Change the name of the legend and the labels
# Try using a different color palette (http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/)


# . -----------------------------------------------------------------------


## Arranging plots

# Combine separate ggplots into a single figure
install.packages("patchwork")
library(patchwork)

plot_weight <- ggplot(data = surveys_complete,
                             mapping = aes(x = species_id, y = weight)) +
  geom_boxplot() +
  scale_y_log10() +
  labs(x = "Secies",
       y = expression(log[10](Weight)))
  

plot_count <- ggplot(data = yearly_counts,
                         mapping = aes(x = year, y = n, color = genus)) +
  geom_line() + 
  labs(x = "Year", y = "Abundance")


plot_weight / plot_count +
  plot_layout(heights = c(3, 2))

# Tools to construct more complex layouts:
# https://patchwork.data-imaginist.com/

### Export the plot
# Export tab in the Plot pane in RStudio will save your plots at low resolution
# Instead, use ggsave()
my_plot <- ggplot(data = yearly_sex_counts, 
                  mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(vars(genus)) +
  labs(title = "Observed genera through time",
       x = "Year of observation",
       y = "Number of individuals") +
  theme_bw() +
  theme(axis.text.x = element_text(colour = "grey20", size = 12, angle = 90, hjust = 0.5, vjust = 0.5),
        axis.text.y = element_text(colour = "grey20", size = 12),
        text=element_text(size = 16))

ggsave("fig_output/yearly_sex_counts.png", my_plot, width = 15, height = 10)

# It also works for plots combined with patchwork:
plot_combined <- plot_weight / plot_count +
  plot_layout(heights = c(3, 2))

ggsave("fig_output/combo_plot_abun_weight.png", plot_combined, width = 10, dpi = 300)


# Meet 'esquisse' ---------------------------------------------------------

install.packages("esquisse")
library(esquisse)

# Run the following function to open the ggplot2 builder
esquisser()
# Use the drag-and-drop functionality to draw any plot you like

# . -----------------------------------------------------------------------
# . PRESENTATION . #
# . -----------------------------------------------------------------------

# THE END -----------------------------------------------------------------



