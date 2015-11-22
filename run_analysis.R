# Copied requiremetns for this script
#
# You should create one R script called run_analysis.R that does the following. 
# 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the average 
#   of each variable for each activity and each subject.


run_analysis <- function () {
    
    # see README.md file for more information on this function
    
    # R Working Directory must be the "UCI HAR Dataset" folder, with test and train 
    # data in sub folders within the working directory
    
    #Load the required packages
    require(dplyr)

    if (!(file.exists("test") & file.exists("train"))) stop ("Ensure working directory is correct")
    
    #Load feature labels 
    features <- read.table ("features.txt", col.names = c("FeatureId","FeatureName"))

    #Load acivity labels 
    activities <- read.table ("activity_labels.txt", col.names = c("ActivityId","ActivityName"))
    
    #Load all test source files into data frames
    subjectTest <- read.table ("./test/subject_test.txt", col.names = "SubjectId")
    xTest <-  read.table ("./test/x_test.txt", col.names = features$FeatureName)
    yTest <-  read.table ("./test/y_test.txt", col.names = "ActivityId")
    
    #Combine the test data (subject, y and x in that order) into one dataset
    allTest <- bind_cols(subjectTest,yTest,xTest)
    
    #Load all train source files into data frames
    subjectTrain <- read.table ("./train/subject_train.txt", col.names = "SubjectId")
    xTrain <-  read.table ("./train/x_train.txt", col.names = features$FeatureName)
    yTrain <-  read.table ("./train/y_train.txt", col.names = "ActivityId")

    #Combine the train data (subject, y and x in that order) into one dataset
    allTrain <- bind_cols(subjectTrain,yTrain,xTrain)
    
    #Combine the test and train datasets to form a complete dataset
    allData <- bind_rows(allTest,allTrain)
    
    #Select Only Mean and Std columns
    selData <- select (allData,ActivityId,SubjectId,contains(".mean."), contains(".std."))
    
    #Name the activities as per the "activity_labels.txt" file
    mergedData <- merge(activities,selData,by="ActivityId")
    
    #Create second data set
    groupedData <- group_by(mergedData,ActivityName,SubjectId)
    finalData <- summarise_each (groupedData,funs(mean), contains(".mean."), contains(".std."))
    
    #write this to a txt file for uploading
    write.table(finalData,file="TidyData.txt", row.names = FALSE)
}