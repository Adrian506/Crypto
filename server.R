#### INSTALACIÓN DE PAQUETES ####

if(!require("tidyverse")) {
  install.packages("tidyverse")
  library("tidyverse")
}
if(!require("shiny")) {
  install.packages("shiny")
  library("shiny")
}
if(!require("ggplot2")) {
  install.packages("ggplot2")
  library("ggplot2")
}
if(!require("tidyverse")) {
  install.packages("tidyverse")
  library("tidyverse")
}
if(!require("dygraphs")) {
  install.packages("dygraphs")
  library("dygraphs")
}
if(!require("xts")) {
  install.packages("xts")
  library("xts")
}
if(!require("viridis")) {
  install.packages("viridis")
  library("viridis")
}
if(!require("hrbrthemes")) {
  install.packages("hrbrthemes")
  library("hrbrthemes")
}
if(!require("plotly")) {
  install.packages("plotly")
  library("plotly")
}
if(!require("quantmod")) {
  install.packages("quantmod")
  library("quantmod")
}
if(!require("forecast")) {
  install.packages("forecast")
  library("forecast")
}

#### Preprocesamiento y carga de datos ####
  #leemos el .csv
  #crypto<-read.csv("crypto-markets.csv")

  #comprobamos estructura
  #str(crypto)

  #cambiamos a formato fecha 
  #crypto$date<- as.Date(crypto$date, format="%Y-%m-%d")

  #se guarda en .Rdata para aumentar la velocidad
  #save(crypto,file="Crypto.Rdata")

  #Cargamos el nuevo archivo
  load(file="Crypto.Rdata")    

  #tipos de monedas distintas con sus nombres para el selectInput
 choices <- data.frame(
   nombres <- levels(crypto$slug),
   num <- 1:length(nombres)
 )
 
  # Lista de monedas para Selectinput
 lista<-as.list(choices$num)
    #Nombres
 names(lista) <- choices$nombres 
 
 #Se ha creado un dataframe quitando ciertas variables
 #crypto2<-crypto[]
 #crypto2<-crypto2[,-2:-3]
 #crypto2<-crypto2[,-3:-8]
 #crypto2<-crypto2[,-4:-5]
 
 #Se  ha realizado un split-merge(by date) con la funcion reshape() ya que el dataframe
 #no estaba organizado de la manera ideal para representarlo.
 #Se ha obtenido un dataframe donde las variables con la misma fecha estarán en la misma fila
 #crypto3<-reshape(crypto2, idvar='date', timevar='slug', direction='wide')
 
 #Se suma las columnas para obtener el marketshare global de todas las criptos
 #crypto3$suma2<-rowSums(crypto3[,5:2072], na.rm=TRUE)
 
 #Columna nueva con el porcentaje de marketshare del BTC
 #crypto3$propbtc<-(crypto3[,2]/crypto3[,2073])*100
 
 #Columna nueva con el porcentaje de marketshare del Ripple
 #crypto3$proprip<-(crypto3[,3]/crypto3[,2073])*100
 
 #Columna nueva con el porcentaje de marketshare del Ethereum
 #crypto3$propeth<-(crypto3[,4]/crypto3[,2073])*100

 #Columna nueva con el porcentaje de marketshare del resto de criptomonedas
 #crypto3$propresto<-(crypto3[,2077]/crypto3[,2073])*100

 #Guardamos .Rdata el dataframe nuevo
 #save(crypto3,file="CryptoMarket.Rdata")
 load(file="CryptoMarket.Rdata") 
 
 

 
#### Input, outputs ####
shinyServer(function(input, output) {
  
#### Ui dinamica ####

  #Selecinput para Comparador con la lista de criptomonedas con Bitcoin i Etherium preseleccionadas y multiple en True
output$lista<-renderUI({
 selectInput("coin", "Elige las Cryptomonedas", choice=lista, selected = c(209,720), multiple = TRUE)
  })  

 #Selecinput para Sceener con la lista de criptomonedas con Bitcoin preseleccionado y multiple en false
output$lista2<-renderUI({
  selectInput("coin2", "Elige las Cryptomonedas", choice=lista, selected =209, multiple = FALSE)
})

 #Tabla en summary para poder mostrar la estructura del conjunto de datos
output$head<-renderTable({
  crypto[1:5,1:13]
 })


#### Variables reactivas ####

 #función reactiva del input monedas del primer selectinput
    col<-reactive({ 
    as.numeric(input$coin) 
  })

 #función reactiva del input monedas del segundo selectinput
col2<-reactive({ 
  as.numeric(input$coin2) 
})

 #función reactiva para poder hacer zoom vertical del gráfico comparador
    rango<-reactive({ 
      as.numeric(input$slider) 
  })
    
 #Dataframe resultante después de seleccionar las criptomonedas seleccionadas en Comparador
    monedasselec<-reactive({
         #monedas elegidas por el usuario
          colm<- choices[col(),1]
          colm<-as.character(colm)
          #lista con True en las filas con monedas elegidas por el usuario
          z<- crypto$slug %in% colm 
          #dataset con las monedas seleecionadas por el usuario
          crypto[z,]      
      })  
    
 #Dataframe resultante después de seleccionar las criptomonedas seleccionadas en Screener     
    monedasselec2<-reactive({
      #monedas elegidas por el usuario
      colm2<- choices[col2(),1]
      colm2<-as.character(colm2)
      #lista con True en las filas con monedas elegidas por el usuario
      z2<- crypto$slug %in% colm2 
      #dataset con las monedas seleecionadas por el usuario
      crypto[z2,]      
    })  
    
#### renderTables ####    
    
    #Se muestra en comparador el dataframe de las monedas seleccionadas
    output$monedas<-renderTable({
          monedasselec()
     })
    
#### renderPlot ####
    
    #representación gráfica comparativa#
    output$Plot <- renderPlot({
    ggplot(data= monedasselec(), aes(x=date, y=close, col=slug))+geom_line()+theme_bw()+coord_cartesian(ylim = rango())+xlab("Año") +ylab("Precio($)")
    })

    

#representación gráfica dygraph interactivo# 
    output$dyplot <- renderDygraph({
      # Xts para dygraph
      don <- xts(x = monedasselec2()$close, order.by = monedasselec2()$date)
      # Plot
      dygraph(don) %>%
      dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
      dyRangeSelector() %>%
      dyCrosshair(direction = "vertical") %>%
      dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.2, hideOnMouseOut = FALSE)  %>%
      dyRoller(rollPeriod = 1)
    })
    
    #representación marketshare investigación#    
    output$marketshare1 <- renderPlot({
      
      cryptotodas<-crypto[1:942297,]     
      ggplot(data = cryptotodas, aes(x=date, y=market, fill=slug,  sepparate=slug)) +
      geom_area( ) +
      scale_fill_viridis(discrete = TRUE) +
      theme(legend.position="none") +
      ggtitle("Capitalización de las cryptos") +
      theme_ipsum() +
      theme(legend.position="none")+xlab("Año") +ylab("Marketshare($)")
   })
    
    
    #representación marketshare investigación2#    
    output$marketshare2 <- renderPlot({
      crypto10<-crypto[1:11644,]     
      ggplot(data = crypto10, aes(x=date, y=market, fill=slug,  sepparate=slug)) +
        geom_area( ) +
        scale_fill_viridis(discrete = TRUE) +
        theme(legend.position="none") +
        ggtitle("Capitalización 10 primeras") +
        theme_ipsum() +
        theme(legend.position="none")+xlab("Año") +ylab("Marketshare($)")
    })
    
    
    #representación marketshare bitcoin proporcion#
    output$marketbtc <- renderPlot({
    
    ggplot(data= crypto5, aes(x=date, y=propbtc))+geom_line()+theme_bw()+ggtitle("Capitalización del BTC respecto al global") + xlab("Año") + ylab("Marketshare(%)")

    })
    
    #representación marketshare rip proporcion#
    output$marketrip <- renderPlot({

    ggplot(data= crypto5, aes(x=date, y=proprip))+geom_line()+theme_bw()+ggtitle("Capitalización del Rippel respecto al global")+xlab("Año") +ylab("Marketshare(%)")
    }) 
    
    
    #representación marketshare etherium proporcion#
    output$marketeth <- renderPlot({
    ggplot(data= crypto5, aes(x=date, y=propeth))+geom_line()+theme_bw()+ggtitle("Capitalización del Etherium respecto al global")+ xlab("Año") +ylab("Marketshare(%)")
    }) 
   
    #representación marketshare resto de monedas proporcion# 
    output$marketresto <- renderPlot({
    ggplot(data= crypto5, aes(x=date, y=propresto))+geom_line()+theme_bw()+xlab("Año") +ylab("Marketshare(%)")+ggtitle("Porcentage de capitalizacion de todas las monedas menos las 3 primeras")
    })
    
    
    
    
    
#### Analisis predictivo #####
    cryptoBTC<-crypto[(crypto$slug=="bitcoin"),]
    cryptoETH<-crypto[(crypto$slug=="ethereum"),]
    
    output$Plot3 <- renderPlot({
      modelfit <- auto.arima(cryptoBTC$close, lambda = "auto")
      price_forecast <- forecast(modelfit, h=30)
      plot(price_forecast)
    })
    output$Plot4 <- renderPlot({
      modelfit <- auto.arima(cryptoETH$close, lambda = "auto")
      price_forecast <- forecast(modelfit, h=30)
      plot(price_forecast)
    })
    
    
    #### Gráfico de Velas #####    
    output$Plot2 <- renderPlotly({
      
      fig <- cryptoETH %>% plot_ly(x = cryptoETH$date, type="candlestick",
                                   open = cryptoETH$open, close = cryptoETH$close,
                                   high = cryptoETH$high, low = cryptoETH$low) 
      
      
      # plot volume bar chart
      #fig2 <- cryptoBTC
      
      fig2 <- cryptoETH %>% plot_ly(x=cryptoETH$date, y=cryptoETH$volume, type='bar', name = "Volume", colors = c('#17BECF','#7F7F7F')) 
      fig2 <- fig2 %>% layout(yaxis = list(title = "Volume"))
      # create rangeselector buttons
      rs <- list(visible = TRUE, x = 0.5, y = -0.055,
                 xanchor = 'center', yref = 'paper',
                 font = list(size = 9),
                 buttons = list(
                   list(count=1,
                        label='RESET',
                        step='all'),
                   list(count=1,
                        label='1 YR',
                        step='year',
                        stepmode='backward'),
                   list(count=3,
                        label='3 MO',
                        step='month',
                        stepmode='backward'),
                   list(count=1,
                        label='1 MO',
                        step='month',
                        stepmode='backward')
                 ))
      
      # subplot with shared x axis
      fig <- subplot(fig, fig2, heights = c(0.7,0.2), nrows=2,
                     shareX = TRUE, titleY = TRUE)
      fig <- fig %>% layout(title = paste("CanddleStick Chart",Sys.Date()),
                            xaxis = list(rangeselector = rs),
                            legend = list(orientation = 'h', x = 0.5, y = 1,
                                          xanchor = 'center', yref = 'paper',
                                          font = list(size = 10),
                                          bgcolor = 'transparent'))
      
      fig
    })
    
    
    

    
    

})

 
 
 
#### Proyectos futuros ####
    #crypto2$close<-scale(crypto2$close)
    #ggplot(crypto3, aes(x = slug, y = ranknow, fill = close)) + geom_tile()+scale_fill_gradient(low = "white", high = "red")
    
    
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
        
   

    #AQUI EMPIEZA EL GRAFICO DE ARAÑA

#library("fmsb")
   
    # To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each variable to show on the plot!
    #data1<- data.frame(c(max(cryptoETH$close), max(cryptoBCH$close), max(cryptoBTC$close),max(cryptoLTC$close),max(cryptoBSV$close)))
    #data2 <- data.frame(c(0, 0, 0,0,0))
    #data3 <- data.frame(c(mean(cryptoETH$close), mean(cryptoBCH$close), mean(cryptoBTC$close),mean(cryptoLTC$close),mean(cryptoBSV$close)))
    #data4<-cbind.data.frame(data1, data2, data3)
    #library(data.table)
    #data_transpose <- transpose(data4)
    # Color vector
    #colors_border=c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9) , rgb(0.7,0.5,0.1,0.9) )
    #colors_in=c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4) , rgb(0.7,0.5,0.1,0.4) )
    
    # plot with default options:
    #radarchart(data_transpose , seg=5, axistype=1 , 
                #custom polygon?
                #pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
                #custom the grid
                #cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                #custom labels
                #vlcex=0.8 
    #)
    
    # Add a legend
    #legend(x=0.7, y=1, legend = rownames(data[-c(1,2),]), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)
    #?radarchart
    