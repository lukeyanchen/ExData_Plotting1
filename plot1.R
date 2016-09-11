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

### Plot graph ###
png("plot1.png",width=480,height=480)
with(data_small,hist(Global_active_power,xlab="Global Active Power (kilowatts)", main="Global Active Power",c="red"))
dev.off()