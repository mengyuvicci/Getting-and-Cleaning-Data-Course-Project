## 1. Merges the training and the test sets to create one data set
activityTestData <- read.table('./UCI HAR Dataset/test/y_test.txt', header = F)
activityTrainData <- read.table('./UCI HAR Dataset/train/y_train.txt', header = F)

subjectTestData <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = F)
subjectTrainData <- read.table('./UCI HAR Dataset/train/subject_train.txt', header = F)

featuresTestData <- read.table('./UCI HAR Dataset/test/X_test.txt', header = F)
featuresTrainData <- read.table('./UCI HAR Dataset/train/X_train.txt', header = F)

activityData <- rbind(activityTestData, activityTrainData)
subjectData <- rbind(subjectTestData, subjectTrainData)
featuresData <- rbind(featuresTestData, featuresTrainData)

names(activityData) <- c("activity")
names(subjectData) <- c("subject")
featureNames <- read.table('./UCI HAR Dataset/features.txt', header = F)
names(featuresData) <- featureNames$V2

oneDataSet <- cbind(featuresData, activityData, subjectData) 

## 2. Extracts only the measurements on the mean and standard
## deviation for each measurement

## sustract feature names with pattern mean() or std()
MeanStdNames <- featureNames$V2[grep("mean\\(\\)|std\\(\\)", featureNames$V2)]
selectedEleNames <- c(as.character(MeanStdNames), "activity", "subject")

## extract mean & std data
MeanStdData <- subset(oneDataSet, select = selectedEleNames)

## 3. Uses descriptive activity names to name the activities in the data set
activityNames <- read.table('./UCI HAR Dataset/activity_labels.txt', header = F)

iterations <- nrow(oneDataSet)
for (i in 1:iterations){
    index <- as.integer(oneDataSet$activity[i])
    oneDataSet$activity[i] <- as.character(activityNames$V2[index])
}

## 4. Appropriately labels the data set with descriptive variable names

names(oneDataSet)<-gsub("^t", "time", names(oneDataSet))
names(oneDataSet)<-gsub("^f", "frequency", names(oneDataSet))
names(oneDataSet)<-gsub("BodyBody", "Body", names(oneDataSet))
names(oneDataSet)<-gsub("Acc", "Accelerometer", names(oneDataSet))
names(oneDataSet)<-gsub("-std$", "Standard Deviation", names(oneDataSet))
names(oneDataSet)<-gsub("Mag", "Magnitude", names(oneDataSet))
names(oneDataSet)<-gsub("Gyro", "Gyroscope", names(oneDataSet))


## 5. creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.

library(plyr)

removeAS <- oneDataSet[, names(oneDataSet) != c("activity, subject")]
tidyDataSet <- aggregate(removeAS, by = list(activity = oneDataSet$activity,
                                               subject = oneDataSet$subject), FUN = mean)
write.table(tidyDataSet, file = "tidyDataSet.txt",row.name = FALSE)
