## Download the data set
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCIDataset.zip")
unzip("UCIDataset.zip")

## Include packages that we need
library(dplyr)

## Get the feature data into a data frame
features = read.table("./features.txt")

## We need the feature names to use as column names later
feature.names = features[,2]

## The names have some special characters that R doesnt recognize.
## The names need to be sanitized so that we dont run into duplication issues later.
valid.feature.names = make.names(feature.names,unique=TRUE)

## Read the feature values for every observation in training data
x.train.df = read.table("./train/X_train.txt")
## Lets label the columns with names of features
colnames(x.train.df) <- valid.feature.names

## Read the activity ids for every observation in training data
y.train.df = read.table("./train/y_train.txt")
colnames(y.train.df) = "activity.id"

## Also, read the subject of every observation in training data
subject.train.df = read.table("./train/subject_train.txt")
colnames(subject.train.df) = "subject.id"

## Bind all the columns into a single training data frame
train.df = bind_cols(subject.train.df,y.train.df,x.train.df)


## Lets repeat the same for test data as well
## Read the features for every observation in test data
x.test.df = read.table("./test/X_test.txt")
## Lets label the columns with names of features
colnames(x.test.df) = valid.feature.names

## Read the activity ids for every observation in test data
y.test.df = read.table("./test/y_test.txt")
colnames(y.test.df) = "activity.id"

## Also, read the subject of every observation in test data
subject.test.df = read.table("./test/subject_test.txt")
colnames(subject.test.df) = "subject.id"

## Binding all the columns into a single test data frame
test.df = bind_cols(subject.test.df,y.test.df,x.test.df)

## We can now combine the training and test data sets
df = bind_rows(train.df,test.df)

## Would be nice have activity names rather than activity ids for better readability
## First get the activity names
activity.labels = read.table("activity_labels.txt")
colnames(activity.labels) = c("activity.id","activity.name")

# Convert activity.id into a factor variable
df$activity.id = factor(df$activity.id)
levels(df$activity.id) = activity.labels$activity.name

# We should rename the activity.id field
df = rename(df,activity = activity.id)

## Finally, selecting only the columns that represent mean and sd parameters and
## grouping by activity and subject id and 
## summarizing by the average of every selected feature (mean and sd features)
df.meansd.grouped = df %>%
  select(subject.id,activity,contains("mean"),contains("std")) %>%
  group_by(activity,subject.id) %>%
  summarise_each(funs(mean)) %>%
  print

write.table(df.meansd.grouped,"./UCI_HAR_tidydataset.txt",row.names=FALSE)
