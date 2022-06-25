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
library(plotly)
library(DT)

#-----------------------------------------------------------------------

server <- function(input, output, session) {

    title_location_filter <-
        reactive({
            title_location %>%
                filter(title %in% input$JOBS)
        })

    output$SALARY_PLOT <-
        renderPlotly({
            data <- title_location_filter() %>%
                group_by(title) %>%
                summarize(salary = mean(salary, na.rm = TRUE)) %>%
                unique()
            out <- ggplot(data,
                          mapping = aes(x = reorder(title, salary),
                                        y = salary, label = salary)) +
                geom_bar(stat = "identity") +
                theme_classic() +
                theme(axis.text.x = element_text(angle = 45)) +
                labs(x = "Position",
                     y = "Salary")
        ggplotly(out, tooltip = "label")
    })

    output$QUALIFICATION_TABLE <-
        renderDT({
            datatable(qualifications_salaries) %>%
                formatCurrency(2)
        })
}

#-----------------------------------------------------------------------
