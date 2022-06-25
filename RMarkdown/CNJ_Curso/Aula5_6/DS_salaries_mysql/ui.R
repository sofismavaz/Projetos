#-----------------------------------------------------------------------
# Aplicação desenvolvida por Felipe Queluz
#
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-07 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

options(scipen = 999)

#-----------------------------------------------------------------------

fluidPage(
    class = "container",
    h2("California Data Science Jobs"),
    helpText("Aplicação feita sobre dados disponíveis no",
             tags$a("Kaggle.",
                    href = "https://www.kaggle.com/datasets/michaelbryantds/california-salaries-in-data-science",
                    target = "_blank")),
    fluidRow(
        column(
            width = 6,
            box(width = 12,
                selectInput(
                    inputId = "JOBS",
                    label = "Select Data Science positions",
                    choices = sort(unique(title_location$title)),
                    selected = salary_top5$title,
                    multiple = TRUE,
                    width = "100%",
                    selectize = TRUE)),
            box(width = 12,
                plotlyOutput(
                    outputId = "SALARY_PLOT"))
        ),
        column(width = 6,
               box(width = 12,
                   title = "Average pay per qualification",
                   dataTableOutput(
                       outputId = "QUALIFICATION_TABLE"))
               )
    ) # fluidRow()
) # fluidPage()

#-----------------------------------------------------------------------
