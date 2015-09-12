#### Data loading and preparing
setwd("C:/Users/Gosia/Desktop/COURSERA/Exploratory_Data_Analysis/exdata_data_household_power_consumption")

data.to.subset <- read.csv("household_power_consumption.txt", nrows=100000,
                           sep=";", header=T, stringsAsFactors=F)
data.gr <- data.to.subset

data.gr$DateTime <- paste(data.gr$Date, data.gr$Time)
data.gr$DateTime <- strptime(data.gr$DateTime, "%d/%m/%Y %H:%M:%S")

r.data <- data.gr[grepl("2007-02-01",data.gr$DateTime),c("DateTime","Global_active_power","Global_reactive_power",
                                                         "Voltage","Global_intensity","Sub_metering_1",
                                                         "Sub_metering_2","Sub_metering_3")]
r.data.2 <- data.gr[grepl("2007-02-02",data.gr$DateTime),c("DateTime","Global_active_power","Global_reactive_power",
                                                           "Voltage","Global_intensity","Sub_metering_1",
                                                           "Sub_metering_2","Sub_metering_3")]

real.data <- rbind(r.data, r.data.2)

for(i in 2:dim(real.data)[2]){
  if(class(real.data[,i])=="character"){
    real.data[,i] <- as.numeric(real.data[,i])
  }
}

png("plot3.png",width=480,height=480)
plot(real.data$DateTime, real.data$Sub_metering_1, type="l",xlab="",
     ylab="Energy sub metering")
lines(real.data$DateTime, real.data$Sub_metering_2, col="red")
lines(real.data$DateTime, real.data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"),lwd=1)
dev.off()