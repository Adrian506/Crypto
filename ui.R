library(shiny)


shinyUI(
  fluidPage(
  
  # Título
  titlePanel(h2('Proyecto Shiny Crypto', align='center')),
  
  # Sidebar selección de cryptos 
  sidebarLayout(
        sidebarPanel(
              selectInput("coin", "Elige las Cryptomonedas", choice=lista, selected = 209, multiple = TRUE)
                  ),
    
    # Tabs
  mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Gráfico", plotOutput("Plot")),
                  tabPanel("Investigación"),
                  tabPanel("Sobre somos"),
                  tabPanel("Disclaimer", h5("Este software es simplemente educativo. Comprar cryptomonedas conlleva un riesgo de perdida absoluta de capital."), h5("En caso de ganancias se aceptan donaciones"))
                  )
            )
  ))
)
