 setwd("C:/Users/User/Desktop/Rdirectory/Getting_Data")
library(data.table)

CodeRunner <- function() {
  if (!file.exists("UCI HAR Dataset")) {
    stop("UCI HAR Dataset folder must be in the current folder")
  }
  setwd("UCI HAR Dataset")
  
  print("Reading labels...")
  # Read activity labels
 
  labels <- fread("activity_labels.txt", header = FALSE)
  setnames(labels, c("LABEL_LEVEL", "Behaviour"))
  print(labels)
  
  print("Reading features...")
  # Read features
  if (!file.exists("features.txt")) {
    stop("Couldn't find features.txt")
  }
  features <- fread("features.txt", header = FALSE)
  setnames(features,  c("FEATURE_No", "FEATURE_Fun"))
  
  # Find required measurement indexes
  Descrips <- features[grep("-mean\\(\\)|-std\\(\\)", features[, features$FEATURE_Fun], )]
  Descrips$FEATURE_Fun <- gsub("-mean\\(\\)", "Mean", Descrips$FEATURE_Fun)
  Descrips$FEATURE_Fun <- gsub("-std\\(\\)", "Stdev", Descrips$FEATURE_Fun)
  
  testData <- loadData("test", Descrips)
  trainData <- loadData("train", Descrips)
  
  # Merges the training and the test sets to create one data set.
  mergedData <<- rbind(testData, trainData)
  
  #Uses descriptive activity names to name the activities in the data set
  mergedData$ACTIVITY <<- factor(mergedData$ACTIVITY, 
                                 levels = labels$LABEL_LEVEL, 
                                 labels = labels$Behaviour)
  
  # Creates summarized tidy data set with mean of each activity and subject
  
  summaryData <<- aggregate(mergedData[, 3:ncol(mergedData), with = FALSE], by = 
                              list(ACTIVITY = mergedData$ACTIVITY, 
                                   SUBJECT = mergedData$SUBJECT), 
                            FUN = mean)
  
  setwd("..")
  
  #tidyData folder creation
  
  
  dir.create("tidyData")
  
  #Write TidyData csv file in the folder created
  
  
  
  write.table(summaryData, "tidyData/TidyData.txt", row.names = FALSE)
 
  
}

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

## Auto-run  function
CodeRunner()
