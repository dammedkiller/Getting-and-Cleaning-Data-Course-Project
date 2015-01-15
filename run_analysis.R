###################################################################################
##                                                                               ##
##      Script made for the Course Project of "Getting and cleaning Data"        ##
##      Made by Jorge Sendino                                                    ##
##                                                                               ##
###################################################################################

##Read the diferent data sets into R and load data.table library
library(data.table)
train = read.table("data/train/X_train.txt")
test = read.table("data/test/X_test.txt")
features = read.table("data/features.txt")
testLabels = read.table("data/test/Y_test.txt", col.names="activity")
trainLabels = read.table("data/train/Y_train.txt", col.names="activity")
testSubject = read.table("data/test/subject_test.txt")
trainSubject = read.table("data/train/subject_train.txt")

##Combine the labels, convert them into a factor variable and give it descriptive names
labels = factor(c(testLabels$activity, trainLabels$activity), 
                    labels=tolower(c("WALKING",
                                     "WALKING_UPSTAIRS",
                                     "WALKING_DOWNSTAIRS",
                                     "SITTING",
                                     "STANDING",
                                     "LAYING")))

##Merge the data and make the names more readable
data = rbind(test, train)
names(data) = features$V2

##Extract from the data set the columns corresponding to the mean and the std
##Save them in another data frame
correctColumns = c(grep("mean", names(data)), grep("std", names(data)))
meanAndStd = data[, correctColumns]

##Bind the original data set with its labels and fix the names
meanAndStd = cbind(c(testSubject$V1, trainSubject$V1),labels, meanAndStd)
names(meanAndStd) = c("subject", "activity",sub("\\()", "", features$V2[correctColumns]))
names(meanAndStd) = gsub("-","",names(meanAndStd))
names(meanAndStd) = sub("BodyBody", "Body", names(meanAndStd))
names(meanAndStd) = gsub("mean","Mean",names(meanAndStd))
names(meanAndStd) = gsub("std","STD",names(meanAndStd))

##Convert the dataset to data.table and obtain the mean of all variables by subject and activity
meanAndStd = data.table(meanAndStd)
ave = meanAndStd[, lapply(.SD, mean), by=c("subject", "activity")]

write.table(ave, "average_dataset.txt", row.name=FALSE)
