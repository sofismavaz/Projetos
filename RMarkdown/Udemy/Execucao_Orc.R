library(shiny)
library(ggplot2)

Registros_Orc <- data.frame(plan <- read.csv2("/home/lrocio/Projetos/RMarkdown/Udemy/Registros_Orc.csv", header = TRUE, sep = ";"))

Tipo_Execucao <- Registros_Orc$TIPO
Unid_Defere <- Registros_Orc$DEFERIDO.POR
Unid_Demandante <- Registros_Orc$UNIDADE

ui <- fluidPage(
    titlePanel("Acompanhamento da Execução Orçamentária"),
    helpText("Escolha o agrupador"),

    fluidRow(
        column(2, sliderInput("Tipo_Execucao", "Tipo de Execução")),
        column(4, sliderInput("Unid_Defere", "Unidade que deferiu")),
        column(6, sliderInput("Unid_Demandante", "Unidade demandante"))
    )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)

