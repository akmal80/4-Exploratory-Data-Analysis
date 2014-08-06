#Initializes the library
library(data.table)
#Verifies if the file already exists in the directory, otherwise unzip and extract the file
if (!file.exists("./data/household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="./data/household_power_consumption.zip")
    unzip("./data/household_power_consumption.zip", overwrite = T, exdir = "./data")
}
#
# Read all the data
dataAll <- read.csv("household_power_consumption.txt", na.string="?", sep=";", header=TRUE)
# Extract needed dataset
data_12_Feb <- dataAll[(dataAll$Date=="1/2/2007" | dataAll$Date=="2/2/2007"),]
# Format date and hour
data_12_Feb$Datetime <- strptime(paste(data_12_Feb$Date, data_12_Feb$Time), "%d/%m/%Y %H:%M:%S")
rm(dataAll)
#
# Open png device
png("plot2.png", width=480, height=480)
#Plot the graph 2
plot(data_12_Feb$Datetime, data_12_Feb$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")
# Turn off device
dev.off()
