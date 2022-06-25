#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-06 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

library(shiny)

shinyUI(
    fluidPage(
        class = "container",
        titlePanel("Gerador de Delineamento Quadrado Latino"),
        sidebarLayout(
            sidebarPanel(
                numericInput(inputId = "SIZE",
                             label = "Tamanho do Quadrado Latino:",
                             min = 4,
                             max = 20,
                             step = 1,
                             value = 5),
                checkboxInput(inputId = "SET_SEED",
                              label = "Fixar semente.",
                              value = FALSE),
                conditionalPanel(
                    condition = "input.SET_SEED",
                    textInput(
                        inputId = "SEED",
                        label = "Semente:",
                        value = 1234
                    )
                ),
                downloadButton(outputId = "DOWNLOADDATA",
                               label = "Download")
            ),
            mainPanel(
                plotOutput(outputId = "PLOTLAYOUT")
            )
        )
    )
)

#-----------------------------------------------------------------------
