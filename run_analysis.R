# 1. Merge the training and the test sets to create one data set
## Set working directory
setwd("~/Coursera/Getting and Cleaning Data/Project")

## Open needed libraries
library(dplyr)
library(car)

## Download and upzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "Dataset.zip")
unzip("Dataset.zip")

## Read in test data tables
setwd("~/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

## Read in train data tables
setwd("~/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

## Use cbind to combine test and train data into 2 data frames
test <- cbind(subject_test, y_test, x_test)
train <- cbind(subject_train, y_train, x_train)

## use rbind to combine test and train into single data frames
fullData <- rbind(test, train)


# 2. Extract only the measurements on the mean and standard deviation for each 
# measurement
## Read in features to use as column names
setwd("~/Coursera/Getting and Cleaning Data/Project/UCI HAR Dataset")
features <- read.table("features.txt")

## Find the indices of standard deviation variables
colIndex <- sort(union(grep("-mean", features$V2, fixed = TRUE), 
                       grep("-std", features$V2, fixed = TRUE)))


## First two columns of fullData are subject ID and activity, add these to the front
## of colIndex and add two to all mean and standard deviation indices
colIndex_2 <- c(1, 2, colIndex + 2)

## Create subset of data using colIndex
data <- fullData[, colIndex_2]

# 3. Use descriptive activity names to name the activities in the data set
## Create variables with descriptions of activity
data$V1.1 <-recode(data$V1.1, "1='WALKING'; 2='WALKING_UPSTAIRS'; 3='WALKING_DOWNSTAIRS'; 4='SITTING'; 5='STANDING'; 6='LAYING'")


# 4. Appropriately label the data set with descriptive variable names
## Change second column of features from factor to character
features$V2 <- as.character(features$V2)

## Remove dashes and replace with underscores in new variable varNames
varNames <- gsub("-", "_", features$V2)

## Remove parenthesis from variable names
varNames <- gsub("[(-)]", "", varNames)

## Reduce varNames to only variables left in data
varNames_reduced <- varNames[colIndex]

## Replace variable names in data with descriptive names
names(data) <- c("subjectID", "activity", varNames_reduced)

# 5. From the data set in step 4, create a second, independent tidy data set with the 
# average of each variable for each activity and each subject
