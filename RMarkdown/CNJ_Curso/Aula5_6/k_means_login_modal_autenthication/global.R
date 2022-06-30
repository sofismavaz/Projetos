#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-14 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Modal de autenticação.

# Deixar como `FALSE` enquanto desenvolve.
login_screen <- FALSE

# Isso pode ser consultado e validado em um BD. Lembre-se: senhas,
# tokens e outras informações pessoais não dever ficar em código,
# principalmente em código público.
credentials <- data.frame(
    user = c("admin"),
    password = c("admin")
)

#-----------------------------------------------------------------------
