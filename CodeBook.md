---
title: "CodeBook.md"
output: pdf_document
---

## Code book for Getting and Cleaning Data Course Project

## Data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## R script:
1. Download the data
2. Read in data: 
    features.txt: variable names for X_train and X_test
    activity_labels.txt: variable names/labels for y_train and y_test
    in train folder (txt files): X_train, y_train, subject_train
    in test folder (txt files): X_test, y_test, subject_test
3. Merge all data in step 2 by common variables
4. Extracts only the variables with measurements on the mean and standard deviation for each measurement
5. Uses descriptive activity names to name the activities in the data set which is found in activity_labels data
6. Assign appropriately labels to the data set with descriptive variable names in order to clarify the abbribriate variable names
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
8. Generates tidydataset.txt as the output file


## Variables:  
features.txt: variable names for X_train and X_test

activity_labels.txt: variable names/labels for y_train and y_test

tidydataset.txt: kept the variable names without altering. includes only variables with mean and standard deviation for each measurement.         



