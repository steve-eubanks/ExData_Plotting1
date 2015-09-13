# This R file contains the code to download a data file, read the data into R and produce
# Plot 3 as assigned in Course Project 1 in the class Exploratory Data Analysis

# First, download the file using the URL provided in the project instructions
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.txt")

# Then read the data into a table named 'pdatap
pdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# Create a timestamp column by combining the Date and Time columns.  This allows us to easily produce
# a plot with weekdays in the x axis as required by the instructions.
pdata$timestamp <- as.POSIXct(paste(pdata$Date, pdata$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")

# Convert the Time column using strptime() and the Date column using as.Date() because the project
# instructions told us to do so.
pdata$Time <- strptime(pdata$Time,"%H:%M:%S")
pdata$Date <- as.Date(pdata$Date, "%d/%m/%Y")

# Create a subset of pdata because the project requires that the plots use data from only two
# days within the dataset.  Working with the subset also improves performance of the plots
subp <- subset(pdata, Date >= "2007-02-01" & Date <= "2007-02-02")

#
#Create Plot 3 using the plot() function
#
#First, open a screen device to build the plot and display it on the screen
windows()

# Create the initial plot of the Sub_metering_1 variable using the plot() command
with(subp, plot(timestamp,Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))

# Use the points() commands to add Sub_metering_2 and _3 in their appropriate colors
with(subp, points(timestamp,Sub_metering_2, type="l", col="red"))
with(subp, points(timestamp,Sub_metering_3, type="l", col="blue"))

# Add a legend to the top right corner of the plot
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Turn off the screen device
dev.off()

# Turn on a png device to create the png file for Plot 3.  Using the dev.copy() command caused
# the legend to be improperly formatted.  
png("plot3.png")
with(subp, plot(timestamp,Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering"))
with(subp, points(timestamp,Sub_metering_2, type="l", col="red"))
with(subp, points(timestamp,Sub_metering_3, type="l", col="blue"))
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()