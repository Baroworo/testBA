# Using Pipes
#-----------------------
# What are pipes? This %>% is the pipe operator. The pipe operator is not part of base R. 
# So, you will need to install and load a package to use it. There is actually more than 
# one package that you can use. I recommend that you install and load the dplyr package.

# You can install the dplyr package by copying and pasting the following command in your 
# R console 
# install.packages("dplyr")

# You can load the dplyr package by copying and pasting the following command in your R console 
library(dplyr)

# The pipe operator makes your R code much easier to read and understand.

# Pipes allow us to retain the benefits of nesting functions without making our code 
# really difficult to read. At this point, I think it’s best to show you an example. 
# In the code below we want to generate a sequence of numbers, then we want to calculate 
# the log of each of the numbers, and then find the mean of the logged values.

# Performing an operation using a series of steps.
my_numbers <- seq(from = 2, to = 100, by = 2)
my_numbers
my_numbers_logged <- log(my_numbers)
mean_my_numbers_logged <- mean(my_numbers_logged)
mean_my_numbers_logged

# We can do the same using pipe operator as follows:
# Performing an operation using pipes.
mean_my_numbers_logged <- seq(from = 2, to = 100, by = 2) %>% 
  log() %>% 
  mean()
mean_my_numbers_logged

# Here’s what we did above:
# We created a vector of numbers called mean_my_numbers_logged by passing the result 
# of the seq() function directly to the log() function using the pipe operator, and 
# passing the result of the the log() function directly to the mean() function using 
# the pipe operator.Then, we printed the value of mean_my_numbers_logged to the screen 
# to view.

# How do pipes work?
# Perhaps I’ve convinced you that pipes are generally useful. But, it may not be totally 
# obvious to you how to use them. They are actually really simple. Start by thinking about 
# pipes as having a left side and a right side.

# left %>% right function

# The thing on the right side of the pipe operator should always be a function.
# The thing on the left side of the pipe operator can be a function or an object.
# All the pipe operator does is take the thing on the left side and pass it to the 
# first argument of the function on the right side.

x <- mean(c(2, 4, 6, 8))
x
c(2, 4, 6, 8) %>% mean()

# Here’s one more example. Pretty soon we will learn how to use the filter() function 
# from the dplyr package to keep only a subset of rows from our data frame. Let’s start 
# by simulating some data:

# Simulate some data
height_and_weight <- tibble(
  id     = c("001", "002", "003", "004", "005"),
  sex    = c("Male", "Male", "Female", "Female", "Male"),
  ht_in  = c(71, 69, 64, 65, 73),
  wt_lbs = c(190, 176, 130, 154, 173)
)

height_and_weight

# In order to work, the filter() function requires us to pass two values to it. The first value 
# is the name of the data frame object with the rows we want to subset. The second is the condition 
# used to subset the rows. Let’s say that we want to do a subgroup analysis using only the females 
# in our data frame. We could use the filter() function like so:

# First value = data frame name (height_and_weight)
# Second value = condition for keeping rows (when the value of sex is Female)
filter(height_and_weight, sex == "Female")

# We kept only the rows from the data frame called height_and_weight that had a value of 
# Female for the variable called sex using dplyr’s filter() function.

# We can also use a pipe to pass the height_and_weight data frame to the filter() function.

# First value = data frame name (height_and_weight)
# Second value = condition for keeping rows (when the value of sex is Female)
height_and_weight %>% filter(sex == "Female")

# As you can see, we get the exact same result. So, the R interpreter took the thing 
# on the left side of the pipe operator, stuck it into the first argument of the function 
# on the right side of the pipe operator, and then executed the function. 

# In this case, the filter() function needs a value supplied to two arguments in order work. 
# So, we wrote sex == "Female" inside of the filter() function’s parentheses. When we see 
# height_and_weight %>% filter(sex == "Female"), R sees filter(height_and_weight, sex == "Female").

# Keyboard shortcut
#----------------------
# Typing %>% over and over can be tedious! Thankfully, RStudio provides a keyboard shortcut for 
# inserting the pipe operator into your R code.

# On Mac type shift + command + m.
# On Windows type shift + control + m

# It may not seem totally intuitive at first, but this shortcut is really handy once 
# you get used to it.
#
#------------------------------------------------------
# Pipe example - built-in Dataset Iris
#------------------------------------------------------
# Load data
data("iris")
# View data
head(iris)

# These data describe several measurements for three plant species (Iris setosa, Iris versicolor, 
# and Iris virginica). These measurements describe morphological differences among the three species 
# in terms of sepal length and width and petal length and width, all in centimeters.

# I want to keep only the largest plants in the data set, so let’s only include plants with 
# Sepal.Length greater than 5 cm, and Petal.Length greater than 3 cm. I also want to create 
# two columns called “Sepal.Area” and “Petal.Area”, equivalent to length x width (for an 
# approximation of sepal/petal area). 
#
# To do this, I’ll use the filter() and mutate() functions. Notice that I also hit “Enter” or “Return” 
# to add a new line after every pipe to keep the code clean and keep each function on a separate line.
# Filter and mutate data
new_iris <- iris %>% 
  filter(Sepal.Length > 5 & Petal.Length > 3) %>%
  mutate(Sepal.Area = Sepal.Length * Sepal.Width,
         Petal.Area = Petal.Length * Petal.Width)

# View new data
head(new_iris)

# Our data set looks good. You’ll see that my arguments in the filter() and mutate() functions are a 
# bit different from usual. Normally, most of the dplyr functions are formatted like this: 
# function(data, arguments).

# Remember that pipes take the output of what came before it and passes it as the first argument 
# of the function that follows. Thus, the filter() function receives iris as it’s data argument, 
# and then the mutate() function receives filter(data=iris, Sepal.Length > 5 & Petal.Length > 3) 
# as its data argument.

# With pipes there was no need for me to write filter(iris, Sepal.Length > 5 & Petal.Length > 3), 
# because that would be repetitive. I could just skip straight to the arguments and write 
# filter(Sepal.Length > 5 & Petal.Length > 3).

# To summarize in plain English (each then in this sentence can be substituted for a pipe):

# I wrote code starting with the iris data set, then filtered it by Sepal.Length and Petal.Length, 
# then used mutate to create two new columns.

# Without pipes, our sentence becomes longer:
#I wrote code starting with the iris data set. I filtered the iris data set by Sepal.Length and 
# Petal.Length. Using the filtered iris data, I used mutate to create two new columns.
# And those are the essentials of using pipes!

#---------------------------
# Cleaning code with pipes
#---------------------------
# After that last example, you might be thinking, OK, that’s pretty cool. But can it really make 
# that big of a difference for organizing my code? The answer is…yes! And I’ll quickly demonstrate why.

# Example 1: Creating new variables for each step
# Let’s filter and mutate our data like we did above, then group by species and summarize to find 
# the average sepal and petal area within each species. Without pipes, our code might look like this:

filtered_iris <- filter(iris, Sepal.Length > 5 & Petal.Length > 3)
mutated_iris <- mutate(filtered_iris, 
                       Sepal.Area = Sepal.Length * Sepal.Width,
                       Petal.Area = Petal.Length * Petal.Width)
grouped_iris <- group_by(mutated_iris, Species)
summary_iris <- summarize(grouped_iris, 
                          avg.sepal.area = mean(Sepal.Area),
                          avg.petal.area = mean(Petal.Area))

# View result
summary_iris

# Whew. It can be a little exhausting to have to save each step as a new variable, and now our 
# environment will be cluttered with a bunch of intermediate variables. Aside from the clutter, 
# your code is also much more prone to errors if you change something in the earlier steps but 
#forget to run those lines before the later steps again. So let’s not do that then.

#------------------------------
# Example 2: Nesting functions
#------------------------------
# Let’s try another method, where we nest each function inside the previous one.

summarize(group_by(mutate(filter(iris, 
                                 Sepal.Length > 5 & Petal.Length > 3), 
                          Sepal.Area = Sepal.Length * Sepal.Width,
                          Petal.Area = Petal.Length * Petal.Width), 
                   Species),
          avg.sepal.area = mean(Sepal.Area),
          avg.petal.area = mean(Petal.Area))

# That doesn’t really look much better. If all these nested functions are making your head spin, 
# don’t worry, it’s doing that to me too. Code like this is a great way to spend hours searching 
# for errors… only to realize you’re missing a parenthesis.
# 
#---------------------
# Example 3: Pipes!
#---------------------
iris %>% 
  # first filter and keep only sepals greater than 5cm long and 3cm wide:
  filter(Sepal.Length > 5 & Petal.Length > 3) %>%
  # then approximate sepal and petal area by multiplying length and width:
  mutate(Sepal.Area = Sepal.Length * Sepal.Width,
         Petal.Area = Petal.Length * Petal.Width) %>%
  # after that group by species to summarize the mean 
  # sepal/petal area of each species:
  group_by(Species) %>%
  summarize(avg.sepal.area = mean(Sepal.Area),
            avg.petal.area = mean(Petal.Area))

# All that said, I’m not suggesting that your entire R analysis script fit inside one 
# long set of pipes. Find what works best for you and your analyses in terms of splitting 
#up your code into neat organized chunks that make sense.







#-----------------------------------------------------
# A new paradigm for calling functions in R is the pipe. The pipe from the magrittr
# package works by taking the value or object on the left-hand side of the pipe and inserting
# it into the first argument of the function that is on the right-hand side of the pipe. A
# simple example example would be using a pipe to feed x to the mean function.

library(magrittr)
x <- 1:10
x
mean(x)
x %>% mean

# The result is the same but they are written differently. 
# Pipes are most useful when used in a pipeline to chain together a series of function calls. 
# Given a vector z that contains numbers and NAs, we want to find out how many NAs are present. 
# Traditionally, this would be done by nesting functions.
z <- c(1, 2, NA, 8, 3, NA, 3)
sum(is.na(z))

# This can also be done using pipes.
z %>% is.na %>% sum

# Pipes read more naturally in a left-to-right fashion, making the code easier to comprehend. 
# Using pipes is negligibly slower than nesting function calls, though as Hadley
# Wickham notes, pipes will not be a major bottleneck in code.

# When piping an object into a function and not setting any additional arguments, no
# parentheses are needed.
# However, if additional arguments are used, then they should be named and included inside 
# the parentheses after the function call. 
# The first argument is not used, as the pipe already inserted the left-hand object into
# the first argument.

z %>% mean(na.rm=TRUE)

# Pipes are used extensively in a number of modern packages after being popularized by
# Hadley Wickham in the dplyr package