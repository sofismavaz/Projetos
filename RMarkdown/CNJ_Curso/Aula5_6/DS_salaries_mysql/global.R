#-----------------------------------------------------------------------
# Aplicação desenvolvida por Felipe Queluz
#
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

# Criando conexão com o BD.
mgr <- dbDriver("MySQL")
conn <-  DBI::dbConnect(mgr,
                        user = Sys.getenv("DB_USER"),
                        password = Sys.getenv("DB_PASSWORD"),
                        host = Sys.getenv("DB_HOST"),
                        dbname = Sys.getenv("DB_NAME"))
# class(conn)
# methods(class = "MySQLConnection")

# SQL para algumas consultas.
benefits_query <- paste("SELECT * FROM benefits")
qualifications_query <- paste("SELECT * FROM qualifications")
title_location_query <- paste("SELECT * FROM title_location_company_salary")

# Resultados de benefits.
benefits <-
    DBI::dbGetQuery(conn,
                    benefits_query)
##' str(benefits)

# Resultados de qualifications.
qualifications <-
    DBI::dbGetQuery(conn,
                    qualifications_query)
##' str(qualifications)

# Resultados de title_location_company_salary.
title_location <-
    DBI::dbGetQuery(conn,
                    statement = title_location_query) %>%
    mutate(salary = as.numeric(salary))
str(title_location)

# Fechando conexões abertas.
lapply(dbListConnections(dbDriver(drv = "MySQL")), dbDisconnect)

#-----------------------------------------------------------------------
# Criando as tabelas que serão usadas.

# Salvando as posições com maiores salários médios para deixar
# pré-selecionado.
salary_top5 <-
    title_location %>%
    mutate(salary = as.numeric(salary)) %>%
    group_by(title) %>%
    summarize(salary = mean(salary, na.rm = TRUE)) %>%
    distinct() %>%
    slice_max(order_by = salary, n = 5)
##' salary_top5

# Juntando a base de qualificações com a base de salários, por id.
qualifications_salaries <-
    inner_join(select(title_location, "id", "salary"),
               qualifications,
               by = "id") %>%
    # Removendo id, pois aqui não nos interessa.
    select(-id) %>%
    # Mantendo salário como variável de interesse.
    pivot_longer(cols = -salary) %>%
    # Filtrando valores onde salário é NA.
    filter(!is.na(salary), value != "NA", value != 0) %>%
    # Agrupando por skill.
    group_by(name) %>%
    # Fazendo contagem de ocorrências de cada skill.
    mutate(n = n()) %>%
    # Mantemos apenas as que possuem contagem acima de 60.
    filter(n > 60) %>%
    # Sumarizando as médias de salário das qualificações.
    summarize(salary = round(mean(salary))) %>%
    # Mantendo valores únicos.
    unique() %>%
    # Renomeando "variable" para "skill".
    rename(skill = name) %>%
    # Deixando em ordem descendente.
    arrange(desc(salary))
##' qualifications_salaries

#-----------------------------------------------------------------------
