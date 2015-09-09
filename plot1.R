getwd()
setwd("../")
setwd("./Desktop/Coursera/Exploratory_Data_Analysis/ExData_Plotting1")
setwd("C:/Users/Matthew/Desktop/Coursera/Exploratory_Data_Analysis")
getwd()

######################################################################################################
######################################################################################################
## BEGIN take a peek at the Working directory to ensure that files are present and unzipped. 
######################################################################################################
######################################################################################################

if(!file.exists("./data")){dir.create("./data")} 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile="./data/household_power_consumption.zip") 
date()
## Date original file downloaded
## [1] "Wed Sep 09 16:59:32 2015"

## check file is present and unzip  
list.files("./data") 
unzip("./data/household_power_consumption.zip") 
list.files()

## Check estimated memory size
## The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset 
## will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
## rows * columns * est(bytes per cell)
2075259*9*8/1000000
## [1] 149.4186 Mb
## Yes we have enough space

HPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,  stringsAsFactors=FALSE)

## Check actual memory size
print(object.size(x=lapply(ls(), get)), units="Mb")
## 143 Mb
dim(HPC)
str(HPC)

## Understand Missing Data structure using "?'s"
## Note that in this dataset missing values are coded as ?.
tail(head(HPC,6842),4)
grep("^[/?]",tail(head(HPC,6842),4)$Global_reactive_power)
## this tells me my grep command is workig correctly it extracted the values that I wanted
## also notice that Sub_metering_3 has missing values articulated by "NA" instead of "?"

## 1. Date: Date in format dd/mm/yyyy
## 2. Time: time in format hh:mm:ss
## 3. Global_active_power: household global minute-averaged active power (in kilowatt)
## 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## 5. Voltage: minute-averaged voltage (in volt)
## 6. Global_intensity: household global minute-averaged current intensity (in ampere)
## 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
##    It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave 
##    (hot plates are not electric but gas powered).
## 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
##    It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a 
##    refrigerator and a light.
## 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
##    It corresponds to an electric water-heater and an air-conditioner.


## We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
## from just those dates rather than reading in the entire dataset and subsetting to those dates.
HPC <- HPC[grep("^[1-2]/2/2007", HPC$Date),]

head(HPC)
tail(HPC)
str(HPC)
dim(HPC)

## Check for missing in subsetted data
grep("^[/?]",HPC$Global_active_power)
grep("^[/?]",HPC$Global_reactive_power)
grep("^[/?]",HPC$Voltage)
grep("^[/?]",HPC$Global_intensity)
grep("^[/?]",HPC$Sub_metering_1)
grep("^[/?]",HPC$Sub_metering_2)
grep("^[/?]",HPC$Sub_metering_3)
sum(is.na(HPC$Sub_metering_3))
## I found that none of the subsetted data is missing. 

## You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
## I'll pass on the strptime and as.Date and use what we learned using lubridate in the Getting and Cleaning Data course
library(lubridate)
HPC$DateTime <- dmy_hms(paste(HPC$Date, HPC$Time))
HPC$Date <- dmy(HPC$Date)
HPC$Time <- hms(HPC$Time)
HPC$Global_active_power <- as.numeric(HPC$Global_active_power)
HPC$Global_reactive_power <- as.numeric(HPC$Global_reactive_power)
HPC$Voltage <- as.numeric(HPC$Voltage)
HPC$Global_intensity <- as.numeric(HPC$Global_intensity)
HPC$Sub_metering_1 <- as.numeric(HPC$Sub_metering_1)
HPC$Sub_metering_2 <- as.numeric(HPC$Sub_metering_2)
HPC$Sub_metering_3 <- as.numeric(HPC$Sub_metering_3)

str(HPC)
head(HPC)

getwd()
setwd("./ExData_Plotting1")  ## back up working directory to cloned file
getwd()
list.files()
######################################################################################################
######################################################################################################
######################################################################################################
## Plot 1
######################################################################################################
######################################################################################################
######################################################################################################
## Take a peek at what it looks like on the screen device
hist(HPC$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
## Use the PNG device to write the file out
png(filename="plot1.png", width=480, height=480)
hist(HPC$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()
