# MGS 3101
# Simple Linear Regression Example in R

# install necessary packages 
#install.packages("ggplot2")
#install.packages("carData")
#install.packages("car")

# Loading necessary libraries
library(ggplot2)
library(car)
data(package = .packages(all.available = TRUE))
# Reading the dataset
# data <- read.csv("path_to_your_file/house_price.csv")
data <- read.csv("house_price.csv")
View(data)

# Generating dummy variables for CentralAir and PavedDrive
data$CentralAir <- as.numeric(factor(data$CentralAir)) - 1  # Convert to 0 and 1
data$PavedDrive <- as.numeric(factor(data$PavedDrive)) - 1  

# Plotting the data
ggplot(data, aes(x=TotRmsAbvGrd, y=SalePrice)) + 
  geom_point() + 
  geom_smooth(method='lm', formula=y~x, color='blue')

# Performing linear regression
model1 <- lm(SalePrice ~ TotRmsAbvGrd, data=data)

# Displaying the model summary
summary(model1)

# Interpreting dummy variables: 
#model2 <- lm(SalePrice ~ PavedDrive, data=data)
model2 <- lm(SalePrice ~ CentralAir, data=data)

summary(model2)

################################################################################
## Multiple linear regression: 
modelMulti1 <- lm(SalePrice ~ firstFlrSF + secondFlrSF + CentralAir + PavedDrive, data=data)
summary(modelMulti1)

# To detect multicollinearity in R, we typically look at the Variance Inflation Factor (VIF).
#  A VIF value greater than 10 (or sometimes 5, as a more conservative threshold) indicates 
#high multicollinearity that may be problematic.

# Calculate Variance Inflation Factors (VIF) to check for multicollinearity
vif_values1 <- vif(modelMulti1)

# Display the VIF values
print(vif_values1)

modelMulti2 <- lm(SalePrice ~  firstFlrSF + secondFlrSF + GrLivArea + CentralAir + PavedDrive, data=data)
summary(modelMulti2)

vif_values2 <- vif(modelMulti2)
print(vif_values2)


## Correlation vs. Causation: 
model3 <- lm(SalePrice ~  TotRmsAbvGrd + CentralAir + PavedDrive, data=data)
model3 <- lm(SalePrice ~  TotRmsAbvGrd + GrLivArea + CentralAir + PavedDrive, data=data)
summary(model3)

