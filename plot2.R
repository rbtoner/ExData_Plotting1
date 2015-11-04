plot2 <- function() {
  
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
  png(filename="plot2.png")
  
  #New vector with Date + Time:
  fulltime <- strptime(paste(mytable$Date,mytable$Time),"%d/%m/%Y %H:%M:%S")
  
  #Plot the histogram:
  with(mytable,plot(fulltime,Global_active_power,type="l",
                    ylab="Global Active Power (kilowatts)",xlab=""))
  
  #Close the device:
  dev.off()
  
  }
