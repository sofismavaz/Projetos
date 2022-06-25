#-----------------------------------------------------------------------
# Pacotes.

# rm(list = ls())
 
Instala_Pacotes <- function() {
    pkgs <- c( "dashboardthemes", "shiny", "shinydashboard", "shinyjs",
    "data.table", "echarts4r", "highcharter", "leaflet", "plotly",
    "tidyverse", "DataExplorer")

    install.packages(pkgs, dependencies = TRUE)
}

library(tidyverse)
library(DataExplorer)
library(leaflet)
library(plotly)
#library(echarts4r)
#library(highcharter)
#library(geobr)

#-----------------------------------------------------------------------
# Leitura da tabela de dados.

# tb <- data.table::fread("./prouni_2005_2019.csv")
tb <- data.table::fread("./prouni_2005_2019-top150.csv")
# str(tb)

# DataExplorer::plot_bar(tb)
# DataExplorer::plot_histogram(tb)

# tb %>%
#     count(NOME_CURSO_BOLSA, sort = TRUE)
#
# tb %>%
#     count(NOME_IES_BOLSA, sort = TRUE)

tb <- tb %>%
    mutate_at(c("MUNICIPIO_BENEFICIARIO_BOLSA",
                "NOME_CURSO_BOLSA"),
              ~toupper(iconv(., to = "ASCII//TRANSLIT")))

# Idade na concessão da bolsa.
tb <- tb %>%
    mutate(IDADE_BENEFICIARIO =
               ANO_CONCESSAO_BOLSA -
               as.integer(strftime(DT_NASCIMENTO_BENEFICIARIO, "%Y")))

#-----------------------------------------------------------------------
# Filtrar para fazer o APP.

# tb_freq <- tb %>%
#     filter(SIGLA_UF_BENEFICIARIO_BOLSA %in%
#                c("MS", "PR", "RO", "CE", "ES")) %>%
#     count(NOME_CURSO_BOLSA, sort = TRUE) %>%
#     head(150)
# tb_freq
#
# tb_sel <- tb %>%
#     filter(NOME_CURSO_BOLSA %in%
#                tb_freq[[1]]) %>%
#     filter(SIGLA_UF_BENEFICIARIO_BOLSA %in%
#                c("MS", "PR", "RO", "CE", "ES"))
# str(tb_sel)
#
# write_csv(tb_sel,
#           file = "./prouni_2005_2019-top150.csv")

#-----------------------------------------------------------------------
# Base geográfica.

url <- "https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/main/csv/estados.csv"
tb_uf <- data.table::fread(url)
# str(tb_uf)

url <- "https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/main/csv/municipios.csv"
tb_mun <- data.table::fread(url)
# str(tb_mun)

tb_mun <- left_join(rename(tb_mun[, nome:codigo_uf], "MUN" = "nome"),
                    rename(tb_uf[, codigo_uf:nome], "ESTADO" = "nome"),
                    by = "codigo_uf")
# str(tb_mun)

# Deixar caixa alta.
tb_mun <- tb_mun %>%
    mutate_at(c("MUN", "ESTADO"),
              ~toupper(iconv(., to = "ASCII//TRANSLIT")))

#-----------------------------------------------------------------------
# Tabela com opções de UF e CURSO.

uf_curso_set <- tb %>%
    distinct(SIGLA_UF_BENEFICIARIO_BOLSA, NOME_CURSO_BOLSA) %>%
    filter(SIGLA_UF_BENEFICIARIO_BOLSA != "",
           NOME_CURSO_BOLSA != "")
# str(uf_curso_set)

#-----------------------------------------------------------------------
# Função para filtar os dados.

filter_data <- function(tb, UF, CURSO) {
    tb <- tb[
        SIGLA_UF_BENEFICIARIO_BOLSA == UF &
            NOME_CURSO_BOLSA == CURSO, ]
    tb
}

##' input <- list(UF = "MS", CURSO = "AGRONOMIA")
##' filter_data(tb, input$UF, input$CURSO) |>
##'     str()

#-----------------------------------------------------------------------
# Gráfico de série.

plot_ano <- function(tb_sel, plotly = FALSE) {
    tb_ano <- tb_sel %>%
        count(ANO_CONCESSAO_BOLSA, SEXO_BENEFICIARIO_BOLSA) %>%
        complete() %>%
        mutate(text = sprintf("Ano: %d\nSexo: %s\nQtd: %d",
                              ANO_CONCESSAO_BOLSA,
                              SEXO_BENEFICIARIO_BOLSA,
                              n))
    gg <- ggplot(data = tb_ano,
                 mapping = aes(x = ANO_CONCESSAO_BOLSA,
                               y = n,
                               color = SEXO_BENEFICIARIO_BOLSA,
                               group = SEXO_BENEFICIARIO_BOLSA,
                               text = text)) +
        geom_line() +
        geom_point() +
        labs(x = "Ano de concessão da bolsa",
             y = "Número de beneficiários",
             color = "Sexo do\nbeneficiário")
    if (plotly) {
        return(plotly::ggplotly(gg, tooltip = "text"))
    } else {
        return(gg)
    }
}

##' input <- list(UF = "MS", CURSO = "AGRONOMIA")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_ano(tb_sel, FALSE)
##' plot_ano(tb_sel, TRUE)

#-----------------------------------------------------------------------
# Gráfico de pareto das IES.

plot_ies <- function(tb_sel, plotly = FALSE) {
    tb_ies <- tb_sel %>%
        mutate(NOME_IES_BOLSA = fct_lump_n(NOME_IES_BOLSA,
                                           n = 5,
                                           other_level = "Outras")) %>%
        count(NOME_IES_BOLSA) %>%
        mutate(text = sprintf("Instituição: %s\nQtd: %d",
                              NOME_IES_BOLSA,
                              n)) %>%
        mutate(NOME_IES_BOLSA = str_wrap(NOME_IES_BOLSA, width = 14))
    gg <- ggplot(data = tb_ies,
                 mapping = aes(y = NOME_IES_BOLSA,
                               x = n,
                               text = text)) +
        geom_col() +
        labs(y = "Instituição",
             x = "Número de beneficiários")
    if (plotly) {
        return(plotly::ggplotly(gg, tooltip = "text"))
    } else {
        return(gg)
    }
}

##' input <- list(UF = "MS", CURSO = "AGRONOMIA")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_ies(tb_sel, FALSE)
##' plot_ies(tb_sel, TRUE)

#-----------------------------------------------------------------------
# Bubble map.

plot_county_map <- function(tb_sel, tb_mun) {
    tb_map <- tb_sel %>%
        count(SIGLA_UF_BENEFICIARIO_BOLSA,
              MUNICIPIO_BENEFICIARIO_BOLSA) %>%
        left_join(tb_mun,
                  by = c("SIGLA_UF_BENEFICIARIO_BOLSA" = "uf",
                         "MUNICIPIO_BENEFICIARIO_BOLSA" = "MUN")) %>%
        drop_na()
    leaflet::leaflet(tb_map) %>%
        leaflet::addTiles() %>%
        leaflet::addCircleMarkers(
            lng = ~longitude,
            lat = ~latitude,
            label = ~sprintf("%s: %d", MUNICIPIO_BENEFICIARIO_BOLSA, n),
            labelOptions = leaflet::labelOptions(textsize = "12px"),
            radius = ~sqrt(n),
            color = "black",
            fillOpacity = 0.5)
}

##' input <- list(UF = "MS", CURSO = "ENFERMAGEM")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_county_map(tb_sel, tb_mun)

#-----------------------------------------------------------------------
# Pirâmide etária.

plot_etary_pyramid <- function(tb_sel) {
    tb_idade <- tb_sel %>%
        filter(IDADE_BENEFICIARIO >= 16) %>%
        count(IDADE_BENEFICIARIO, SEXO_BENEFICIARIO_BOLSA) %>%
        complete() %>%
        mutate(text = sprintf("\nSexo: %s\nIdade: %d\nQtd: %d",
                              SEXO_BENEFICIARIO_BOLSA,
                              IDADE_BENEFICIARIO,
                              n))
    m <- max(tb_idade$n)
    tb_idade <- tb_idade %>%
        group_split(SEXO_BENEFICIARIO_BOLSA)
    fig <-
        plot_ly() %>%
        add_trace(
            y = tb_idade[[1]]$IDADE_BENEFICIARIO,
            x = -tb_idade[[1]]$n,
            name = tb_idade[[1]]$SEXO_BENEFICIARIO_BOLSA[1],
            marker = list(color = "pink"),
            hoverinfo = c("text"),
            hovertext = tb_idade[[1]]$text,
            type = "bar",
            orientation = "h") %>%
        add_trace(
            y = tb_idade[[2]]$IDADE_BENEFICIARIO,
            x = tb_idade[[2]]$n,
            name = tb_idade[[2]]$SEXO_BENEFICIARIO_BOLSA[1],
            marker = list(color = "cyan"),
            hoverinfo = c("text"),
            hovertext = tb_idade[[2]]$text,
            type = "bar",
            orientation = "h") %>%
        layout(
            barmode = "overlay",
            # bargap = 0,
            yaxis = list(title = "Idade do beneficiário"),
            xaxis = list(title = "Número de beneficiários",
                         range = c(-m, m)))
    fig
}

##' input <- list(UF = "MS", CURSO = "AGRONOMIA")
##' input <- list(UF = "MS", CURSO = "ENFERMAGEM")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_etary_pyramid(tb_sel)

#-----------------------------------------------------------------------
# Tipo de bolsa.

plot_scholarship <- function(tb_sel) {
    tb_bolsa <- tb_sel %>%
        count(MODALIDADE_ENSINO_BOLSA, TIPO_BOLSA) %>%
        complete() %>%
        mutate(text = sprintf("\nModalidade: %s\nBolsa: %s\nQtd: %d",
                              MODALIDADE_ENSINO_BOLSA,
                              TIPO_BOLSA,
                              n))
    tb_bolsa %>%
        highcharter::hchart(
            "column",
            highcharter::hcaes(x = "MODALIDADE_ENSINO_BOLSA",
                               y = "n",
                               group = "TIPO_BOLSA")) %>%
        # highcharter::hc_colors(c("")) %>%
        highcharter::hc_title(text = "Modalidade de ensino e tipo de bolsa") %>%
        highcharter::hc_yAxis(title = list(text = "Número de beneficiários")) %>%
        highcharter::hc_xAxis(title = list(text = "Modalidade de ensino"))
}

##' input <- list(UF = "MS", CURSO = "ENFERMAGEM")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_scholarship(tb_sel)

#-----------------------------------------------------------------------
# Raça.

plot_ethnicity <- function(tb_sel) {
    tb_raca <- tb_sel %>%
        count(RACA_BENEFICIARIO_BOLSA)
    tb_raca %>%
        echarts4r::e_charts(RACA_BENEFICIARIO_BOLSA) %>%
        echarts4r::e_pie(n, radius = c("30%", "70%"))
}

##' input <- list(UF = "MS", CURSO = "HISTORIA")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_ethnicity(tb_sel)

#-----------------------------------------------------------------------
# Turno.

plot_period <- function(tb_sel, plotly = FALSE) {
    gg <- ggplot(data = tb_sel,
           mapping = aes(x = NOME_TURNO_CURSO_BOLSA,
                         y = IDADE_BENEFICIARIO)) +
        geom_boxplot() +
        geom_jitter() +
        labs(x = "Período do curso",
             y = "Idade do beneficiário")
    if (plotly) {
        return(plotly::ggplotly(gg, tooltip = "text"))
    } else {
        return(gg)
    }
}

##' input <- list(UF = "MS", CURSO = "DIREITO")
##' tb_sel <- filter_data(tb, input$UF, input$CURSO)
##' plot_period(tb_sel, FALSE)
##' plot_period(tb_sel, TRUE)

#-----------------------------------------------------------------------
