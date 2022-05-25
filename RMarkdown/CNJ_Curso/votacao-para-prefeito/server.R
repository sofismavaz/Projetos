#-----------------------------------------------------------------------
#
#         Dashboards e relatórios dinâmicos com R
#
#                                            Prof. Dr. Walmes M. Zeviani
#                Department of Statistics · Federal University of Paraná
#                                       2022-mai-23 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------

library(shiny)

shinyServer(
    function(input, output, session) {

        #---------------------------------------------------------------
        # Expressões reativas.

        # Filtra os dados para passar para as render*().
        FILTERED_DATA <- reactive({
            filter_data(tb,
                        br_municipal,
                        unidade_federativa = input$UF,
                        ano_eleitoral = input$ANO)
        })

        #---------------------------------------------------------------
        # Gráficos e tabelas.

        # Exibe o gráfico de barras.
        output$BARPLOT <- renderPlot({
            make_barplot(tb_count = FILTERED_DATA()$tb_count,
                         unidade_federativa = isolate(input$UF),
                         ano_eleitoral = isolate(input$ANO))
        })

        # Exibe o mapa.
        output$MAP <- renderPlot({
            make_cloropleth(tb_estado = FILTERED_DATA()$tb_estado,
                            unidade_federativa = isolate(input$UF),
                            ano_eleitoral = isolate(input$ANO))
        })

        # Exibe a tabela.
        output$TABLE <- renderReactable({
            make_table(tb_count = FILTERED_DATA()$tb_count,
                       tb_estado = FILTERED_DATA()$tb_estado)
        })

        #---------------------------------------------------------------
        # Caixas de informação.

        output$IB_ANO <- renderUI({
            summaryBox2(
                title = "Ano eleitoral",
                input$ANO,
                width = 3,
                icon = "fas fa-calendar",
                style = "light")
        })

        output$IB_UF <- renderUI({
            summaryBox2(
                title = "Unidade federativa",
                input$UF,
                width = 3,
                icon = "fas fa-map",
                style = "primary")
        })

        output$IB_TOT <- renderUI({
            summaryBox2(
                title = "Número de municípios",
                value = sum(FILTERED_DATA()$tb_count$n),
                icon = "fas fa-university",
                width = 3,
                style = "secondary")
        })

        output$IB_PERC <- renderUI({
            freq <- with(FILTERED_DATA()$tb_count,
                         max(n)/sum(n))
            summaryBox2(
                title = "Percentual de prefeituras",
                value = sprintf("%0.1f%%", 100 * freq),
                icon = "fas fa-trophy",
                width = 3,
                style = "success")
        })

    }
)

#-----------------------------------------------------------------------