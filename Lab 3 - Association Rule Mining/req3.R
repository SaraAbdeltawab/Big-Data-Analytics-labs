#req2
library(arules)
library(arulesViz)
#############################
#req1
#clean environment 
rm(list=ls())
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 3 - Association Rule Mining\\Lab 3 - Association Rule Mining")
#############################
#req3
transactions <- read.transactions("AssociationRules.csv", header=FALSE)
dim(transactions)
##Make sure you don't include the header line in the dataset ??#modify
###############################
#req4
inspect(transactions[1:100,])
##############################
#req5
#itemFrequency(transactions)
summary(transactions)
##the most frequent two items in the dataset
##item13 = 4948   item5 = 3699 
#############################
#req6
itemFrequencyPlot(transactions,topN = 5)
#############################
#req7
rules <- apriori(transactions, parameter = list(supp = 0.01, conf = 0.5, minlen = 2))
rules
#############################
#req8
rules_by_support <- sort(rules)
inspect(rules_by_support[1:6])
###########################
#req9
rules_by_confidence <- sort(rules, by="conf")
inspect(rules_by_confidence[1:6])
##########################
#req10
rules_by_lift <- sort(rules, by="lift")
inspect(rules_by_lift[1:6])
##########################
#req11
plot(rules, measure = c("support", "confidence"), shading = "lift", jitter = 0)
##########################
#req12
#Based on (8-11)
#Can you tell now what are the most interesting rules that are really useful and provide a real business value and an insight to the concerned corporate?
# values with high  Lift we may say the rule is true and not coincidental.
#So we take rules with high lift and confidence.. 
#such as
#[1] {item15,item30,item56} => {item49} 0.0101  0.7709924  19.42046 101  
#[2] {item30,item56,item84} => {item49} 0.0100  0.7407407  18.65846 100 
