#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-07 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(DBI)
library(RMySQL)
library(pool)
library(tidyverse)

#-----------------------------------------------------------------------
# Fazendo a conexão e puxando os dados.

# ATTENTION: o bando de dados para essa aplicação foi hospedado
# gratuitamente no serviço \url{remotemysql.com}. É um banco de dados em
# MySQL e esse serviço disponibiliza até 100 MB para prototipação de
# aplicações.

# IMPORTANT: Abaixo você tem todas as credenciais para acesso ao banco
# mas isso não deveria ser público no repositório. Então você deve mover
# as instruções `Sys.setenv()` para o seu `.Rprofile` de usuário ou
# `.Rprofile` do repositório e esse arquivo não pode ser
# versinado/exposto em repositórios públicos por razões de segurança. No
# script use `Sys.getenv()` para acessar as variáveis de ambiente. Você
# também pode definir variáveis de ambiente no sistema operacional. O
# link abaixo dá exeplos de como fazer no Linux.
# https://www.serverlab.ca/tutorials/linux/administration-linux/how-to-set-environment-variables-in-linux/

# Deixar isso no `.Rprofile`.
Sys.setenv(DB_USER = "fkShATH4wF",
           DB_PASSWORD = "DDQw9kdvlt",
           DB_HOST = "remotemysql.com",
           DB_NAME = "fkShATH4wF")

# O {pool} a gerencia a conexão para otimização. Mais detalhes no link.
##' browseURL("https://shiny.rstudio.com/articles/pool-basics.html")

# Conectar no MySQL e buscar
conn <- dbPool(MySQL(),
               user     = Sys.getenv("DB_USER"),
               password = Sys.getenv("DB_PASSWORD"),
               host     = Sys.getenv("DB_HOST"),
               dbname   = Sys.getenv("DB_NAME"))
##' class(conn)
##' methods(class = "Pool")

# NOTE: conexão é fechada quando fecha o processo.
onStop(function() {
    poolClose(conn)
})

##' dbListTables(conn)
##' tbl(conn, "qualifications")

# Lista de opções para selecionar as posições.
title_set <-
    tbl(conn, "title_location_company_salary") |>
    distinct(title) |>
    collect() |>
    pull(title)

#-----------------------------------------------------------------------

# input <- list(TITLE = title_set[1])

shinyServer(function(input, output, session) {

    # Retorna o seletor para a interface.
    output$TITLE_UI <- renderUI(
        selectInput(
            inputId = "TITLE",
            label = "Selecione uma posição",
            choices = title_set,
            selected = title_set[1],
            multiple = FALSE,
            width = "100%",
            selectize = TRUE),
        )

    # Exibe a tabela com a lista.
    output$TABLE <- renderDT({
        tb_salaries <-
            tbl(conn, "title_location_company_salary") %>%
            filter(title == !!input$TITLE) %>%
            group_by(location) %>%
            summarise(mean_salary = mean(salary, na.rm = TRUE),
                      min_salary = min(salary, na.rm = TRUE),
                      max_salary = max(salary, na.rm = TRUE),
                      sd_salary = sd(salary, na.rm = TRUE),
                      n_jobs = n()) %>%
            collect()
        datatable(tb_salaries) %>%
            formatCurrency(2)
    })

})

#-----------------------------------------------------------------------
