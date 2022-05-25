exemplo1 <- fluidPage(

    dados <- read.csv2("http://www.leg.ufpr.br/~fernandomayer/data/crabs.csv"),

    plot(dados)
    p1 <- dir()
    length(p1)
    nrow(p1)

    p1[-1]
    getwd()

    for(i in 1:10){
        print(p1[i])
    }

    for(i in dir()){
        print(i)
    }
)
# --->