# Breast Cancer Classification using K-Nearest Neighbors (KNN)

 A practical machine learning project in **R** applying **KNN** to predict breast cancer diagnoses with real-world medical data.

## Overview
This project builds a **K-Nearest Neighbors (KNN)** classification model using the **Wisconsin Breast Cancer Dataset**.  
The goal is to accurately classify tumors as **Benign** or **Malignant** based on cell nucleus features.  

The project demonstrates:
- Data preprocessing and cleaning  
- Normalization of numerical variables  
- Model training using KNN  
- Evaluation and optimization for best accuracy  

## Objective
Develop a reliable KNN model that can distinguish between **Benign** and **Malignant** breast tumors to support early cancer detection and diagnosis.

## Dataset
**Source:** [UCI Machine Learning Repository – Breast Cancer Wisconsin Dataset](https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+(Diagnostic))  
**Features:** 30 numerical attributes describing cell nucleus characteristics (e.g., radius, texture, area, smoothness).  
**Target Variable:**  
- `B` → Benign  
- `M` → Malignant  

---

## ⚙️ Workflow

### 1. Data Preparation

wisc_bc_data <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

wisc_bc_data <- wisc_bc_data[-1] # remove ID column for irrelevant data

wisc_bc_data$diagnosis <- factor(wisc_bc_data$diagnosis, levels = c("B", "M"),
                                 labels = c("Benign", "Malignant"))


### 2. Scaling the Dataset
scaling the dataset for accurate distance computation
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

wisc_bc_data_n <- as.data.frame(lapply(wisc_bc_data[2:31], normalize))

### 3. Train & Test Split
Spliting the dataset into two parts
| Dataset  | Observations |
| -------- | ------------|
| Training | 469          |
| Testing  | 100          |

wisc_bc_data_train <- wisc_bc_data_n[1:469, ]

wisc_bc_data_test  <- wisc_bc_data_n[470:569, ]

### 4. Model Training
library(class)
wbcd_test_pred <- knn(train = wisc_bc_data_train,
                      test = wisc_bc_data_test,
                      cl = wisc_bc_data[1:469, 1],
                      k = 21)

### 5. Evaluating the model
library(gmodels)
CrossTable(x = wisc_bc_data[470:569, 1], y = wbcd_test_pred, prop.chisq = FALSE)

### 6.Optimization
Tested different k values (5, 11, 15, 21, 23, 27) to find the best accuracy balance.

Key libraries/Packages
| Library   | Purpose                           |
| --------- | --------------------------------- |
| `readr`   | Data import and cleaning          |
| `class`   | Implements the KNN algorithm      |
| `gmodels` | Evaluation using cross-tabulation |

 Model Results
| Metric            | Description                                         |
| --------| --------------------------------------------------- |
| Accuracy| High performance achieved with `k = 11–15`          |
| Balance | Good trade-off between sensitivity and specificity  |
| Effect of Scaling | Normalization significantly improved model accuracy |

- Most test samples correctly classified as Benign or Malignant.
- Model generalizes well to unseen data.

  ### Model Accuracy Calculation

The accuracy of the KNN model was computed by comparing the predicted labels with the actual test labels:


# Calculate model accuracy
accuracy <- mean(wbcd_test_pred == wbcd_test_labels)
print(paste("Model Accuracy:", round(accuracy * 100, 2), "%"))
[1] "Model Accuracy: 96.00 %"

The model achieved 96% accuracy , demonstrating strong performance in distinguishing Benign from Malignant cases.

Author

Joshua Ojumola
Data Analyst | Excel | Power BI | R | SQL 
📫 LinkedIn: [https://www.linkedin.com/in/ojumola-adedeji-758471381]
 
📧 Email: [joshuaojumola@gmail.com]
