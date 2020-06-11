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


shinyUI(
  fluidPage(
  
  # Título
  titlePanel(h2('Proyecto Shiny Crypto', align='center')),
  
  # Sidebar selección de cryptos 
  sidebarLayout(
          tags$img(src="iqs2.jpg", height=160,width=250),
        
        # Tabs
  mainPanel(
  tabsetPanel(type="tab",
                  tabPanel("Summary",
                           h5("Se dispone de un base de datos de Cryptomonedas con la siguiente estructura"),
                           tableOutput("head"),
                           h5("Con 942297 observaciones y 13 variables"),
                           h5("Actualmente el dataset datos de 2071 cryptomonedas entre el 28/4/2013 y el 29/11/2018")
                           ),
                  tabPanel("Comparador", uiOutput("lista"),
                           plotOutput("Plot"),
                           sliderInput("slider", "Elija el rango de precios", min=0, max=19000, value=c(0,19000)),
                           tableOutput("monedas")
                           ),
                  tabPanel("Screener", 
                           uiOutput("lista2"),
                           dygraphOutput("dyplot")),
                  tabPanel("Grafico de Velas", plotlyOutput("Plot2")),
                  tabPanel("Investigación", 
                           h4("Analisis de datos"),
                           h5("En este primer grafico se quiere remarcar la capitalización global "),
                           plotOutput("marketshare1"),
                           h5("Representacion de la capitalización de las 10 primeras Critomonedas"),
                           plotOutput("marketshare2"),
                           h5("El porcentage de marketshare de Bitcoin respecto al conjunto de las cryptomonedas"),
                           plotOutput("marketbtc"),
                           h5("El porcentage de marketshare de Ripel respecto al conjunto de las cryptomonedas"),
                           plotOutput("marketrip"),
                           h5("El porcentage de marketshare de Etherium respecto al conjunto de las cryptomonedas"),
                           plotOutput("marketeth"),
                           h5("El porcentage de marketshare de todas las monedas menos las tres primeras"),
                           plotOutput("marketresto")
                                                      ),
                  tabPanel("Predictivo", h5("Predicción precio Bitcoin"), plotOutput("Plot3"),
                           h5("Predicción precio Ethereum"),
                           plotOutput("Plot4")),
                  tabPanel("Disclaimer", h5("Este software es simplemente educativo. Comprar cryptomonedas conlleva un riesgo de perdida absoluta de capital."))
                  )
            )
  ))
)
