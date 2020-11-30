######################################
## Download file and unzip, read data
######################################

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="powerconsumption.zip", method="curl")
unzip("powerconsumption.zip")
rawdata <- read.table("household_power_consumption.txt", header=TRUE,
                      sep=";", na.strings="?")

######################################
## Convert column 1 to date, convert column 2 to time
## filter data from  2007-02-01 and 2007-02-02
######################################
library(dplyr)
cleandata <- mutate(rawdata, Date = as.Date(Date, format="%d/%m/%Y"))
cleandata <- filter(cleandata, Date >= "2007-02-01" & Date <"2007-02-03")
cleandata <- mutate(cleandata, Time = strptime(Time, format="%H:%M:%S"))
rm(rawdata)

#####################################
## plot histogram of global active power
######################################

png(filename="plot1.png", width=480, height=480, units="px")
hist(cleandata$Global_active_power, xlab="Global Active Power (kilowatts)", 
     ylab = "Frequency", col="red")
dev.off()



