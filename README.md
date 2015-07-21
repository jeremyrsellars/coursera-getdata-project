# Getting and Cleaning Data Course Project

This Jeremy Sellars' course project described here: https://class.coursera.org/getdata-030

Creates a tidy dataset from data from "Human Activity Recognition Using Smartphones"
with mean sensor values per participant subject in each of 6 activities.
These activities and sensors are described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Citation
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


### Note
This assumes that "getdata-projectfiles-UCI HAR Dataset.zip" 
is extracted to the current working directory - so its README.txt
is in the working directory.




## Project source/explanation

The `load_dataset` function takes files from a data set (train or test)
* `load_dataset("train")` uses
  * \subject_train.txt
  * \X_train.txt
  * \y_train.txt
* `load_dataset("test")` uses:
  * \subject_test.txt
  * \X_test.txt
  * \y_test.txt

The `combine_datasets` function uses `rbind` to form a single result set by stacking the test and train datasets with `rbind`.

This resultset is then aggregated to form the final product

* **A row for each subject-activity pair**
* **A column for every feature (measurement)** - The mean of each feature, grouped by subject (person), and activity.


The 5 objectives from the assignment description are clearly marked in the source code, for example: `###### REQUIREMENT #2 - fulfilled ###### `.


```r
get_file_name <- function(set_name, file) paste(set_name, "/", file, "_", set_name, ".txt", sep = "")

# Read activity names from file
activity_names <- read.csv("activity_labels.txt", header=F, sep=" ", stringsAsFactors=F)[,2]
get_activity_name <- function(activity_index) activity_names[activity_index]

# Read feature names from file
feature_names <- read.csv("features.txt", header=F, sep=" ", stringsAsFactors=F)[,2]
# Get feature names containing "std()" or "mean()", sorted alphabetically
mean_and_std_feature_names <-
  sort(feature_names[c(grep("std\\(\\)", feature_names, ignore.case = F),
                       grep("mean\\(\\)", feature_names, ignore.case = F))])

## Loads and transforms a dataset (set_name should be "train" or "test")
load_dataset <- function(set_name){
  # Read the feature (measurement) file
  all_features <- read.csv(get_file_name(set_name, "X"), sep="", header = F)
  # Read the subject (measurement) file
  subject <- read.csv(get_file_name(set_name, "subject"), header = F)
  # Name the feature columns re: Requirement #4
  names(all_features) <- feature_names
  
  ###### REQUIREMENT #2 - fulfilled ###### 
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement
  #    There are a bunch of columns we don't care about.  The next statement includes
  #    only the features whose names contain "std()" or "mean()"
  features <- all_features[,mean_and_std_feature_names]

  ###### REQUIREMENT #3 - fulfilled ###### 
  # 3. Uses descriptive activity names to name the activities in the data set
  #    Instead of listing an activity number like 1 or 2, it lists "WALKING" or "WALKING_UPSTAIRS"
  y <- sapply(read.csv(get_file_name(set_name, "y"), header = F), get_activity_name)
  dataset <- cbind(subject, features, y)

  ###### REQUIREMENT #4 - fulfilled ###### 
  # 4. Appropriately labels the data set with descriptive variable names.
  #    The "feature" (measurement) columns are already named with names from "features.txt".
  #    The following line names the subject and activity columns.
  names(dataset)[c(1,ncol(dataset))] <- c("subject", "activity")
  
  dataset
}

combine_datasets <- function(){
  ###### REQUIREMENT #1 - fulfilled ###### 
  # 1. Merges the training and the test sets to create one data set.
  #    The next expression essentially stacks the "test" dataset on top of the "train" dataset.
  rbind(load_dataset("test"),
        load_dataset("train"))
}

combined_datasets <- combine_datasets()

###### REQUIREMENT #5 - fulfilled ###### 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
# The following code aggregates the previously created dataset by taking the mean
# of the data grouped by subject and activity.
combined_datasets.mean <- aggregate(. ~ subject + activity, data = combined_datasets, mean)
names(combined_datasets.mean) <- Map(function(n)paste("mean", n, sep = "_"), names(combined_datasets.mean))
names(combined_datasets.mean)[1:2] <- c("subject", "activity")
```

You can reproduce my "means.txt" file with the following R code:

`write.table(combined_datasets.mean, "means.txt", row.names=FALSE, sep="\t")`


## Reading the output

The means.txt file may be read with this code:

`means <- read.table("means.txt", header=TRUE)`

**Note: This file is in wide-form (see project rubric).**

* There is a column for every feature (measurement) containing either "std()" or "mean()", per class instructions.  It seems that which features qualified was a matter of debate.  For this project, I chose a smaller set of features that are clearly valuable.  I accept that my reviewers may have formed their own opinions on the subject, and I hope they will give me the benefit of the doubt.  The selection of features is easily changed (search for `grep`).
* There is a row for each subject-activity pair

## CodeBook
The resultant data is described in the [CodeBook](CodeBook.md).

## Comparing with my results

Note: In the interest of keeping people honest, I haven't included the data in the repository.  It was submitted as an attachment to the Coursera course.


```r
summary(combined_datasets.mean)
```

```
##     subject                   activity  mean_fBodyAcc-mean()-X
##  Min.   : 1.0   LAYING            :30   Min.   :-0.9952       
##  1st Qu.: 8.0   SITTING           :30   1st Qu.:-0.9787       
##  Median :15.5   STANDING          :30   Median :-0.7691       
##  Mean   :15.5   WALKING           :30   Mean   :-0.5758       
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:30   3rd Qu.:-0.2174       
##  Max.   :30.0   WALKING_UPSTAIRS  :30   Max.   : 0.5370       
##  mean_fBodyAcc-mean()-Y mean_fBodyAcc-mean()-Z mean_fBodyAcc-std()-X
##  Min.   :-0.98903       Min.   :-0.9895        Min.   :-0.9966      
##  1st Qu.:-0.95361       1st Qu.:-0.9619        1st Qu.:-0.9820      
##  Median :-0.59498       Median :-0.7236        Median :-0.7470      
##  Mean   :-0.48873       Mean   :-0.6297        Mean   :-0.5522      
##  3rd Qu.:-0.06341       3rd Qu.:-0.3183        3rd Qu.:-0.1966      
##  Max.   : 0.52419       Max.   : 0.2807        Max.   : 0.6585      
##  mean_fBodyAcc-std()-Y mean_fBodyAcc-std()-Z mean_fBodyAccJerk-mean()-X
##  Min.   :-0.99068      Min.   :-0.9872       Min.   :-0.9946           
##  1st Qu.:-0.94042      1st Qu.:-0.9459       1st Qu.:-0.9828           
##  Median :-0.51338      Median :-0.6441       Median :-0.8126           
##  Mean   :-0.48148      Mean   :-0.5824       Mean   :-0.6139           
##  3rd Qu.:-0.07913      3rd Qu.:-0.2655       3rd Qu.:-0.2820           
##  Max.   : 0.56019      Max.   : 0.6871       Max.   : 0.4743           
##  mean_fBodyAccJerk-mean()-Y mean_fBodyAccJerk-mean()-Z
##  Min.   :-0.9894            Min.   :-0.9920           
##  1st Qu.:-0.9725            1st Qu.:-0.9796           
##  Median :-0.7817            Median :-0.8707           
##  Mean   :-0.5882            Mean   :-0.7144           
##  3rd Qu.:-0.1963            3rd Qu.:-0.4697           
##  Max.   : 0.2767            Max.   : 0.1578           
##  mean_fBodyAccJerk-std()-X mean_fBodyAccJerk-std()-Y
##  Min.   :-0.9951           Min.   :-0.9905          
##  1st Qu.:-0.9847           1st Qu.:-0.9737          
##  Median :-0.8254           Median :-0.7852          
##  Mean   :-0.6121           Mean   :-0.5707          
##  3rd Qu.:-0.2475           3rd Qu.:-0.1685          
##  Max.   : 0.4768           Max.   : 0.3498          
##  mean_fBodyAccJerk-std()-Z mean_fBodyAccMag-mean() mean_fBodyAccMag-std()
##  Min.   :-0.993108         Min.   :-0.9868         Min.   :-0.9876       
##  1st Qu.:-0.983747         1st Qu.:-0.9560         1st Qu.:-0.9452       
##  Median :-0.895121         Median :-0.6703         Median :-0.6513       
##  Mean   :-0.756489         Mean   :-0.5365         Mean   :-0.6210       
##  3rd Qu.:-0.543787         3rd Qu.:-0.1622         3rd Qu.:-0.3654       
##  Max.   :-0.006236         Max.   : 0.5866         Max.   : 0.1787       
##  mean_fBodyBodyAccJerkMag-mean() mean_fBodyBodyAccJerkMag-std()
##  Min.   :-0.9940                 Min.   :-0.9944               
##  1st Qu.:-0.9770                 1st Qu.:-0.9752               
##  Median :-0.7940                 Median :-0.8126               
##  Mean   :-0.5756                 Mean   :-0.5992               
##  3rd Qu.:-0.1872                 3rd Qu.:-0.2668               
##  Max.   : 0.5384                 Max.   : 0.3163               
##  mean_fBodyBodyGyroJerkMag-mean() mean_fBodyBodyGyroJerkMag-std()
##  Min.   :-0.9976                  Min.   :-0.9976                
##  1st Qu.:-0.9813                  1st Qu.:-0.9802                
##  Median :-0.8779                  Median :-0.8941                
##  Mean   :-0.7564                  Mean   :-0.7715                
##  3rd Qu.:-0.5831                  3rd Qu.:-0.6081                
##  Max.   : 0.1466                  Max.   : 0.2878                
##  mean_fBodyBodyGyroMag-mean() mean_fBodyBodyGyroMag-std()
##  Min.   :-0.9865              Min.   :-0.9815            
##  1st Qu.:-0.9616              1st Qu.:-0.9488            
##  Median :-0.7657              Median :-0.7727            
##  Mean   :-0.6671              Mean   :-0.6723            
##  3rd Qu.:-0.4087              3rd Qu.:-0.4277            
##  Max.   : 0.2040              Max.   : 0.2367            
##  mean_fBodyGyro-mean()-X mean_fBodyGyro-mean()-Y mean_fBodyGyro-mean()-Z
##  Min.   :-0.9931         Min.   :-0.9940         Min.   :-0.9860        
##  1st Qu.:-0.9697         1st Qu.:-0.9700         1st Qu.:-0.9624        
##  Median :-0.7300         Median :-0.8141         Median :-0.7909        
##  Mean   :-0.6367         Mean   :-0.6767         Mean   :-0.6044        
##  3rd Qu.:-0.3387         3rd Qu.:-0.4458         3rd Qu.:-0.2635        
##  Max.   : 0.4750         Max.   : 0.3288         Max.   : 0.4924        
##  mean_fBodyGyro-std()-X mean_fBodyGyro-std()-Y mean_fBodyGyro-std()-Z
##  Min.   :-0.9947        Min.   :-0.9944        Min.   :-0.9867       
##  1st Qu.:-0.9750        1st Qu.:-0.9602        1st Qu.:-0.9643       
##  Median :-0.8086        Median :-0.7964        Median :-0.8224       
##  Mean   :-0.7110        Mean   :-0.6454        Mean   :-0.6577       
##  3rd Qu.:-0.4813        3rd Qu.:-0.4154        3rd Qu.:-0.3916       
##  Max.   : 0.1966        Max.   : 0.6462        Max.   : 0.5225       
##  mean_tBodyAcc-mean()-X mean_tBodyAcc-mean()-Y mean_tBodyAcc-mean()-Z
##  Min.   :0.2216         Min.   :-0.040514      Min.   :-0.15251      
##  1st Qu.:0.2712         1st Qu.:-0.020022      1st Qu.:-0.11207      
##  Median :0.2770         Median :-0.017262      Median :-0.10819      
##  Mean   :0.2743         Mean   :-0.017876      Mean   :-0.10916      
##  3rd Qu.:0.2800         3rd Qu.:-0.014936      3rd Qu.:-0.10443      
##  Max.   :0.3015         Max.   :-0.001308      Max.   :-0.07538      
##  mean_tBodyAcc-std()-X mean_tBodyAcc-std()-Y mean_tBodyAcc-std()-Z
##  Min.   :-0.9961       Min.   :-0.99024      Min.   :-0.9877      
##  1st Qu.:-0.9799       1st Qu.:-0.94205      1st Qu.:-0.9498      
##  Median :-0.7526       Median :-0.50897      Median :-0.6518      
##  Mean   :-0.5577       Mean   :-0.46046      Mean   :-0.5756      
##  3rd Qu.:-0.1984       3rd Qu.:-0.03077      3rd Qu.:-0.2306      
##  Max.   : 0.6269       Max.   : 0.61694      Max.   : 0.6090      
##  mean_tBodyAccJerk-mean()-X mean_tBodyAccJerk-mean()-Y
##  Min.   :0.04269            Min.   :-0.0386872        
##  1st Qu.:0.07396            1st Qu.: 0.0004664        
##  Median :0.07640            Median : 0.0094698        
##  Mean   :0.07947            Mean   : 0.0075652        
##  3rd Qu.:0.08330            3rd Qu.: 0.0134008        
##  Max.   :0.13019            Max.   : 0.0568186        
##  mean_tBodyAccJerk-mean()-Z mean_tBodyAccJerk-std()-X
##  Min.   :-0.067458          Min.   :-0.9946          
##  1st Qu.:-0.010601          1st Qu.:-0.9832          
##  Median :-0.003861          Median :-0.8104          
##  Mean   :-0.004953          Mean   :-0.5949          
##  3rd Qu.: 0.001958          3rd Qu.:-0.2233          
##  Max.   : 0.038053          Max.   : 0.5443          
##  mean_tBodyAccJerk-std()-Y mean_tBodyAccJerk-std()-Z
##  Min.   :-0.9895           Min.   :-0.99329         
##  1st Qu.:-0.9724           1st Qu.:-0.98266         
##  Median :-0.7756           Median :-0.88366         
##  Mean   :-0.5654           Mean   :-0.73596         
##  3rd Qu.:-0.1483           3rd Qu.:-0.51212         
##  Max.   : 0.3553           Max.   : 0.03102         
##  mean_tBodyAccJerkMag-mean() mean_tBodyAccJerkMag-std()
##  Min.   :-0.9928             Min.   :-0.9946           
##  1st Qu.:-0.9807             1st Qu.:-0.9765           
##  Median :-0.8168             Median :-0.8014           
##  Mean   :-0.6079             Mean   :-0.5842           
##  3rd Qu.:-0.2456             3rd Qu.:-0.2173           
##  Max.   : 0.4345             Max.   : 0.4506           
##  mean_tBodyAccMag-mean() mean_tBodyAccMag-std() mean_tBodyGyro-mean()-X
##  Min.   :-0.9865         Min.   :-0.9865        Min.   :-0.20578       
##  1st Qu.:-0.9573         1st Qu.:-0.9430        1st Qu.:-0.04712       
##  Median :-0.4829         Median :-0.6074        Median :-0.02871       
##  Mean   :-0.4973         Mean   :-0.5439        Mean   :-0.03244       
##  3rd Qu.:-0.0919         3rd Qu.:-0.2090        3rd Qu.:-0.01676       
##  Max.   : 0.6446         Max.   : 0.4284        Max.   : 0.19270       
##  mean_tBodyGyro-mean()-Y mean_tBodyGyro-mean()-Z mean_tBodyGyro-std()-X
##  Min.   :-0.20421        Min.   :-0.07245        Min.   :-0.9943       
##  1st Qu.:-0.08955        1st Qu.: 0.07475        1st Qu.:-0.9735       
##  Median :-0.07318        Median : 0.08512        Median :-0.7890       
##  Mean   :-0.07426        Mean   : 0.08744        Mean   :-0.6916       
##  3rd Qu.:-0.06113        3rd Qu.: 0.10177        3rd Qu.:-0.4414       
##  Max.   : 0.02747        Max.   : 0.17910        Max.   : 0.2677       
##  mean_tBodyGyro-std()-Y mean_tBodyGyro-std()-Z mean_tBodyGyroJerk-mean()-X
##  Min.   :-0.9942        Min.   :-0.9855        Min.   :-0.15721           
##  1st Qu.:-0.9629        1st Qu.:-0.9609        1st Qu.:-0.10322           
##  Median :-0.8017        Median :-0.8010        Median :-0.09868           
##  Mean   :-0.6533        Mean   :-0.6164        Mean   :-0.09606           
##  3rd Qu.:-0.4196        3rd Qu.:-0.3106        3rd Qu.:-0.09110           
##  Max.   : 0.4765        Max.   : 0.5649        Max.   :-0.02209           
##  mean_tBodyGyroJerk-mean()-Y mean_tBodyGyroJerk-mean()-Z
##  Min.   :-0.07681            Min.   :-0.092500          
##  1st Qu.:-0.04552            1st Qu.:-0.061725          
##  Median :-0.04112            Median :-0.053430          
##  Mean   :-0.04269            Mean   :-0.054802          
##  3rd Qu.:-0.03842            3rd Qu.:-0.048985          
##  Max.   :-0.01320            Max.   :-0.006941          
##  mean_tBodyGyroJerk-std()-X mean_tBodyGyroJerk-std()-Y
##  Min.   :-0.9965            Min.   :-0.9971           
##  1st Qu.:-0.9800            1st Qu.:-0.9832           
##  Median :-0.8396            Median :-0.8942           
##  Mean   :-0.7036            Mean   :-0.7636           
##  3rd Qu.:-0.4629            3rd Qu.:-0.5861           
##  Max.   : 0.1791            Max.   : 0.2959           
##  mean_tBodyGyroJerk-std()-Z mean_tBodyGyroJerkMag-mean()
##  Min.   :-0.9954            Min.   :-0.99732            
##  1st Qu.:-0.9848            1st Qu.:-0.98515            
##  Median :-0.8610            Median :-0.86479            
##  Mean   :-0.7096            Mean   :-0.73637            
##  3rd Qu.:-0.4741            3rd Qu.:-0.51186            
##  Max.   : 0.1932            Max.   : 0.08758            
##  mean_tBodyGyroJerkMag-std() mean_tBodyGyroMag-mean()
##  Min.   :-0.9977             Min.   :-0.9807         
##  1st Qu.:-0.9805             1st Qu.:-0.9461         
##  Median :-0.8809             Median :-0.6551         
##  Mean   :-0.7550             Mean   :-0.5652         
##  3rd Qu.:-0.5767             3rd Qu.:-0.2159         
##  Max.   : 0.2502             Max.   : 0.4180         
##  mean_tBodyGyroMag-std() mean_tGravityAcc-mean()-X
##  Min.   :-0.9814         Min.   :-0.6800          
##  1st Qu.:-0.9476         1st Qu.: 0.8376          
##  Median :-0.7420         Median : 0.9208          
##  Mean   :-0.6304         Mean   : 0.6975          
##  3rd Qu.:-0.3602         3rd Qu.: 0.9425          
##  Max.   : 0.3000         Max.   : 0.9745          
##  mean_tGravityAcc-mean()-Y mean_tGravityAcc-mean()-Z
##  Min.   :-0.47989          Min.   :-0.49509         
##  1st Qu.:-0.23319          1st Qu.:-0.11726         
##  Median :-0.12782          Median : 0.02384         
##  Mean   :-0.01621          Mean   : 0.07413         
##  3rd Qu.: 0.08773          3rd Qu.: 0.14946         
##  Max.   : 0.95659          Max.   : 0.95787         
##  mean_tGravityAcc-std()-X mean_tGravityAcc-std()-Y
##  Min.   :-0.9968          Min.   :-0.9942         
##  1st Qu.:-0.9825          1st Qu.:-0.9711         
##  Median :-0.9695          Median :-0.9590         
##  Mean   :-0.9638          Mean   :-0.9524         
##  3rd Qu.:-0.9509          3rd Qu.:-0.9370         
##  Max.   :-0.8296          Max.   :-0.6436         
##  mean_tGravityAcc-std()-Z mean_tGravityAccMag-mean()
##  Min.   :-0.9910          Min.   :-0.9865           
##  1st Qu.:-0.9605          1st Qu.:-0.9573           
##  Median :-0.9450          Median :-0.4829           
##  Mean   :-0.9364          Mean   :-0.4973           
##  3rd Qu.:-0.9180          3rd Qu.:-0.0919           
##  Max.   :-0.6102          Max.   : 0.6446           
##  mean_tGravityAccMag-std()
##  Min.   :-0.9865          
##  1st Qu.:-0.9430          
##  Median :-0.6074          
##  Mean   :-0.5439          
##  3rd Qu.:-0.2090          
##  Max.   : 0.4284
```
