#-----------------------------------------------------------------------
# Aplicação desenvolvida por Felipe Queluz
#
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-14 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(shiny)
library(shinydashboard)
library(plotly)
library(reactable)

options(scipen = 999)

#-----------------------------------------------------------------------

fluidPage(
    h2("Forbes Billionaires - 2022"),
    fluidRow(
        column(width = 6,
               box(width = 12,
                   column(width = 3,
                          selectInput(
                              inputId = "COUNTRIES",
                              label = "Selecione os países",
                              choices = c("All", sort(unique(billionaires$Country))),
                              selected = "All",
                              multiple = TRUE,
                              selectize = TRUE)
                          ),
                   column(width = 3,
                          selectInput(
                              inputId = "GROUPING",
                              label = "Selecione os grupos",
                              choices = c("Age", "Continent", "Country", "Industry"),
                              selected = "Continent")
                          ),
                   column(width = 3,
                          selectInput(
                              inputId = "N_BINS",
                              label = "Defina o número de barras",
                              choices = c(10, 15, 20, 25),
                              selected = 10)
                          )
                   ),
               # Criação de tabpanel para selecionar visualização de
               # distribuição e médias.
               tabBox(width = 12,
                      tabPanel("Rank - Networth Overview",
                               plotlyOutput("billionaireGeneral")),
                      tabPanel("Grouped Means - Networth Overview",
                               plotlyOutput("billionaireNetWorth"))
                      )
               ),
        # Output da tabela.
        column(width = 6,
               box(width = 12,
                   reactableOutput("billionaireTable"))
               )
    )
)

#-----------------------------------------------------------------------
