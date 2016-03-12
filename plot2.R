library("knitr")
opts_chunk$set(echo = TRUE, results = 'hold')

library("xtable")
library("ggplot2")

unzip("exdata_data_household_power_consumption.zip")
rawdata <- read.csv("household_power_consumption.txt", sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
dim(rawdata)
summary(rawdata)

rawdata$Date <- as.Date(rawdata$Date, format="%d/%m/%Y") 
subSetData <- rawdata[(rawdata$Date=="2007-02-01") | (rawdata$Date=="2007-02-02"),]

subSetData$Global_active_power <- as.numeric(as.character(subSetData$Global_active_power))
subSetData$Global_reactive_power <- as.numeric(as.character(subSetData$Global_reactive_power))
subSetData$Voltage <- as.numeric(as.character(subSetData$Voltage))
subSetData <- transform(subSetData, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

subSetData$Sub_metering_1 <- as.numeric(as.character(subSetData$Sub_metering_1))
subSetData$Sub_metering_2 <- as.numeric(as.character(subSetData$Sub_metering_2))
subSetData$Sub_metering_3 <- as.numeric(as.character(subSetData$Sub_metering_3))

plot2 <- function() {
    plot(
        subSetData$timestamp,
        subSetData$Global_active_power,
        type = "l",
        xlab = "",
        ylab = "Global Active Power (kilowatts)"
    )
    dev.copy(png,
             file = "plot2.png",
             width = 480,
             height = 480)
    dev.off()
    cat("plot2.png has been saved in", getwd())
}
plot2()