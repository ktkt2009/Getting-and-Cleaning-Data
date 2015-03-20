#** Code book** #


Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



The data in TidyData.txt can be read into R with the following code:
place TidyData.txt file in your working directory.
read.table("TidyData.txt", header=TRUE, colClasses=c('factor', 'factor', rep('numeric', 66)))

## Brief Introduction ##

Source of data is UCI HAR Dataset available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip which is included in this repo. 
 
TidyData.txt is the outcome of the project work by using UCI HAR Data set. It was extracted by only the measurements on the mean and standard deviation for each measure of the data set. This reduces the data to 68 columns (68 feature variable measurements, plus the Subject and Activity columns). The activity in data set are expressed as using descriptive activity name and appropriately labeled the data with descriptive variable names.  The size of the tidy data set was further reduced by averaging each variable for each activity and each subject. This resulted in 180 observations, with a unique combination of Subject and Activity values in each row. 

## Package require ##
Package( "data.table") is required to run the code of "run_analysis.R" .


## Variables ##
The variables in TidytData are a subset of the variables described in the features_info.txt file in the original data set. 

Subject - A factor that identifies the volunteer participants(2947 test and 7532 train)
Values: integer from 1 to 30 

Activity - six basic activities being analysed.
Values: Walking, WalkingUpStairs, WalkingDownStairs, Sitting, Standing, Lying.

## Variable Names ##
Variables in the TidyData includes:


tBodyAccMean-X- 
tBodyAccMean-Y
tBodyAccMean-Z
tBodyAccStdev-X
tBodyAccStdev-Y
tBodyAccStdev-Z
tGravityAccMean-X
tGravityAccMean-Y
tGravityAccMean-Z
tGravityAccStdev-X
tGravityAccStdev-Y
tGravityAccStdev-Z
tBodyAccJerkMean-X
tBodyAccJerkMean-Y
tBodyAccJerkMean-Z
tBodyAccJerkStdev-X
tBodyAccJerkStdev-Y
tBodyAccJerkStdev-Z
tBodyGyroMean-X
tBodyGyroMean-Y
tBodyGyroMean-Z
tBodyGyroStdev-X
tBodyGyroStdev-Y
tBodyGyroStdev-Z
tBodyGyroJerkMean-X
tBodyGyroJerkMean-Y
tBodyGyroJerkMean-Z
tBodyGyroJerkStdev-X
tBodyGyroJerkStdev-Y
tBodyGyroJerkStdev-Z
tBodyAccMagMean
tBodyAccMagStdev
tGravityAccMagMean
tGravityAccMagStdev
tBodyAccJerkMagMean
tBodyAccJerkMagStdev
tBodyGyroMagMean
tBodyGyroMagStdev
tBodyGyroJerkMagMean
tBodyGyroJerkMagStdev
fBodyAccMean-X
fBodyAccMean-Y
fBodyAccMean-Z
fBodyAccStdev-X
fBodyAccStdev-Y
fBodyAccStdev-Z
fBodyAccJerkMean-X
fBodyAccJerkMean-Y
fBodyAccJerkMean-Z
fBodyAccJerkStdev-X
fBodyAccJerkStdev-Y
fBodyAccJerkStdev-Z
fBodyGyroMean-X
fBodyGyroMean-Y
fBodyGyroMean-Z
fBodyGyroStdev-X
fBodyGyroStdev-Y
fBodyGyroStdev-Z
fBodyAccMagMean
fBodyAccMagStdev
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagStdev
fBodyBodyGyroMagMean
fBodyBodyGyroMagStdev
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagStdev

## Note: Variable Name Reference ##
t... time
Acc... accelerometer
Gyro..gyroscope measure orientations
X,Y,Z.. direction of orientation
Jerk... body linear acceleration and angular velocity 
Mag... magnitude
f... Fast Fourier Transform (FFT)
Mean...average value
Stdev..Standard deviation


The feature of human activity dataset gathered from the accelerometer and gyroscope 3-axial raw signals time accelerometer-XYZ and time gyroscope-XYZ.
Body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time Body acceloremeter jerk signal-XYZ and time Body gyroscope jerk signal-XYZ).Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain signal Body.

Data reliability was measured by mean and standard deviation.



## Program work flow ##

- CodeRunner functions created for the task to be done
- check the source of data "UCI HAR Dataset folder" in the working directory
- read activity.txt and features.txt files
- loadData function built within the CodeRunner fun.
- set required measurement index as Descrips.
- use load function to assign testData and trainData
- Naming activities in the data set 
- Labeled appropriately in data
- merge testData and trainData with rbind and cbind function
- Clean data by summarized with mean of each activity and subject
- 10299 observations of 68 variables are cleaned as summaryData by ACTIVITY and SUBJECT. 


