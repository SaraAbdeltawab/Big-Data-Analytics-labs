#setwd("~/LAB")
library("Metric")
rm(list=ls())

#=============================Part(1)=====================================
x <- runif(100, 0, 10)     # 100 draws between 0 & 10

#(Q1) Try changing the value of standard deviation (sd) in the next command 
#How do the data points change for different values of standard deviation?
y <- 5 + 6*x + rnorm(100, sd = 2)  # default values for rnorm (mean = 0 and sigma = 1)
#rnorm(n, mean = 0, sd = 1)
#n: number of observations
#Plot it
plot (x,y)

y2 <- 5 + 6*x + rnorm(100, sd = 10)  # default values for rnorm (mean = 0 and sigma = 1)
#rnorm(n, mean = 0, sd = 1)
#n: number of observations
#Plot it
plot (x,y2)


# OLS model
# OLS : Ordinary Least Squares
model1 <- lm(y ~ x)
# Learn about this object by saying ?lm and str(d)

# Compact model results
print(model1)


model11 <- lm(y2 ~ x)
# Learn about this object by saying ?lm and str(d)

# Compact model results
print(model11)

#(Q2) How are the coefficients of the linear model affected by changing the value
#of standard deviation in Q1?

# Regression diagnostics --
ypred <- predict(model1) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm
ypred
y
par(mfrow=c(1,1))
plot(y,y, type="l", xlab="true y", ylab="predicted y") # ploting the ideal line
points(y, ypred) # plotting the predicted points
                 # the nearer to the ideal line the better

# Detailed model results
d1 <- summary(model1)
print(d1)


# Regression diagnostics --
ypred1 <- predict(model11) # use the trained model to predict the same training data
# Learn about predict by saying ?predict.lm
ypred1
y2
par(mfrow=c(1,1))
plot(y2,y2, type="l", xlab="true y", ylab="predicted y") # ploting the ideal line
points(y2, ypred1) # plotting the predicted points
# the nearer to the ideal line the better

# Detailed model results
d11 <- summary(model11)
print(d11)
#(Q3) How is the value of R-squared affected by changing the value
#of standard deviation in Q1?

# Learn about this object by saying ?summary.lm and by saying str(d)
cat("OLS gave slope of ", d1$coefficients[2,1],   
    "and an R-sqr of ", d1$r.squared, "\n")

#Graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model1, 1) # plot one diagnostic graphs

#(Q4)What do you conclude about the residual plot? Is it a good residual plot?
#========================End of Part(1)==============================================

#========================Part(2)=====================================================
#Training a linear regression model
x1 <- runif(100) 
x1
# introduce a slight nonlinearity
#(A)
y1 = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)
plot(x1,y1)
model <- lm(y1 ~ x1)

summary(model)

#Creating a test set (test vector)

#EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
#becaues the lm function searches in the formula for variables named 
#with x1 and not any other name.
#So, if you used xtest, the lm function will not know what is xtest and
#a random plot will be generated. 

x1 <- runif(100)
#(B)
ytrue = 5 + 6*x1 + 0.1*x1*x1 + rnorm(100)  # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow=c(1,1))
plot(ytrue, ytrue, type="l", xlab="true y", ylab="predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs

#(Q5)What do you conclude about the residual plot? Is it a good residual plot?

#(Q6)Now, change the coefficient of the non-linear term in the original model for (A) training 
#and (B) testing to a large value instead. What do you notice about the residual plot?
#(A)
y1 = 5 + 6*x1 + 100*x1*x1 + rnorm(100)
plot(x1,y1)
model <- lm(y1 ~ x1)

summary(model)

#Creating a test set (test vector)

#EDIT: We renamed the variable as x1 instead of xtest (in previous versions)
#becaues the lm function searches in the formula for variables named 
#with x1 and not any other name.
#So, if you used xtest, the lm function will not know what is xtest and
#a random plot will be generated. 

x1 <- runif(100)
#(B)
ytrue = 5 + 6*x1 + 100*x1*x1 + rnorm(100)  # same equation of y1 but on xtest to get true y for xtest

ypred <- predict(model, data.frame(x1))

par(mfrow=c(1,1))
plot(ytrue, ytrue, type="l", xlab="true y", ylab="predicted y")
points(ytrue, ypred)

# graphic dignostic (cont.)
par(mfrow=c(1,1)) # parameters for the next plot
plot(model, 1) # plot the diagnostic graphs
#===============================End of Part(2)=============================================

#=================================Part(3)==================================================
#(Q7) Import the dataset LungCapData.tsv. What are the variables in this dataset?
dfm <- read.csv("LungCapData.tsv", sep = "\t")
dfm

#(Q8) Draw a scatter plot of Age (x-axis) vs. LungCap (y-axis). Label x-axis "Age" and y-axis "LungCap"
par(mfrow=c(1,1)) # parameters for the next plot
plot(dfm$Age, dfm$LungCap, type="p", xlab="Age", ylab="LungCap")

#(Q9) Draw a pair-wise scatter plot between Lung Capacity, Age and Height. 
#Check the slides for how to plot a pair-wise scatterplot
pairs(dfm$LungCap~dfm$Age+dfm$Height)


#(Q10) Calculate correlation between Age and LungCap, and between Height and LungCap.
#Hint: You can use the function cor
cor(dfm$Age, dfm$LungCap)
cor(dfm$Height, dfm$LungCap)
cor(dfm$Age, dfm$Height)
#(Q11) Which of the two input variables (Age, Height) are more correlated to the 
#dependent variable (LungCap)?

#(Q12) Do you think the two variables (Height and LungCap) are correlated ? why ?

#(Q13) Fit a liner regression model where the dependent variable is LungCap 
#and use all other variables as the independent variables
model2 <- lm(dfm$LungCap~dfm$Age+dfm$Height+dfm$Smoke+dfm$Gender+dfm$Caesarean)
#(Q14) Show a summary of this model
d2 <- summary(model2)
print(d2)
#(Q15) What is the R-squared value here ? What does R-squared indicate?

#(Q16) Show the coefficients of the linear model. Do they make sense?
#If not, which variables don't make sense? What should you do?
cat("coefficients ", d2$coefficients[,1],   
    "and an R-sqr of ", d2$r.squared, "\n")

#(Q17) Redraw a scatter plot between Age and LungCap. Display/Overlay the linear model (a line) over it.
#Hint: Use the function abline(model, col="red").
#Note (1) : A warning will be displayed that this function will display only the first two 
#           coefficients in the model. It's OK.
#Note (2) : If you are working correctly, the line will not be displayed on the plot. Why?
par(mfrow=c(1,1)) # parameters for the next plot
plot(dfm$Age, dfm$LungCap, type="p", xlab="Age", ylab="LungCap")
abline(model2, col="red")


#(Q18)Repeat Q13 but with these variables Age, Smoke and Cesarean as the only independent variables.
model3 <- lm(dfm$LungCap~dfm$Age+dfm$Smoke+dfm$Caesarean)

d3 <- summary(model3)
d3
#(Q19)Repeat Q16, Q17 for the new model. What happened?
cat("coefficients ", d3$coefficients[,1],   
    "and an R-sqr of ", d3$r.squared, "\n")
par(mfrow=c(1,1)) # parameters for the next plot
plot(dfm$Age, dfm$LungCap, type="p", xlab="Age", ylab="LungCap")
abline(model3, col="red")


#(Q20)Predict results for this regression line on the training data.
pred <- predict(model3)

#(Q21)Calculate the mean squared error (MSE)of the training data.
MSE <- mean(model3$residuals^2)
MSE

#MSE2 <- mse(dfm$LungCap,pred)
#MSE2