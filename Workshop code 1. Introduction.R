# We're going to start with a brief look through some of the
# basic functionality of R, before we move on to working
# with actual data.

# The most basic thing you can use R for is a simple
# calculator. It can perform a large number of mathematical
# operations, but let's start simple. Click (anywhere) on
# the line with 2 + 2 below, then hit control-Enter (or
# command-Enter on mac). You should see some output appear
# in your Console window below.

2 + 2

# Symbols R will recognize include, among others, `*` for multiplication, `-` for subtraction, `+` for
# addition, `/` for division, and `^` for "to the power of."

2 * 2 + 4

4 ^ 2


# One of the key things we'll need to do in R is save things (usually data) as variables. To assign a variable, we use the <- (backwards arrow). 
# The <- symbol should be read as 'becomes' or 'gets'. Run the following, and check what happens in the environment window in the upper right corner.
a <- 4
b <- 2

# To see what a variable contains, you can just type it in and hit Enter

a

# Variables can be treated as if they are the values/things they represent. 
a + b
a * b


# You can also assign the result of any calculation (or function) to a variable. 
c <- 2 * 5

# Let's create a variable with a more complex name. Almost anything goes when it comes to naming variables, but generally it's standard
# to use lowercase and separate words with underscores. 
very_long_variable <- 5

# Try typing very in the console and see what happens. You can hit tab or click to accept a completion. This is very useful for longer
# variables or functions (which we'll get to soon). 


# Try the following and note what happens. R is case sensitive, which is one of the reasons sticking to lowercase is a good idea!
very_long_variable
Very_Long_Variable



# Let's imagine you want to change the name of the variable you assign, but don't want to rewrite the entire line. Click on the console window, 
# then hit the up arrow. This will cycle through your recent commands. You can then tweak and re-run them. Try changing the name of the variable
# a little bit and see what happens. 




### Exercises

# 1. Calculate 10 to the power of 3
10 ^ 3
# 2. Create a variable d that contains the number 5
d <- 5
# 3. Create a variable e that contains the result of dividing d by 2
e <- (d/2)


### Functions ###

# One of the most powerful aspects of R are the functions. These let us do pretty much everything we want to with our objects (usually data). 

# Generally speaking, functions take some input (which goes in brackets just after the function name, as you can see below), perform their
# specific function (thus the name!) and output the result. The input to functions are called arguments, and using functions generally takes
# the form shown below (although there is often only one argument). 

function_name(arg1 = val1, arg2 = val2, ...)


# The seq function, for instance:

seq(from = 1, to = 10, by = 2)

# As long as you write the arguments in the right order, you can leave out their names to save time. 
seq(1, 10, 2)

# One very important thing to note about functions - every opening bracket ( has to be matched with a closing bracket. RStudio helpfully
# creates closing brackets for you in simple cases, but one of the most common errors you'll likely make as you get used to things is leaving out
# brackets when things get more complicated. 

# A few more basic functions are below. These take a single argument (a number) and perform a simple function (square root, log, or absolute value) 

sqrt(4)

log(8)

abs(-4)


# Functions are evaluated in an inside-out fashion - think back to mathematical operations. This allows for things like the following:
sqrt(4*4)

sqrt(sqrt(16))



# A lot of function in R don't just work on single numbers, but also collections of numbers (or words, etc). 
# Usually, these will take the form of variables, read in from your data. But sometimes we need to create these
# collections (known as vectors) ourselves. The easiest way to do this is with the c() function, which stands for 
# 'concatenate'

y <- c(1, 4, 16)

y

# Take a look at what happens when we take the square root of y

sqrt(y)

# Now try out the mean, median, mode, range, and len functions

mean(y)

median(y)

range(y)

length(y)



### Exercises

# 1. Find the square root of 130. 
sqrt(130)
# 2. Save a number of your choice as a variable, then take the square root of that variable
d <- 10
sqrt(d)
# 3. Use the seq function to generate the following sequence: 2, 5, 8, 11, 14, 17, 20
seq(2, 20, 3)
# 4. Use the up arrow to alter the code you used above, and save the result in a variable called num
num <- seq(2, 20, 4)
# 5. calculate the mean and median of the num variable
mean(num)
median(num)


# Now the last thing you'll want to do in this section is clear out your workspace, removing all the variables you've created.
# You can do this by clicking the broom icon in the top right window. 

