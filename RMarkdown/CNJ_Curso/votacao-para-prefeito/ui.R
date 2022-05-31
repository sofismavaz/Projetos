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

fluidPage(
    titlePanel("Eleições para prefeito"),
    # Chama arquivo de CSS.
    includeCSS("www/style.css"),
    # Aplica alguns CSS aqui mesmo (bom para testar).
    tags$head(
        tags$style(
            ".card-counter .count-name {
                 font-style: normal !important;
                 text-transform: none !important;
                 font-size: 14px !important;
             }
             .card-counter .count-numbers {
                 font-weight: bolder;
             }"
        )
    ),
    sidebarLayout(
        sidebarPanel(
            width = 2,
            # Input de Unidade Federativa.
            selectInput(inputId = "UF",
                        label = "Unidade Federativa",
                        choices = sort(unique(br_municipal$abbrev_state)),
                        selected = "MS"),
            # Input de Ano Eleitoral.
            # selectInput(inputId = "ANO",
            #             label = "Ano eleitoral",
            #             choices = sort(unique(tb$Ano)),
            #             selected = max(tb$Ano, na.rm = TRUE))
            sliderInput(inputId = "ANO",
                        label = "Ano eleitoral",
                        min = min(tb$Ano),
                        max = max(tb$Ano),
                        value = max(tb$Ano),
                        step = 4L)
            ), # sidebarPanel()
        mainPanel(
            fluidRow(
                # Caixas de informação.
                uiOutput(outputId = "IB_UF"),
                uiOutput(outputId = "IB_ANO"),
                uiOutput(outputId = "IB_TOT"),
                uiOutput(outputId = "IB_PERC")
            ),
            hr(),
            fluidRow(
                column(
                    width = 6,
                    # Gráfico de barras.
                    plotOutput("BARPLOT")),
                column(
                    width = 6,
                    # Mapa.
                    plotOutput("MAP"))
            ),
            hr(),
            # Tabela.
            reactableOutput("TABLE")
        ) # mainPanel()
    ) # sidebarLayout()
) # fluidPage()

#-----------------------------------------------------------------------
