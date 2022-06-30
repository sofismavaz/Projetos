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

# Ubuntu: sudo apt-get install libssl-dev libsasl2-dev
# pkgs <- c("mongolite", "reactable", "countrycode",
#           "plotly", "shinydashboard")
# install.packages(pkgs)

library(mongolite)
ls("package:mongolite")

library(tidyverse)
library(reactable)
library(countrycode)

#-----------------------------------------------------------------------
# Armazenando credenciais de conexão em uma lista.
# NOTE: você já sabe que não deve deixar isso dentro do script.

credentials <- list(user = "CNJMongoDBUser",
                    password = "C1W7N9ffHwRU1tZ1")

# Realizando a conexão com o banco de dados remoto.
connection_string <-
    sprintf(
        "mongodb+srv://%s:%s@rshiny.v1mhjhl.mongodb.net/?retryWrites=true&w=majority",
        credentials$user,
        credentials$password
    )

# IMPORTANT: para fazer a conexão, é necessário que o admin do BD
# adicione o seu IP à lista de pontos de acesso confiáveis.
dbconnect <- mongo(
    collection = "forbesBillionaires",
    url = connection_string,
    db = "forbesDB"
)
# class(dbconnect)
# methods(class = "mongo")
# methods(class = "jeroen")

# Conteúdo dentro do objeto.
names(dbconnect)

# Tipo do conteúdo.
sapply(dbconnect,
       function(x) {
           if (is.function(x)) args(x) else class(x)
       })

#-----------------------------------------------------------------------
# Preparo dos dados.

# Executando a query, retornando registros do banco de dados ordenados
# por patrimônio.
billionaires_query <-
    dbconnect$find(sort = '{"Networth":-1}')

# Usando o pacote {countrycode} para poder agrupar os dados por
# continente.
billionaires_query$Continent <-
    countrycode(sourcevar = billionaires_query[, "Country"],
                origin = "country.name",
                destination = "continent")

# Reordenando colunas para melhorar a visualização da tabela, e criando
# categorias de idade.
billionaires <- billionaires_query[, c(1, 2, 3, 4, 8, 5, 6, 7)] %>%
    mutate(Age = cut(Age,
                     breaks = c(10, 30, 40, 50, 60, 70, 80, 90, 105),
                     right = FALSE))

#-----------------------------------------------------------------------
# Funções para usar na aplicação.

# Função de criação da tabela.
make_table <- function(data,
                       grouping_variable = NULL){
    reactable::reactable(
        data = data,
        columns = list(
            `Networth` = colDef(
                name = "Networth (Billions)",
                format = colFormat(currency = "USD",
                                   separators = TRUE,
                                   locales = "en-US")
            )
        ),
        groupBy = grouping_variable,
        defaultSortOrder = "desc",
        defaultPageSize = 10,
        filterable = TRUE,
        searchable = TRUE)
}

# Função de criação dos gráficos de dispersão e barra.
make_plot <- function(data,
                      xvar,
                      yvar,
                      colorvar,
                      type = c("scatter", "vertical-bar")){
    type <- match.arg(type)
    plot <- switch(
        type,
        "scatter" = {
            ggplot(data,
                   mapping = aes_string(
                       x = xvar, y = yvar,
                       color = colorvar)
                   ) +
                theme_light() +
                scale_color_brewer(palette = "Spectral") +
                geom_point()
        },
        "vertical-bar" = {
            ggplot(data, aes_string(
                x = xvar, y = yvar,
                fill = colorvar
            )) +
                coord_flip() +
                theme_light() +
                scale_color_brewer(palette = "Blues") +
                geom_bar(stat = "identity") +
                labs(x = "") +
                theme(legend.position = "none")
        },
        stop("Valor desconhecido para argumento `type`."))
    ggplotly(plot)
}

#-----------------------------------------------------------------------
