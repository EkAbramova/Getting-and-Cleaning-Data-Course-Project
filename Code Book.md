## Code Book for Course Project

### Overview

[Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of the original data:

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[Full Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) at the site where the data was obtained:

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Process

The script `run_analysis.R` performs the following process to clean up the data and create tiny data sets:

1. Merge the training and test sets to create one data set.

2. Reads `features.txt` and uses only the measurements on the mean and standard deviation for each measurement. 

3. Reads `activity_labels.txt` and applies human readable activity names to name the activities in the data set.

4. Labels the data set with descriptive names. (Names are converted to lower case; underscores and brackets are removed.)

5. Merges the features with activity labels and subject IDs.

6. The average of each measurement for each activity and each subject is merged to a second data set. The result is saved as `tidydata.txt`.
	
### Variables

- testSet - table contents of `test/X_test.txt`
- trainSet - table contents of `train/X_train.txt`
- testlab - table contents of `test/y_test.txt`
- trainlab - table contents of `train/y_train.txt`
- testSubject - table contents of `test/subject_test.txt`
- trainSubject - table contents of `test/subject_train.txt`
- features - Names of for data columns derived from featuresList
- activityLab - table contents of `activity_labels.txt`
- test - combined data set of the testlab, the testSubject, the testSet
- train - combined data set of the trainlab, the trainSubject, the trainSet
- fullSet - Combined data set of the two above sets
- col2keep - vector of which features to use in tidy data set
- MeanStdSet - subsetted, human-readable data
- ActivityNameSet - MeanStdSet with named activites
- tidyDataSet - econd tiny data set with average of each variable for each activity and subject
