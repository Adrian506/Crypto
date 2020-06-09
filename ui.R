library(shiny)


shinyUI(
  fluidPage(
  
  # Título
  titlePanel(h2('Proyecto Shiny Crypto', align='center')),
  
  # Sidebar selección de cryptos 
  sidebarLayout(
        sidebarPanel(
              uiOutput("lista")
              
                  ),
    
    # Tabs
  mainPanel(
  tabsetPanel(type="tab",
                  tabPanel("Summary",
                           h5("Se dispone de un base de datos de Cryptomonedas con la siguiente estructura"),
                           tableOutput("head"),
                           h5("Con 942297 observaciones y 13 variables"),
                           h5("Actualmente el dataset datos de 2071 cryptomonedas entre el 28/4/2013 y el 29/11/2018")
                           
                           ),
                  tabPanel("Gráfico", plotOutput("Plot"),
                           sliderInput("slider", "Elija el rango de precios", min=0, max=19000, value=c(0,19000))
                           ),
                  tabPanel("Gráfico", dygraphOutput("dyplot")),
                  tabPanel("Gráfico", plotOutput("Plot1")),
                  tabPanel("Gráfico", plotlyOutput("Plot2")),
                  tabPanel("Investigación"),
                  tabPanel("Disclaimer", h5("Este software es simplemente educativo. Comprar cryptomonedas conlleva un riesgo de perdida absoluta de capital."), h5("En caso de ganancias se aceptan donaciones"))
                  )
            )
  ))
)
