# Cada bloco de código abaixo constrói um layout diferente. Os layouts que eles constrõem estão na imagem a seguir, numerados na margem. Arraste e solte cada bloco de código no espaço retangular na imagem sobre o layout correspondente.
# O `server` desta aplicação não contém reatividade e a função `div_create()` serve para incluir um texto com fundo de alguma cor e facilitar a visualização da disposição dos objetos.

library(shiny)

setwd("/home/lrocio/Projetos/RMarkdown/CNJ_Curso/exec")


t1 <- fluidPage(
    flowLayout(
        div_create("OBJ1", "gray"),
        div_create("OBJ2", "yellow"),
        div_create("OBJ3", "gray")
    )
)

t2 <- fluidPage(
    sidebarLayout(
        sidebarPanel(div_create("OBJ1", "gray")),
        mainPanel(div_create("OBJ2", "gray"),
            div_create("OBJ3", "yellow"))
            )
)

t3 <- fluidPage(
    verticalLayout(
        div_create("OBJ1", "gray"),
        div_create("OBJ2", "gray"),
        div_create("OBJ3", "yellow")
            )
)
t4 <- fluidPage(
    splitLayout(
        div_create("OBJ1", "gray"),
        div_create("OBJ2", "gray"),
        div_create("OBJ3", "yellow ")
    )
)

t5 <- fluidPage(
    fluidRow(
        column(width = 4, div_create("OBJ1", "yellow")),
        column(width = 2, div_create("OBJ2", "gray"))),
    fluidRow(column(width = 12, div_create("OBJ3", "gray")))
)


# Esse server não tem reatividade.
server <- shinyServer(
    function(input, output, session) {
    NULL
    }
)

# Essa função é para criar blocos mais fáceis de ver.
div_create <- function(content, color) {
    css <- c(sprintf("background-color: %s;", color),
             "margin: 1px;",
             "height: 4em;")
    div(content,
        style = paste0(css, collapse = " "))
}

# Para qualquer `ui`, abra a aplicação com isso.
shinyApp(ui = ui, server = server)
