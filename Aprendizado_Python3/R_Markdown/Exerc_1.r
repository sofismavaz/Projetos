
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

import(cellranger)

, cli, curl, gargle, cola, googledrive, httr, ids, magrittr, métodos, purrr , rematch2 , rlang, tibble, utils, vctrs)



url <- "https://docs.google.com/spreadsheets/d/1tAeMng_wLlZfDfeeLzgV8h7vGqWmFhqQv1AAXf60HtU/edit?usp=sharing"

df <- googlesheets4::read_sheet(url, sheet="sensib-fungic")