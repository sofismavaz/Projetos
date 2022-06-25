shinyServer(function(input, output, session) {

    observeEvent(input$UF, {
        choices <- uf_curso_set$NOME_CURSO_BOLSA[
            uf_curso_set$SIGLA_UF_BENEFICIARIO_BOLSA == input$UF] |>
            sort() |>
            unique()
        updateSelectInput(inputId = "CURSO",
                          choices = choices,
                          selected = input$CURSO)
    })

    FILTERED_DATA <- eventReactive(input$EXECUTAR, {
        filter_data(tb,
                    UF = input$UF,
                    CURSO = input$CURSO)
    })

    output$PLOT_ANO <- renderPlotly({
        tb_sel <- FILTERED_DATA()
        plot_ano(tb_sel, plotly = TRUE)
    })

    output$PLOT_IES <- renderPlotly({
        tb_sel <- FILTERED_DATA()
        plot_ies(tb_sel, TRUE)
    })

}) # shinyServer()
