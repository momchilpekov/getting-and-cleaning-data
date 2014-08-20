# Loading column names
filefeatures <- "features.txt"
features <- read.table(filefeatures, header=F)

# Remove unnecessary symbols from column names and make them descriptive
names <- make.names(gsub("\\(|\\)|-","",features[,2]))

# Add activity and subject to column names
names <- c(names, "activity", "subject")

# Loading Train and Test data
filetrain <- ".//train/X_train.txt"
filetest <- ".//test/X_test.txt"
train <- read.table(filetrain, header=F)
test <- read.table(filetest, header=F)

# Loading activity lables (for point 4)
file_activity_labels <- "activity_labels.txt"
activity_labels <- read.table(file_activity_labels ,header=F)
# Loading activities for train and test datasets
file_activity_train <- ".//train//y_train.txt"
activity_train <- read.table(file_activity_train, header=F)
file_activity_test <- ".//test//y_test.txt"
activity_test <- read.table(file_activity_test, header=F)

# Loading subject data
file_subject_train <- ".//train//subject_train.txt"
subject_train <- read.table(file_activity_train, header=F)
file_subject_test <- ".//test//subject_test.txt"
subject_test <- read.table(file_subject_test, header=F)

# Combine main data with activity type and subject
test1 <- cbind(test, activity_test, subject_test)
train1 <- cbind(train, activity_train, subject_train)

# Descriptive names as numbers
meanstd <- grep("mean|std|activity|subject", names, ignore.case=T)

# Combaine test and tran datasets
data <-rbind(test1[ , meanstd], train1[ , meanstd])

# Apply descriptive names to datasets
names(data) <- names[meanstd]

# vector with names as numbers for menas and standard deviations.
# All columns with mean are included
meanstd1 <- grep("mean|std", names(data), ignore.case=T)

# Descriptive names for the activities
data$activity <- activity_labels[data$activity, 2]

#Prepraing tiny dataset 
tinydata <- aggregate(data[, meanstd1], list(Activity=data$activity, Subject=data$subject), mean)

# Write tiny dataset to file
write.table(tinydata, file="tiny.txt", row.name=FALSE)