CodeBook
===================
This Code Book describes the variables, data and the transformations performed to clean up the data.

Data Information
===================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
  
  For each record in the dataset it is provided:  
  
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.  

- Triaxial Angular velocity from the gyroscope.  

- A 561-feature vector with time and frequency domain variables.  

- Its activity label.  

- An identifier of the subject who carried out the experiment.  

Data Descriptions
===================
After the downloaded files are unzipped, the following files and their corresponding data information are as follows:  
•	test/X_test.txt will give us the local variable, test_data containing all the 541 columns of raw data in the test set  

•	train/X_train.txt will give us the local variable, train_data containing all the 541 columns of raw data in the training set  

•	activities.txt will give us the local variable, activity_labels containing all the different types of activities: WALKING,WALKING_UPSTAIRS, SITTING, etc  

•	train/subject_train.txt will give us the local variable, subject_train containing all the possible subject data inside the training set.  

•	test/subject_test.txt will give us the local variable, subject_test containing all the possible subject data inside the test set.  

•	train/y_train.txt will give us the local variable, y_train containing all the possible label data inside the training set.  

•	test/y_test.txt will give us the local variable, y_test containing all the possible label data inside the test set.  

Data Transformations
===================
1. To reduce the need for high memory to manage the datasets, the program first subset the datasets such that only the mean and standard deviation are extracted. The following code performs the tasks:
      features_data <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)  
	  extract_features <- subset(features_data,  grepl("(mean\\(\\)|std\\(\\))", features_data$V2) )  
	  x_test = x_test[,extract_features$V1]  
	  x_train = x_train[,extract_features$V1]  

2. To display the activities, e.g. "WALKING", "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS", etc. The test and train data were merged with the activity_labels via the following:  
		y_train_labels <- merge(y_train,activity_labels,by="V1")  
		y_test_labels <- merge(y_test,activity_labels,by="V1")  

3. The data were then combined, as follows:  
		train_data <- cbind(subject_train,y_train_labels,x_train)  
		test_data <- cbind(subject_test,y_test_labels,x_test)  

4. For the column names, add the three names - "Subject", "Activity_Id", "Activity" to the data tables. This is done in the following:  
		colnames(test_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))  
		colnames(train_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))  

5. Merge the test_data and train_data into a single data table - all_data, via the following line:  
		all_data <- rbind(test_data,train_data)  
		
6. Melt the merged data by "Subject","Activity_Id" & "Activity", via the following line:  
		melted_data <- melt(merged_data, id=c("Subject","Activity_Id","Activity"))  

7. Use the Dcast function to get the mean for the variables, via the following line:  
		tidy_data <- dcast(melted_data, formula = Subject + Activity_Id + Activity ~ variable, mean)

8. Clean up the column headers, by substituting "-mean" with "Mean", "-std()" with "Std", "BodyBody" with "Body" using gsub function, e.g.:  
		col_names_vector <- gsub("-mean()","Mean",col_names_vector,fixed=TRUE)  

9. Write the table out in a tab delimited text file:  
	write.table(tidy_data,file="./tidy_data.txt",sep="\t",row.names=FALSE)

Data Columns
===================
The transformed data columns are as follow:
> colnames(tidy_data)
 [1] "Subject"              "Activity_Id"          "Activity"              
 
 [4] "tBodyAccMean-X"       "tBodyAccMean-Y"       "tBodyAccMean-Z"        
 
 [7] "tBodyAccStd-X"        "tBodyAccStd-Y"        "tBodyAccStd-Z"         
 
[10] "tGravityAccMean-X"    "tGravityAccMean-Y"    "tGravityAccMean-Z"     

[13] "tGravityAccStd-X"     "tGravityAccStd-Y"     "tGravityAccStd-Z"      

[16] "tBodyAccJerkMean-X"   "tBodyAccJerkMean-Y"   "tBodyAccJerkMean-Z"    

[19] "tBodyAccJerkStd-X"    "tBodyAccJerkStd-Y"    "tBodyAccJerkStd-Z"     

[22] "tBodyGyroMean-X"      "tBodyGyroMean-Y"      "tBodyGyroMean-Z"       

[25] "tBodyGyroStd-X"       "tBodyGyroStd-Y"       "tBodyGyroStd-Z"         

[28] "tBodyGyroJerkMean-X"  "tBodyGyroJerkMean-Y"  "tBodyGyroJerkMean-Z"   

[31] "tBodyGyroJerkStd-X"   "tBodyGyroJerkStd-Y"   "tBodyGyroJerkStd-Z"    

[34] "tBodyAccMagMean"      "tBodyAccMagStd"       "tGravityAccMagMean"    

[37] "tGravityAccMagStd"    "tBodyAccJerkMagMean"  "tBodyAccJerkMagStd"    

[40] "tBodyGyroMagMean"     "tBodyGyroMagStd"      "tBodyGyroJerkMagMean"  

[43] "tBodyGyroJerkMagStd"  "fBodyAccMean-X"       "fBodyAccMean-Y"        

[46] "fBodyAccMean-Z"       "fBodyAccStd-X"        "fBodyAccStd-Y"         

[49] "fBodyAccStd-Z"        "fBodyAccJerkMean-X"   "fBodyAccJerkMean-Y"    

[52] "fBodyAccJerkMean-Z"   "fBodyAccJerkStd-X"    "fBodyAccJerkStd-Y"     

[55] "fBodyAccJerkStd-Z"    "fBodyGyroMean-X"      "fBodyGyroMean-Y"       

[58] "fBodyGyroMean-Z"      "fBodyGyroStd-X"       "fBodyGyroStd-Y"        

[61] "fBodyGyroStd-Z"       "fBodyAccMagMean"      "fBodyAccMagStd"        

[64] "fBodyAccJerkMagMean"  "fBodyAccJerkMagStd"   "fBodyGyroMagMean"      

[67] "fBodyGyroMagStd"      "fBodyGyroJerkMagMean" "fBodyGyroJerkMagStd" 		  

		


