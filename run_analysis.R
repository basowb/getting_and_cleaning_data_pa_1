## Benjamin Basow
## Getting and Cleaning Data Assignment #1

## Setting the working directory

setwd("C:/Users/user/Desktop/data_science/clean_data_assignment_1/UCI HAR Dataset")

## Loading relevant packages

library(plyr)
library(data.table)
library(RCurl)
library(stringr)

## Prompt 1: Merges the training and the test sets to create one data set.

## Loading the Data Sets from Working Directory

## Loading the training data

subtrain = read.table('./train/subject_train.txt',header=FALSE)

xtrain = read.table('./train/x_train.txt',header=FALSE)

ytrain = read.table('./train/y_train.txt',header=FALSE)

# Loading the testing data

subtest = read.table('./test/subject_test.txt',header=FALSE)

xtest = read.table('./test/x_test.txt',header=FALSE)

ytest = read.table('./test/y_test.txt',header=FALSE)

# Merging the training and testing data sets

xdata <- rbind(xtrain, xtest)

ydata <- rbind(ytrain, ytest)

subdata <- rbind(subtrain, subtest)

# Checking the newly created data sets 

str(xdata[1:5])

str(ydata)

str(subdat)

# Check original data sets to make sure the merged data set combined all observations

str(subtrain)

str(xtrain)

str(ytrain)

str(subtest)

str(xtest)

str(ytest)

## Prompt 2: Extracts only the measurements on the mean and standard deviation for each measurement.

## Trying to figure out what the features data set looks like

features <- read.table('./features.txt')

str(features)

features

## Extracting the mean and standard deviation for the second variable V2

xdata_mean_std <- xdata[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]

## Naming the variables in created data set

names(xdata_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 

## Testing the data set

View(xdata_mean_std)

## Prompt 3: Use descriptive activity names to name the activities in the data set.

## loading the activity lables

ydata[, 1] <- read.table("activity_labels.txt")[ydata[, 1], 2]

## Naming the activity column in the data set

names(ydata) <- "Activity"

## Checking the data set

View(ydata)

## Prompt 4: Appropriately labels the data set with descriptive variable names.

## Naming the subject data set

names(subdata) <- "Subject"

View(subdata)

## Combining all data sets into one data set

finaldata <- cbind(xdata_mean_std, ydata, subdata)

View(finaldata)

## Naming all the variables in the final data set

names(finaldata) <- make.names(names(finaldata))

names(finaldata) <- gsub('\\.mean',"Mean",names(finaldata))

names(finaldata) <- gsub('\\.std',"StandardDeviation",names(finaldata))

names(finaldata) <- gsub('^t',"TimeDomain",names(finaldata))

names(finaldata) <- gsub('^f',"FrequencyDomain",names(finaldata))

names(finaldata) <- gsub('Acc',"Acceleration",names(finaldata))

names(finaldata) <- gsub('GyroJerk',"AngularAcceleration",names(finaldata))

names(finaldata) <- gsub('Gyro',"AngularSpeed",names(finaldata))

names(finaldata) <- gsub('Mag',"Magnitude",names(finaldata))

names(finaldata) <- gsub('Acc',"Acceleration",names(finaldata))

names(finaldata) <- gsub('Freq\\.',"Frequency",names(finaldata))

names(finaldata) <- gsub('Freq$',"Frequency",names(finaldata))

## Testing final data set

View(finaldata)


## Prompt 5: From the data set in step 4, create a second,independent 
##           tidy data set with the average of each variable for each activity and each subject.

## Creating the data set with the average of each variable

finaldata2<-aggregate(. ~Subject + Activity, finaldata, mean)

finaldata2<-finaldata2[order(finaldata2$Subject,finaldata2$Activity),]

## Creating the physical text file

write.table(finaldata2, file = "tidydata.txt",row.name=FALSE)

## Testing the tidy data set

tidydata = read.table('tidydata.txt',header=FALSE)

View(tidydata)


activitylabels = read.table('activity_labels.txt',header=FALSE)

View(activitylabels)

