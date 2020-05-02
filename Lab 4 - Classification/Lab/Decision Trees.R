#clean environment 
rm(list=ls())
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 4 - Classification\\Lab")

#install.packages("rpart.plot")
library("rpart")
library("rpart.plot")
library("ROCR")

#Read the data
play_decision <- read.table("DTdata.csv",header=TRUE,sep=",")
play_decision
summary(play_decision)

#Build the tree to "fit" the model
fit <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit, type = 4, extra = 1)

summary(fit)
#######################################################################################
# Q1: what is the defult value for split? 
#the split defaults to gini.
#The splitting index can be gini or information. 

# Q2: what are the meanings of these control parameters?  
#          1- "minsplit=2"
#the minimum number of observations that must exist in a node in order for a split to be attempted = 2.
#          2- "maxdepth=3" 
#Set the maximum depth of any node of the final tree, with the root node counted as depth 0.
#          3- "minbucket=4" 
#"the minimum number of observations in any leaf"


# Support your answers with graphs for different values of these parameters.
##
#1- minsplit
#Build the tree to "fit" the model
#graph1
fit1 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=4, maxdepth = 3),
             parms=list(split='information'))
#plot the tree
rpart.plot(fit1, type = 4, extra = 1)
summary(fit1)

#graph2
fit2 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=8, maxdepth = 3),
             parms=list(split='information'))
#plot the tree
rpart.plot(fit2, type = 4, extra = 1)
summary(fit2)

################################################################
#2-maxdepth
#graph1
fit3 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=3, maxdepth = 1),
             parms=list(split='information'))
#plot the tree
rpart.plot(fit3, type = 4, extra = 1)
summary(fit3)

#graph2
fit4 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=3, maxdepth = 4),
             parms=list(split='information'))
#plot the tree
rpart.plot(fit4, type = 4, extra = 1)
summary(fit4)
###the maximun = 2 any value greater than that wouldn't change the tree

######################################################################
#3-minbucket
#graph1
#Build the tree to "fit" the model
fit5 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3, minbucket=4),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit5, type = 4, extra = 1)

#graph2
fit5 <- rpart(Play ~ Outlook + Temperature + Humidity + Wind,
             method="class", 
             data=play_decision,
             control=rpart.control(minsplit=2, maxdepth = 3, minbucket=3),
             parms=list(split='information'))
# split='information' : means split on "information gain" 
#plot the tree
rpart.plot(fit5, type = 4, extra = 1)


#############################################################

#Q3: What will happen if only one of either minsplit or minbucket is specified
#    and not the other?

#If only one of minbucket or minsplit is specified, the code either sets minsplit to minbucket*3 
#or minbucket to minsplit/3, as appropriate.

#Q4: What does 'type' and 'extra' parameters mean in the plot function?
if(FALSE){
"
  type: different representation of the tree
  extra: Display extra information at the nodes.
  check different examples below.
  From Documentation: 
  Type Possible values:
  0: Draw a split label at each split and a node label at each leaf.
  1 Label all nodes, not just leaves.
  2 Default. Like 1 but draw the split labels below the node labels.
  3 Draw separate split labels for the left and right directions.
  4 Like 3 but label all nodes, not just leaves.

  
  extra Possible values:
  auto (case insensitive) Default.
  Automatically select a value based on the model type, as follows:
  extra=106 class model with a binary response
  extra=104 class model with a response having more than two levels
  extra=100 other models
  
  0 No extra information.
  1 Display the number of observations that fall in the node (per class for class objects; prefixed by the number of events for poisson and exp models)
  2 Class models: display the classification rate at the node, expressed as the number of correct classifications and the number of observations in the node.
  Poisson and exp models: display the number of events.
  3 Class models: misclassification rate at the node, expressed as the number of incorrect classifications and the number of observations in the node.
  4 Class models: probability per class of observations in the node (conditioned on the node, sum across a node is 1).
  5 Class models: like 4 but don't display the fitted class.
  6 Class models: the probability of the second class only. Useful for binary responses.
  7 Class models: like 6 but don't display the fitted class.
  8 Class models: the probability of the fitted class.
  9 Class models: The probability relative to all observations - the sum of these probabilities across all leaves is 1. This is in contrast to the options above, which give the probability relative to observations falling in the node - the sum of the probabilities across the node is 1.
  "
}
rpart.plot(fit, type = 0, extra = 1)
rpart.plot(fit, type = 0, extra = 0)
rpart.plot(fit, type = 2, extra = 3)
rpart.plot(fit, type = 4, extra = 4)
#Q5: Plot the tree with propabilities instead of number of observations in each node.
######################################################################################
rpart.plot(fit, type = 4, extra = 9)
 
#Predict if Play is possible for condition rainy, mild humidity, high temperature and no wind
newdata <- data.frame(Outlook="overcast",Temperature="mild",Humidity="high",Wind=FALSE)
newdata
predict(fit,newdata=newdata,type=c("class"))
# type can be class, prob or vector for classification trees.

######################################################################################
#Q6: What is the predicted class for this test case?
#yes => play
#Q7: State the sequence of tree node checks to reach this class (label).
#1- temperature mild => go left
#2- outlook  overcast => go right
"taking the last represnted graph as reference"
## ================================= END ===================================== ##