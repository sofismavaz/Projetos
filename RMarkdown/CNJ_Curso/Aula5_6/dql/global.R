#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-06 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Pacotes.

library(lattice)
library(RColorBrewer)

#-----------------------------------------------------------------------
# Função para aleatorizar experimento em quadrado latino.

dql_create <- function(dim) {
    # dim: escalar inteiro que é a dimensão do QL.
    M <- matrix(1:dim, dim, dim)
    N <- M + (t(M))
    O <- (N %% dim) + 1
    lin <- sample(1:dim)
    col <- sample(1:dim)
    M <- O[lin, col]
    D <- expand.grid(lin = gl(dim, 1), col = gl(dim, 1))
    D$trat <- c(M)
    return(list(M = M, D = D))
}

##' tb <- dql_create(5)
##' tb

#-----------------------------------------------------------------------
# Função para exibir o layout do delineamento.

dql_layout <- function(tb, colr) {
    levelplot(trat ~ lin + col,
              data = tb$D,
              aspect = 1,
              colorkey = FALSE,
              col.regions = colr,
              panel = function(x, y, z, ...) {
                  panel.levelplot(x = x, y = y, z = z, ...)
                  panel.text(x = x, y = y, labels = LETTERS[z])
              },
              xlab = "Linha",
              ylab = "Coluna")
}

##' tb <- dql_create(5)
##' tb
##' colr <- brewer.pal(9, "Set1")
##' colr <- colorRampPalette(colr, space = "rgb")
##' dql_layout(tb, colr)

#-----------------------------------------------------------------------
