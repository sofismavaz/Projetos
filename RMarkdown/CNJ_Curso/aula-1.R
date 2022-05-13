library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")

ui <- fluidPage(
    selectInput("dataset", "Dataset", choices = datasets),
    verbatimTextOutput("summary"),
    plotOutput("plot")
)

server <- function(input, output, session) {
    # Bloco 1.
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    # Bloco 2.
    output$summry <- renderTable({
        summary(dataset())
    })
    # Bloco 3.
    output$plot <- renderPlot({
        plot(dataset())
    }, res = 96)
}

shinyApp(ui, server)


correto <- function() {

 produto <- reactive({ list(x = input$x, y = input$y)  })

 output$produto <- renderText({  produto()$x * produto()$y  })
 output$produto_mais5 <- renderText({ produto()$x * produto()$y + 5  })
 output$produto_mais10 <- renderText({ produto()$x * produto()$y + 10 })

ui <- fluidPage( 

    sliderInput("x", label = "Se x é", min = 1, max = 50, value = 22),
    sliderInput("y", label = "Se y é", min = 1, max = 50, value = 31),

    "então, (x * y) é", textOutput("produto"),
    "e, (x * y) + 5 é", textOutput("produto_mais5"),
    "e (x * y) + 10 é", textOutput("produto_mais10")

)

server <- function(input, output, session) {

    produto <- reactive({ input$x * input$y })

    output$produto <- renderText({ produto() })
    output$produto_mais5 <- renderText({ produto() + 5 })
    output$produto_mais10 <- renderText({ produto() + 10 })

}
}

## Questão 1 (b, e)

ui <- fluidPage(
    # Conteúdo para criar o front-end.
    textOutput("cumprimento")
)
server <- function(input, output, session) {
    # Conteúdo para criar o back-end.
    output$cumprimento <- renderText({
    paste0("Olá ", input$nome)
}
shinyApp(ui, server)

## Questão 2 (d)

library(shiny)

ui <- fluidPage(
    sliderInput("x", label = "Se x é", min = 1, max = 50, value = 30),
    sliderInput("y", label = "Se y é", min = 1, max = 50, value = 30),

    "Então x vezes 5 é",
    textOutput("produto")
)

server <- function(input, output, session) {
    output$produto <- renderText({ input$x * 5 })
#        x * 5 # Há algo errado aqui, escolha a alternativa que resolva o problema
#   })    
}

## Questão 3 (c,d)
### c. No bloco server, deve ser criado um segundo bloco reativo para receber o input de y.
### d. No bloco UI, deve ser adicionado
sliderInput("y", label = "Se y é", min = 1, max = 50, value = 30)

## Questão 4 (a)

library(shiny)
ui <- fluidPage(
    sliderInput("x", "Se x é", min = 1, max = 50, value = 30),
    sliderInput("y", "e y é", min = 1, max = 50, value = 5),
    "então, (x * y) é", textOutput("produto"),
    "e, (x * y) + 5 é", textOutput("produto_mais5"),
    "e (x * y) + 10 é", textOutput("produto_mais10")
)
server <- function(input, output, session) {
 
 produto <- reactive({ input$x * input$y })
 
 output$produto <- renderText({ produto() })
 output$produto_mais5 <- renderText({ produto() + 5 })
 output$produto_mais10 <- renderText({ produto() + 10 })

}

shinyApp(ui, server)

Resposta_errada <- function() {
       output$produto <- renderText({
        produto <- input$x * input$y
        produto
    })
    output$produto_mais5 <- renderText({
        produto <- input$x * input$y
        produto + 5
    })
    output$produto_mais10 <- renderText({
        produto <- input$x * input$y
        produto + 10
    })
}

## Questão 5 (b, g)

library(shiny)
library(ggplot2)

datasets <- c("economics", "faithfuld", "seals")

ui <- fluidPage(
    selectInput("dataset", "Dataset", choices = datasets),
    verbatimTextOutput("summary"),
    tableOutput("plot")
)

server <- function(input, output, session) {
    # Bloco 1.
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    # Bloco 2.
    output$summry <- renderPrint({
        summary(dataset())
    })
    # Bloco 3.
    output$plot <- renderPlot({
        plot(dataset)
    }, res = 96)
}

shinyApp(ui, server)

Resposta_Correta <- function() {
    b. No bloco de UI, `tableOutput()` precisa ser substituído por `plotOutput()`.
    g. A chamada do dataset no terceiro bloco reativo está errada. O correto seria `dataset()`.
}
