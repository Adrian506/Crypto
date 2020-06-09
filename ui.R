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
                           sliderInput("slider", "Elija el rango de precios", min=0, max=19000, value=c(0,19000)),
                           tableOutput("monedas")
                           ),
                  tabPanel("Gráfico", dygraphOutput("dyplot")),
                  tabPanel("Gráfico", plotlyOutput("Plot2")),
                  tabPanel("Investigación", 
                           h4("Analisis de datos"),
                           h5("En este primer grafico se quiere remarcar la capitalización global de las 10 primeras monedas con mayor marketshare"),
                           plotOutput("marketshare1"),
                           h5("Pudiendose comprar el marketshare con el total de las cryptomonedas analizadas, 2071 en total."),
                           plotOutput("marketshare2")
                                                      ),
                  tabPanel("Disclaimer", h5("Este software es simplemente educativo. Comprar cryptomonedas conlleva un riesgo de perdida absoluta de capital."))
                  )
            )
  ))
)
