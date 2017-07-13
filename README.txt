Course Project - Getting and Cleaning Data

Instructions
    This repo contains course project to Coursera "Getting and Cleaning Data" . This is part of courses of the Data Science specialization. 
 
Getting-and-Cleaning-Data-Project

About the raw data
   .The dataset being used is: Human Activity Recognition Using Smartphones  It can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test     subjects are in the subject_test.txt file.
         The training data set has the similar contents.

The prerequisit of run the R script:
 . Download the raw data (the zip file in above link), unzip it into local working direcory
 . Two packages (dplyr and data.table) are installed. 

The R script, run_analysis.R, does the following:

. Loads and merge the activity, feature and subject data sets from test and train within working directory seperately
. Merge two data sets after loading
. Load column names for feature from 'feature.txt' 
. Keeping only those columns which reflect a mean or standard deviation measurement in feature data set
. Combine features,activity,subject into the one data set, called extractedData 
. Rename some column's name
. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
. The end result is shown in the file Tidy.txt.