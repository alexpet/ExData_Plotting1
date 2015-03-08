#
# ------------------------------------------------------------------------------
#
# Exploratory Data Analysis Project 1
# Plot 1
#
# ------------------------------------------------------------------------------
#
# written by: Alexander Petkovski
# 
# Description:
# Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#    if file does not existing in the current working data directory.
# Extracts the text file into data
# Loads the data and processes date columns
# Produces the required plot in png format for the plot
#
# WARNING: Script will clear any local variables
#

# Clear local variables
print("Clear local variables...")
rm(list = ls())

# URL variable for files to download and filename
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFileName <- "./data/household_power_consumption.zip"
destFolder <- "./data"
dataFileName <- "./data/household_power_consumption.txt"
plotFileName <- "./plot1.png"

# Delete the plot if it exists
if(file.exists(plotFileName)) {
        # Download and unzip file
        print("Deleting the existing plot...")
        file.remove(plotFileName)
}

# Create data directory if necessary
if(!file.exists(destFolder)) {
        # Download and unzip file
        print("Creating data directory...")
        dir.create(destFolder)
}

# Download file and unzip if it doesn't exist
if(!file.exists(destFileName)) {
        # Download file
        print("Dowloading file...")
        download.file(fileUrl, destFileName)
}

# Download file and unzip if it doesn't exist
if(!file.exists(dataFileName)) {
        # Unzip file
        print("Unzipping the file...")
        unzip(destFileName, exdir = destFolder)
}

# Read into data
print("Reading the data...")
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Fix date columns
print("Adjusting date columns...")
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(strptime(data$Date, "%d/%m/%Y"))

# Keep only dates needed
print("Keeping ony required dates...")
data <- data[data$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

# Plot the histogram to a PNG file
print("Plotting to a png file...")
png(plotFileName)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

# Clear all local variables
print("Removing local variables...")
rm(list = ls())

print("All done!")