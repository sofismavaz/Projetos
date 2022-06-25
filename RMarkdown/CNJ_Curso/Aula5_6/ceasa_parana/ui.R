#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-06 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------
# Pacotes necessários:
# install.packages("shinyjs")
# install.packages("shinythemes")
# install.packages("waiter")
#-----------------------------------------------------------------------

library(shiny)
library(shinythemes)
library(shinyjs)
library(waiter)
 
shinyUI(
    fluidPage(
        class = "container",
        # Para usar recursos do {shinyjs}.
        useShinyjs(),
        # Para usar recursos do {waiter}.
        useWaitress(),
        # Uso de um tema do {shinythemes}.
        theme = shinytheme("yeti"),
        # Inclusão de CSS em linha.
        tags$head(
            # Note the wrapping of the string in HTML()
            tags$style(
                HTML("
                @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@300;800&display=swap');
                h1, h2 {
                  font-family: 'Montserrat', sans-serif;
                  font-weight: 800;
                }
                body {
                  font-family: 'Montserrat', sans-serif;
                  font-weight: 300;
                }
                .shiny-input-container {
                  color: #474747;
                }"
                )
            )
        ),
        titlePanel("Conversão de Cotação Diária de Preços"),
        verticalLayout(
            actionLink(inputId = "DOCUMENTACAO",
                       label = "Documentação",
                       style = "margin-bottom: 1em;"),
            # Upload de arquivo.
            h3("Widget de botão de UPLOAD de arquivo PDF."),
            h3("Widget de botão de PROCESSAR."),
            h3("Widget de botão de DOWNLOAD de arquivo CSV.")
        ) # verticalLayout()
    ) # fluidPage()
) # shinyUI()

#-----------------------------------------------------------------------
