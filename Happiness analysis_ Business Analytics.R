##Objective:
#Perform Linear Regression Analysis to find variables most influential to the happiness of citizens worldwide


##Dataset from:
# https://www.kaggle.com/datasets/ajaypalsinghlo/world-happiness-report-2021
# https://www.kaggle.com/datasets/londeen/world-happiness-report-2020
# https://www.kaggle.com/datasets/unsdsn/world-happiness?select=2018.csv

library(car) #load the car library

happiness <- read.csv("world-happiness-report-2021.csv")
str(happiness)

#Model 1: Multiple linear regression model
happiness.regression <- lm(Ladder.score ~ Log.GDP.per.capita + Social.support + Healthy.life.expectancy + Freedom.to.make.life.choices + Perceptions.of.corruption, data = happiness)
summary(happiness.regression)

#Out-of-sample R-square
test.2020 <- read.csv("world-happiness-report-2020.csv")
predict.2020 <- predict(happiness.regression, newdata=test.2020)
SSE.2020 <- sum((test.2020$Ladder.score - predict.2020)^2)
SST.2020 <- sum((test.2020$Ladder.score - mean(happiness$Ladder.score))^2)
R_squared.2020 <- 1 - SSE.2020/SST.2020

test.2019 <- read.csv("world-happiness-report-2019.csv")
predict.2019 <- predict(happiness.regression, newdata=test.2019)
SSE.2019 <- sum((test.2019$Ladder.score - predict.2019)^2)
SST.2019 <- sum((test.2019$Ladder.score - mean(happiness$Ladder.score))^2)
R_squared.2019 <- 1 - SSE.2019/SST.2019

test.2018 <- read.csv("world-happiness-report-2018.csv")
predict.2018 <- predict(happiness.regression, newdata=test.2018)
SSE.2018 <- sum((test.2018$Ladder.score - predict.2018)^2)
SST.2018 <- sum((test.2018$Ladder.score - mean(happiness$Ladder.score))^2)
R_squared.2018 <- 1 - SSE.2018/SST.2018

#checking for multicollinearity
vif(happiness.regression)
paste("Mean of VIF :" , mean(vif(happiness.regression)))

#Check for correlations
cor(happiness$Log.GDP.per.capita, happiness$Social.support)
cor(happiness$Log.GDP.per.capita, happiness$Healthy.life.expectancy)
cor(happiness$Log.GDP.per.capita, happiness$Freedom.to.make.life.choices)
cor(happiness$Log.GDP.per.capita, happiness$Generosity)
cor(happiness$Log.GDP.per.capita, happiness$Perceptions.of.corruption)

#Model 2: Multiple linear to reduce Multicollinearity
happiness.regression2 <- lm(Ladder.score ~ Log.GDP.per.capita + Freedom.to.make.life.choices + Generosity + Perceptions.of.corruption, data = happiness)
summary(happiness.regression2)
vif(happiness.regression2)
paste("Mean of VIF :" , mean(vif(happiness.regression2)))

#Out-of-sample R-square
predict2.2020 <- predict(happiness.regression2, newdata=test.2020)
SSE2.2020 <- sum((test.2020$Ladder.score - predict2.2020)^2)
R_squared2.2020 <- 1 - SSE2.2020/SST.2020

predict2.2019 <- predict(happiness.regression2, newdata=test.2019)
SSE2.2019 <- sum((test.2019$Ladder.score - predict2.2019)^2)
R_squared2.2019 <- 1 - SSE2.2019/SST.2019

predict2.2018 <- predict(happiness.regression2, newdata=test.2018)
SSE2.2018 <- sum((test.2018$Ladder.score - predict2.2018)^2)
R_squared2.2018 <- 1 - SSE2.2018/SST.2018

#checking for multicollinearity
vif(happiness.regression2)
paste("Mean of VIF :" , mean(vif(happiness.regression2)))
