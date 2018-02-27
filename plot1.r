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

## Plotting first graphic
par(mfrow=c(1,1), mar=c(4,4,2,2), oma=c(0,0,1,0))
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()
