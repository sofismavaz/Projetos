#-----------------------------------------------------------------------
# Pacotes.
 
library(shiny)
library(shinydashboard)
library(shinyjs)
# https://cran.r-project.org/web/packages/dashboardthemes/readme/README.html
library(dashboardthemes)

#-----------------------------------------------------------------------
# Funções.

check_chr_input <- function(value) {
    is.character(value) &&
        length(value) == 1 &&
        !is.na(value) &&
        value != ""
}
##' check_chr_input("")
##' check_chr_input(character())
##' check_chr_input(NA_character_)
##' check_chr_input("MS")

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
        shinyDashboardThemes(
            theme = c(
                "blue_gradient",
                "flat_red",
                "grey_light",
                "grey_dark",
                "onenote",
                "poor_mans_flatly",
                "purple_gradient")[3]
        ),
        fluidRow(
            box(
                title = "Série",
                h2("Usar a `plot_ano()`.")
            ),
            box(
                title = "Instituições",
                h2("Usar a `plot_ies()`.")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Mapa",
                h2("Usar a `plot_county_map()`.")
            ),
            box(
                title = "Pirâmite etária",
                h2("Usar a `plot_etary_pyramid()`.")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Tipo de bolsa",
                h2("Usar a `plot_scholarship()`.")
            ),
            box(
                title = "Etinia",
                h2("Usar a `plot_ethnicity()`")
            )
        ), # fluidRow()
        fluidRow(
            box(
                title = "Período",
                h2("Usar a `plot_period()`")
            )
        ) # fluidRow()
    ) # dashboardBody()
) # dashboardPage()

#-----------------------------------------------------------------------
