# plot 3

library(data.table)
library(readr)
library(lubridate)
library(dplyr)
library(chron)
library(ggplot2)
options(digits=9)

household1 <- fread(cmd = "grep 1/2/2007 household_power_consumption.txt")
household1 <- rename(household1, "Date" = "V1", "Time" = "V2", "Global_active_power" = "V3", "Global_reactive_power" = "V4",
                     "Voltage" = "V5", "Global.intensity" = "V6", "sub1" = "V7", "sub2" = "V8", "sub3" = "V9")
household1 <- subset(household1, Date == "1/2/2007")

household2 <- fread(cmd = "grep 2/2/2007 household_power_consumption.txt")
household2 <- rename(household2, "Date" = "V1", "Time" = "V2", "Global_active_power" = "V3", "Global_reactive_power" = "V4",
                     "Voltage" = "V5", "Global.intensity" = "V6", "sub1" = "V7", "sub2" = "V8", "sub3" = "V9")
household2 <- subset(household2, Date == "2/2/2007")

household <- rbind(household1, household2)
household <- as.data.frame(household)

household$Date <- as.Date(household$Date, "%d/%m/%Y")
household$Time <- strptime(household$Time, "%H:%M:%S")

household <- transform(household, 
                       Global_active_power = as.numeric(Global_active_power),
                       Global_reactive_power = as.numeric(Global_reactive_power),
                       Voltage = as.numeric(Voltage),
                       Global.intensity = as.numeric(Global.intensity),
                       sub1 = as.numeric(sub1),
                       sub2 = as.numeric(sub2))
household$day <- weekdays(household$Date)

png(file="plot3.png",width=480,height=480)
plot(as.numeric(household$Time), household$sub1, type = "l", xaxt = 'n',
     ylab = "Energy sub metering", xlab = "Thursday\t\t\t\t\t\t\t\t\t\t\t\tFriday\t\t\t\t\t\t\t\t\t\tSaturday")
points(as.numeric(household$Time), household$sub2, type = "l", xaxt = 'n', col = "red")
points(as.numeric(household$Time), household$sub3, type = "l", xaxt = 'n', col = "blue")
dev.off()

