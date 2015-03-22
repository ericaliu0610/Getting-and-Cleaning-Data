# 1. Merges the training and the test sets to create one data set.
data_train <- read.table("train/X_train.txt")
data_test <- read.table("test/X_test.txt")
data<-rbind(data_train,data_test)

s_train <- read.table("train/subject_train.txt")
s_test <- read.table("test/subject_test.txt")
S <- rbind(s_train, s_test)

label_train <- read.table("train/Y_train.txt")
label_test <- read.table("test/Y_test.txt")
label <- rbind(label_train, label_test)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("features.txt")
mean_std <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
data<-data[,mean_std]
names(data)<-features[mean_std,2]

#3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
label[,1] = activities[label[,1], 2]
names(label)<-"activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <-"subject"
com_data<-cbind(S,label,data)
write.table(com_data,"data_on_mean_and_std.txt")

row = 1
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
uniS = unique(S)[,1]
uniS<-sort(uniS)
numS = length(unique(S)[,1])
numA = length(activities[,1])
numCols = dim(com_data)[2]
independent = com_data[1:(numS*numA), ]

for (i in 1:numS) {
  for (j in 1:numA) {
    independent[row, 1] = uniS[i]
    independent[row, 2] = activities[j, 2]
    tmp <- com_data[com_data$subject==i & com_data$activity==activities[j, 2], ]
    independent[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
write.table(independent, "second_independent_tidy_data.txt",row.names = FALSE)
