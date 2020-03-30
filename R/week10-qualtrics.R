# R Studio API
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Libraries
library(tidyverse) # to clean data
library(qualtRics) # to import data from Qualtrics
library(lubridate) # to format dates in POSIXct format

# Data Import and Cleaning
# Authenticate session
token <- "apikeygoeshere"
qualtrics_api_credentials(token, "umn.qualtrics.com")

# Pull survey info
surveys <- all_surveys()

# Create tibble with creationDate
surveys_tbl <- surveys %>%
                  transmute(creationDate = ymd_hms(creationDate)) %>%
                  as_tibble()

# Visualization
# The plot shows the number of surveys created over time. The observations are divided into 30 bins.
ggplot(surveys_tbl, aes(x = creationDate)) +
  geom_histogram() + 
  labs(x = "Date Created", y = "Count")
