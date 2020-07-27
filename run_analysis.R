library(dplyr)
#file download
filename <- "UCI HAR Dataset.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Make folder
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

inpath<-'./UCI HAR Dataset'

#1.Merges the training and the test sets to create one data set  
#readin train data
xtrain<-read.table(file.path(inpath, 'train', 'X_train.txt'), header=FALSE)
ytrain<-read.table(file.path(inpath, 'train', 'y_train.txt'), header=FALSE)
strain<-read.table(file.path(inpath, 'train', 'subject_train.txt'), header=FALSE)

#readin test data 
xtest<-read.table(file.path(inpath, 'test', 'X_test.txt'), header=FALSE)
ytest<-read.table(file.path(inpath, 'test', 'y_test.txt'), header=FALSE)
stest<-read.table(file.path(inpath, 'test', 'subject_test.txt'), header=FALSE)

#readin feature data
features<-read.table(file.path(inpath, 'features.txt'), header=FALSE)

#readin activity data
activity<-read.table(file.path(inpath, 'activity_labels.txt'), header=FALSE)
colnames(activity) <- c('activityid','activitylabel')

#merge train, test, feature and activity data
colnames(xtrain)=features[,2]
colnames(ytrain)='activityid'
ytrain1<-merge(ytrain, activity, by='activityid' )
colnames(strain)='subjectid'

colnames(xtest)=features[,2]
colnames(ytest)='activityid'
ytest1<-merge(ytest, activity, by='activityid' )
colnames(stest)='subjectid'

train<-cbind(strain, xtrain, ytrain1)
test<-cbind(stest, xtest, ytest1)
df<-rbind(train, test)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
extract<-df %>%
  select(subjectid, activityid, contains('mean'), contains('std'))

#3. Uses descriptive activity names to name the activities in the data set.
data<-merge(extract, activity, by='activityid')

#4. Appropriately labels the data set with descriptive variable names.
names(data)<-gsub('Acc', 'Accelerometer', names(data))
names(data)<-gsub('BodyBody', 'Body', names(data))
names(data)<-gsub('^f', 'frequency', names(data))
names(data)<-gsub('Gyro', 'Gyroscope', names(data))
names(data)<-gsub('Mag', 'Magnitude', names(data))
names(data)<-gsub('^t', 'time', names(data))

#5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
tidydataset<-data %>%
  group_by(activitylabel, subjectid) %>%
  summarise_all(mean, na.rm = TRUE) 

write.table(tidydataset, 'tidydataset.txt', row.name=FALSE)
