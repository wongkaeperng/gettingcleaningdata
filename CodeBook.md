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

