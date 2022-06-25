#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-06 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# server.R

library(shiny)

# Exclui os arquivos.
unlink("tabela.csv")
unlink("arquivo.csv")
 
shinyServer(
    function(input, output, session) {

        # Mostra o modal quando o link é clicado.
        observeEvent(input$DOCUMENTACAO, {
            showModal(
                modalDialog(
                    title = "Veja como usar essa aplicação",
                    footer = modalButton("Fechar"),
                    p("Essa aplicação lê a tabela de",
                      strong("Cotação Diária de Preços"),
                      "do Ceasa-PR e gera um arquivo CSV."
                      ),
                    p("Você pode baixar os PDF",
                      tags$a("aqui.",
                             href = "https://www.ceasa.pr.gov.br/Pagina/Cotacao-Diaria-de-Precos-2022",
                             target = "_blank")
                      )
                ))
        })

        # Carrega os dados quando botão de UPLOAD é usado.
        observe({

        }) # observe()

        # Cria instância para usar algo que indique processamento.
        waitress <- Waitress$new("#PROCESSAR",
                                 theme = "overlay",
                                 infinite = TRUE)

        # Processa do PDF em CSV.
        observeEvent(input$PROCESSAR, {
            # cat("Clicou em processar\n")
            waitress$start()

            Sys.sleep(5)

            waitress$close()

        }) # observeEvent()

        # Colocar a lado server para download de arquivo.
    }
)

#-----------------------------------------------------------------------
