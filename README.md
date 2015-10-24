# GettingAndCleaningDataProject
Course project for the Getting and Cleaning Data course offered by Johns Hopkins University on Coursera

There is only one script file in this repository. The file includes downloading and cleaning the data for the course project. At the end of the script, the file ActivitySubjectSummary.txt is saved to the same directory the data was downloaded into.

The analysis is broken down into several steps. First, data is downloaded and unzipped. Data is split into 6 files so these files are combined into one single data set. Second, there is a great deal of excess information provided in the full data set, so a subset is created that only looks at mean and standard deviation variables. Next the activity types are changed from numerical into meaningful descriptions. Then the variable names (column names) are updated to meaningful descriptions. Finally, a summary data set is created with the average of the mean and standard deviation for each activity by subject and saved to a txt file.
