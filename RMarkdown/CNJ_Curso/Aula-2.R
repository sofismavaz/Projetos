# Cada bloco de código abaixo constrói um layout diferente. Os layouts que eles constrõem estão na imagem a seguir, numerados na margem. Arraste e solte cada bloco de código no espaço retangular na imagem sobre o layout correspondente.
# O `server` desta aplicação não contém reatividade e a função `div_create()` serve para incluir um texto com fundo de alguma cor e facilitar a visualização da disposição dos objetos.

library(shiny)

setwd("/home/lrocio/Projetos/RMarkdown/CNJ_Curso")


ui <- fluidPage(
    splitLayout(
        
    )
)

# Esse server não tem reatividade.
server <- shinyServer(
    function(input, output, session) {
    NULL
    }
)

# Para qualquer `ui`, abra a aplicação com isso.
shinyApp(ui = ui, server = server)
