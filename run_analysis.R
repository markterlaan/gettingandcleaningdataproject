library(dplyr)
#read variable and label names
varnames <- read.table("features.txt")
labels <- read.table("activity_labels.txt")

#load data
datatest <- read.table("test/x_test.txt")
acttest <- read.table("test/y_test.txt")
subjtest <- read.table("test/subject_test.txt")
datatrain <- read.table("train/x_train.txt")
acttrain <- read.table("train/y_train.txt")
subjtrain <- read.table("train/subject_train.txt")

#add variable 'activity'to identify activity's
activity <- as.character()
for (i in acttest) activity <- labels$V2[i]
datatest <- cbind(activity,datatest)
activity <- as.character()
for (i in acttrain) activity <- labels$V2[i]
datatrain <- cbind(activity, datatrain)

#ad variable subject
datatest <- cbind(subjtest, datatest)
datatrain <- cbind(subjtrain, datatrain)

#merge data into one dataset
datatt <- rbind(datatest, datatrain)

#apply variable names
names(datatt) <- c('subject','activity', as.character(varnames[,2]))

#get only data on means an std's and activity, subject
datastdmean <- datatt[,c(1,2,grep("std",names(datatt)), grep("mean", names(datatt)))]


#get means
datameans <- datastdmean %>% group_by(subject, activity) %>% summarise_each(funs(mean))

