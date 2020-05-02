# Let us get the appropriate libraries loaded for NB Classifier. 
#install.packages("e1071")
library("e1071")
#req1
#clean environment 
rm(list=ls())
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 4 - Classification\\Lab")
###########################
#req2
dfm <- read.csv("nbtrain.csv")
dim(dfm)
#What are the variables of this data set?
#age, gender, educ, income "in a categorial form"
##########################
#req3
traindata <- dfm[1:9000,]
testdata <- dfm[9001:nrow(dfm),]

#Display data frames
traindata
testdata

#Why do we split data into training and test sets?
#trining set is the initial dataset used to train the algorithm
#test set to test the performance of our model and adjust the hyper parameters
#and if test if there is an overfitting/underfitting issues
#we can't  reuse the training dataset in testing 
#because the algorithm will already know the expected output
#########################
#req4
# use the NB classifier with Laplace smoothing
model <- naiveBayes(income ~.,traindata,laplace=.01)
########################
#req5
#display model
model
#########################
#req6
# predict with testdata
results <- predict (model,testdata)
# display results
results
#What does Laplace smoothing coefficient mean?
#positive double controlling Laplace smoothing. The default (0) disables Laplace smoothing.
#to solve the problem of zero probability.
#In NaiveBayes: we are multiplying all the probabilities during inference
#One zero probability term will lead to the entire process failing.
#the goal is to increase the zero probability values to a small positive number
#and  reduce other values so that the sum is still 1
#Laplace smoothing is one such method
##########################
#req7
#confusionMatrix(data, reference, positive = NULL, dnn = c("Prediction", "Reference"), ...)
tb <- table(results, testdata$income)
tb
#Investigate the results.
#Explain the variation in the model's classification power across income classes.
#It seems that the model is biased towards 10-50K,
#we have 803 10-50K and 75 80K and 132 50-80K
############################
#req8
#accuracy = sum diagol/total
accuracy <- sum(diag(tb))/sum(tb)
accuracy
#accuracy = Tp+TN/total
#accuracy = 0.79 means 79% of the tested data is correctly classified 
###########################
missclassification <- (1-accuracy)
missclassification



