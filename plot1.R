dataSet = "../household_power_consumption.txt"

## to read date in a specific format 
## https://stackoverflow.com/questions/13022299/specify-date-format-for-colclasses-argument-in-read-table-read-csv
# setAs("character","myDate", function(from) as.Date(from, format="%d:%m:%Y"))
# tmp2 <- read.csv(con, colClasses=c('numeric','myDate'))
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S"))

f <- read.table(dataSet,
                sep=";",
                na.strings="?",
                header = TRUE,
                col.names = c("Date",
                              "Time",
                              "Global_active_power",
                              "Global_reactive_power",
                              "Voltage",
                              "Global_intensity",
                              "Sub_metering_1",
                              "Sub_metering_2",
                              "Sub_metering_3"),
                colClass= c("myDate",
                            "myTime",
                            "integer",
                            "integer",
                            "integer",
                            "integer",
                            "integer",
                            "integer",
                            "integer"))
## to coerce a col in df
#df[,i] <- as.numeric(df[,i])


## filter out the data and plot it
data <- f[f$Date >= as.Date("2007-02-01") & f$Date <= as.Date("2007-02-02"),]

## copy the plot to png file
png(file="plot1.png",width = 480, height = 480, units = "px",bg="transparent")
hist(data$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatt)")
dev.off()
