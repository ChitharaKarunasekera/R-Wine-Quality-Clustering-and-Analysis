whitewine <- read.csv("Whitewine_v2.csv")

whitewine$quality = NULL

set.seed(26)

clusterNo=NbClust(iris,distance="euclidean", min.nc=2,max.nc=10,method="kmeans",index="all")