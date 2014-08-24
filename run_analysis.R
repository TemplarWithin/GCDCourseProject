        ## Getting and Cleaning Data Course Project
        
        
        ## Foreword:
                # For this script to actually work you're working directory must 
                # contain both: the run_analysis.R script and the uncompressed 
                # rawdata folder "UCI HAR Dataset" that was provided through Coursera
                # for this particular Course Project; furthermore, you will need to change
                # the following setwd() function for the specific path of your working directory
        
                setwd("C:/Users/Christian/SkyDrive/Drive Gate/Dropbox/Documents Archive/Coursera/Data Science Specialization/Getting & Cleaning Data/Programming Assignments/Project")
        
        ## Part 1.- Read & convert data from the rawfiles into proper data types
                
                # 1.1 Create data types from subjects (Id's)
               
                Raw_ID_Training <- readLines("./UCI HAR Dataset/train/subject_train.txt")
                
                Raw_ID_Training <- as.integer(Raw_ID_Training)
                
                Raw_ID_Test  <- readLines("./UCI HAR Dataset/test/subject_test.txt")
                
                Raw_ID_Test  <- as.integer(Raw_ID_Test)
        
                # 1.2 Create data types from activity labels
                
                Raw_Activity <- readLines("./UCI HAR Dataset/activity_labels.txt")
                
                Raw_Activity <- sapply(Raw_Activity, function(x) {
                                        idx <- grepRaw( " ", x)
                                        substr(x, (idx+1), nchar(x)) }, 
                                        USE.NAMES=FALSE )
                
                Raw_Activity <- factor(Raw_Activity,levels=Raw_Activity)
                
                Raw_Activity_Train  <- readLines("./UCI HAR Dataset/train/y_train.txt")
                
                Raw_Activity_Train  <- as.integer(Raw_Activity_Train)
                
                Raw_Activity_Test   <- readLines("./UCI HAR Dataset/test/y_test.txt")
                
                Raw_Activity_Test   <- as.integer(Raw_Activity_Test)
        
                # 1.3 Create data types from features
                
                Raw_Feature <- readLines("./UCI HAR Dataset/features.txt")
                
                Raw_Feature <- sapply( 
                        Raw_Feature, 
                        function(x) {
                                idx <- grepRaw( " ", x)
                                substr(x, (idx+1), nchar(x)) }, 
                        USE.NAMES=FALSE )
                        
                        Raw_Feature_Train <- read.csv(
                                file="./UCI HAR Dataset/train/X_train.txt",
                                sep="", header=FALSE)
                        
                        colnames(Raw_Feature_Train) <- Raw_Feature
              
                        Raw_Feature_Test  <- read.csv(
                                file="./UCI HAR Dataset/test/X_test.txt",
                                sep="", header=FALSE)
                        
                        colnames(Raw_Feature_Test) <- Raw_Feature
                        
                        rm(list = c("Raw_Feature"))
        
        ## Part 2. Merge the datasets into a more comprehensive object
                
                Raw_Feature_Both    <- rbind( Raw_Feature_Train, Raw_Feature_Test)
                
                Raw_Activity_Both <- c( Raw_Activity_Train, Raw_Activity_Test)
                
                Raw_Subject_Both    <- c( Raw_ID_Training, Raw_ID_Test)
                
                Raw_Subject_Both_Leveling <- character(length(Raw_Activity_Both)) 
                        for (i in 1:length(Raw_Activity)) {
                        Raw_Subject_Both_Leveling[Raw_Activity_Both==i] <- levels(Raw_Activity)[i]
                        }
                
                Raw_Activity_Both <- factor(Raw_Subject_Both_Leveling,
                                            levels=levels(Raw_Activity))
        
                rm(list = c("Raw_Feature_Train","Raw_Feature_Test",
                            "Raw_Activity_Train","Raw_Activity_Test",
                            "Raw_ID_Training","Raw_ID_Test"),
                   "i", "Raw_Subject_Both_Leveling")
                
                
        ## Part 3. Subset the requiered columns
               
                Feature_Names <- colnames(Raw_Feature_Both)
                
                idx <- sapply(Feature_Names, 
                              function(x) {
                                      grepl("mean",x) | grepl("std",x)
                              },
                              USE.NAMES=FALSE )
                
                Raw_Feature_Both <- Raw_Feature_Both[,idx]
                
                rm( list = c("Feature_Names","idx"))
                
        ## Part 4. Create the data.frame requiered in the conditions 
        ## asked for the DataSet #1 (With descriptive activity names,
        ## appropiate labels & measurements)
               
                My_Dataset_1 <- data.frame( 
                                subject=Raw_Subject_Both, 
                                activity=Raw_Activity_Both,
                                Raw_Feature_Both)
                
                colnames(My_Dataset_1) <- c( "subject", "activity", 
                                             colnames(Raw_Feature_Both))
                
                rm(list = c("Raw_Subject_Both","Raw_Activity_Both",
                            "Raw_Feature_Both"))
        
        ## Part 5. Save the Output of the DataSet #1 data.frame to a csv file 
        ## for the subsequent creation of the Tidy Data Set (DataSet #2).
                
                write.csv(My_Dataset_1, file="dataset1.txt",
                          row.names = FALSE)
                
        ## Part 6
                
                # 6.1 Read the relevant data from DataSet #1 directly from file
                
                My_Dataset_1 <- read.csv( 
                        file="dataset1.txt", 
                        header=TRUE,
                        check.names=FALSE,
                        stringsAsFactors=FALSE)
                
                My_Dataset_1[["activity"]] <- factor(My_Dataset_1[["activity"]],
                                                     levels=c("WALKING","WALKING_UPSTAIRS", 
                                                              "WALKING_DOWNSTAIRS","SITTING",
                                                              "STANDING", "LAYING") )
                
                # 6.2 Subset and average each subject & activity from DataSet #1 to 
                # fullfill the requierements set for the  DataSet #2 data.frame 
                
                Features_Mean <- grepl("mean", colnames(My_Dataset_1))
                
                Subjects_Unique   <- as.numeric( rownames( table(My_Dataset_1[["subject"]]) ) )
                
                Activities_Unique <- levels(My_Dataset_1[["activity"]])
                
                My_Dataset_2 <- data.frame( 
                        subject =integer  (length(Subjects_Unique)*length(Activities_Unique)), 
                        activity=character(length(Subjects_Unique)*length(Activities_Unique)),
                        matrix(data=numeric(sum(Features_Mean)*length(Subjects_Unique)*
                                                    length(Activities_Unique)), 
                                ncol=sum(Features_Mean), nrow=length(Subjects_Unique)*
                                        length(Activities_Unique) ),
                        stringsAsFactors=FALSE
                )
                
                colnames(My_Dataset_2) <- c("subject", "activity", 
                                            colnames(My_Dataset_1)[Features_Mean])
                
                count <- 1
                for (subject in Subjects_Unique) {
                        for (activity in Activities_Unique) {
                                
                                idx_subject  <- ( My_Dataset_1[["subject"]]  == subject  )
                                
                                idx_activity <- ( My_Dataset_1[["activity"]] == activity )
                                
                                subset_df <- My_Dataset_1[ idx_subject & idx_activity,Features_Mean]
                                
                                My_Dataset_2[count,"subject"]  <- subject
                                
                                My_Dataset_2[count,"activity"] <- activity
                                
                                My_Dataset_2[count,3:ncol(My_Dataset_2)] <- sapply( subset_df, mean)
                                count <- count + 1
                        }
                }
                
                My_Dataset_2[["activity"]] <- factor(My_Dataset_2[["activity"]], 
                                                     levels=c("WALKING","WALKING_UPSTAIRS", 
                                                              "WALKING_DOWNSTAIRS", "SITTING", 
                                                              "STANDING","LAYING") )
                
                rm( list = c("activity", "count","idx_activity","Features_Mean",
                             "idx_subject","subject","subset_df","Activities_Unique",
                             "Subjects_Unique") )
                
                # 6.3 Save the Output of the DataSet #2 data.frame to a csv file for the 
                # subsequent course requiered submission .
                
                write.csv( My_Dataset_2, file="dataset2.txt", row.names = FALSE )
                