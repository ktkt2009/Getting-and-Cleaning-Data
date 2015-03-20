# Getting-and-Cleaning-Data: README#
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set by a learner.
The goal is to prepare tidy data that can be used for later analysis.
This project work will be reviewed by peer assessment.

This repo includes

1) a tidy data set
2) the script run_analysis.R
3) a code book that describes the variables, the data, and any transformation work called CodeBook.md
4)README.md

To complete the requirement of the project, the script run the following steps:


1. It is assumed that downloaded raw data set "UCI HAR Dataset" exist in the current working directory.
To check the Dataset file in current wworking directory run the following code.

	if (!file.exists("UCI HAR Dataset")) {
	    stop("UCI HAR Dataset folder must be in the current folder")
	  }


2. Read activity_lables.txt file and set names of the variables
	labels <- fread("activity_labels.txt", header = FALSE)
    	setnames(labels, c("LABEL_LEVEL", "Behaviour"))

3. Read the features.txt and set varaiable name

	features <- fread("features.txt", header = FALSE)
  	setnames(features,  c("FEATURE_No", "FEATURE_Fun"))

4. Finding the required index of mean and standard deviation fun in features 

	Descrips <- features[grep("-mean\\(\\)|-std\\(\\)", features[, features$FEATURE_Fun], )

5. Appropriate lable to feature fun descriptions

	Descrips$FEATURE_Fun <- gsub("-mean\\(\\)", "Mean", Descrips$FEATURE_Fun)
	Descrips$FEATURE_Fun <- gsub("-std\\(\\)", "Stdev", Descrips$FEATURE_Fun)

6. LoadData function 

	 loadData <- function(type, Descrips) {
	  print(paste("Reading data from", type, "folder"))
	  if (!file.exists(type)) {
	    stop(paste("Couldn't find", type, "folder"))
	  }
	  setwd(type)
	  
	  # Path to the the data file
	  x <- paste0("X_",type,".txt")
	  # Path to the activity file
	  y <- paste0("y_",type,".txt")  
	  
	  # Path to the subject file
	  subjectFile  <- paste0("subject_", type ,".txt")
	  
	  if (!file.exists(y)) {
	    stop(paste("Couldn't find", subjectFile, "in raw data"))
	  }
	  if (!file.exists(x)) {
	    stop(paste("Couldn't find", x, "in raw data"))
	  }
	  if (!file.exists(y)) {
	    stop(paste("Couldn't find", y, "in raw data"))
	  }
	  
	  # Read the subject file
	  subjectData <- fread(subjectFile, header = FALSE)
	  setnames(subjectData, "SUBJECT")
	  dataSize <- nrow(subjectData)
	  
	  # Read the Activity file
	  yData <- fread(y, header = FALSE, nrows = dataSize)
	  setnames(yData, "ACTIVITY")
	  
	  # Read the data file
	   
	  xData <- read.table(x, header = FALSE, colClasses = rep("numeric", 561), 
	                      quote="", stringsAsFactors = FALSE, comment.char="", 
	                      nrows = dataSize)
	  
	  # Extracts only the measurements on the mean and standard deviation for each measurement. 
	  xData <- xData[, Descrips$FEATURE_No]
	  setnames(xData, Descrips$FEATURE_Fun)
	  
	  # Up one level
	  setwd("..")
	  
	  cbind(subjectData, yData, xData)
	  
	}


7. Assign testData and trainData from loadData fun

	testData <- loadData("test", Descrips)
	trainData <- loadData("train", Descrips)

8. Merge test and train data in one data set

	mergedData <<- rbind(testData, trainData)

	mergedData$ACTIVITY <<- factor(mergedData$ACTIVITY, 
	                                 levels = labels$LABEL_LEVEL, 
	                                 labels = labels$Behaviour)


9. Create TidyData by summarizing mean of each actvity and subject

	summaryData <<- aggregate(mergedData[, 3:ncol(mergedData), with = FALSE], by = 
	                              list(ACTIVITY = mergedData$ACTIVITY, 
	                                   SUBJECT = mergedData$SUBJECT), 
	                            FUN = mean)
10. Write TidyData.txt file

	write.table(summaryData, "tidyData/TidyData.txt", row.names = FALSE)

## Note ##
TidyData.txt include 180 observations of 68 variables. Brief explanation are included in CodeBook.md file of the project.
