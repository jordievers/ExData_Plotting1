data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#Create DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

#Filter out the 2 days that we will use
data_filter <- data %>% 
  filter(DateTime >= as.POSIXct("2007-02-01 00:00:00") & DateTime < as.POSIXct("2007-02-03 00:00:00"))

data_filter$Global_active_power <- as.numeric(gsub(",", ".", data_filter$Global_active_power))
data_filter$weekday <- wday(data_filter$DateTime, label = TRUE)

plot(data_filter$Global_active_power ~ data_filter$DateTime, 
     type = "l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "")

dev.copy(png, file = "plot2.png")
png("./plot2.png", width = 480, height = 480)
dev.off()