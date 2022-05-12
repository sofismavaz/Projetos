
---
title: "Exercícios "
date: "`r Sys.Date()`"
author: "Sofisma Vaz"
---


```{r, echo = FALSE}
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  purl = NOT_CRAN,
  eval = NOT_CRAN
)
```

```{r eval = FALSE}
library(testthat)
library(googlesheets)
if (identical(tolower(Sys.getenv("NOT_CRAN")), "true")) {
  test_check("googlesheets")
}
```
library(googlesheets)



# Curso R Mardown - Prof. Isaias

## Vetores

vendedores <- c("carlos", "maria", "João")
Matrizes 
<!-- 
matriz

array(elemento, dim(l, c, nr matriz), nome da dimensão)
>

A <- matrix(1:20,4,5)

array(A, dim = c(2,6,4))


array(A, dim = c(2,6))


x <- rnorm(30)
hist(x)

library(rmarkdown)

hgd(x)

hgd_browse(x)


x = seq(0, 133 * pi, by = 0.1)
plot(x, sin(x), type = "l")

plot(x, cos(x), type = "l")


library(ggplot2)


str(r12)

str(r1)

dados$quant_Fev

library(knitr)

## Dimensionamento do data frame

ncol(dados)
nrow(dados)

dim(dados)
names(dados)

utils::View(dados)
utils::View(dados$quant_Fev)

summary(dados)


a<-c(1,3,5,7,9)
b<-c(5,6,3,8,9)
c<-c("a","a","b","a","b")

dados_1<-data.frame(a,b,c)

utils::View(dados_1)
summary(dados_1)

dados_1[c(1:5),c(2,3)]
dados_1[,2]

setwd("/home/lrocio/Projetos")

s1 <- (2*4)+(3**2)/(4.1-1.3)

###### Criação de Dataframes

## Opção 1
fornecedores<-c("Aliança","Boltão","Elite","Domus","Xgurio")
quant_Jan<-c(320,230,100,340,10)
quant_Fev<-c(220,630,60,50,60)
quant_Mar<-c(520,430,100,34,10)

resumo<-cbind(fornecedores,quant_Jan,quant_Fev,quant_Mar)
resumo_l<-rbind(fornecedores,quant_Jan,quant_Fev,quant_Mar)

r1 <- rbind(quant_Jan)

r11 <- as.character(quant_Jan)
r12 <- as.numeric(quant_Jan)

## Opção 2
resumo_df<-as.data.frame(resumo)

dados_r1 <- data.frame(fornecedores=c("A","B","E","D","X"),
            quant_Jan=c(320,230,100,340,10),
           quant_Fev=c(220,630,60,50,60),
           quant_Mar=c(520,430,100,34,10))

## Opção 3
# dados<-data.frame(V1=fornecedores,V2=quant_Jan,V3=quant_Fev)

dados <- data.frame(fornecedores, quant_Jan, quant_Fev, quant_Mar)

nrow(resumo)

for (i in 1:nrow(dados)) {
 # print(dados$quant_Jan[i])
 cat("valor da linha: ", dados$quant_Jan[i], "do Fornecedor: ", dados$fornecedores[i], "Valor da variável i: ", i, "\n")

}

dados$fornecedores


