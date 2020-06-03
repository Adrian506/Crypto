crypto<-read.csv("crypto-markets.csv")

summary(crypto)

cryptoBITS<-crypto[(crypto$symbol=="BITS"),]
cryptoPXC<-crypto[(crypto$symbol=="PXC"),]
cryptoBTB<-crypto[(crypto$symbol=="BTB"),]
cryptoBTM<-crypto[(crypto$symbol=="BTM"),]
cryptoBTC<-crypto[(crypto$symbol=="BTC"),]
cryptoLTC<-crypto[(crypto$symbol=="LTC"),]

str(cryptoBITS)



# Library
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(tidyverse)
library(lubridate)

# Read the data (hosted on the gallery website)


# Check type of variable
# str(data)

# Since my time is currently a factor, I have to convert it to a date-time format!
cryptoBITS$date <- as.Date(cryptoBITS$date)

# Then you can create the xts necessary to use dygraph
don <- xts(x = cryptoBITS$close, order.by = cryptoBITS$date)

# Finally the plot
 m<-dygraph(don) %>%
  dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
  dyRangeSelector() %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
  dyRoller(rollPeriod = 1)
dygraph(p)
# save the widget
# library(htmlwidgets)
# saveWidget(p, file=paste0( getwd(), "/HtmlWidget/dygraphs318.html"))




# Since my time is currently a factor, I have to convert it to a date-time format!
cryptoBTC$date <- as.Date(cryptoBTC$date)
cryptoBITS$date <- as.Date(cryptoBITS$date)
cryptoBTB
cryptoBTM
cryptoLTC
cryptoPXC
# Then you can create the xts necessary to use dygraph
don1 <- xts(x = cryptoBTC$close, order.by = cryptoBTC$date)

# Finally the plot
p<-dygraph(don1) %>%
  dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
  dyRangeSelector() %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
  dyRoller(rollPeriod = 1)%>%
  dyHighlight(highlightCircleSize = 5, 
              highlightSeriesBackgroundAlpha = 0.2,
              hideOnMouseOut = FALSE)
grapg<-cbind(p,m)
dygraph(grapg)


?dygraph


y<-cbind.data.frame(cryptoBITS$date[1:2042],cryptoBITS$close[1:2042], cryptoBTB$close[1:2042], cryptoBTC$close[1:2042], cryptoBTM$close[1:2042],cryptoLTC$close[1:2042],cryptoPXC$close[1:2042])
colnames(y)<-c("date","BITS","BTB","BTC","BTM","LCT","PXC")

dygraph(y, main = "patata") %>%
  dyHighlight(highlightCircleSize = 5, 
              highlightSeriesBackgroundAlpha = 0.2,
              hideOnMouseOut = FALSE)
