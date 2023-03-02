#library needed
library(tidyverse)

#set sys time
Sys.setlocale("LC_TIME", "C")

#loading data
household_data <- read_csv2("household_power_consumption.txt")

#combining colums of date and time
household_data <- unite(household_data, "Date_time", 1:2, sep = " ")

#convert character to time in the column "Date_time"
household_data$Date_time <- strptime(household_data$Date_time, "%d/%m/%Y %H:%M:%S")
household_data$Date_time <- as.POSIXct(household_data$Date_time)

#convert character to number
household_data$Global_active_power <- as.numeric(household_data$Global_active_power)
household_data$Global_reactive_power <- as.numeric(household_data$Global_reactive_power)
household_data$Voltage <- as.numeric(household_data$Voltage)
household_data$Global_intensity <- as.numeric(household_data$Global_intensity)
household_data$Sub_metering_1 <- as.numeric(household_data$Sub_metering_1)
household_data$Sub_metering_2 <- as.numeric(household_data$Sub_metering_2)
household_data$Sub_metering_3 <- as.numeric(household_data$Sub_metering_3)

#Subset the data to 2007-02-01 and 2007-02-02
household_clean <- household_data[household_data$Date_time >= "2007-02-01" & household_data$Date_time < "2007-02-03",]

#remove Na data
household_clean <- household_clean[!is.na(household_clean$Date_time),]

#confirm that are no NA
sum(is.na.data.frame(household_clean))

#Remove old data for geting space in memory
#rm(household_data)

#creating plot 1
with(household_clean, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))

#saving plot 1
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

#creating plot 2
plot(household_clean$Global_active_power~household_clean$Date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#saving plot 2
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#creating plot 3
with(household_clean, {
    plot(Sub_metering_1~Date_time, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Date_time,col='Red')
    lines(Sub_metering_3~Date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#saving plot 3
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

#creating plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(household_clean, {
    plot(Global_active_power~Date_time, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Date_time, type="l", 
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Date_time, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Date_time,col='Red')
    lines(Sub_metering_3~Date_time,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Date_time, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="")
})

#saving plot 4
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()