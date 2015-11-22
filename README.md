 # Create TidyD data set

 The run_analysis function creates a tidy dataset as follows

 1. First, the required packages for this function is loaded
 .. dplyr

 1. A very basic test is performed to see if the required dta exist, by checking if the
 	subdirectories exist

 1. A number of Source data files provded for the assignment is then read into datasets
 ..	features (A list of all variables htat were automatically recorded)
 ..	activities (A list of descriptios for the activities)
 ..	test data (3 files - subjects, activities and measurements)
 ..	train data (3 files - subjects, activities and measurements)

 1.	Test and Train datasets are then combined
 ..	First the 3 files for each group to expand the columns
 ..	Then the test and train data together to expand the number of rows

 1.	Only measurements with "mean" or "std" is then selected as this is all we're intersted in

 1.	The activity descriptions is merged into the dataset to have desciptive activity names for each record

 1.	Finally, data is grouped by Activity and Subject in order to get the Mean for each group and each 
 	measurement

 1.	TidyData.txt is created by writing the final dataset to disk
