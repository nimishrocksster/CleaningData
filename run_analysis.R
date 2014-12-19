## Code for run_analysis.R
## assuming that we are in the UHI HAR Dataset directory as the working dir.

## read all the training data in a variable.
training = read.table("train\\X_train.txt")
# also read the activity table
trainingActivity = read.table("train\\y_train.txt")

## read all the test data in a variable
test = read.table("test\\X_test.txt")
# also read the activity table
testActivity = read.table("test\\y_test.txt")

## merge the two data sets using rbind function 
data = rbind(training,test)
# also combine the activity table
activity = rbind(trainingActivity, testActivity)

## read all the features
feature = read.table("features.txt")

## assign the column names to the data that we just combined
colnames(data) = feature$V2

## select all the features with mean and Std deviation
colList = grepl("mean|std", feature$V2);

## now that we have the boolean list of all the columns that match the 
## std dev and mean patter we can apply this list to the combined data
## and get the subset of data that we are interested in 
tidyData = data[colList]

## to this tidy data add the activity column
tidyData = cbind(tidyData,activity)

## since the activity column in only integer here, we need to 
## put appropriate names
# first read all the labels in a data frame
labels = read.table("activity_labels.txt")
# now merge the two data frames, tidyData and label based on the activity integer
tidyData = merge(tidyData, labels, by.x = "V1", by.y = "V1")

## remove the first column containing the activity integer 
tidyData = tidyData[,-c(1)]

## rename the last column to Activity
colnames(tidyData)[80] = "Activity"

## writing this data set in to a file
write.table(tidyData, row.names = FALSE, file = "TidyData.txt")

## get all the members that participated in the test
trainSubject = read.table("train\\subject_train.txt")
testSubject = read.table("test\\subject_test.txt")
# merge the subjects together
subjects = rbind(trainSubject, testSubject)

## merge the subjects with the tidy data
subjectData = cbind(tidyData, subjects)

## rename the last column to Subject
colnames(subjectData)[81] = "Subject"

## melt the data with two ids
meltData = melt(subjectData, id=c("Subject","Activity"))

# once the data has been melted group it
groupData=group_by(meltData, Subject, Activity, variable)

## and lastly summarise the data
tidyDataNew = summarise(groupData,mean(value))

