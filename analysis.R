# Load libraries
library(tidyverse)
library(caret)
library(randomForest)
library(ggcorrplot)

# Read dataset
data <- read.csv("data.csv")

# Check data
str(data)
anyNA(data)
sum(duplicated(data))

# Preprocessing
temp_data <- data %>%
  mutate(
    infill_pattern = as.numeric(infill_pattern != "grid"),
    material = as.numeric(material != "abs")
  )

# Summary statistics
summary(temp_data)

# Scatter plot example
plot(temp_data$layer_height, temp_data$roughness,
     main="Layer Height vs Roughness",
     xlab="Layer Height", ylab="Roughness")

# Train Random Forest model
set.seed(123)
rf_model <- train(roughness ~ ., data=temp_data, method="rf")

print(rf_model)