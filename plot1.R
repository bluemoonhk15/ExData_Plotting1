## first install.package("sqldf") for csv file sql query
library(sqldf)
## by default data source file is in working directory
plot1 <- function(file = "household_power_consumption.txt") {
    if(!file.exists(file)) {
        stop("file doesn't exist!")
    }
    mydata <- read.csv.sql(file, 
                           sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", 
                           sep = ";", header = TRUE)
    closeAllConnections()
    
    png(file="plot1.png")
    hist(mydata$Global_active_power, col = "red", 
         xlab = "Global Active Power (kilowatts)", 
         main = "Global Active Power")
    dev.off()
}