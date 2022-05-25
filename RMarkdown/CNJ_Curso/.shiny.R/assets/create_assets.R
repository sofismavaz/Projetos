
# Pacotes.
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("readxl")) install.packages("readxl")

library(readxl)
library(tidyverse)





ex2 <- fluidPage(
    orc1 <- data.frame(read.csv2("/home/lrocio/Projetos/Base_textes/e1_Empenho.csv", header = TRUE, sep = ";", dec = ","))

    orc1$ANO_EMPENHO <- as.factor(orc1$ANO_EMPENHO)

    orc1$ANO_REF <- as.factor(orc1$ANO_REF)
    orc1$NR_CONTRATO <- as.factor(orc1$NR_CONTRATO)
    orc1$ANO_CONTRATO <- as.factor(orc1$ANO_CONTRATO)
    
    orc1$VALOR_INICIAL <- as.character.numeric_version(orc1$VALOR_INICIAL)
    orc1$PERIODO_INICIAL <- as.data.frame.Date(orc1$PERIODO_INICIAL)

    str(orc1)
   
    str(orc1$VALOR_INICIAL) 
        orc1$TIPO_NOTA

    s1 <- renderPlot(orc1, width = "auto")
    plotOutput(s1)

    

    unique.default(orc1$CARACT)
    unique.default(orc1$ANO_EMPENHO)

    plotOutput(grafico1)
)

ex3 <- fluidPage(
    expand.grid(orc1$VALOR_INICIAL, orc1$TIPO_NOTA_REF )    
    mean(orc1$NR_NOTA)
    match("400770", orc1$EVENTO_SEI)
    plot(orc1$ANO_EMPENHO, orc1$ANO_CONTRATO)
    mean(factor(orc1$VALOR_INICIAL))

)


ui <- fluidPage(
    titlePanel("lista"),
    fluidRow(
        column(4, fileInput("arq", "inf: ", multiple = F, accept = c(".csv")))
    ),
    fluidRow(
        column(8, plotOutput("arq"))
    )
)





