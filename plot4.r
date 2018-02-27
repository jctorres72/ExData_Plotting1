## Loading dataset
data <- read.table("./../household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Formating date 
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subseting data from Feb. 1 2007 to Feb. 2 2007
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Merging Date and Time columns
dateTime <- paste(data$Date, data$Time)

## Naming the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
data <- data[,-1]
data <- data[,-1]

## Add DateTime column
data <- cbind(dateTime, data)

## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

## Plotting fourth graphic
par(mfrow=c(2,2), mar=c(4,4,2,2), oma=c(0,0,1,0))
with(data, {
  plot(data$Global_active_power~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(data$Voltage~dateTime, type="l", ylab="Voltage (volt)", xlab="")
  plot(data$Sub_metering_1~dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(data$Sub_metering_2~dateTime,col='Red')
  lines(data$Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(data$Global_reactive_power~dateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
