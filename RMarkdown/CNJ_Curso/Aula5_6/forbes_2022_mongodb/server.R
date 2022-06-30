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
# Pacotes.

library(tidyverse)
library(plotly)
library(reactable)

#-----------------------------------------------------------------------

# Criando conexão com o BD.
shinyServer(function(input, output, session) {

    # Criando reatividade dos dados.
    data <-
        reactive({
            if ("All" %in% input$COUNTRIES) {
                billionaires
            } else {
                billionaires %>%
                    filter(Country %in% input$COUNTRIES)
            }
    })

    # Output dos gráficos de distribuição por patrimônio líquido.
    output$billionaireGeneral <-
        renderPlotly({
            make_plot(data(),
                      xvar = "Rank",
                      yvar = "Networth",
                      colorvar = "Continent",
                      type = "scatter")
        })

    # Output da tabela de registros de acordo com o(s) país(es)
    # selecionado(s).
    output$billionaireTable <-
        renderReactable({
            make_table(data()[, 1:6])
        })

    # Renderização dos gráficos de barras, sempre mostrando as 15
    # maiores médias de cada variável.
    output$billionaireNetWorth <-
        renderPlotly({
            # Sumarizando dados por média, de acordo com variável de
            # agrupamento.
            summary_data <-
                data() %>%
                group_by_(input$GROUPING) %>%
                summarize(Networth = mean(Networth)) %>%
                unique() %>%
                # Passando input do SelectInput como numérico.
                top_n(as.numeric(input$N_BINS)) %>%
                # Ordenando os dados pela variável de interesse.
                arrange(Networth)

            # Transformando a variável de agrupamento em fator
            # ordenado para melhorar a visualização.
            summary_data[[input$GROUPING]] <-
                factor(summary_data[[input$GROUPING]],
                       levels = summary_data[[input$GROUPING]])
            # Passa argumentos necessários para a criação dos gráficos
            # de barras.
            make_plot(data = summary_data,
                      xvar = input$GROUPING,
                      yvar = "Networth",
                      type = "vertical-bar",
                      colorvar = "Networth")
        })

})

#-----------------------------------------------------------------------
