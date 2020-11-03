library(dplyr)
household_power_consumption <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?",
                                         colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
consumption <- as_tibble(household_power_consumption) %>%
  mutate(datetime = as.POSIXct(strptime(paste(Date, Time), tz="", format = "%d/%m/%Y %H:%M"))) %>%
  filter(datetime >= as.POSIXct("2007-02-01") & datetime < as.POSIXct("2007-02-03")) 

png("plot4.png")
par(mfcol=c(2,2))
with(consumption, plot(Global_active_power ~ datetime, type="n", xlab="", ylab="Global Active Power"))
with(consumption, lines(Global_active_power ~ datetime))

with(consumption, plot(Sub_metering_1 ~ datetime, type="n", xlab="", ylab="Energy sub metering"))
with(consumption, lines(Sub_metering_1 ~ datetime))
with(consumption, lines(Sub_metering_2 ~ datetime,  col="red"))
with(consumption, lines(Sub_metering_3 ~ datetime, col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= c(1,1, 1), col=c("black","red","blue"))

with(consumption, plot(Voltage ~ datetime, type="n"))
with(consumption, lines(Voltage ~ datetime))

with(consumption, plot(Global_reactive_power ~ datetime, type="n"))
with(consumption, lines(Global_reactive_power ~ datetime))


dev.off()
