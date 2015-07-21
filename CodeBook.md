# CodeBook

A tidy dataset from data from "Human Activity Recognition Using Smartphones"
with mean sensor values per participant subject in each of 6 activities.

The document describes the mapping between this tidy dataset and the source data from which it was generated.

These activities and sensors are described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



## Identification

The resultant dataset has a row for each subject-activity pair.  The subject is an [individual test participant](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), and an activity is one of (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`).

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

From the [dataset summary](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Sample
Sometimes a picture is worth a 1000 words.  Here are a few rows and columns.


|  subject|activity  |  mean_fBodyAcc-mean()-X|  mean_fBodyAcc-mean()-Y|
|--------:|:---------|-----------------------:|-----------------------:|
|        1|LAYING    |              -0.9390991|              -0.8670652|
|        3|SITTING   |              -0.9701544|              -0.8919078|
|        6|STANDING  |              -0.9771003|              -0.9303365|
|        9|WALKING   |              -0.2947112|              -0.2576776|


## Features (Measurements)

There is a column for every feature (measurement) - The mean of each feature, grouped by subject (person), and activity.

The original features are described [here](README.txt) (copied from the study [source files](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/) for your convenience).

The tidy feature is the "mean" of the original feature partitioned by participant and activity.

### tl;dr
In the tidy dataset, the feature name is the original name prefixed with "mean_" to remind you it has been averaged.

### Features


|Original Feature             |Tidy Feature                      |
|:----------------------------|:---------------------------------|
|fBodyAcc-mean()-X            |mean_fBodyAcc-mean()-X            |
|fBodyAcc-mean()-Y            |mean_fBodyAcc-mean()-Y            |
|fBodyAcc-mean()-Z            |mean_fBodyAcc-mean()-Z            |
|fBodyAcc-std()-X             |mean_fBodyAcc-std()-X             |
|fBodyAcc-std()-Y             |mean_fBodyAcc-std()-Y             |
|fBodyAcc-std()-Z             |mean_fBodyAcc-std()-Z             |
|fBodyAccJerk-mean()-X        |mean_fBodyAccJerk-mean()-X        |
|fBodyAccJerk-mean()-Y        |mean_fBodyAccJerk-mean()-Y        |
|fBodyAccJerk-mean()-Z        |mean_fBodyAccJerk-mean()-Z        |
|fBodyAccJerk-std()-X         |mean_fBodyAccJerk-std()-X         |
|fBodyAccJerk-std()-Y         |mean_fBodyAccJerk-std()-Y         |
|fBodyAccJerk-std()-Z         |mean_fBodyAccJerk-std()-Z         |
|fBodyAccMag-mean()           |mean_fBodyAccMag-mean()           |
|fBodyAccMag-std()            |mean_fBodyAccMag-std()            |
|fBodyBodyAccJerkMag-mean()   |mean_fBodyBodyAccJerkMag-mean()   |
|fBodyBodyAccJerkMag-std()    |mean_fBodyBodyAccJerkMag-std()    |
|fBodyBodyGyroJerkMag-mean()  |mean_fBodyBodyGyroJerkMag-mean()  |
|fBodyBodyGyroJerkMag-std()   |mean_fBodyBodyGyroJerkMag-std()   |
|fBodyBodyGyroMag-mean()      |mean_fBodyBodyGyroMag-mean()      |
|fBodyBodyGyroMag-std()       |mean_fBodyBodyGyroMag-std()       |
|fBodyGyro-mean()-X           |mean_fBodyGyro-mean()-X           |
|fBodyGyro-mean()-Y           |mean_fBodyGyro-mean()-Y           |
|fBodyGyro-mean()-Z           |mean_fBodyGyro-mean()-Z           |
|fBodyGyro-std()-X            |mean_fBodyGyro-std()-X            |
|fBodyGyro-std()-Y            |mean_fBodyGyro-std()-Y            |
|fBodyGyro-std()-Z            |mean_fBodyGyro-std()-Z            |
|tBodyAcc-mean()-X            |mean_tBodyAcc-mean()-X            |
|tBodyAcc-mean()-Y            |mean_tBodyAcc-mean()-Y            |
|tBodyAcc-mean()-Z            |mean_tBodyAcc-mean()-Z            |
|tBodyAcc-std()-X             |mean_tBodyAcc-std()-X             |
|tBodyAcc-std()-Y             |mean_tBodyAcc-std()-Y             |
|tBodyAcc-std()-Z             |mean_tBodyAcc-std()-Z             |
|tBodyAccJerk-mean()-X        |mean_tBodyAccJerk-mean()-X        |
|tBodyAccJerk-mean()-Y        |mean_tBodyAccJerk-mean()-Y        |
|tBodyAccJerk-mean()-Z        |mean_tBodyAccJerk-mean()-Z        |
|tBodyAccJerk-std()-X         |mean_tBodyAccJerk-std()-X         |
|tBodyAccJerk-std()-Y         |mean_tBodyAccJerk-std()-Y         |
|tBodyAccJerk-std()-Z         |mean_tBodyAccJerk-std()-Z         |
|tBodyAccJerkMag-mean()       |mean_tBodyAccJerkMag-mean()       |
|tBodyAccJerkMag-std()        |mean_tBodyAccJerkMag-std()        |
|tBodyAccMag-mean()           |mean_tBodyAccMag-mean()           |
|tBodyAccMag-std()            |mean_tBodyAccMag-std()            |
|tBodyGyro-mean()-X           |mean_tBodyGyro-mean()-X           |
|tBodyGyro-mean()-Y           |mean_tBodyGyro-mean()-Y           |
|tBodyGyro-mean()-Z           |mean_tBodyGyro-mean()-Z           |
|tBodyGyro-std()-X            |mean_tBodyGyro-std()-X            |
|tBodyGyro-std()-Y            |mean_tBodyGyro-std()-Y            |
|tBodyGyro-std()-Z            |mean_tBodyGyro-std()-Z            |
|tBodyGyroJerk-mean()-X       |mean_tBodyGyroJerk-mean()-X       |
|tBodyGyroJerk-mean()-Y       |mean_tBodyGyroJerk-mean()-Y       |
|tBodyGyroJerk-mean()-Z       |mean_tBodyGyroJerk-mean()-Z       |
|tBodyGyroJerk-std()-X        |mean_tBodyGyroJerk-std()-X        |
|tBodyGyroJerk-std()-Y        |mean_tBodyGyroJerk-std()-Y        |
|tBodyGyroJerk-std()-Z        |mean_tBodyGyroJerk-std()-Z        |
|tBodyGyroJerkMag-mean()      |mean_tBodyGyroJerkMag-mean()      |
|tBodyGyroJerkMag-std()       |mean_tBodyGyroJerkMag-std()       |
|tBodyGyroMag-mean()          |mean_tBodyGyroMag-mean()          |
|tBodyGyroMag-std()           |mean_tBodyGyroMag-std()           |
|tGravityAcc-mean()-X         |mean_tGravityAcc-mean()-X         |
|tGravityAcc-mean()-Y         |mean_tGravityAcc-mean()-Y         |
|tGravityAcc-mean()-Z         |mean_tGravityAcc-mean()-Z         |
|tGravityAcc-std()-X          |mean_tGravityAcc-std()-X          |
|tGravityAcc-std()-Y          |mean_tGravityAcc-std()-Y          |
|tGravityAcc-std()-Z          |mean_tGravityAcc-std()-Z          |
|tGravityAccMag-mean()        |mean_tGravityAccMag-mean()        |
|tGravityAccMag-std()         |mean_tGravityAccMag-std()         |

## Citation
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

