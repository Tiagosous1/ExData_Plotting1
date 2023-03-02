#creating plot 2
plot(household_clean$Global_active_power~household_clean$Date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#saving plot 2
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()