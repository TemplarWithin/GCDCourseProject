GCDCourseProject
================
Summary of the run_analysis.R script contained within this repo
--------------
The script contained within this repo is used for transforming a very specific RAW dataset into an infinitely more useful "Tidy Data Set" through the use of several R functions. Such dataset was provided through the Coursera course: "Getting and Cleaning Data", and because of that i took the liberty of transcribing the goals and objectives of such assignment further down.

For this script to actually work, your working directory must contain both: the run_analysis.R script contained within this repo, and the uncompressed raw data folder "UCI HAR Dataset", which you can acquire either through these repo, through the Coursera course from which this particular Course Project was assigned, or through the following hyperlink: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Furthermore, you will need to manually assign the working directory in which you have stored those files through the setwd() function when you run it in R.Studio.

Step by step, this R Script does the following:

1. The script will read all the data from the raw files, and it will then convert them into proper data types, specifically it will: Create data types from the "subjects (Id's)", create data types from the "activity labels" and create data types from the "features".
        
2. The script will then merge the datasets into a more comprehensive object that integrates the subjects with the appropriate labels, activity names, and relevant measurements recorded.

*Note for the Peer Assessment's: Steps 1 & 2 jointly cover project requirements 1,3 & 4*
        
3. The script will then subset the columns that contain the specific information that the assignment requires; heavily reducing the computer load required to execute further analysis on it.
        
*Note for the Peer Assessment's: Step 3 covers the second project requirement*

4. The script will then create and save an output data frame with a .txt extension, to avoid having to repeat the procedure every time we need the specific data we have created up to this point.

5. Finally, the script will read the relevant data required for the Coursera's .txt file submission from the Dataset #1 (directly from file), sub setting and averaging each subject & activity, and it will then save the Output to a data.frame named dataset2.txt, to fulfill the requirements set for the subsequent course required submission.
        
*Note for the Peer Assessment's: Steps 4 & 5 jointly cover project requirement 5*


Project Objectives & Description
--------------

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a GitHub repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for                    each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Good luck!