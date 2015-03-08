#
# ------------------------------------------------------------------------------
#
# Exploratory Data Analysis Project 1
# Plot 4
#
# ------------------------------------------------------------------------------
#
# written by: Alexander Petkovski
# 
# Description:
# Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#    if file does not existing in the current working directory.
# Extracts the text file into data
# Loads the data and processes date columns
# Produces the required plot in png format for the plot
# Note: This script prints to png file only
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
plotFileName <- "./plot4.png"

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

# Plot the 4 graphs along a 2x2 grid to a PNG file
print("Plotting to a png file...")
png(plotFileName)
par(mfrow = c(2,2))
with( data, {
        plot(DateTime, Global_active_power, type = "l", xlab = ""
             , ylab = "Global Active Power")
        plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        plot(DateTime, Sub_metering_1, type = "l", xlab = ""
             , ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_2, type = "l", col = "red")
        lines(DateTime, Sub_metering_3, type = "l", col = "blue")
        legend("topright", c("Sub_metering_1", "Sub_metering_2"
                             , "Sub_metering_3")
               , lty = c(1,1,1), col = c("black","red","blue")
               , cex = 0.5, pt.cex = 1, bty = "n", xjust = 1)
        plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"
             , ylab = "Global_reactive_power")
        }
     )
dev.off()

# Clear all local variables
print("Removing local variables...")
rm(list = ls())

print("All done!")