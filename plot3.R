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