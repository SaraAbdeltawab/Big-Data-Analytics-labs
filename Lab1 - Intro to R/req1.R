#Sara Ahmed
#clean environment 
rm(list=ls())
#display work items
ls()
#get working directory
getwd()
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\lab1")

#Importing data from csv files and reading data into a data frame
#================================================================
titanic_dfm <- read.csv("titanic.csv")
#get dimensions of data frame
dimension <- dim(titanic_dfm)
print(dimension)
#get structure
print(str(titanic_dfm))
#==============
#visualize some of the data
print(head(titanic_dfm,10))
print(tail(titanic_dfm,10))
#====
#get summary
summary(titanic_dfm)
#=======REQ4============
#Show a summary for the variable age only.
summary(titanic_dfm$Age)
#1st Qu : median of the first half = 20.12
#3rd Qu: median of the second half = 38.00
#there is 177 number missing
is.na(titanic_dfm$Age) 
typeof(titanic_dfm$Embarked) #expected character output: integer ??
#=======================================================================
#=======REQ5============
#is.na(titanic_dfm$Age) 
#titanic_dfm <- subset(titanic_dfm, is.na(titanic_dfm$Age) == 1)
#titanic_dfm
#dim(titanic_dfm)
#Remove the rows containing <NA> in the age variable from the data frame.
titanic_dfm <- titanic_dfm[-which(is.na(titanic_dfm$Age)), ]
titanic_dfm$Embarked
dim(titanic_dfm)
#titanic_dfm$Embarked[titanic_dfm$Embarked == "C"] <-  ""
#Remove the rows containing any unexpected value
titanic_dfm <- titanic_dfm[-which(titanic_dfm$Embarked != c("C", "Q", "S")), ]
titanic_dfm$Embarked
dim(titanic_dfm)
#5C
#check that no NA values exist in the age variable. Also, factor the embarked variable
#and display its levels. Is that what you are expecting?
is.na(titanic_dfm$Age)
unique_val_Embarked <- factor(titanic_dfm$Embarked)
unique_val_Embarked #Same as expected 
#5D
#Some variables are not very interesting and provide no real indicative value. Remove
#columns Cabin and Ticket from the dataset.
titanic_dfm$Ticket <- NULL
titanic_dfm$Cabin <- NULL
dim(titanic_dfm)
#===================================================================
#=======REQ6============
#Show the number of males and females aboard the Titanic.
female_num <- sum(titanic_dfm$Gender =='female')
male_num <- sum(titanic_dfm$Gender =='male')
#b
pie(c(female_num, male_num), c("Female", "Male"),  col = c("pink", "black"))
#c
male_survived_num <- sum(titanic_dfm$Survived == 1 & titanic_dfm$Gender =='male')
male_survived_num
male_num - male_survived_num

female_survived_num <- sum(titanic_dfm$Survived == 1 & titanic_dfm$Gender =='female')
female_survived_num
female_num - female_survived_num
#D
pie(c(female_survived_num, male_survived_num), c("female_survived_num", "male_survived_num"),  col = c("pink", "black"))
#E
#conclude:
#numbers of males survived < numbers of female survived
#=====================================================================
#Show the relationship between social class and survival i.e. show how many people
#survived and how many people didn't survive from each class.
class1_survived_num <- sum(titanic_dfm$Survived == 1 & titanic_dfm$Pclass == 1)
class2_survived_num <- sum(titanic_dfm$Survived == 1 & titanic_dfm$Pclass == 2)
class3_survived_num <- sum(titanic_dfm$Survived == 1 & titanic_dfm$Pclass == 3)

class1_unsurvived_num <- sum(titanic_dfm$Survived == 0 & titanic_dfm$Pclass == 1)
class2_unsurvived_num <- sum(titanic_dfm$Survived == 0 & titanic_dfm$Pclass == 2)
class3_unsurvived_num <- sum(titanic_dfm$Survived == 0 & titanic_dfm$Pclass == 3)

out <- c(class1_survived_num, class2_survived_num, class3_survived_num, class1_unsurvived_num, class2_unsurvived_num, class3_unsurvived_num)
out
out_name <- c("class1_survived_num", "class2_survived_num", "class3_survived_num", "class1_unsurvived_num", "class2_unsurvived_num", "class3_unsurvived_num")
color <- c("blue","blue","blue","red","red","red")
barplot(out, names.arg = out_name, col = color)
#conclude
#there is a relation between the social class and the unsurvival number 
#inversely proportional relation, higher class, lower unsurvived people
#======================================
boxplot(titanic_dfm$Age)
#it gives the summary of age: min, max, median, 1stquad, 3rdquad
#Plot a density distribution for the variable age.
#hist(titanic_dfm$Age, col="cyan")
plot(density(titanic_dfm$Age))
new_dfm <- subset(titanic_dfm, select=c(Name,Survived))
write.csv(new_dfm,"new_titanic.csv")