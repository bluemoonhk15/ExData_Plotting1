## first install.package("sqldf") for csv file sql query
library(sqldf)
## by default data source file is in working directory
plot2 <- function(file = "household_power_consumption.txt") {
    if(!file.exists(file)) {
        stop("file doesn't exist!")
    }
    mydata <- read.csv.sql(file, 
                           sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                           sep = ";", header = TRUE)
    closeAllConnections()
    
    png(file="plot2.png")
    dt <- strptime(paste(mydata$Date, mydata$Time), format = "%d/%m/%Y %H:%M:%S")
    plot(dt, mydata$Global_active_power, type = "n", 
         xlab = NA, ylab = "Global Active power (kilowatts)")
    lines(dt, mydata$Global_active_power)
    dev.off()
}