# Now that you're familiar with the R interface, let's get our hands on some data! #

# Before we do, we'll need to load up a few packages. The base version of R comes with a lot of functionality, but over the years
# people and organisations have built modules that improve over the basics in particular areas. In particular, a concerted effort
# has been made to create a set of packages known as the 'tidyverse', designed to make the process of cleaning, plotting and analyzing
# data more straight forward, clean, and user-friendly. We'll be using this set of packages to load, manipulate, and plot our data today. 

# You should already have the tidyverse package installed, but if you don't, run the below line of code:

install.packages('tidyverse')

# Once installed, packages have to be activated each time you launch R. We can do this using the library command.

library(tidyverse)

library(readr)

# Now, the last step before we load in our own data is to change our working directory. This is the default folder where R will look for 
# data. In RStudio, click 'Session', 'Set working directory', and 'Choose directory'. Then navigate to the folder with the data and code for
# today's course, and select this. You'll notice some code appear in the Console window - this is the function to change the working directory,
# which you can use instead of the dropdown menu once you're more used to R. 


# Now let's read in our data. We'll use the read_csv function. Notice that we save the dataset into a variable in the same fashion as we did 
# with simple numbers. 

manylabs <- read_csv('manylabs.csv')

# This might feel a bit anticlimactic - nothing really
# happens! Or rather, something happens - we can see a
# manylabs object appear in the environment window in the
# upper-right hand corner. This will likely feel unfamiliar,
# if you're used to data appearing front-and-center in some
# other statistics packages. But remember that in R we
# interact with our data through functions, rather than
# directly. Let's take a look at what happens when we call
# the data itself, by running the following line:

manylabs

# You'll see that we have a number of variables, represented by their names at the top of the data frame, and their data type below (e.g. <chr>).
# The most common data types we'll encounter are character (string data), integer/double (numeric data), and factor (categorical data). 

# This way of viewing data will likely feel uncomfortable at first, but you'll get used to it. Until then, you can also click on the data object 
# in the environment window to open up a direct view on the dataset (SPSS-style), though we won't work with the data in that form. 

# Below, you can test out some functions that give you different views on a dataset:

# View the column names
colnames(manylabs)

# View the last 6 rows of the dataset (this can go up to 20)
tail(manylabs, 6)

# See some data for all the variables, flipped horizontally to fit on the screen
glimpse(manylabs)

# Get some basic descriptive statistics for the data. 
summary(manylabs)


# Now we're going to get familiar with the tools you'll need
# to explore, wrangle, and clean your data in R. We'll be
# using the dplyr package within the tidyverse for this.

# Almost all the data wrangling operations you might want to
# perform can be done primarily through five functions that
# take the form of 'verbs' - actions we want to take with
# our data. These are select, filter, arrange, mutate, and
# summarize. We'll work through them using the manylabs
# dataset.


### select ###

# select allows us to extract specific columns of our data to look at, and comes with some fairly powerful 'helper' functions that let us be
# quite flexible in which columns we choose

# Like all five of these functions, the first argument you need to give select is the name of the dataset in question. Then, additional arguments
# can be used to select variables. Each extra argument is used additively to select more columns to keep (or drop, in the case of the - symbol)

# Try running the following and see what happens.
select(manylabs, age, sex, citizenship)


### Assignment and saving our progress

# One key thing about R functions is that they will almost never directly change their input (i.e. our data) unless we explicitly save the result
# using the assignment operator (<-). When we use functions like we did above, we're just viewing our data in different ways. 

# For instance, you can see that the manylabs dataset hasn't actually changed as a result of our selecting a subset of variables:
manylabs

# If we wanted to save our selection, we need to use assignment, like so:
manylabs_reduce <- select(manylabs, age, sex, citizenship)

# Notice that a new object has appeared in the upper right corner of the screen - this can be useful if you're performing multiple
# steps and need to save your progress along the way - more on that later.


# Back to selecting - you can use numbers indicating the indices of columns you'd like to select
select(manylabs, 1:3)

# Using the - sign, we can drop variables instead of selecting them

select(manylabs, -age)

# We can also use helper functions like starts_with, ends_with, contains, and matches to make our selections

select(manylabs, starts_with('exp'))

# And we can combine multiple methods additively

select(manylabs, starts_with('exp'), -exprace)


# Again, as you add more select statements together, they're combined additively - all will be implemented:
select(manylabs, 1:3, age, starts_with('gambfal'))



# We can also use the special everything() helper function. This selects all the variables we haven't already specified, so adding it to the end
# of a selection will keep all variables, but bring the variables you've select to the 'front' (left) of the dataset, for easy viewing. 
select(manylabs, age, sex, everything())


### Exercises
# With the manylabs dataset:
# 1. select sex, gender, and race

# 2. select the first 10 columns

# 3. Select all variables that end with 'order' 

# 4. Select all variables that contain 'flag', and all variables that start with 'sysjust'

# 5. Write a command to select expgender, lab_or_online, us_or_international, anchoring1, and anchoring2. Once you've verified that it works, 
#    use a different select statement to achieve the same result. 


### The $ operator

# A way to select a single variable, (or just useful to quickly scroll through the variables to check
# their spelling!)
manylabs$age

### filter ###

# The filter functions works to select a specific subset of the rows in a dataset. Like all five of these functions, it takes a dataset as its first
# argument, and subsequent arguments are interpreted as logical tests on which to filter the dataset. 

# For instance, assume we want to look at only the rows of our dataset containing male participants. We would use the following code:

filter(manylabs, sex == 'm')

# Note that the text at the top now tells us there are only 2060 rows in this filtered dataset, down from 6344. 


## Remember - when testing for equality, we have to use the double equals sign (==) because the = sign means something different in R. This
## is easy to forget, but filter will give you a helpful error message if you make a mistake:
filter(manylabs, sex = 'm')


# We can use various logical operators: | for OR, ! for NOT, & for AND

# Keep rows where sex is male or female
filter(manylabs, sex == 'f' | sex == 'm')

# Keep rows where sex is female and age is above 18
filter(manylabs, sex == 'f' & age > 18)

# Keep rows where sex is not male
filter(manylabs, sex != 'm')


# This doesn't work:
filter(manylabs, sex == 'f' | 'm')

# Has to be written like this:
filter(manylabs, sex == 'f' | sex == 'm')

filter(manylabs, age > 18 & age < 75)

# If we want to filter with multiple options, we can use the special %in% operator rather than right multiple == tests. 
filter(manylabs, sex %in% c('m', 'f'))

# One way to check what values are available to filter on is to use the count function, which gives a descriptive frequency table:

count(manylabs, expgender)

# Adding extra arguments turns this into a cross-table (though more than 2 variables gets unwieldy) 

count(manylabs, expgender, lab_or_online)


# To test for missing data, we use the is.na() function, since we can't ask R whether something == NA. 

# Find rows where experimenter gender is missing
filter(manylabs, is.na(expgender))

# Find rows where experimenter gender is not missing - notice any commonalities? 
filter(manylabs, !is.na(expgender))


### Exercise
# Filter the manylabs dataset so that:
# 1. Only male experimenters are included:
# Hint: To see what values are in the variable, try: 
count(manylabs, expgender)


# 2. US citizens are removed (participants with 'US' in the citizenship variable)

# 3. Only Brazillian (BR) or italian (IT) citizens are included

# 4. Only participants who missed 2 or more explicit measures (counted in the totexpmissed variable) are included



### chaining functions together with 'pipes' ###

# So far, we've taken each step one at a time - selecting and filtering. One way to bring these functions together is to perform
# multiple separate steps, where we save the results of each function as input to the next function. 

manylabs_filter <- filter(manylabs, sex == 'm')
manylabs_filter <- select(manylabs_filter, 1:10)

manylabs_filter

# However, creating intermediate datasets can get messy, especially if we just want to look at the results of our filtering/selecting, 
# rather than save them. 

# Another way to do this is to directly wrap one function around the other, like we saw with sqrt(sqrt(16)). For instance:

select(filter(manylabs, sex == 'm'), 1:10)

# However, that quickly gets unwieldy - imagine if we wanted to perform 3, 4, or more data cleaning steps this way! 

# A better option is to chain commands together using 'pipes', which look like this: %>%. 

manylabs %>%
  filter(sex == 'm') %>%
  select(1:10)


mydat <- manylabs %>%
  filter(sex == 'm') %>%
  select(1:10)

# The pipe operator can be read as 'and then', and allows us to put together operations in the order we would say them. So the above would
# read "Take the manylabs data, and then filter it to include only male participants, and then select the first ten columns. Notice that we 
# no longer need to tell each individual function (i.e. filter or select) that they should use the manylabs dataset - the pipe operator 
# carries the dataset through, and each function knows that it's working with the output from the previous pipe. Don't worry if this seems 
# confusing at first - it will become intuitive as we continue.


### Exercise

# 1. Write a command to select only the variables that start with 'sysjust', and make sure you get the columns you'd expect

# 2. Using pipes, first select the variables that start with 'sysjust', and then filter the dataset so only scores of 4 or higher (>=)
#    on sysjust2 are included. You should have a dataset with 2 328 rows and 9 columns. 



### arrange ###

# The arrange operator is pretty simple. It orders dataframes according to the variables you input, breaking ties successively using extra variables. 

# Apparently we have some pretty young participants in this dataset!
arrange(manylabs, age, sex)

# To sort in reverse order, we use the desc() function. 

arrange(manylabs, desc(age))

# These two are equivalent
arrange(manylabs, age) %>% 
  filter(recruitment == 'unisubjpool') %>%
  select(age, citizenship, lab_or_online, recruitment)

manylabs %>% 
  arrange(age) %>% 
  filter(recruitment == 'unisubjpool') %>%
  select(age, citizenship, lab_or_online, recruitment)


### mutate ###

# So far we've looked at ways to move around and select our existing variables. But often we want to create new helpful variables. That's where
# mutate comes in. It allows us to create new variables - usually as functions of existing ones. It works similarly to the commands we've looked
# at previously. 

# For the next few steps, we'll use a subset of the manylabs dataset, to make our newly calculated columns easier to see

manylabs_r <- select(manylabs, 1:4, sunkDV, starts_with('flagdv'))

manylabs_r

# To create a new variable, we give it a name (we can use quotation marks here, but they're not necessary) and specify the operation to create it. 
# For instance, if we wanted to reverse-score the flagdv1 variable, we could do so like this:

mutate(manylabs_r, flagdv1_rev = 8 - flagdv1) %>%
  select(starts_with('flag'))

# We can also calculate a set of new variables at once:

mutate(manylabs_r, flagdv1_rev = 8 - flagdv1,
                   flagdv3_rev = 8 - flagdv3,
                   flagdv5_rev = 8 - flagdv5)


# Remember that the new variable won't appear in the dataset unless we assign it:
manylabs_r <- mutate(manylabs_r, flagdv1_rev = 8 - flagdv1)


# Here are some examples of using the if_else function to create TRUE/FALSE variables indicating 
# whether each participant meets a certain criterion. This can be useful for later filtering. 
manylabs_r <- manylabs_r %>% 
  mutate(adult_status = if_else(age >= 18, 'adult', 'junior'))

# We can now count how many participants are 18 or over
count(manylabs_r, adult_status)

# And of course, can do all that within a single piped statement
manylabs_r %>% 
  mutate(adult_status = if_else(age >= 18, 'adult', 'junior')) %>%
  count(adult_status)


### Exercise

# 1. Using manylabs_r, create a variable, called age_months, corresponding to each participant's age in months.


# 2. Reverse-score sunkDV (it's on a 1 to 9 scale)



### summarise ###

# the summarise function is similar to mutate in that it calculates values, but rather than return a variable with the same number of rows as 
# the original dataset, it calculates summaries (i.e. averages, medians, counts). By default, it will return only the summary variables, rather
# then the entire dataset, like mutate.

summarise(manylabs, age_av = mean(age, na.rm = TRUE))



# Notice the na.rm = TRUE argument - without this, if there are any NA values, the result of most summary functions will also be NA. Specifying this
# argument instead means we ignore them as if they are not there. 


# While summarise can be useful to calculate summary statistics across an entire dataset, it becomes much more powerful when we combine it
# with group_by and pipes. group_by takes a dataframe, and groups it into sub-dataframes for each unique value of the grouping variable.
# After this, summarise will give us results by-group, allowing for us to easily perform a lot of powerful grouped calculations.

# Let's take the location variable, which gives us the site where the study was run. Grouping by location, we can see how age varies across testing
# sites to better characterise the sample. 

manylabs %>% 
  group_by(location) %>%
  summarise(mean_age = mean(age, na.rm = TRUE))

# We can combine this with arrange to view the sites with the youngest or oldest participants. Remember, we can use the variable we just calculated with mutate
# as input to arrange further down the pipe.

manylabs %>% 
  group_by(location) %>%
  summarise(mean_age = mean(age, na.rm = TRUE)) %>%
  arrange(desc(mean_age))


# A little trick if we want to be able to see all of the rows, is to add a function at the end of our pipe that converts from the specialised data format
# (tibble) we're using in dplyr, to the basic r data.frame. Tibbles refrain from printing more than 20 rows to stop us accidentally flooding our screen with
# data, but we don't always need that help!

manylabs %>% group_by(location) %>%
  summarise(mean_age = mean(age, na.rm = TRUE)) %>%
  arrange(desc(mean_age)) %>% 
  data.frame()


# We can add multiple summary functions together to get a full table of descriptive statistics, grouped by any characteristics we want! 

# The special n() function will get the size of each group (the count function is actually a shortcut to this). This comes in handy for giving context to 
# means that might be driven by small sample sizes. 

manylabs %>% 
  group_by(location) %>%
  summarise(mean_age = mean(age, na.rm = TRUE), 
            sd_age = sd(age, na.rm = TRUE),
            sample_size = n()) %>%
  arrange(desc(mean_age))

# The benefit of functions like this becomes clear when you want to look at summary statistics across multiple variables. 
# Just change location to something else (like lab_or_online) and you've got a completely different table.
manylabs %>% 
  group_by(lab_or_online) %>%
  summarise(mean_age = mean(age, na.rm = TRUE),
            sd_age = sd(age, na.rm = TRUE),
            sample_size = n()) %>%
  arrange(desc(mean_age))


### Exercises

# Grouping by location, as in the first example above

# 1. Find the average system justifiction scale score (Sysjust) for each location

# 2. Add a command to also get the standard deviation of system justification at each location


# 3. arrange locations in order of highest to lowest system justification (remember the desc function)

# 4. Change the group_by command in your code to use sex instead of location. Notice how easily you can get different summaries! 



### Advanced exercise

### Bringing everything together - this advanced example calculates some new descriptives not already in the dataset 
### (whether participants are adult, male, and/or white), removes online testing sites, groups by loction, calculates 
### the mean for each location on our new statistics, and then sorts them by gender. This allows is to quickly get a 
### feel for the demographics at different locations. Feel free to play with this example and adapt it to your own data!

manylabs %>% 
  mutate(adult = if_else(age >= 18, 1, 0),
         male = if_else(sex == 'm', 1, 0),
         white = if_else(race == 6, 1, 0)) %>%
  filter(lab_or_online == 0) %>%
  group_by(location) %>%
  select(adult, male, white) %>%
  summarise_all(function(x) round(mean(x, na.rm = TRUE), 2)) %>%
  arrange(desc(male)) %>%
  as.data.frame()

