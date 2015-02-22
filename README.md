# UCI-HAR-tidy
Script to create tidy data set from UCI-HAR data

# Creating a tidy data set from the Human Activity Recognition Using Smartphones Dataset

Human Activity Recognition Dataset files are available in the following archive [link] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The script "run_analysis.R" downloads, extracts and consolidates data from the input dataset into a tidy dataset called "UCI_HAR_tidydataset.txt".

## Files Used from the input archive
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Associates activity id with activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Activity ids for every observation in Training set.
* 'train/subject_train.txt': Subject ids for every observation in Training set
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Activity ids for every observation in Test set.
* 'test/subject_test.txt': Subject ids for every observation in Test set

## Information about the data
* Training set has 7352 observations
* Test set has has 2947 observations
* There are 561 features
** 53 features represent mean values
** 33 features represent standard deviation values
* There are 6 activities with ids 1:6 - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

## The script "run_analysis.R"
1. Download th archive and extract the contents.
2. Create a consolidated training data set combining subject id, activity id and features from the train folder
3. Create a consolidated training data set combining subject id, activity id and features from the test folder
4. Create a consolidated data set combining training and test datasets
5. Select only the features that represent mean and standard deviation values - the feature names contain "mean" and "std" respectively
6. Group the features by activity and subject.id
7. Summarize by calculating the average of every feature for each group (activity-subject.id combination)

## Points to note
* Feature names have special characters that are not accepted by R. This results in duplicate column names. The names have to be sanitized and made unique for us to process the data. 
