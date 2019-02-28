##  Download and unzip

# variables for file download
fileName <- "UCI_HAR_data.zip"
URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# verification for file dowload
if(!file.exists(fileName)){download.file(URL,fileName, mode="wb")}

# verification for unzip file
if(!file.exists(dir)){unzip(fileName)}

## Read Data
subject_test <- read.delim("UCI HAR Dataset/test/subject_test.txt", header = F,  sep="")
subject_train <- read.delim("UCI HAR Dataset/train/subject_train.txt", header = F,  sep="")

X_test <- read.delim("UCI HAR Dataset/test/X_test.txt", header = F,  sep="")
X_train <- read.delim("UCI HAR Dataset/train/X_train.txt", header = F,  sep="")
y_test <- read.delim("UCI HAR Dataset/test/y_test.txt", header = F,  sep="")
y_train <- read.delim("UCI HAR Dataset/train/y_train.txt", header = F,  sep="")

activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", header = F,  sep="")
features <- read.delim("UCI HAR Dataset/features.txt", header = F,  sep="")



##  1. Merges the training and the test sets to create one data set.
dataSet <- rbind(X_train,X_test)



##  2. Extracts only the measurements on the mean and standard deviation
##  for each measurement.
indexMeanStd <- grep("mean()|std()",features[,2])
dataSet <- dataSet[,indexMeanStd]



##  4. Appropriately labels the data set with descriptive variable names.

##  Get Clean feature names Vector: First replace "()" by "" and 
##  after change "," by "_"
cleanFeatureLabel <- sapply(features[,2],
                            function(x){ 
                                        gsub("[,]","_",gsub("[()]", "",x))
                                        }
                            )
names(dataSet) <- cleanFeatureLabel[indexMeanStd]

##  Merges the training and the test subject to create one data subject.
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'

##  Merges the training and the test "y" to create one data activity.
activity <- rbind(y_train, y_test)
names(activity) <- 'activity'

## Add to dataSet columns subject and activity
dataSet <- cbind(subject, activity, dataSet)



##  3. Uses descriptive activity names to name the activities in the data set
dataSet$activity <- factor(dataSet$activity)
levels(dataSet$activity) <- activity_labels[,2]



##  5. From the data set in step 4, creates a second, independent tidy data
##  set with the average of each variable for each activity and each subject

##  Check if reshape2 package is installed
pack <- "reshape2"
if (!pack %in% installed.packages()) install.packages(pack)
library(pack)

dataMelt <- melt(dataSet,(id.vars=c("subject","activity")))
meanDataMelt <- dcast(dataMelt, subject + activity ~ variable, mean)
names(meanDataMelt)[-c(1:2)] <- paste0("MEAN_" , names(meanDataMelt)[-c(1:2)] )
write.table(meanDataMelt, "tidyData.txt", sep = ",")

