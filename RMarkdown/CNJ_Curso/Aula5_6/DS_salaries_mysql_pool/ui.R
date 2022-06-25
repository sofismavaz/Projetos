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
library(DT)

#-----------------------------------------------------------------------
# Uma aplicação bem simples.

fluidPage(
    class = "container",
    h2("California Data Science Jobs"),
    helpText("Aplicação feita sobre dados disponíveis no",
             tags$a("Kaggle.",
                    href = "https://www.kaggle.com/datasets/michaelbryantds/california-salaries-in-data-science",
                    target = "_blank")),
    uiOutput(outputId = "TITLE_UI"),
    fluidRow(
        dataTableOutput(
            outputId = "TABLE")
    ) # fluidRow()
) # fluidPage()

#-----------------------------------------------------------------------
