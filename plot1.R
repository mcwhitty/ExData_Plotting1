#Plot 1

# Global variable for data file
data_file="household_power_consumption.txt"
data_archive="power_consumption.zip"
data_file_url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download dataset if the file doesn't exist
if (!is_file(data_archive)) {download.file(data_file_url, data_archive)}
if (!is_file(data_file)) {unzip(data_archive)}

# Load the full data set into a table
powerData <- read.table(data_file, header = TRUE, sep = ";",  na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))

# Fix Date column data
powerData$Date <- as.Date(powerData$Date, "%d/%m/%Y")

# Subset the data to focus on data from the dates 2007-02-01 and 2007-02-02
myPD <- powerData[(powerData$Date >= "2007-02-01" & powerData$Date <= "2007-02-02"),]

# Add new leading column that will hold dateTime field and populate with combination of Date and Time fields
myPD <- cbind(DateTime = "", myPD)
myPD$DateTime <- paste(myPD$Date, myPD$Time, sep=" ")

# Modify DateTime field to be of Date/Time class
myPD$DateTime <- strptime(myPD$DateTime, format = "%Y-%m-%d %H:%M:%S")

# Create file device that plot will be written to
png("plot1.png", width = 480, height = 480)

# Create necessary plot
hist(subsetPD$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="Red")

# Close dev 
dev.off() 
