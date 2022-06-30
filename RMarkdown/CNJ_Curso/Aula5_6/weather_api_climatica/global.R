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

# install.packages("owmr")
library(owmr)
ls("package:owmr")

library(tidyverse)
library(reactable)

#-----------------------------------------------------------------------
# Importação dados dados.

# Leitura de capitais brasileiras.
# capitais <- read.csv(url("https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/main/csv/municipios.csv")) %>%
url <- "https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/main/csv/municipios.csv"
capitais <- read.csv(url) %>%
    select(nome, capital) %>%
    filter(capital == 1) %>%
    # Remoção de acentos.
    # mutate(nome = stringi::stri_trans_general(nome, id = "Latin-ASCII"))
    mutate(nome = iconv(nome, to = "ASCII//TRANSLIT"))
# str(capitais)

# Dados obtidos de https://openweathermap.org/. A chave de API é criada
# ao registrar uma conta. Armazenando a chave API no environment,
# conforme indicado pela documentação.
# Lembre-se: deixar o comando abaixo no seu `.Rprofile`.
Sys.setenv(OWM_API_KEY = "07dbddcbfa3d938de7cd72e5316381af")

# IMPORTANT: essa chave de API é de Felipe Queluz. Não use de forma que
# possa vir a causar prejuízo a este usuário. Essa chave foi criada para
# fins didáticos. Para fins de desenvolvimento de algo próprio, crie uma
# chave para você.

#-----------------------------------------------------------------------
# Função para retornar temperatura da cidade e seus arredores através de
# busca textual. IMPORTANT: não incluir acentos no nome da busca nesta
# função. A transformação necessária já foi feita na base de capitais.

getCapitalAndSurroundings <- function(City, n_around){
    # Obtendo dados da cidade.
    city <- get_current(City, units = "metric")
    # Obtendo dados dos arredores baseados nas coordernadas da cidade.
    city_surroundings <-
        find_cities_by_geo_point(
            lat = city$coord$lat,
            lon = city$coord$lon,
            cnt = n_around,
            units = "metric"
        ) %>%
        # Transformando os dados para tabela.
        owmr_as_tibble() %>%
        mutate(Data_Hora = as.POSIXct(dt_txt)) %>%
        group_by(name) %>%
        # Obtendo apenas resultados mais recentes, no caso de cidades
        # duplicadas.
        slice(which.max(Data_Hora)) %>%
        # Selecionando apenas variáveis de interesse.
        select(name,
               temp,
               pressure,
               humidity,
               weather_main,
               wind_speed,
               weather_description) %>%
        rename(Cidade = name,
               Temperatura = temp,
               Pressão = pressure,
               Umidade = humidity,
               Tempo_Principal = weather_main,
               Clima_Descrição = weather_description,
               Vento_Velocidade = wind_speed)
}

# Criando tabela com formatação de unidades de medida, coloração e
# tamanho de fonte.
make_weather_table <- function(weather_data){
    reactable::reactable(
        weather_data,
        columns = list(
            Temperatura = colDef(
                format = colFormat(suffix = " ºC")),
            Umidade = colDef(
                format = colFormat(suffix = " g/Kg")),
            Vento_Velocidade = colDef(
                format = colFormat(suffix = " km/h")),
            Pressão = colDef(
                format = colFormat(suffix = " mb"))),
        theme = reactableTheme(
            backgroundColor = "#c9bfbd",
            borderColor = "#dfe2e5",
            stripedColor = "#f6f8fa",
            highlightColor = "#f0f5f9"),
        style = list(
            fontSize = "12px"
        )
    )
}

#-----------------------------------------------------------------------
