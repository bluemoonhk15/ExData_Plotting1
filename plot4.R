## first install.package("sqldf") for csv file sql query
library(sqldf)
## by default data source file is in working directory
plot4 <- function(file = "household_power_consumption.txt") {
    if(!file.exists(file)) {
        stop("file doesn't exist!")
    }
    mydata <- read.csv.sql(file, 
                           sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                           sep = ";", header = TRUE)
    closeAllConnections()
    
    png(file="plot4.png")
    dt <- strptime(paste(mydata$Date, mydata$Time), format = "%d/%m/%Y %H:%M:%S")
    par(mfrow = c(2, 2))
    #1
    plot(dt, mydata$Global_active_power, type = "n", xlab = NA, ylab = "Global Active Power")
    lines(dt, mydata$Global_active_power)
    #2
    plot(dt, mydata$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
    lines(dt, mydata$Voltage)
    #3
    plot(dt, mydata$Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
    lines(dt, mydata$Sub_metering_1)
    lines(dt, mydata$Sub_metering_2, col = "red")
    lines(dt, mydata$Sub_metering_3, col = "blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"), lty = 1, box.lty = 0)
    #4
    plot(dt, mydata$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
    lines(dt, mydata$Global_reactive_power)
    dev.off()
}