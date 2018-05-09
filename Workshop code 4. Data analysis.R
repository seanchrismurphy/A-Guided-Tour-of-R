### Analysing Data in R ###

# In this section of the workshop, we'll demonstrate the basic principles of data analysis in R using the manylabs data. 

# Remember that the general formula that runs through most statistics in R follows the form "DV ~ IV" where you can read the '~' symbol as
# 'is predicted by'. This is then usually followed by an argument that tells R which dataset you want to fit the model to.

### Fitting linear models ###


# In general, analysing data in R consists of two steps. First, you fit a model to your data, using a model fitting function like lm(). We
# can try this now with the manylabs data, to test whether the gamblers fallacy dv we graphed earlier differs signiicantly as a function of
# experimental group.

# What we're essentially saying here is "Using the manylabs data, predict scores on gambfalDV from scores on gambfalgroup"
lm(gambfalDV ~ gambfalgroup, data = manylabs)

# Notice that the output from lm doesn't give us a lot in the way of the results we're used to seeing. We get a pair of coefficients, but 
# no significance tests. In order to get more meaningful output, we'll need to save our model and use various summary functions to view the 
# results in different formats. 

model.1 <- lm(gambfalDV ~ gambfalgroup, data = manylabs)

# The anova() function will give us anova-style output. This is an omnibus test of whether each predictor explains significant variance in the 
# dependent variable.
anova(model.1)

# The output shows us that gambfalgroup predicts significant variance in our output variable. We can tell 
# this from the Pr(>F) column in the output - this is out p value. the value <2.2e-16 essentially means
# that the p value is less than 2 times ten to the negative 16 - it's really, really small. We have familiar
# significance stars here to hammer the point home, as well as the standard degrees of freedom, sums of squares,
# mean squared errors, and F value. 

# However, an anova won't show us the direction of the effects we're interested in. One way to see this is with 
# the summary() function, which gives us regression style output. the summary() function will automatically dummy-code
# categorical predictors for us so that we don't need to worry too much whether we're giving it continuous or categorical
# independent variables. 

summary(model.1)

# Now let's deconstruct this output. We can see that we have an intercept, and then a single regression term - 
# gambfalgrouptwo-six. This is a result of the dummy-coding R has performed. The first level of our gambfalgroup variable
# in alphabetical order (three-six) has been coded as the model baseline (the intercept). So the output tells us that the mean
# on our DV for this experimental group is 3.76. Then the coefficient for the two-six group indicates its difference from the 
# baseline. The coefficient is negative, indicating that the two-six group scored lower on the DV than the three-six group. 
# Another way of framing this is that the effect of being in the two-six group, compared to the three-six group, is -1.69. 
# The t value is -24.01, and the p value is once again infintesimally small (<2e-16), indicating that this difference is significant.

# In this case, since we only have a two-level IV, we knew from the anova already that our result would be significant, but this won't 
# always be the case if we're testing with multiple predictors, or predictors with more than two levels. 



### Exercise

# 1. One of the experiments from the manylabs study primed participants with the american flag (flagGroup) and measured their attitudes on a 
#    number of political issues (flagdv). Fit a model testing the effects of this experimental manipulation, and examine it with summary() and anova()



# Interaction effects can be tested in R using the * operator. For instance, age*sex would fit the interaction of age and sex. By default, when you fit 
# an interaction, R will also include the main effects of each of those predictors in the model, because it is generally a bad idea to fit interactions
# on their own!

# For instance, if we wanted to test whether the effect of our gambler's fallacy manipulation depended on whether participants were in the lab or 
# online, we could fit the following model.

model.2 <- lm(gambfalDV ~ gambfalgroup*lab_or_online, data = manylabs)

# An anova will show us that the interaction was not significant - the gambfalgroup:lab_or_online term has a p value of .54
anova(model.2)

# And this is confirmed in the summary output
summary(model.2)

### Exercise
# 1. One proposed moderator of the flag priming effects was whether participants were US citizens, given that the US flag was used. Fit a model testing this
#    possibility, using the us_or_international variable as a moderator. 



# So far, we've looked at categorical predictors. But let's take a quick look at a case with a continuous predictor. For this, we'll examine the 
# relationship between IATexpart and IATexpmath math (explicit attitudes towards art and math). 

model.3 <- lm(IATexpart ~ IATexpmath, data = manylabs)

# Because this question better fits a regression framework, let's jump straight to summary

summary(model.3)

# Here we can see that a 1-point increase in explicit math attitudes predicts a .08 point decrease in explicit art attitudes - a significant relationship.



### T-tests ###

# I've included t-tests here as a bit of an afterthought, because generally, while some questions are simple enough to be answered with 
# a t-test in R, it's easier once you're in the habit to just fit them with lm(). Nonetheless, it's good to know how to conduct one!

# t.tests and correlations are sort of exceptions to the rule of how R works to analyse data - they're so simple that you pretty much always
# want the same output, so a single function performs the test and reports it.

# Since the tests we ran earlier on the gambler's fallacy are simple enough to be performed with a t-test, 
# we'll conduct them again, here using the t-test function.

# The way to read the command below is "fit a model where height is predicted by sex, using manylabs data". 
t.test(gambfalDV ~ gambfalgroup, data = manylabs)

# Let's deconstruct the output of that command. First R tells us that we've run a two-sample t-test, 
# also known as an independent samples t-test. Next we have our t value, -22.994. The negative sign indicates that
# our first group (two-six) scored lower than the second group (three-six) - group order is set alphabetically.

# We have our degrees of freedom (4301.1, which is fractional because we're using Welch's t-test by default). 

# After that, we get the 95% confidence interval for the difference between the two groups. Then we
# have the actual means of each group, which always helps to sanity check the direction of the differences. 


### Correlations 

# For simple relationships between two variables, we can just use the lm() function. But what if we want to 
# quickly eyeball many continuous relationships? Here, correlation tables come in handy. Thankfully, while R
# doesn't have great built-in options for making correlation tables, the apaTables package is available to create
# apa-style correlation tables for you. 

# You'll need to install the package the first time you run this. 
install.packages('apaTables')
require(apaTables)

# Here, we use the select function we learned earlier to extract all the system justification items in the dataset, and
# feed them to the apa.cor.table function (remember, functions are evaluated from the inside-out). 
apa.cor.table(select(manylabs, contains('sysjust')))

# If you don't want confidence intervals, there's an option to turn them off!
apa.cor.table(select(manylabs, contains('sysjust')), show.conf.interval = FALSE)

# You can save these tables as objects, and use write_csv to output them to a spreadsheet for reporting. 
