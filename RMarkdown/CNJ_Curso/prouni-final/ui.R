#-----------------------------------------------------------------------
# Pacotes.

library(shiny)
library(shinydashboard)
library(shinyjs)
# https://cran.r-project.org/web/packages/dashboardthemes/readme/README.html
library(dashboardthemes)
 
#-----------------------------------------------------------------------

UF_choices <-
    sort(unique(uf_curso_set$SIGLA_UF_BENEFICIARIO_BOLSA))

dashboardPage(
    dashboardHeader(
        title = "Bolsas do PROUNI"
    ),
    dashboardSidebar(
        selectInput(inputId = "UF",
                    label = "Estado",
                    choices = UF_choices),
        selectInput(inputId = "CURSO",
                    label = "Curso",
                    choices = ""),
        actionButton(inputId = "EXECUTAR",
                     label = "Executar",
                     icon = icon("cog"))
    ),
    dashboardBody(
        useShinyjs(),
        shinyDashboardThemes(
            theme = c(
                "blue_gradient",
                "flat_red",
                "grey_light",
                "grey_dark",
                "onenote",
                "poor_mans_flatly",
                "purple_gradient")[]
        ),
        fluidRow(
            box(
                title = "Série",
                plotlyOutput("PLOT_ANO")
            ),
            box(
                title = "Instituições",
                plotlyOutput("PLOT_IES")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Mapa",
                leafletOutput("PLOT_COUNTY_MAP")
            ),
            box(
                title = "Pirâmite etária",
                plotlyOutput("PLOT_ETARY_PYRAMID")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Tipo de bolsa",
                highchartOutput("PLOT_SCHOLARSHIP")
            ),
            box(
                title = "Etinia",
                echarts4rOutput("PLOT_ETHNICITY")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Período",
                plotlyOutput("PLOT_PERIOD")
            )
        ) # fluidRow()
    ) # dashboardBody()
) # dashboardPage()

#-----------------------------------------------------------------------
