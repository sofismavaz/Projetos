#!/bin/bash
# Aluno: Lucir Rocio Vaz ARL108053 / ARL108

function ajuda() {
echo "+====================================================================================+"
echo "|                                                                                    |"
echo "| Converte o formato data e hora para o formato timestamp, a partir do arquivo       |"
echo "|       informado como parâmetro pelo usuário                                        |"
echo "| A sintaxe para execucao do script é: ./script1.sh arquivo                          |"
echo "|                                                                                    |"
echo "| => $1"
echo "|                                                                                    |"
echo "| Os erros de processamento podem ser relatios a:                                    |"
echo "|  * Parâmetro incorreto, por favor, verifique se o arquivo existe                   |"
echo "|    e você tem permissão de leitura                                                 |"
echo "|  * Você deve se certificar que o arquivo está no formato:                          |"
echo "|    Jun..9 23:03:53 donald shutdown[3820]: shutting down for system halt            |"
echo "|                                                                                    |"
echo "+====================================================================================+"
echo ""
# Encerra o Script
  exit 1
}

# Valida linguagem
unset ${!LC_*}
export LANG=pt_BR.UTF-8
export LC_COLLATE=pt_BR.UTF-8

# Verifica se o usuario deseja ajuda
if [ "$1" = "-h" ] ; then
  ajuda "Procedimentos de execução do script                                                               |"
fi

if [ "$#" = "0" ]; then
  ajuda "Procedimentos de execução do script                                                               |"
fi

if [ "$#" -gt "1" ]; then
  ajuda "Procedimentos de execução do script                                                               |"
fi

if [ -d "$1" ]; then
  ajuda "Você deve informar um arquivo no formato /var/log/messages                           |"
fi

if [ ! -e "$1" ]; then
  ajuda "O Arquivo $1 não existe ou não está no path                                          |"
fi

if [ ! -r "$1" ]; then
  ajuda "O Arquivo $1 não existe ou não está no path                                          |"
fi

if [ ! -r "$1" ]; then
  ajuda "Voce não tem permissão de leitura no arquivo $1                                      |"
fi

if [ -e "$1" ] && [ -r "$1" ]; then
gawk '
BEGIN {
	MESES="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
	ANO=2010
      }
{

# Separa a Hora, minuto e segundo
split($3,HORA,":")

# Obtem o Mes
MES=(index(MESES,$1)+3)/4
DIA=$2
TAM_LINHA=length($0)

# Gera Nova DAta no padrão Timestamp
H_TMSTP = mktime(ANO" "MES" "DIA" "HORA[1]" "HORA[2]" "HORA[3])

# Separa o restante da string
RESTO = substr($0,15,TAM_LINHA)

# Concatena Novo horário ao resto da string
print H_TMSTP RESTO
}' $1 > $1.timestamp
else
  ajuda "Procedimentos de execução do script                                                               |"
fi