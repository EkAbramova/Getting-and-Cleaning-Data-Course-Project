## downloading data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip")

## Unzip data
unzip(zipfile="./data/Dataset.zip", exdir="./data")

## reading the training and the test sets
testSet <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
trainSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

## read lables
testlab <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
trainlab <- read.table("./data/UCI HAR Dataset/train/y_train.txt")

## read subjects
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## read features
features <- read.table('./data/UCI HAR Dataset/features.txt')

## Read  activity labels
activityLab = read.table('./data/UCI HAR Dataset/activity_labels.txt')


## Name all columns
names(testSet) <- features[, "V2"]
names(testlab) <-"activity"
names(testSubject) <- "subject"

names(trainSet) <- features[, "V2"]
names(trainlab) <-"activity"
names(trainSubject) <- "subject"

names(activityLab) <- c('activity','activityName')

## Merges the training and the test sets to create one data set.
## MERGE ALL
test <- cbind(testlab, testSubject, testSet)
train <- cbind(trainlab, trainSubject, trainSet)

fullSet <- rbind(test, train)


rm(testSet)
rm(trainSet)

rm(test)
rm(train)

## Extracts only the measurements on the mean and standard deviation for each measurement.
## Keep columns
col2keep <- grep(".*mean.*|.*std.*|activity|subject", names(fullSet))

MeanStdSet <- fullSet[,col2keep]


## Appropriately labels the data set with descriptive variable names.
## Names
names(MeanStdSet)<-gsub("BodyBody", "Body", names(MeanStdSet))
names(MeanStdSet)<-gsub("^t", "time", names(MeanStdSet))
names(MeanStdSet)<-gsub("^f", "frequency", names(MeanStdSet))
names(MeanStdSet)<-gsub("Mag", "Magnitude", names(MeanStdSet))
names(MeanStdSet)<-gsub("Acc", "Accelerometer", names(MeanStdSet))
names(MeanStdSet)<-gsub("Gyro", "Gyroscope", names(MeanStdSet))


## Uses descriptive activity names to name the activities in the data set
ActivityNameSet <- merge(MeanStdSet, activityLab, by.x ='activity')


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr);

tidyDataSet <- aggregate(. ~subject + activity+activityName, ActivityNameSet, mean)
tidyDataSet <- tidyDataSet[order(tidyDataSet$subject,tidyDataSet$activity),]

write.table(tidyDataSet, file = "tidydata.txt", row.name = FALSE)
