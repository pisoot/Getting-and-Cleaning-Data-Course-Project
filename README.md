h# Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## The R script called "run_analysis.R" will do the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## The steps that must be performed before running the R script:
1. Download the data source and put into a folder on your local drive. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip the file to your working directory. 
3. You'll have a "UCI HAR Dataset" folder in your working directory.
4. Put "run_analysis.R" in your working directory.
5. Install package "reshape2" which will be used in the R script.
6. Run source("run_analysis.R"), then it will generate a output file "tiny.txt" in your working directory.
