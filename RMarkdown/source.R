# pacotes necessários pra rodar o R Markdown e shiny
# com o Visual Studio no Ubuntu 20.04

sudo apt-get upgrade

# Instruções: https://gist.github.com/kforeman/8551ce6679a3e8091543
sudo apt install r-base-core r-base r-base-dev

# Erros de instalação do pacote install.packages("languageserver", dependencies = T)
sudo apt-get install libssl-dev libxml2-dev 

