# Creates a tidy dataset from data from "Human Activity Recognition Using Smartphones"
# with mean sensor values per participant subject in each of 6 activities.
# These activities and sensors are described here:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Citation:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


# Note:
# This assumes that "getdata-projectfiles-UCI HAR Dataset.zip"
# is extracted to the current working directory - so its README.txt
# is in the working directory.

# setwd("C:/code/jeremy.sellars/coursera/getdata/project")
# .libPaths("c:/temp/rpackages")
# install.packages("data.table")
library("data.table")

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

write.table(combined_datasets.mean, "means.txt", row.names=FALSE, sep="\t")

# Return the results in case the return value is evaluated.
combined_datasets.mean

##### The file may be read with this code:
# input_file <- read.table("means.txt", header=TRUE)

##### Note: This file is in wide-form (see project rubric).
# * There is a column for every feature (measurement)
# * There is a row for each subject-activity pair
