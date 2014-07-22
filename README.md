Introduction
===================
R Script run_analysis.R is created to perform the following:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Program Descriptions
===================
1. Program calls "downloadData()" function to download and unzip the data from URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Program then extract the following data from the unzipped files:  

	a. /UCI HAR Dataset/test/X_test.txt  
	
	b. /UCI HAR Dataset/test/y_test.txt  
	
	c. /UCI HAR Dataset/test/subject_test.txt  
	
	d. /UCI HAR Dataset/train/X_train.txt  
	
	e. /UCI HAR Dataset/train/y_train.txt  
	
	f. /UCI HAR Dataset/train/subject_train.txt  
	
	g. /UCI HAR Dataset/features.txt  
	
	h. /UCI HAR Dataset/activity_labels.txt  
	
3. From the features.txt data, create a subset of data where only mean and standard deviation are taken. The following command does the job:  

	extract_features <- subset(features_data,  grepl("(mean\\(\\)|std\\(\\))", features_data$V2) )  
	
	x_test = x_test[,extract_features$V1] 
	x_train = x_train[,extract_features$V1]
	 	
4. Merge the test and train dataset activity labels:  
	y_train_labels <- merge(y_train,activity_labels,by="V1")  
	y_test_labels <- merge(y_test,activity_labels,by="V1")

5. Combined the test and train data:  
	train_data <- cbind(subject_train,y_train_labels,x_train)
	test_data <- cbind(subject_test,y_test_labels,x_test)  

6. Set the column headers accordingly:  
	colnames(test_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))  
	colnames(train_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))  
      
7. Combine both test and train datasets:  
	all_data <- rbind(test_data,train_data)

8. Melt the data:  
	melted_data <- melt(merged_data, id=c("Subject","Activity_Id","Activity"))

9. Cast the data back to tidy format:  
	tidy_data <- dcast(melted_data, formula = Subject + Activity_Id + Activity ~ variable, mean)

10. Write the tidy_data data table into an output named "tidy_data.txt":  
	write.table(tidy_data,file="./tidy_data.txt",sep="\t",row.names=FALSE)
	

