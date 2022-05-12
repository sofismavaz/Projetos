library(shiny)

nameui <- function(id) {
    ns <- NS(id)
    tagList(
    
        )
    }

name <- function(input, output, session) {
    ns <- session$ns
}

# Copy in UI
nameui("nameui")

# Copy in server
callModule(name, "nameui")

