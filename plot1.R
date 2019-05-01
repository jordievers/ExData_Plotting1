data <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

#Convert Date to date format and filter out the 2 days that we will use
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_filter <- data %>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date( "2007-02-02"))

data_filter$Global_active_power <- as.numeric(gsub(",", ".", data_filter$Global_active_power))

hist(data_filter$Global_active_power, 
     col = "red", 
     ylim = c(0, 1200), 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.copy(png, file = "plot1.png")
png("./plot1.png", width = 480, height = 480)
dev.off()