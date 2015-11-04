plot1 <- function() {
  
  #Make sure data.table library is available for fread:
  require(data.table)
  
  #Load the table (using fread) for 2007-02-01 and 2007-02-02
  mytable <-fread("household_power_consumption.txt",sep=";",
                  skip=66637,nrow=2880,header=FALSE,
                  na.strings="?")
  
  #Get the header information, as this was lost in the row skip:
  myheader <- fread("household_power_consumption.txt",sep=";",
                    nrows = 1, header = FALSE,stringsAsFactors = FALSE)
  
  #Set the column names:
  colnames( mytable ) <- unlist(myheader)
  
  #Open PNG file device:
  png(filename="plot1.png")
  
  #Plot the histogram:
  with(mytable,hist(Global_active_power,xlab="Global Active Power (kilowatts)",
                    col="red",main="Global Active Power"))
  
  #Close the device:
  dev.off()
  
  }
