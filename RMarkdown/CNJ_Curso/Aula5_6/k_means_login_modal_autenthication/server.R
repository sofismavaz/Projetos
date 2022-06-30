#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-14 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Back-end.

shinyServer(function(input, output, session) {

    # Combine the selected variables into a new data frame
    selectedData <- reactive({
        iris[, c(input$xcol, input$ycol)]
    })

    clusters <- reactive({
        kmeans(selectedData(), input$clusters)
    })

    output$plot1 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
                  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

    #---------------------------------------------------------------
    # Modal de autenticação.

    if (login_screen) {
        res_auth <- secure_server(
            check_credentials = check_credentials(credentials)
        )
        output$auth_output <- renderPrint({
            reactiveValuesToList(res_auth)
        })
    }

    #-------------------------------------------------------------------

})

#-----------------------------------------------------------------------
