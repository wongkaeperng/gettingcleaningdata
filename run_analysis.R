library(data.table)
library(reshape2)

#download Data 
downloadData <- function() {
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, destfile = "data.zip")
      unzip("data.zip")
}

#load Data
loadData <- function(){
      downloadData()      
      
      # Read test data
      x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,sep="")
      y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep="")
      subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep="")

      # Read train data
      x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE,sep="")
      y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE,sep="")
      subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,sep="")

      # Extract features data
      features_data <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
      
      #names(x_train) = features_data
      #names(x_test) = features_data
      
      # Extract only measurements on the mean and std.
      extract_features <- subset(features_data,  grepl("(mean\\(\\)|std\\(\\))", features_data$V2) )
      
      x_test = x_test[,extract_features$V1]
      x_train = x_train[,extract_features$V1]
            
      # Read activity labels
      activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
      
      # merge y test and training activity labels
      y_train_labels <- merge(y_train,activity_labels,by="V1")
      y_test_labels <- merge(y_test,activity_labels,by="V1")
      
      # combine train data
      train_data <- cbind(subject_train,y_train_labels,x_train)
      
      # combine test data
      test_data <- cbind(subject_test,y_test_labels,x_test)
            
      # set column headers
      colnames(test_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))      
      colnames(train_data) <- c("Subject","Activity_Id","Activity",as.vector(extract_features[,2]))      
      
      #combine both test and train data
      all_data <- rbind(test_data,train_data)
      
      return (all_data)      
}


merged_data <- loadData()

#Melt the data
melted_data <- melt(merged_data, id=c("Subject","Activity_Id","Activity"))

#Get the mean for the variables.
tidy_data <- dcast(melted_data, formula = Subject + Activity_Id + Activity ~ variable, mean)

#Clean up column names.
col_names_vector <- colnames(tidy_data)
#Substitute -mean() to "Mean"
col_names_vector <- gsub("-mean()","Mean",col_names_vector,fixed=TRUE)
#Substitute "Std()" to "Std"
col_names_vector <- gsub("-std()","Std",col_names_vector,fixed=TRUE)
#Substitute "BodyBody" to "Body"
col_names_vector <- gsub("BodyBody","Body",col_names_vector,fixed=TRUE)
#Place tidied column names back to tiday_data
colnames(tidy_data) <- col_names_vector


write.table(tidy_data,file="./tidy_data.txt",sep="\t",row.names=FALSE)
