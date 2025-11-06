library(readr) #package for importing files

wisc_bc_data <- read.csv("wisc_bc_data.csv",stringsAsFactors = FALSE) #importing the dataset 
str(wisc_bc_data)  # checking the data structure
wisc_bc_data <- wisc_bc_data[-1]  # dropped unnecessary columns to improve data quality 

#table of diagonsis
table(wisc_bc_data$diagnosis)

#recode diagonsis as a factor
wisc_bc_data$diagnosis <- factor(wisc_bc_data$diagnosis, levels = c("B", "M"),
                                 labels = c("Benign", "Malignant"))

#finding the percentage of the diagonsis
round(prop.table(table(wisc_bc_data$diagnosis)) * 100, digits = 1)

#summary of three numerical features
summary(wisc_bc_data[c("radius_mean", "area_mean", "smoothness_mean")])

#create normalization function
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# test normalization function - result should be identical
normalize(c(1,2,3,4,5))
normalize(c(10,20,30,40,50))

# normalize that wisc_bc_data
wisc_bc_data_n = as.data.frame(lapply(wisc_bc_data[2:31], normalize))

#create training and test data
wisc_bc_data_train = wisc_bc_data_n[1:469,]
wisc_bc_data_test = wisc_bc_data_n[470:569,]

# create labels for traning and test data
wbcd_train_labels = wisc_bc_data[1:469,1]
wbcd_test_labels = wisc_bc_data[470:569,1]

### step 3 training the models

# load the"class" library
library(class)


wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 21)


##step 4: Evaluating model performance

#load the "gmodels" library
library(gmodels)

#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

## Step 5 : Improving model performance ----

#retesting the models

wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 5)

#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 11)
#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 15)
#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 23)
#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)

wbcd_test_pred = knn(train = wisc_bc_data_train, test = wisc_bc_data_test,
                     cl = wbcd_train_labels, k = 27)
#create the cross tabulation of predicted vs actual
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq=FALSE)



