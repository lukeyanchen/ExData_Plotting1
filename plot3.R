### Download file if does not exist ###
filename <- "exdata-data-household_power_consumption.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

### Read data ###
data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")

### Reformat date ###
data$Date <- as.Date(strptime(as.character(data$Date),format='%d/%m/%Y'))

### Choose only 2007-02-01 and 2007-02-02
data_small <- data[ which(data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02")), ]

### Add datetime ###
data_small$datetime <- strptime(paste(as.character(data_small$Date),data_small$Time),format="%Y-%m-%d %H:%M:%S")

### Plot graph ###
png("plot3.png",width=480,height=480)
with(data_small,plot(datetime,Sub_metering_1,type='l',xlab=NA,ylab="Energy sub metering"))
with(data_small,lines(datetime,Sub_metering_2, col = "red"))
with(data_small,lines(datetime,Sub_metering_3, col = "blue"))
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()