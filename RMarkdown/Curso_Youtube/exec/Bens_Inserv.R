# Os layouts abaixo possuem menus para navegação. O `server` da aplicação, fornecido abaixo, não contém reatividade para essa ser uma aplicação que apenas exiba o layout. A função `div_create()` serve para incluir um texto com fundo de alguma cor e facilitar a visualização da disposição dos objetos nesse layout.

library(shiny)
library(ggplot2)
library(reactable)

setwd("/home/lrocio/Projetos/RMarkdown/CNJ_Curso/exec")

bi1 <- read.csv("/home/lrocio/Projetos/Base_textes/CPAD.csv")

bi1$ZONA <- as.factor(bi1$ZONA)
#bi1$DESCRIÇÃO.DO.DOCUMENTO <- as.character(toupper(iconv(bi1$DESCRIÇÃO.DO.DOCUMENTO)))
bi1$DESCRIÇÃO.DO.DOCUMENTO <- as.character(tolower(bi1$DESCRIÇÃO.DO.DOCUMENTO))
bi1$DT.FIM <- as.factor(bi1$DT.FIM)
bi1$GUARDA <- as.factor(bi1$GUARDA)
bi1$EVENTO <- as.factor(bi1$EVENTO)
bi1$DT.FIM <- as.factor(bi1$DT.FIM)
str(bi1)

a1 <- ggplot2(bi1)



save(a1, list = character(), file = "teste_2.txt")

output$dataTableOutput <- renderDataTable(bi1)

textOutput() <- htmlOutput(a1)


# Este server não contém reatividade mas precisa ser declarado.
server <- shinyServer(
    function(input, output, session) {
        output$TABLE <- renderReactable({
            make_table( ZE = FILTERED_DATA()$ZONA,

                       )
        })

  # Exibe a tabela.
        output$TABLE <- renderReactable({
            make_table(tb_count = FILTERED_DATA()$tb_count,
                       tb_estado = FILTERED_DATA()$tb_estado)
        })
    }
)

ui <- fluidPage(
    titlePanel("Table CPAD"),
    splitLayout(
        reactableOutput("TABLE")
    )
)


shinyApp(ui = ui, server = server)


