library(dplyr)
 household_power_consumption <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?",
   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- as_tibble(household_power_consumption) %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), tz="", format = "%d/%m/%Y %H:%M"))) %>%
  filter(datetime >= as.POSIXct("2007-02-01") & datetime < as.POSIXct("2007-02-03")) 

png("plot1.png")

hist(consumption$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
