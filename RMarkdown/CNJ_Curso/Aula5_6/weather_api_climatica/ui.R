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
library(waiter)

#-----------------------------------------------------------------------
# Front-end.

fluidPage(
    # Para usar recursos do {waiter}.
    useWaitress(),
    titlePanel("Consulta de temperaturas em Capitais e seus arredores"),
    sidebarLayout(
        sidebarPanel(
            width = 3,
            selectInput(
                inputId = "CAPITAL",
                label = "Selecione a capital",
                choices = capitais$nome),
            numericInput(
                inputId = "N_CIDADES",
                label = "Selecione o máximo de cidades nos arredores",
                min = 5,
                max = 30,
                value = 5),
            actionButton(
                inputId = "API_CALL",
                label = "Consultar dados via API")
        ),
        mainPanel(
            reactableOutput("weatherTable")
        )
    )
)

#-----------------------------------------------------------------------
