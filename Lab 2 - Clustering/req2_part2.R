library(rattle.data)
library(NbClust)
library(cluster)
library(HSAUR)
library(png)
#req1
#clean environment 
rm(list=ls())
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 2 - Clustering\\Lab 2")
###########################
#req2
image<-readPNG("bird_small.png") #The resulting image is a 3-dimensional vector
#########################
#req3
R <- c(image[1:nrow(image),1:ncol(image),1])
G <- c(image[1:nrow(image),1:ncol(image),2])
B <- c(image[1:nrow(image),1:ncol(image),3])
dfm <- data.frame(R, G, B)
#########################
#req4
#apply kmeans clustering 
km <- kmeans(dfm,16,15) #numberofclusters,max iterations default = 10
#########################
#req5
print(km$cluster)
#clusplot(dfm, km$cluster, color=TRUE, shade=TRUE,  labels=0, lines=0)
#plot(dfm, col=km$cluster)
#################
#req6
print(km$centers)
#represents the 16 selected colors that will represent the image
##################
#req7
#for (i in 1:nrow(dfm)) dfm[i,] <- km$centers[km$cluster[i],]
dfm<- km$centers[km$cluster,]
print(dfm)
#################
#req8
typeof(dfm)
dim(dfm) <- c(128,128,3)
###################
#req9
writePNG(dfm,"compressed.png")
#The size of image reduced from 32.2 KB to 10.6 KB
###################



