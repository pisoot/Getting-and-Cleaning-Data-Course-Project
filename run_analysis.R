## STEP 0: Pre-check and load required packages
##----------------------------------------------

# Check if data (folder "UCI HAR Dataset") is in working directory

if (!file.exists("UCI HAR Dataset")) {
     stop("Folder 'UCI HAR Dataset' is not found!!")
}

# Load the "reshape2" package (for using in STEP 5)

library(reshape2)


## STEP 1: Merges the training and the test sets to create one data set
##---------------------------------------------------------------------

# 1.1 Read the training sets

message("Reading the training sets...")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# 1.2 Add column name to the training sets

features <- read.table("UCI HAR Dataset/features.txt")

names(subject_train) <- "subject"
names(y_train) <- "activity"
names(x_train) <- features[[2]]

# 1.3 Read the test sets

message("Reading the test sets...")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# 1.4 Add column name to the test sets

names(subject_test) <- "subject"
names(y_test) <- "activity"
names(x_test) <- features[[2]]

# 1.5 Merge all data to create one dataset

message("Merging into one dataset...")

train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
alldata <- rbind(train, test)


## STEP 2: Extracts only the measurements on the mean and 
##         standard deviation for each measurement.
##--------------------------------------------------------

# 2.1 Select columns that contain "mean()" or "std()"

selected <- grepl("(mean|std)\\(\\)",names(alldata))

# 2.2 Also keep the "subject" and "activity" columns

selected[1:2] <- TRUE

# 2.3 Extract selected columns

message("Extracting only the measurements on mean() and sd()...")
select_data <- alldata[,selected]


## STEP 3: Uses descriptive activity names to name the activities
##         in the data set.
##----------------------------------------------------------------

# 3.1 Read the activity labels

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("id","label")

# 3.2 Name the activities in the data set

select_data$activity <- factor(select_data$activity,labels = activity_labels$label)


## STEP 4: Appropriately labels the data set with descriptive
##         variable names. 
##------------------------------------------------------------

# 4.1 Remove "-" and "()" from variable names

names(select_data) <- gsub("-","",names(select_data))
names(select_data) <- gsub("mean\\(\\)","Mean",names(select_data))
names(select_data) <- gsub("std\\(\\)","Std",names(select_data))

# 4.2 Change "t" to "time", "f" to "frequency" and remove duplicate words

names(select_data) <- sub("^t","time",names(select_data))
names(select_data) <- sub("^f","frequency",names(select_data))
names(select_data) <- sub("BodyBody","Body",names(select_data))


## STEP 5: Creates a second, independent tidy data set with the
##         average of each variable for each activity and each subject.
##----------------------------------------------------------------------

# 5.1 Create the tidy data set

melted <- melt(select_data, id=c("subject","activity"))
tidy <- dcast(melted, subject + activity ~ variable, mean)

# 5.2 Write the tidy data set to output txt file

message("Writing the tidy data set to 'tidy.txt'...")
write.table(tidy, "tidy.txt", row.names=FALSE)