######################################
## Download file and unzip, read data
######################################
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="powerconsumption.zip", method="curl")
unzip("powerconsumption.zip")
rawdata <- read.table("household_power_consumption.txt", header=TRUE,
                      sep=";", na.strings="?")

######################################
## create new column datetime with both date and time
## filter data from  2007-02-01 and 2007-02-02
######################################
library(dplyr)
tidydata <- mutate(rawdata, datetime = 
                     strptime(paste(Date, Time, sep=" "),  
                              format = "%d/%m/%Y %H:%M:%S"))
tidydata <- filter(tidydata, datetime >= "2007-02-01" & datetime <"2007-02-03")
rm(rawdata)

#####################################
## plot 2x2 plots
######################################

png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2))
## plot 1
plot(tidydata$datetime, tidydata$Global_active_power, 
     ylab = "Global Active Power", xlab="", type="n")
lines(tidydata$datetime, tidydata$Global_active_power, type="l")
## plot 2
plot(tidydata$datetime, tidydata$Voltage, xlab="datetime",
     ylab = "Global Active Power", type="n")
lines(tidydata$datetime, tidydata$Voltage, type="l")
## plot 3
plot( tidydata$datetime, tidydata$Sub_metering_1,
      ylab = "Energy sub metering", xlab="", type="n")
lines(tidydata$datetime, tidydata$Sub_metering_1, col="black", type="l")
lines(tidydata$datetime, tidydata$Sub_metering_2, col="red", type="l")
lines(tidydata$datetime, tidydata$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lty=c(1,1,1))
## plot 4
plot(tidydata$datetime, tidydata$Global_reactive_power, xlab="datetime",
     ylab = "Global_reactive_power", type="n")
lines(tidydata$datetime, tidydata$Global_reactive_power, type="l")
dev.off()