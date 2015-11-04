plot4 <- function() {
    
  #Make sure data.table library is available for fread:
  require(data.table)
  
  #Load the frame (using fread) for 2007-02-01 and 2007-02-02
  mytable <-fread("household_power_consumption.txt",sep=";",
                  skip=66637,nrow=2880,header=FALSE,
                  na.strings="?")
  
  #Get the header information, as this was lost in the row skip:
  myheader <- fread("household_power_consumption.txt",sep=";",
                    nrows = 1, header = FALSE,stringsAsFactors = FALSE)
  
  #Set the column names:
  colnames( mytable ) <- unlist(myheader)
  
  #Open PNG file device:
  png(filename="plot4.png")
  
  #New vector with Date + Time:
  fulltime <- strptime(paste(mytable$Date,mytable$Time),"%d/%m/%Y %H:%M:%S")

  #Fill 2x2 by column:
  par(mfcol=c(2,2))

  #PLOT 1-----------------
  with(mytable,plot(fulltime,Global_active_power,type="l",
                    ylab="Global Active Power",xlab=""))

  #PLOT 2-----------------
  #Plot without drawing points::
  with(mytable,plot(fulltime,Sub_metering_1,type="n",
                    ylab="Energy sub metering",xlab=""))  

  #Add sub-metering 1:
  with(mytable,points(fulltime,Sub_metering_1,type="l",xlab=""))
  #Add sub-metering 2:
  with(mytable,points(fulltime,Sub_metering_2,type="l",xlab="",col="red"))
  #Add sub-metering 3:
  with(mytable,points(fulltime,Sub_metering_3,type="l",xlab="",col="blue"))

  #Add a legend:
  legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         lty="solid",bty="n")

  #PLOT 3-----------------
  with(mytable,plot(fulltime,Voltage,type="l",
                    ylab="Voltage",xlab="datetime"))

  #PLOT 4-----------------
  with(mytable,plot(fulltime,Global_reactive_power,type="l",
                    ylab="Global_reactive_power",xlab="datetime"))
  
  #Close the device:
  dev.off()
  
  }
