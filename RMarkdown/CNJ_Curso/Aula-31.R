# Os layouts abaixo possuem menus para navegação. O `server` da aplicação, fornecido abaixo, não contém reatividade para essa ser uma aplicação que apenas exiba o layout. A função `div_create()` serve para incluir um texto com fundo de alguma cor e facilitar a visualização da disposição dos objetos nesse layout.

library(shiny)
setwd("/home/lrocio/Projetos/RMarkdown/CNJ_Curso/exec")

# Este server não contém reatividade mas precisa ser declarado.
server <- shinyServer(
    function(input, output, session) {
    NULL
    }
)

# Essa função é usada para criar blocos placeholders.
div_create <- function(content, color) {
    css <- c(sprintf("background-color: %s;", color),
             "margin: 1px;",
             "height: 4em;")
    div(content,
        style = paste0(css, collapse = " "))
}

# Para qualquer que seja o `ui`, aqui você abre a aplicação.

shinyApp(ui = ui, server = server)

# Associe a cada bloco de código para `ui` a descrição do que ele constrói.

# Cria menu lateral de navegação, com itens um ao lado do outro
t0 <- navbarPage(
    "Página - opção 1",
    tabPanel("Guia 1", div_create("OBJ1", "yellow")),
    tabPanel("Guia 2", div_create("OBJ2", "gray")),
    navbarMenu(
        "Guia 3",
        tabPanel("Entrada 3.1",
                 div_create("OBJ1", "red")),
        tabPanel("Entrada 3.2",
                 div_create("OBJ2", "black")),
        tabPanel("Entrada 3.3",
                 div_create("OBJ3", "green"))
    )
)

# Cria página com menu de navegação superior com itens um ao lado do outro
t1 <- fluidPage(
    navbarPage(
        title = "Página - opção 2",
        tabPanel("Guia 1", div_create("OBJ1", "gray")),
        tabPanel("Guia 2", div_create("OBJ2", "yellow")),
        tabPanel("Guia 3", div_create("OBJ3", "yellow"))
    )
)

# Cria página, com menu de navegação superior e entradas na última aba
t2 <- navbarPage(
    "Página - opção 3",
    tabPanel("Guia 1", div_create("OBJ1", "red")),
    tabPanel("Guia 2", div_create("OBJ2", "blue")),
    navbarMenu(
        "Guia 3",
        tabPanel("Entrada 3.1",
                 div_create("OBJ1", "black")),
        tabPanel("Entrada 3.2",
                 div_create("OBJ2", "#bebebe")),
        tabPanel("Entrada 3.3",
                 div_create("OBJ3", "#bebebef1f"))
    )
)

# Cria paǵina com guias dispostas de forma horizontal, no top e uma ao lado da outra
ui <- fluidPage(
    titlePanel("Página - opção 4"),
    tabsetPanel(
        tabPanel("Guia 1", div_create("OBJ1", "green")),
        tabPanel("Guia 2", div_create("OBJ2", "black")),
        tabPanel("Guia 3", div_create("OBJ3", "gray"))
    )
)
