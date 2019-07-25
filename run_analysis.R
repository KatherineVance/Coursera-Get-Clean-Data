## This function analyzes the "Human Activity Recognition Using Smartphones Dataset Version 1.0"
## as directed in the instructions for the Getting and Cleaning Data Course Project.
## To run the function, source this script and then use "run_analysis()" in the console.

## Load the dplyr packages (necessary for grouping the data in lines 61-63).
require(dplyr)

run_analysis <- function(){
  ## Instruction 1. Merges the training and the test sets to create one data set.
    ## Read the various testing and training data sets and the feature names into R.  
      X_test <- read_delim("UCI HAR Dataset/test/X_test.txt", " ", col_names = FALSE)
      y_test <- read_delim("UCI HAR Dataset/test/y_test.txt", " ", col_names = FALSE)
      subject_test <- read_delim("UCI HAR Dataset/test/subject_test.txt", " ", col_names = FALSE)
      X_train <- read_delim("UCI HAR Dataset/train/X_train.txt", " ", col_names = FALSE)
      y_train <- read_delim("UCI HAR Dataset/train/y_train.txt", " ", col_names = FALSE)
      subject_train <- read_delim("UCI HAR Dataset/train/subject_train.txt", " ", col_names = FALSE)
      features <- read_delim("UCI HAR Dataset/features.txt", " ", col_names = FALSE)
    ## Add column names to the various testing and training data sets.
      colnames(y_train) <- c("activity")
      colnames(y_test) <- c("activity")
      colnames(subject_test) <- c("subject")
      colnames(subject_train) <- c("subject")
      as.data.frame(features)
      colnames(X_test) <- features$X2
      colnames(X_train) <- features$X2  
    ## Merge the training and testing data, respectively
      train <- cbind(subject_train, y_train, X_train)
      test <- cbind(subject_test, y_test, X_test)
    ## Merge the training and testing data into a single dataset  
      data1 <- rbind(train, test)
      
      
  ## Instruction 2. Extracts only the measurements on the mean and standard deviation 
  ## for each measurement.
    ## Filter the columns of the single dataset from instruction 1 to keep only the columns 
    ## with "mean" or "std" anywhere in the column name.  I also keep the "subject" and 
    ## "activity" columns as the first two columns. 
      data2 <- data1[, c(1, 2, grep("mean|std", colnames(data1)))]

      
  ## Instruction 3. Uses descriptive activity names to name the activities in the data set.
    ## Convert the activity column of the data from instruction 2 to a factor.
      data2$activity <- as.factor(data2$activity)
    ## Rename the factor levels of the activity column to be the names of the activities.
      levels(data2$activity) <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")

      
  ## Instruction 4. Appropriately labels the data set with descriptive variable names.   
    ## Lines 18-25 under the Instruction 1 section add the descriptive variable names from 
    ## features.txt file.  
    ## Further improve the variable names by removing parentheses and replacing other special 
    ## characters (dashes) by periods.
      colnames(data2) <- sub("[(][)]", "", colnames(data2))
      colnames(data2) <- gsub("-", ".", colnames(data2))
      
      
  ## Instruction 5. From the data set in step 4, creates a second, independent tidy data
  ## set with the average of each variable for each activity and each subject.
    ## Change most column types to numeric, so means can be taken in line 65.
      data2[, 3:81] <- sapply(data2[, 3:81], as.numeric)
    ## Group the data by subject and activity.
      grouped <- group_by(data2, subject)
      grouped <- group_by(grouped, activity, add = TRUE)
    ## Create a tibble with average of each variable for each group.
      finaldataset <- summarise_all(grouped, mean)
    ## Save the tidy data set to a .txt file
      write.table(finaldataset, file = "tidydataset.txt", row.names = FALSE)
      print("The tidy data set is saved in the file 'tidydataset.txt' in your working directory.")
}