#creating plot 1
with(household_clean, hist(Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))

#saving plot 1
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()