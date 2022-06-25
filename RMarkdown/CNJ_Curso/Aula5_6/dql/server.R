#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2022-jun-06 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

library(shiny)

colr <- brewer.pal(9, "Set1")
colr <- colorRampPalette(colr, space = "rgb")

shinyServer(
    function(input, output, clientData, session) {

        DESIGN_CREATION <- reactive({
            if (input$SET_SEED) {
                seed <- input$SEED
                set.seed(seed)
            } else {
                seed <- sample(100:999, size = 1)
                set.seed(seed)
            }
            tb <- dql_create(input$SIZE)
            tb$seed <- seed
            return(tb)
        })

        output$PLOTLAYOUT <- renderPlot({
            tb <- DESIGN_CREATION()
            print(tb)
            dql_layout(tb, colr)
        })

        output$DOWNLOADDATA <- downloadHandler(
            filename = function() {
                sprintf("dql-seed:%s.txt", DESIGN_CREATION()$seed)
            },
            content = function(file) {
                write.table(x = DESIGN_CREATION()$D,
                            file = file,
                            quote = FALSE,
                            row.names = FALSE,
                            sep = "\t")
            }
        ) # downloadHandler()
    }
)

#-----------------------------------------------------------------------
