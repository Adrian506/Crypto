library(shiny)
library(ggplot2)

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
  

    ggplot(data= monedasselec, aes(x=date, y=close, col=slug))+geom_line()

    #ggplot(data=monedasselec, aes(x=date, y=volume))+geom_histogram()
  })
    #output$moneda <- renderText(input$coin)
 

})


crypto$close[3]

??data.frame
alex<-data.frame[1,942297]
for (i in 2019)
alex[2]<-(crypto$close[2-1]-crypto$close[2])/100

alex <- data.frame(1:942297, letters[1:942297])
