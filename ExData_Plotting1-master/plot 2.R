#plot 2

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
household$Time <- times(household$Time)

household <- transform(household, 
                       Global_active_power = as.numeric(Global_active_power),
                       Global_reactive_power = as.numeric(Global_reactive_power),
                       Voltage = as.numeric(Voltage),
                       Global.intensity = as.numeric(Global.intensity),
                       sub1 = as.numeric(sub1),
                       sub2 = as.numeric(sub2))
household$day <- weekdays(household$Date)


plot(as.numeric(household$Time), household$Global_active_power, type = "l", xaxt = 'n',
     ylab = "Global Active Power (kilowatts)", xlab = "Thursday\t\t\t\t\t\t\t\t\t\t\t\tFriday\t\t\t\t\t\t\t\t\t\tSaturday")
axis(1, at = 1:max(household$Time), labels=letters[1:10])



