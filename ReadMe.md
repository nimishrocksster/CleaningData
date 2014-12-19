## Code for run_analysis.R
## Assuming that we are in the UHI HAR Dataset directory as the working dir. We read all the training data in a variable.
## We also read the training activity data in the variable

## read all the test data and the test activity data in their respective variables.

## merge the two training and test data sets using rbind function. We also merge the activity data for training and test

## read the features file to get all the names of the variables and set these variable names to the above combined data.

## select all the features with mean and Std deviation. Using this boolean vector select only the interesting data from the giant data set formed above

## combine the activity data set to the main data. Also read the activity labels and then apply these labels to the tidy data set

## write the data in the file

## select and merge the subject data set from training and test. 

## melt the data with Subject and Activity names 

# once the data has been melted group it

## and lastly summarise the data

