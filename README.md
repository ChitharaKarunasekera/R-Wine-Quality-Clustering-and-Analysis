# Wine Quality Clustering and Analysis

This project involves performing k-means clustering and principal component analysis (PCA) on a white wine dataset to analyze the relationship between chemical properties and quality ratings, aiming to enhance the wine quality assessment process. The project is implemented in R.

## Project Overview
This project is part of the coursework for the Machine Learning and Data Mining module. The primary objective of this project is to perform clustering analysis on a white wine dataset and evaluate the clustering results. The dataset contains 4710 observations with 11 attributes representing chemical properties and one output attribute representing wine quality.

## Objectives
### Pre-processing Tasks
+ Removing outliers.
+ Normalizing and scaling the data.

### Clustering Analysis
+ Determine the number of cluster centers using manual and automated methods (NbClust, Elbow, Silhouette).
+ Perform k-means clustering with different values of k (2, 3, and 4).
+ Evaluate clustering results against the quality attribute using confusion matrices and calculate accuracy, recall, and precision.
+ Apply PCA to reduce dimensionality and re-evaluate clustering performance.

## Dataset
The dataset used in this project is named `Whitewine_v2.csv`.

## Project Structure
+ `ClusteringPart.Rproj`: R project file.
+ `Whitewine_v2.csv`: The dataset used for analysis in CSV format.
+ `Whitewine_v2.xlsx`: The dataset used for analysis in Excel format.
+ `clustering_part.R`: Script for performing the entire clustering part, including data preprocessing, k-means clustering, and PCA analysis.

## Usage
1. ### Open the Project
+ Open ClusteringPart.Rproj in RStudio.

2. ### Run the Clustering Script
+ Run clustering_part.R to:
  + Clean and normalize the dataset.
  + Determine the optimal number of clusters using manual and automated methods.
  + Perform k-means clustering with k=2, 3, and 4.
  + Evaluate the clustering results.
  + Apply PCA and re-evaluate clustering performance.
 
## Results
1. ### Data Pre-processing
![Dara-Preprocessing](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/22b1e538-cfcd-42b6-8efb-a0bd3920146d)

2. ### Clustering using Automated Tools
+ #### NbClust Method using silhouette method
![silhouette_method](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/9af89ea2-3775-4e47-beb9-17e7cfa7cee4)

+ #### Elbow Method
![Elbow_Method](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/da8bda44-a23c-4b5b-b7c2-b9109fa26588)

+ According to above methods the most optimal number of clusters can be identified as 2
 
3. ### K-means analysis for each k attempt.
+ #### K-means analysis with k=2
![k=2](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/77ce2f72-b3e1-4ab7-9906-b41c994fe7dd)

+ #### K-means analysis with k=3
![k=3](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/cfb9c8fd-2713-4dff-a6e1-c3f56ba1fb2d)

+ #### K-means analysis with k=4
![k=4](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/1d87903b-0bbe-4d30-9c82-fee435b38e3a)


4. ### Evaluation of the produced outputs against 12th column (quality)
+ #### Confusion Matrix for k = 2
![Confusion_Matrix](https://github.com/ChitharaKarunasekera/R-Wine-Quality-Clustering-and-Analysis/assets/78892816/725190ec-6f78-4011-824b-9d4ecdb51731)



The best clustering result was achieved with k=2. Applying PCA improved the quality of the clustering model, increasing the quality score from 30% to 59%.


## Conclusion
This project demonstrates the use of k-means clustering and PCA for analyzing a wine quality dataset. The results show that PCA can significantly improve the quality of clustering models
