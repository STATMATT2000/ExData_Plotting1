getwd()
setwd("./Exploratory_Data_Analysis/ExData_Plotting1")
getwd()
######################################################################################################
######################################################################################################
## BEGIN take a peek at the Working directory to ensure that files are present and unzipped. 
######################################################################################################
######################################################################################################

if(!file.exists("./data")){dir.create("./data")} 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 

if(!file.exists("./data/household_power_consumption.zip"))
{download.file(fileUrl, destfile="./data/household_power_consumption.zip")}
date()
## Date original file downloaded
## [1] "Wed Sep 09 16:59:32 2015"

## check file is present and unzip  
list.files("./data") 
if(!file.exists("./data/household_power_consumption.txt"))
{unzip("./data/household_power_consumption.zip", exdir="./data")
 list.files("./data")}
## Check estimated memory size
## The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset 
## will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).
## rows * columns * est(bytes per cell)
2075259*9*8/1000000
## [1] 149.4186 Mb
## Yes we have enough space

HPC <- read.table("./data/household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE,  
                  stringsAsFactors=FALSE,
                  colClasses = c("character","character","character","NULL","NULL","NULL","NULL","NULL","NULL") 
                    )

## Check actual memory size
print(object.size(x=lapply(ls(), get)), units="Mb")
## 47.8 Mb
str(HPC)

## Understand Missing Data structure using "?'s"
## Note that in this dataset missing values are coded as ?.
tail(head(HPC,6842),4)
grep("^[/?]",tail(head(HPC,6842),4)$Global_active_power)
## this tells me my grep command is workig correctly it extracted the values that I wanted

## 1. Date: Date in format dd/mm/yyyy
## 2. Time: time in format hh:mm:ss
## 3. Global_active_power: household global minute-averaged active power (in kilowatt)

## We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data 
## from just those dates rather than reading in the entire dataset and subsetting to those dates.
HPC <- HPC[grep("^[1-2]/2/2007", HPC$Date),]

head(HPC)
tail(HPC)
str(HPC)

## Check for missing in subsetted data
grep("^[/?]",HPC$Global_active_power)
## I found that none of the subsetted data is missing. 

## You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
## I'll pass on the strptime and as.Date and use what we learned using lubridate in the Getting and Cleaning Data course
library(lubridate)
HPC$DateTime <- dmy_hms(paste(HPC$Date, HPC$Time))
HPC$Date <- dmy(HPC$Date)
HPC$Time <- hms(HPC$Time)
HPC$Global_active_power <- as.numeric(HPC$Global_active_power)

str(HPC)
head(HPC)
list.files()

######################################################################################################
######################################################################################################
######################################################################################################
## Plot 2
######################################################################################################
######################################################################################################
######################################################################################################
## Take a peek at what it looks like on the screen device
plot(HPC$DateTime, HPC$Global_active_power, ylab = "Global Active Power (kilowatts)",
     type = "l",
     xlab = "")
## Use the PNG device to write the file out
png(filename="plot2.png", width=480, height=480)
plot(HPC$DateTime, HPC$Global_active_power, ylab = "Global Active Power (kilowatts)",
     type = "l",
     xlab = "")
dev.off()
## check to ensure file is in the directory
grep("*.png",list.files(), value=TRUE)