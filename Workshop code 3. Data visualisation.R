### Plotting with ggplot ###


# As mentioned in the slides, we'll be using ggplot2 to do our plotting today. First, let's load up the package:

library(ggplot2)

# We'll also use some data from gapminder for illustrative purposes. This data doesn't have to be read in from outside R, as it is 
# contained within the gapminder package. Let's load that package up as well: 

library(gapminder)

gapminder


# Just so you don't trip up - while the package is called ggplot2, the main function in the package is called ggplot!

# With ggplot, we build up our plots in layers - creating a canvas, specifying aesthetics, and choosing geoms - geometric
# objects to represent our data. The syntax is similar to what we learned in dplyr, but ggplot was created before that package
# was invented, so instead of the pipe symbol (%>%) it uses the + sign. 

# If we run ggplot specifying only our data, we get an empty canvas. We've told the software where the variables of interest are, but
# not how to map them to graphics. 
ggplot(data = gapminder)


# Next, we can use the aes() subfunction to specify simple aesthetics - like which variables we want mapped to the x and y axis.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp))

# However, at this point, we still have a mostly blank canvas, though now we've got axis labels. To actually put our data on the graph, we need
# to specify a geom - a geometric shape (and data transformation to fit that shape) to match up with our aesthetic choices. 

# Geom_point is one of the simplest geoms, and translates each data point to one point on the graph. 
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point()


# There are other aesthetic values we can specify - such as color, shape, size, and alpha. Each can be mapped to a variable.

ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()


# each geom will respond differently to different aesthetics. For instance, boxplot
# requires a grouping variable (like continent) as its x aesthetic, and uses color only
# for the edges of the box plots. If we want fully colored in plots, we need to change 
# color to fill
ggplot(data = gapminder, aes(x = continent, y = lifeExp, color = continent)) +
  geom_boxplot()

ggplot(data = gapminder, aes(x = continent, y = lifeExp, fill = continent)) +
  geom_boxplot()


# Here are a few other geoms demonstrated:

# Violin plots are similar to boxplots, and take the same aethetic mappings. 
ggplot(data = gapminder, aes(x = continent, y = lifeExp, fill = continent)) +
  geom_violin()


# Density creates a density graph, where the y axis is the frequency of values
# at each point on the x axis. Thus, it does not take a y aesthetic. 
ggplot(data = gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density()



# Exercises

# Let's start simple - take the code below as your starting point:
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, color = continent)) +
  geom_point()

# For each of the following, tweak the code above so that:
# 1. continents are represented by shape, rather than color
# 2. continents are represented by size, rather than color
# 3. year, rather than continents, is represented by color
# 4. size represents the year, and color the continent



# We can apply these plotting techniques to the manylabs data we've been working with. For instance, 
# to create a visual version of the age-by-location summary we did before, we can use the boxplot geom, 
# with x set to location, and y set to age, like so:

ggplot(data = manylabs, aes(x = location, y = age)) +
  geom_boxplot()

# Now let's flex your plotting muscles on a few examples with more psychological significance. 

# The gambler's fallacy experiment had participants either imagine seeing a man roll 2 sixes and a three, 
# or three sixes in a row, as they walked past him in a casino. They then had to guess how many times he had
# rolled the dice before they walked by. In the manylabs data, the dependent variable (participant's guesses) 
# is represented my the gambfalDV variable. The experimental manipulation is represented by gambfalgroup. Drawing
# on the examples above as inspiration, let's use plots to get an idea of what, if any, effect this manipulation 
# may have had.  

# Exercise
# 1. Create a box plot to show the distribution on gambfalDV by gambfalgroup (You'll need the x, y, and fill aesthetics.)
# 2. Change the box plot to a violin plot
# 3. Try using the same plot on another experiment - the anch1group variable codes the manipulation for a classic
#    anchoring experiment, and anchoring1 contains the outcome. 
# 4. One of the experiments collected two continuous variables - IATexpart and IATexpmath - participant's explicit attitudes
#    towards art and math. Try plotting these against one another using the x and y aesthetics and geom_point. What do you notice?
# 5. Try switching to geom_smooth. What happens?



# If you want to save any of the graphs you make, the ggsave function will output the most recent graph. 
ggsave('Megaplot.png')






### Facets

# Sometimes we want to visualise the same pattern across different subgroups in our data. For instance, we might want to plot
# the relationship between extraversion and wellbeing separately by gender, or by different age groups. To do this, we can add
# an extra element to our graphs - the facet_wrap element. This takes your graph, and repeats it once for each element of a grouping
# variable, specified using the formula ~group - we'll learn more about what the ~ means in the next section. 


# For instance, one effect that didn't replicate in the manylabs data was the effect of money priming on system 
# justification beliefs. Some have argued that this might be due to participant fatigue or overload, given that
# each session consisted of more than ten experiments. Thankfully, the manylabs data contains data on the order in 
# which experiments were presented - in this case, under moneypriorder. Using facet_wrap below, we can judge for ourselves
# whether presentation order moderates the effect:

ggplot(data = manylabs, aes(x = MoneyGroup, y = Sysjust, fill = MoneyGroup)) + 
  geom_boxplot() + facet_wrap(~moneypriorder)


### Exercise 

# The order in which the gambler's fallacy was presented is coded in the gambfalorder DV. Use this and facet_wrap
# to modify your code from before to show a violin plot of the effect across presentation order. 



### Advanced tools: Combining dplyr and ggplot

# ggplot gets even more powerful when we combine it with the data wrangling skills we learned earlier. For instance, 
# let's say we wanted to make a bubble plot mapping countries gdp to life expectancy, with bubbles sized by population
# This kind of plot is popular when graphing data involving countries, so we can weight each point by country
# size. Since the gapminder dataset has multiple entries for each country, we'll want to use group_by and summary to calculate
# averages across years, giving us just one point per country. We'll also use filter to get just the most recent few years of 
# measurement. 

gapminder %>% 
  group_by(continent, country) %>%
  filter(year %in% c(1997, 2002, 2007)) %>%
  summarise(av_life = mean(lifeExp, na.rm = TRUE),
            av_gdp = mean(gdpPercap, na.rm = TRUE),
            pop = mean(pop, na.rm = TRUE))


# Now, we can actually feed this summarised dataset straight into the ggplot function, though we'll
# have to remember to switch from the pipe symbol (%>%) to the plus symbol (+) as we do so. 

gapminder %>% 
  group_by(continent, country) %>%
  filter(year %in% c(1997, 2002, 2007)) %>%
  summarise(av_life = mean(lifeExp, na.rm = TRUE),
            av_gdp = mean(gdpPercap, na.rm = TRUE),
            pop = mean(pop, na.rm = TRUE)) %>%
  ggplot(aes(x = av_gdp, y = av_life, size = pop, color = continent)) +
           geom_point() 



# Let's change our summarise call to divide population into millions, to get more readable graph labels. This is one of 
# the benefits of directly going from dplyr into ggplot - we don't need to go back, save a different version of our
# summarised data, and then go back to plotting. We can just tweak the same line of code:

gapminder %>% 
  group_by(continent, country) %>%
  filter(year %in% c(1997, 2002, 2007)) %>%
  summarise(av_life = mean(lifeExp, na.rm = TRUE),
            av_gdp = mean(gdpPercap, na.rm = TRUE),
            pop_millions = mean(pop/1000000, na.rm = TRUE)) %>%
  ggplot(aes(x = av_gdp, y = av_life, size = pop_millions, color = continent)) +
  geom_point() 



### Tweaking graphics for publication quality

# ggplot comes with many other options for tweaking plots to get them just the way you want for publication. These
# can be a bit hard to remember, but I usually just look them up (There is an R graphics cookbook online that has
# example code to cover most use cases!)
  

gapminder %>% 
  group_by(continent, country) %>%
  filter(year %in% c(1997, 2002, 2007)) %>%
  summarise(av_life = mean(lifeExp, na.rm = TRUE),
            av_gdp = mean(gdpPercap, na.rm = TRUE),
            pop_millions = mean(pop/1000000, na.rm = TRUE)) %>%
  ggplot(aes(x = av_gdp, y = av_life, size = pop_millions, color = continent)) +
  geom_point() +
  geom_text(aes(label = country), nudge_y = -.8, size = 2.1, check_overlap = TRUE) +
    ylab('Average life expectancy between 1997-2007') +
    xlab('Average GDP per capita between 1997-2007') +
    guides(color = guide_legend(title = 'Continent'),
           size = guide_legend(title = 'Population \n (Millions)')) +
    theme(panel.background = element_rect(fill = 'white'),
          axis.title.x = element_text(vjusst = -1))

# If we want to save out graphics to a file, the ggsave function will output the most recent graph. 
ggsave('Megaplot.png')










