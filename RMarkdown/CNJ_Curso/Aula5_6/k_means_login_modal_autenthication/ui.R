#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-14 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
setwd("/home/lrocio/Projetos/RMarkdown/CNJ_Curso/Aula5_6/k_means_login_modal_autenthication")
# Pacotes.

library(shiny)
library(shinythemes)

# Para modal de login.
# https://github.com/datastorm-open/shinymanager
library(shinymanager)
# packageDescription("shinymanager")
# ls("package:shinymanager")

#-----------------------------------------------------------------------
# Front-end.

# Código base para essa aplicação foi retirado de
# https://shiny.rstudio.com/gallery/kmeans-example.html.

# k-means only works with numerical variables,
# so don't give the user the option to select
# a categorical variable.
vars <- setdiff(names(iris), "Species")

ui <- fluidPage(
    class = "container",
    # theme = shinytheme("superhero"),
    shinythemes::themeSelector(),
    # shinythemes::shinytheme("paper"),
    headerPanel("Iris k-means clustering"),
    sidebarLayout(
        sidebarPanel(
            width = 3,
            selectInput("xcol", "X Variable", vars),
            selectInput("ycol", "Y Variable", vars, selected = vars[[2]]),
            numericInput("clusters", "Cluster count", 3, min = 1, max = 9)
        ),
        mainPanel(
            plotOutput("plot1",
                       width = "600px",
                       height = "600px")
        )
    )
)

#-----------------------------------------------------------------------
# Modal de autenticação.

if (login_screen) {
    shinymanager::set_labels(
        language = "pt-BR",
        "Dashboards com R" = "Você precisa efetuar login",
        "Usuário:" = "Forneça o seu nome de usuário:",
        "Senha:" = "Sua senha")
    shinymanager::secure_app(
        language = "pt-BR",
        theme = shinythemes::shinytheme("paper"),
        tag_img = div(
            tags$img(
            src = "https://upload.wikimedia.org/wikipedia/commons/8/83/Logo_cnj.jpg",
            width = 200),
            h3(strong("Dashboards"), "com R")
        ),
        ui = ui,
        head_auth = tags$style(
            HTML(
                ".panel-body { padding: 50px; }",
                "#auth-shinymanager-auth-head { display: none;}",
                ""
            )
        )
    )
} else {
    ui
}

#-----------------------------------------------------------------------
