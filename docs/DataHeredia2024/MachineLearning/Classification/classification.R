library(dplyr)
library(readr)

#install.packages('caret')
#library(caret)

dat <- read.csv("./data.csv")
glimpse(dat)

#Convert <chr> to <fct>
names <- c(1,2,3,4,5,11,12)
dat[,names] <-lapply(dat[,names], factor)
glimpse(dat)

# Step 1) Check continuous variables

continuous <-select_if(dat, is.numeric)
summary(continuous)

# Histogram with kernel density curve
library(ggplot2)
ggplot(continuous, aes(x = ApplicantIncome)) +
  geom_density(alpha = .5, fill = "#FF6666")

applicant_income <- quantile(dat$ApplicantIncome, .98)
applicant_income


dat_drop <- dat %>%
  filter(ApplicantIncome<applicant_income)
dim(dat_drop)


dat_rescale <- dat_drop %>%
  mutate_if(is.numeric, funs(as.numeric(scale(.))))
head(dat_rescale)


# Select categorical column
factor <- data.frame(select_if(dat_rescale, is.factor))
ncol(factor)

library(ggplot2)
# Create graph for each column
graph <- lapply(names(factor),
                function(x) 
                  ggplot(factor, aes(get(x))) +
                  geom_bar() +
                  theme(axis.text.x = element_text(angle = 90)))



graph

# Plot Gender Loan Status 
ggplot(dat_rescale, aes(x = Gender, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic()


# Plot Education Loan_status
ggplot(dat_rescale, aes(x = Education, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90))

# Plot Credit_history Loan_status
ggplot(dat_rescale, aes(x = Property_area, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90))


library(ggplot2)
ggplot(dat_rescale, aes(x = ApplicantIncome, y = Loan_amount)) +
  geom_point(aes(color = Loan_status),
             size = 0.5) +
  stat_smooth(method = 'lm',
              formula = y~poly(x, 2),
              se = TRUE,
              aes(color = Loan_status)) +
  theme_classic()

#install.packages('GGally')
library(GGally)
# Convert data to numeric
corr <- data.frame(lapply(dat_rescale, as.integer))
# Plot the graph
ggcorr(corr, 
method = c("pairwise", "spearman"),
nbreaks = 6,
hjust = 0.8,
label = TRUE,
label_size = 3,
color = "grey50")



library(caret)
set.seed(1234)

trainIndex <- createDataPartition(dat$Loan_status, p = 0.7, list = FALSE, times = 1)

trainData <- dat[trainIndex,]
testData <- dat[-trainIndex,]

print(dim(trainData)); print(dim(testData))

model_glm = glm(Loan_status~., family="binomial", data = trainData)
summary(model_glm)

#Baseline Accuracy
prop.table(table(trainData$Loan_status))

# Predictions on the training set
predictTrain <- predict(model_glm, trainData, type = "response")

# Confusion matrix on training data
train_mat <- table(trainData$Loan_status, predictTrain >= 0.5)

train_mat

# Accuracy of the training data
accuracy_train <- sum(diag(train_mat)) / sum(train_mat)
accuracy_train

model_glm = glm(Loan_status~., family="binomial", data = testData)
summary(model_glm)

#Baseline Accuracy
prop.table(table(testData$Loan_status))

# Predictions on the test set
predictTest = predict(model_glm, data = testData, type = "response")

# Confusion matrix on test data
test_mat <- table(testData$Loan_status, predictTest >= 0.5)
test_mat

# Accuracy of the test data
accuracy_test <- sum(diag(test_mat)) / sum(test_mat)
accuracy_test

(30+122)/nrow(testData)

