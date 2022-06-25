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

library(tidyverse)
library(googlesheets4)
##' ls("package:googlesheets4")

#-----------------------------------------------------------------------
# Conexão com Google Drive e download dos dados.

# ATTENTION: ao rodar a função `gs4_auth()`, você será redirecionado
# para a autenticação. Uma lista de email com números associados pode
# aparecer. Você também pode escolher 0 para usar outro email. Com isso
# o seu navegador padrão vai abrir na tela de autenticação. Lá você verá
# que uma Tidyverse API pede acesso aos seus documentos. Você tem que
# marcar a opção que permite isso para poder fazer a leitura. Mais sobre
# o acesso e política de privacidade, acesse o link abaixo.

##' # Privacy policy for packages that access Google APIs
##' browseURL("https://www.tidyverse.org/google_privacy_policy/")

# Criando conexão com o Google sheets e extraindo dados.
googlesheets4::gs4_auth(
    scopes = "https://www.googleapis.com/auth/spreadsheets.readonly")

# Resultados de qualifications.
url <- "https://docs.google.com/spreadsheets/d/1i2z2RuxcGNku7u39ryCRyqLfib8pCi-El2eAeSsqe7w/edit#gid=1755798726"
##' browseURL(url)

qualifications <-
    googlesheets4::read_sheet(url,
                              sheet = "qualifications",
                              col_types = "i")

# Resultados de title_location_company_salary.
url <- "https://docs.google.com/spreadsheets/d/1i2z2RuxcGNku7u39ryCRyqLfib8pCi-El2eAeSsqe7w/edit#gid=1755798726"
##' browseURL(url)

title_location <-
    googlesheets4::read_sheet(url,
                              sheet = "title_location") %>%
    mutate(salary = as.numeric(salary))

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
