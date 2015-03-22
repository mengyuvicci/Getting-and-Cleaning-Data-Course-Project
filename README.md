## Getting-and-Cleaning-Data-Course-Project

The run_analysis.R includes the functionalieis below:
* Read the data (txt files) into the memory as training & testing sets (including features, acitivities & subjects).
* Merges training and test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Read activity names in activity_lables.txt file & Name the activities in the data set (for loop to do so)
* Appropriately labels the data set with descriptive variable names. (such as t -> time, f -> frequency, BodyBody -> Body, Acc -> Accelerometer, -std -> Standard Deviation, Mag -> Magnitude, Gyro -> Gyroscope )
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject & use write.table() funciton to save the data set as tidyDataSet.txt file.
