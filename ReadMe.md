
## Getting and Cleaning Data Course Project

The function run_analysis() analyzes the "Human Activity Recognition Using Smartphones Dataset Version 1.0" as directed in the instructions for the Getting and Cleaning Data Course Project.  

### Running the function

To run the function, ensure that the "run_analysis.R" script and the "UCI HAR Dataset" folder downloaded from Coursera are in the working directory.  Then source the "run_analysis.R" script and use "run_analysis()" in the console.

### Description of the code

The function is structured according to the five-part instructions given in the Getting and Cleaning Data Course Project assignment.

##### Instruction 1: "Merges the training and the test sets to create one data set."
In lines 9 through 30 in "run_analysis.R", I read the various testing and training data sets and the feature names into R.  Then I add the descriptive column names from the "features.txt" file to the various testing and training data sets.  Finally, I merge all of the training and testing data into a single dataset. 

##### Instruction 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
In lines 33 through 38 in "run_analysis.R", I filter the columns of the single dataset from instruction 1 to keep only the columns with "mean" or "std" anywhere in the column name.  I also keep the "subject" and "activity" columns as the first two columns. 

##### Instruction 3: "Uses descriptive activity names to name the activities in the data set"
In lines 41 through 45 in "run_analysis.R", I convert the activity column of the data from instruction 2 to be a factor variable. Then I rename the factor levels of the activity column to be the names of the activities.

##### Instruction 4: "Appropriately labels the data set with descriptive variable names."
In lines 18-25 of "run_analysis.R" (under the Instruction 1 section), I added the descriptive variable names from the "features.txt" file. In this section (lines 48 through 54), I further improve the variable names by removing parentheses and replacing other special characters (dashes) by periods.

##### Instruction 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
In lines 57 through 68 in "run_analysis.R", I change most column types to numeric, so it will be possible to calculate their means. Then I group the data by subject and activity. I create a tibble with the mean of each variable for each group. Finally, I return the tidy data set.