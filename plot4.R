setwd("/Users/jordievers88/Documents/Zelfstudie/Data Science - Johns Hopkins/4. Exploratory Data Analysis")

library(lubridate)
library(dplyr)

data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#Create DateTime column
data$DateTime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$DateTime <- as.POSIXct(data$DateTime)

#Filter out the 2 days that we will use
data_filter <- data %>% 
  filter(DateTime >= as.POSIXct("2007-02-01 00:00:00") & DateTime < as.POSIXct("2007-02-03 00:00:00"))

#Make vectors of metering variables
for (i in 7:8) {
  data_filter[,i] <- as.vector(data_filter[,i])
}

#Make variables numeric
data_filter$Global_active_power <- as.numeric(gsub(",", ".", data_filter$Global_active_power))
data_filter$Global_reactive_power <- as.numeric(gsub(",", ".", data_filter$Global_reactive_power))
data_filter$Voltage <- as.numeric(gsub(",", ".", data_filter$Voltage))

par(mfrow = c(2,2))

#Plot top left
plot(data_filter$Global_active_power ~ data_filter$DateTime, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")

#Plot top right
plot(data_filter$Voltage ~ data_filter$DateTime, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

#Plot bottom left
plot(data_filter$Sub_metering_1 ~ data_filter$DateTime, 
     type = "l", 
     col = "black", 
     ylab = "Energy sub metering", 
     xlab = "")
lines(data_filter$Sub_metering_2 ~ data_filter$DateTime, 
      col = "red")
lines(data_filter$Sub_metering_3 ~ data_filter$DateTime, 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       cex = 0.5,
       lty = 1, 
       bty = "n")

#Plot bottom right
plot(data_filter$Global_reactive_power ~ data_filter$DateTime, 
     type = "l", 
     ylab = "Global_reactive_power", 
     xlab = "datetime")

png(./"plot4.png", width = 480, height = 480)
dev.copy(png, file = "plot4.png")
dev.off()

