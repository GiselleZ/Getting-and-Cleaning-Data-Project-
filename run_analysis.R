# Getting and Cleaning Data Project John Hopkins Coursera


# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# zip file already downloaded and unzipped in folder C:/UCI HAR Dataset
library(data.table)
library(dplyr)

#loads and merge data sets from test and train within working directory

testactivity  <- read.table("test/Y_test.txt" , header = FALSE)
trainactivity <- read.table("train/Y_train.txt", header = FALSE)
activity <- rbind(trainactivity, testactivity)

testsubject  <- read.table("test/subject_test.txt", header = FALSE)
trainsubject <- read.table("train/subject_train.txt", header = FALSE)
subject  <- rbind(trainsubject, testsubject)

testfeatures  <- read.table("test/X_test.txt", header = FALSE)
trainfeatures <- read.table("train/X_train.txt", header = FALSE)
features <- rbind(trainfeatures, testfeatures)

#completeData <- cbind(features,activity,subject)

# Format training and test data sets

#changes factor levels(1-6) to match activity labels
activityLabels <- read.table("activity_labels.txt", header = FALSE)
activity$V1 <- factor(activity$V1, levels = as.integer(activityLabels$V1), labels = activityLabels$V2)

# Read the the name of the features 
featureNames <- read.table("features.txt")
colnames(features) <- t(featureNames[2])

colnames(activity) <- "Activity"
colnames(subject)  <- "Subject"

features <- features[, grep(".*Mean.*|.*Std.*", names(features), ignore.case=TRUE)]

extractedData <- cbind(features,activity,subject)

#rename time, frequency and other variables
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

# tidy data set

suppressWarnings(tidydata <- aggregate(extractedData, by = list(extractedData$Subject, extractedData$Activity), FUN = mean))
write.table(tidydata, file = "Tidy.txt", row.names = FALSE)

