# Exploratory Data Analysis 
# Project 1
# Plot 3

if (file.exists("exdata_data_household_power_consumption.zip") == FALSE){
    print("Data not found - downloading")
    fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url=fileUrl, destfile="exdata_data_household_power_consumption.zip")
} 

if (file.exists("household_power_consumption.txt") == FALSE){
    print("Unzipping")
    unzip(zipfile="exdata_data_household_power_consumption.zip")
}

household_power_consumption = read.csv("household_power_consumption.txt", sep=";", stringsAsFactors=FALSE)

# Subset data to between: 2007-02-01 and 2007-02-02
alldates = as.Date(household_power_consumption$Date,format = "%d/%m/%Y")
dates = (alldates >= "2007-02-01") & (alldates <= "2007-02-02")
plotdata = household_power_consumption[dates==TRUE,]

# Create datetime from first two columns
datetime = strptime(paste(plotdata$Date,plotdata$Time),format='%d/%m/%Y %H:%M:%S')

# Create submetering variables
Sub_metering_1 = as.numeric(plotdata$Sub_metering_1)
Sub_metering_2 = as.numeric(plotdata$Sub_metering_2)
Sub_metering_3 = as.numeric(plotdata$Sub_metering_3)

# Plot to file
png(filename = "plot3.png", width = 480, height = 480)
plot(datetime,Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
    points(datetime,Sub_metering_2,type="l", col = "red")
    points(datetime,Sub_metering_3,type="l", col = "blue")
    legend("topright", lwd = 1, col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

print("Complete")