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

shinyServer(function(input, output) {

    # Cria instância para usar algo que indique processamento.
    waitress <- Waitress$new("#API_CALL",
                             theme = "overlay",
                             infinite = TRUE)

    # Filtrando dados e chamando API de acordo com clique nos botões.
    data <-
        eventReactive(input$API_CALL, {
            waitress$start()
            tb <- getCapitalAndSurroundings(input$CAPITAL,
                                            input$N_CIDADES)
            waitress$close()
            return(tb)
        })

    # Renderizando tabela com dados filtrados.
    output$weatherTable <-
        renderReactable({
            make_weather_table(data())
        })

})

#-----------------------------------------------------------------------
