library(shiny)
library(ggplot2)
library(dygraphs)
library(xts)          # To make the convertion data-frame / xts format
library(tidyverse)
library(lubridate)
library(viridis)
library(hrbrthemes)
library(plotly)
shinyServer(function(input, output) {
  
  #leemos los datos
   crypto<-read.csv("crypto-markets.csv") 
  
  #comprobamos estructura
 #str(crypto)
 
 #cambiamos a formato fecha
 crypto$date<- as.Date(crypto$date, format="%Y-%m-%d")
  
 #tipos de monedas distintas
 choices <- data.frame(
   nombres <- levels(crypto$slug),
   num <- 1:length(nombres)
 )
 
  # Lista de monedas para Selectinput
 lista <- as.list(choices$num)
 
 # Name it
 names(lista) <- choices$nombres

 
 #representación#
    output$Plot <- renderPlot({
      
  #función reactiva del input
    col<-reactive({ 
    as.numeric(input$coin) 
  })

  #monedas elegidas por el usuario
  colm<- choices[col(),1]
  colm<-as.character(colm)

  #lista con True en las filas con monedas elegidas por el usuario
  z<- crypto$slug %in% colm 
  
  #dataset con las monedas seleecionadas por el usuario
  monedasselec<-crypto[z,]
  
  #monedasselec2<-monedasselec
  #monedasselec2$nor<-
  #monedasselec$por<-monedasselec$close
  # Since my time is currently a factor, I have to convert it to a date-time format!
  
  
  # Then you can create the xts necessary to use dygraph
      #don <- xts(x = monedasselec$close, order.by = monedasselec$date)
  
  # Finally the plot
       #dygraph(don) %>%
        #dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
         #dyRangeSelector() %>%
          #dyCrosshair(direction = "vertical") %>%
          #dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
          #dyRoller(rollPeriod = 1)


    ggplot(data= monedasselec, aes(x=date, y=close, col=slug))+geom_line()
    
    

    #ggplot(data=monedasselec, aes(x=date, y=volume))+geom_histogram()
  })
    #output$moneda <- renderText(input$coin)
    output$dyplot <- renderDygraph({
      
      #función reactiva del input
      col<-reactive({ 
        as.numeric(input$coin) 
      })
      
      #monedas elegidas por el usuario
      colm<- choices[col(),1]
      colm<-as.character(colm)
      
      #lista con True en las filas con monedas elegidas por el usuario
      z<- crypto$slug %in% colm 
      
      #dataset con las monedas seleecionadas por el usuario
      monedasselec<-crypto[z,]
      
      #monedasselec2<-monedasselec
      #monedasselec2$nor<-
      #monedasselec$por<-monedasselec$close
      # Since my time is currently a factor, I have to convert it to a date-time format!
      
      
      # Then you can create the xts necessary to use dygraph
      don <- xts(x = monedasselec$close, order.by = monedasselec$date)
      
      # Finally the plot
      dygraph(don) %>%
      dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
      dyRangeSelector() %>%
      dyCrosshair(direction = "vertical") %>%
      dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
      dyRoller(rollPeriod = 1)
      
      
    })
    output$Plot1 <- renderPlot({
      
      #función reactiva del input
      col<-reactive({ 
        as.numeric(input$coin) 
      })
      
      #monedas elegidas por el usuario
      colm<- choices[col(),1]
      colm<-as.character(colm)
      
      #lista con True en las filas con monedas elegidas por el usuario
      z<- crypto$slug %in% colm 
      
      #dataset con las monedas seleecionadas por el usuario
      monedasselec<-crypto[z,]
      
      
     
      
      # Plot
       
      ggplot(data = monedasselec, aes(x=date, y=market, fill=slug,  sepparate=slug)) +
      geom_area( ) +
      scale_fill_viridis(discrete = TRUE) +
      theme(legend.position="none") +
      ggtitle("Market Volume") +
      theme_ipsum() +
      theme(legend.position="none")
      
      # Turn it interactive
      #p <- ggplotly(p, tooltip="text")
     #p
      
      
      
    })
    output$Plot2 <- renderPlot({
      
      #función reactiva del input
      col<-reactive({ 
        as.numeric(input$coin) 
      })
      
      #monedas elegidas por el usuario
      colm<- choices[col(),1]
      colm<-as.character(colm)
      
      #lista con True en las filas con monedas elegidas por el usuario
      z<- crypto$slug %in% colm 
      
      #dataset con las monedas seleecionadas por el usuario
      monedasselec<-crypto[z,]
      
      crypto2<-crypto[1:11644,]
      
      
      # Plot
      # No dendrogram nor reordering for neither column or row
      crypto2$close<-scale(crypto2$close)
      h<-ggplot(crypto2.heatmap, aes(x = slug, y = close, fill = close) + geom_tile()
      plot(h)      
      
    })

})

    
    crypto2$close<-scale(crypto2$close)
    ggplot(crypto3, aes(x = slug, y = ranknow, fill = close)) + geom_tile()+scale_fill_gradient(low = "white", high = "red")
    
    
    #crypto$date <- as.Date(crypto$date, format="%Y-%m-%d")
    
    #crypto2<-crypto[1:11644,]
    #cryptoXRP<-crypto[(crypto$slug=="ripple"),]
    #cryptoETH<-crypto[(crypto$slug=="ethereum"),]
    #cryptoXLM<-crypto[(crypto$slug=="stellar"),]
    #cryptoBCH<-crypto[(crypto$slug=="bitcoin-cash"),]
    #cryptoBTC<-crypto[(crypto$slug=="bitcoin"),]
    #cryptoEOS<-crypto[(crypto$slug=="eos"),]
    #cryptoLTC<-crypto[(crypto$slug=="litecoin"),]
    #cryptoUSDT<-crypto[(crypto$slug=="tether"),]
    #cryptoBSV<-crypto[(crypto$slug=="bitcoin-sv"),]
    #cryptoADA<-crypto[(crypto$slug=="cardano"),]
    
    #almonton<-merge.data.frame(cryptoXRP,cryptoETH, by.x=date )
    
    #crypto3<-cbind.data.frame(scale(cryptoXRP$close[1:425]), scale(cryptoETH$close[1:425]), scale(cryptoXLM$close[1:425]), scale(cryptoBCH$close[1:425])
                              #, scale(cryptoBTC$close[1:425]), scale(cryptoEOS$close[1:425]), scale(cryptoLTC$close[1:425]), scale(cryptoUSDT$close[1:425])
                              #, scale(cryptoBSV$close[1:425]), scale(cryptoADA$close[1:425]))
        
