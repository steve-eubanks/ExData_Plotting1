# This R file contains the code to download a data file, read the data into R and produce
# Plot 2 as assigned in Course Project 1 in the class Exploratory Data Analysis

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
#Create Plot 2 using the plot() function
#
#First, open a screen device to build the plot and display it on the screen
windows()

# Create the plot
with(subp, plot(timestamp,Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Copy the plot to a png device in order to output a png file
dev.copy(png, file="plot2.png")

# Tidy up
dev.off()