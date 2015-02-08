dataSet = "../household_power_consumption.txt"

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
                colClass= c("character",
                            "character",
                            "numeric",
                            "numeric",
                            "numeric",
                            "numeric",
                            "numeric",
                            "numeric",
                            "numeric"))
## to coerce a col in df
#df[,i] <- as.numeric(df[,i])
date <- as.Date(f$Date,format="%d/%m/%Y")

## filter out the data and plot it
select <- (date >= as.Date("2007-02-01") & date <= as.Date("2007-02-02"))
data <- f[select,]
datetime <- strptime(paste(data$Date,data$Time,sep= " "), format = "%d/%m/%Y %H:%M:%S")

## copy the plot to png file
png(file="plot4.png",width = 480, height = 480, units = "px",bg="transparent")
par(mfrow=c(2,2))

with(data,{
     plot(datetime,
          Global_active_power,
          type="l",
          ylab="Global Active Power (kilowatt)",
          xlab="")
     plot(datetime,
          Voltage,
          type="l",
          ylab="Voltage")
     plot(datetime,
          data$Sub_metering_1,
          type="l",
          ylab="Global Active Power (kilowatt)",
          xlab="")
     lines(datetime,
           data$Sub_metering_2,
           col="red")
     lines(datetime,
           data$Sub_metering_3,
           col="blue")
     legend("topright",bty="n",
            col=c("black","red","blue"),
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)
     plot(datetime,
          Global_reactive_power,
          type="l",
          ylab="Global Reactive Power (kilowatt)")
})     

dev.off()

