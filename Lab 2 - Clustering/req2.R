library(rattle.data)
library(NbClust)
library(cluster)
library(HSAUR)
library(png)
#######################################PART1##############################################
#req1
#clean environment 
rm(list=ls())
#set working directory
setwd("E:\\college\\fourth_year\\4B\\BigData\\labs\\Lab 2 - Clustering\\Lab 2")
###########################
#req2
dfm <- read.csv("clustering_data.csv")
plot(dfm)
##########################
#req3
# apply kmeans clustering 
km <- kmeans(dfm,10,15) #numberofclusters,max iterations default = 10
##########################
#req4
print(km$centers)
##########################
#req5
#using colored plot 
#clusplot(dfm, km$cluster, color=TRUE, shade=TRUE,  labels=0, lines=0)
plot(dfm, col=km$cluster)
##########################
#req6
points(km$centers,col=1:10,pch=17,cex=1,lwd=1)
##########################
#req7
if(FALSE) {
  "points: Add Points to a Plot"
  "Is a generic function to draw a sequence of points at the specified coordinates."
  "=> you need to plot first before using this function <="
  "plot: Generic function for plotting of R objects"
}
#########################
#req8
#examine the best number of clusters 
#within group SS
wss <- (nrow(dfm)-1)*sum(apply(dfm,2,var)) 
for (i in 2:25) wss[i] <- sum(kmeans(dfm, centers=i)$withinss)
plot(1:25, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")


# another way to examine the best number of clusters 
nc <- NbClust(dfm, min.nc=2, max.nc=25, method="kmeans")

#Best number of clusters = 3
#########################
#req9
#voting results 
table(nc$Best.n[1,]) 
#########################
#req10
#apply kmeans clustering with the best k
km <- kmeans(dfm,3,20) #numberofclusters,max iterations default = 10
km$centers
################
#req11
#REPEAT FOR nc = 3
#REPEAT req4
print(km$centers)
##########################
#REPEAT req5
#using colored plot 
#clusplot(dfm, km$cluster, color=TRUE, shade=TRUE,  labels=0, lines=0)
plot(dfm, col=km$cluster)
##########################
#REPEAT req6
points(km$centers,col=1:3,pch=17,cex=1,lwd=1)
################################################################
#######################################PART2##############################################
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
dfm <- km$centers[km$cluster,]
print(dfm)
#################
#req8
typeof(dfm)
dim(dfm) <- c(128,128,3)
###################
#req9
writePNG(dfm,"compressed.png")
#The size of image reduced from 32.2 KB to 10.1 KB
###################