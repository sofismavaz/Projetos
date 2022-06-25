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

    observe({
        if (check_chr_input(input$UF) &&
                check_chr_input(input$CURSO)) {
            shinyjs::enable(id = "EXECUTAR")
        } else {
            shinyjs::disable(id = "EXECUTAR")
        }
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

    output$PLOT_COUNTY_MAP <- renderLeaflet({
        tb_sel <- FILTERED_DATA()
        plot_county_map(tb_sel, tb_mun)
    })

    output$PLOT_ETHNICITY <- renderEcharts4r({
        tb_sel <- FILTERED_DATA()
        plot_ethnicity(tb_sel)
    })

    output$PLOT_SCHOLARSHIP <- renderHighchart({
        tb_sel <- FILTERED_DATA()
        plot_scholarship(tb_sel)
    })

    output$PLOT_ETARY_PYRAMID <- renderPlotly({
        tb_sel <- FILTERED_DATA()
        plot_etary_pyramid(tb_sel)
    })

    output$PLOT_PERIOD <- renderPlotly({
        tb_sel <- FILTERED_DATA()
        plot_period(tb_sel, plotly = TRUE)
    })

}) # shinyServer()
