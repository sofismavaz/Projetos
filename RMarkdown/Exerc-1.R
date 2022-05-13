ola.mundo <- function(){
    writeLines("Olá mundo")
}


x <- scan(what = "character")
texto <- readLines(n = 1)

fn.ex <- function() {
    cat("Digite o nome do time de futebol de sua preferência (em letras minúsculas)\n")
    time <- readLines(n = 1)
    if (time == "atletico-pr")
        cat("BOA ESCOLHA!!!\n")
    else cat("Ihh, tá mal de escolha...\n")
    return(invisible())
}
fn.ex()

