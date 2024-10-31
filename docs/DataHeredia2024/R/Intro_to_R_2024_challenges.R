
# CHALLENGE 1 -------------------------------------------------------------

# 1.1. Run the following code and indicate what the values 
# are after each statement:

mass <- 47.5            
# mass = ?

age  <- 122
# age = ?

mass_index <- mass/age
# mass_index = ?

mass <- mass * 2.0
# mass = ?

mass_index
# mass_index = ?

# Is this answer correct?

# . -----------------------------------------------------------------------


# CHALLENGE 2 -------------------------------------------------------------

# 2.1. What will happen in each of the following examples
# (hint: use class() to check data type or look at the environment)

num_char <- c(1, 2, 3, "a")

num_logical <- c(1, 2, 3, TRUE)

char_logical <- c("a", "b", "c", TRUE)

tricky <- c(1, 2, 3, "4")

# . -----------------------------------------------------------------------


# CHALLENGE 3 -------------------------------------------------------------

# 3.1. Can you figure out why "four" > "five" returns TRUE
# when you run the following code?

"four" > "five"

# . -----------------------------------------------------------------------



# CHALLENGE 4 -------------------------------------------------------------

# 4.1. Use the following vector (heights in inches) and create a new vector
# (called "heights_no_na") with NAs removed.

heights <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)


# 4.2. Calculate the median (using the median() function) of the new heights_no_na vector.


# 4.3. How many people in the set are taller than 67 inches?
# Hint: Use conditional subsetting and the length() function


# . -----------------------------------------------------------------------


# CHALLENGE 6 -------------------------------------------------------------

# 6.1. Create a `data.frame` (`surveys_200`) containing only the
#    200th observation of the `surveys` dataset.


# 6.2. Notice how `nrow(surveys)` gave you the number of rows in a `data.frame`?
#    6.2.1. Use that number to pull out just that last row in the data frame (surveys).


#    6.2.2. Compare that with what you see as the last row using `tail()` 
#         to make sure it's meeting expectations.


# 6.3. Use `nrow()` to extract the row that is in the middle of the data frame.
#    Store the content of this row in an object named `surveys_middle`.


# 6.4. Combine `nrow()` with the `-` notation above to reproduce the behavior of
#   `head(surveys)` keeping just the first through 6th rows of the surveys dataset.


# . -----------------------------------------------------------------------


# CHALLENGE 7 -------------------------------------------------------------

# 7.1. Rename "F" and "M" to "female" and "male", respectively


# 7.2. Check that the levels have been renamed


# 7.3. Recreate the bar plot such that "undetermined" is first (before "female")


# . -----------------------------------------------------------------------

# CHALLENGE 8 -------------------------------------------------------------

# Instead of creating a data frame with read.csv(), you can create your own using data.frame()

# 8.1. The following code has a few mistakes. Try to fix it. 

# Now fix the code:
animal_data <- data.frame(
  animal = c(dog, cat, sea cucumber, sea urchin),
  feel = c("furry", "squishy", "spiny"),
  weight = c(45, 8 1.1, 0.8)
)

animal_data


# 8.2. Can you predict the class for each of the columns in the following example?
     # Check your guesses using `str(country_climate)`:

country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1))



# What would you need to change to ensure that each column had the accurate data type?



# . -----------------------------------------------------------------------


# CHALLENGE 9 -------------------------------------------------------------

# Using pipes, subset the survey data to include individuals collected before
# 1995 and retain only columns "year", "sex", and "weight"



# . -----------------------------------------------------------------------



# CHALLENGE 10 ------------------------------------------------------------

# Create a new data frame from survey data with the following:
#       * New column called "hindfoot_cm" containing the hindfoot_length values (currently in mm) converted to centimeters
#       * In the hindfoot_cm column, there are no NAs and all values are less than 3
#       * Only keep the species_id and hindfoot_cm columns



# . -----------------------------------------------------------------------



# CHALLENGE 11 ------------------------------------------------------------

# 11.1. How many individuals were caught in each "plot_type" surveyed?


# 11.2. Use group_by() and summarize() to find the mean, min, and max 
#    hindfoot_length for each species ID (using species_id). Also add
#    the number of observations (hint: see ?n).


# 11.3. What was the heaviest animal measured in each year?


# . -----------------------------------------------------------------------



# CHALLENGE 12 ------------------------------------------------------------

# 12.1. Pivot the surveys data frame with `year` as columns, 
#    `plot_id` as rows, and 
#    the values are the number of unique genera per plot. 
#    You will need to summarize before reshaping, and 
#    use the function `n_distinct` to get the number of unique types of a genera. 
#    It's a powerful function! See `?n_distinct` for more information.



# 12.2. Now take that data frame, and gather() it again, 
#    so each row is a unique `plot_id` by `year` combination



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



#    With this new dataset, calculate the average 
#    of each `measurement` in each `year` for each different 
#    `plot_type`. Then `pivot_wider` them into a data set with 
#    a column for `hindfoot_length` and `weight`. 



# . -----------------------------------------------------------------------




# CHALLENGE 13 ------------------------------------------------------------

# Create a scatter plot of weight over genus
# with the plot_type variable showing in different colors




# . -----------------------------------------------------------------------



# CHALLENGE 14 ------------------------------------------------------------

# 14.1. Boxplots are useful summaries, but hide the *shape* of the distribution.
# Replace the boxplot with a violin plot to see the shape; see geom_violin()


# 14.2. Change the scale of the axis to better distribute observations; see scale_y_log10()


# 14.3. Create boxplot for distribution of hindfoot_length for each genus


# 14.4. Add color to the datapoints according to the plot from which the sample was
# taken (plot_id)
# Hint: check class for plot_id - change from integer to factor




# 14.5. Why does this change how R makes the graph?



# . -----------------------------------------------------------------------




# CHALLENGE 15 ------------------------------------------------------------

# Create a plot that depicts how the average weight of each genus changes
# through the years




# . -----------------------------------------------------------------------





# CHALLENGE 16 ------------------------------------------------------------

# Try to improve one of the plots generated in
# this exercise or make one of your own

# Some ideas:
# Change the thickness of the lines
# Change the name of the legend and the labels
# Try using a different color palette (http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/)


# . -----------------------------------------------------------------------

# THE END -----------------------------------------------------------------
