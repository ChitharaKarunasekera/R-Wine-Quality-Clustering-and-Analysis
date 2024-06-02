library(NbClust)
library(ggpubr)
library(factoextra)
library(caret)
library(devtools)
library(ggbiplot)

#import data
whitewine <- read.csv("Whitewine_v2.csv")

variables <- whitewine[,-12] #stores attributes
quality <- whitewine$quality #class types

D <- c() # empty vector to store outliers in each column

for (i in 1:11) {
  x <- variables[,i] # access every column in data set
  y <- x %in% boxplot.stats(x)$out # records which data are outliers and which are not
  
  d <- which(y == TRUE) # record the outliers of the current column 
  D <- c(D,d) # add every set of outliers to a vector which stores all outliers
}


eleminate <- unique(D) # remove the duplicated rows

eleminate <- sort(eleminate) # sort the outlire rows in order

good_data <- whitewine[-eleminate,] # store the final rows after removing the outlires for attributes

# function to calculate the normalized data
normalize <- function(x){
  return ((x - min(x)) / (max(x) - min(x)))
}


good_data_norm <- as.data.frame(lapply(good_data[,-12], normalize))# normalized data

scale_good_data_norm <- data.frame(scale(good_data_norm)) # scale the normalized data


# Manual Tools - calling k-means function 
kc <- kmeans(scale_good_data_norm,4)
table(good_data$quality,kc$cluster)


# Plotting the clusters for K-Means Output
library(ggpubr)
library(factoextra)
# Plot
fviz_cluster(kc, data = good_data_norm,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
             )



################################################################################
#                  Automated Tools - NbClust Method
################################################################################

# Using NbCluste 
library(NbClust)
nbClust_clusterNo=NbClust(scale_good_data_norm,distance="euclidean", min.nc=2,max.nc=10,method="kmeans",index="all")

# Using factoextra
fviz_nbclust(scale_good_data_norm, kmeans, method = "silhouette")

nbClust_Clsters <- kmeans(scale_good_data_norm,2) #find new clusters with the number of clusters suggested by NbClust

# plot the clusters accordingly 
fviz_cluster(nbClust_Clsters, data = good_data_norm,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
             )



# Automated Tools - Elbow Method
k = 1:10 # number of possible clusters
set.seed(42)


WSS = sapply(k, function(k) {kmeans(scale_good_data_norm, centers=k)$tot.withinss})

plot(k, WSS, type = "b", pch = 19, frame=FALSE, xlab= "Number of k", ylab="Within sum of squares")

fviz_nbclust(scale_good_data_norm, kmeans, method = "wss")+
  geom_vline(xintercept = 2, linetype = 2)+
  labs(subtitle = "Elbow method")


######################################################################
#         1.1.3.	K-means analysis for each k attempt.
#####################################################################

# k = 2
kc2 <- kmeans(scale_good_data_norm,2)

fviz_cluster(kc2, data = scale_good_data_norm,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

kc2_centers <- kc2$centers
kc2_bss <- kc2$betweenss
kc2_tss <- kc2$tot.withinss
kc2_wss <- kc2$withinss


table(good_data$quality,kc2$cluster)#Confusion Matrix


# k = 3
kc3 <- kmeans(scale_good_data_norm,3)

fviz_cluster(kc3, data = scale_good_data_norm,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

kc3_centers <- kc3$centers
kc3_bss <- kc3$betweenss
kc3_tss <- kc3$tot.withinss
kc3_wss <- kc3$withinss

table(good_data$quality,kc3$cluster)


# k = 4
kc4 <- kmeans(scale_good_data_norm,4)

fviz_cluster(kc4, data = scale_good_data_norm,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

kc4_centers <- kc4$centers
kc4_bss <- kc4$betweenss
kc4_tss <- kc4$tot.withinss
kc4_wss <- kc4$withinss

table(good_data$quality,kc4$cluster)



#################################        CM            #########################


class_IDs <- kc4$cluster #cluster ID assigned by automatic clustering method


row_count = 1
cluster5_count = 0 #total number of data points for cluster 5 
cluster6_count = 0 #total number of data points for cluster 6
cluster7_count = 0 #total number of data points for cluster 7
cluster8_count = 0 #total number of data points for cluster 8

#identify cluster by class ID
actualClusters <- good_data$quality #actual cluster each row belongs to

#count number of data points for each cluster 
while (row_count < length(actualClusters)+1) {
  if (actualClusters[row_count] == 5){
    cluster5_count = cluster5_count + 1
    row_count = row_count + 1
  }
  if (actualClusters[row_count] == 6){
    cluster6_count = cluster6_count + 1
    row_count = row_count + 1
  }
  if (actualClusters[row_count] == 7){
    cluster7_count = cluster7_count + 1
    row_count = row_count + 1
  }
  if (actualClusters[row_count] == 8){
    cluster8_count = cluster8_count + 1
    row_count = row_count + 1
  }
}



#function to return mode
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


class_IDs <- kc4$cluster #cluster ID assigned by automatic clustering method

#find 5 when k=2 
quality5_value <- getmode(class_IDs[1:cluster5_count])

#find 6 when k=2 
quality6_value <- getmode(class_IDs[cluster5_count+1:cluster6_count])

#find 7 when k=2
quality7_value <- getmode(class_IDs[cluster6_count+1:cluster7_count])

#find 8 when k=2 
quality8_value <- getmode(class_IDs[cluster7_count+1:cluster8_count])

  
  


#################################        PCA            ########################
transformed <- prcomp(scale_good_data_norm, center = TRUE, scale. = TRUE) #create new PCA data set
summary(transformed)

new_transformed <- transformed$x[,9:11]


transformed_kmeans <- kmeans(new_transformed,2)

transformed_kmeans

fviz_cluster(transformed_kmeans, data = new_transformed,
             palette = c("#2E9FDF", "#00AFBB", "#E7B800", "#b800e7"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)


transformed_kmeans_bss <- transformed_kmeans$betweenss
transformed_kmeans_tss <- transformed_kmeans$tot.withinss
transformed_kmeans_wss <- transformed_kmeans$withinss

table(good_data$quality,kc3$cluster)
