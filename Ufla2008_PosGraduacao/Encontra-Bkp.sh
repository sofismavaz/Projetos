#!/bin/bash
# Aluno: Lucir Rocio Vaz matricula: ARL108053 / ARL108

function ajuda() {
echo "+====================================================================================+"
echo "|                                                                                    |"
echo "| Procura num diretorio e em seus subdiretorios arquivos terminados                  |"
echo "| com .bak ou com ~. Grava o resultado num arquivo de nome backupfile.log no         |"
echo "| diretório pessoal do usuário que executou o script.                                |"
echo "|                                                                                    |"
echo "| A sintaxe para execucao do script é: ./script2.sh nome_diretorio                   |"
echo "|                                                                                    |"
echo "| => $1"
echo "|                                                                                    |"
echo "| Os erros de processamento podem ser relatios a:                                    |"
echo "|  * Parâmetro incorreto, por favor, verifique se o diretório existe e você          |"
echo "|    tem permissão de leitura no mesmo                                               |"
echo "| IMPORTANTE: o arquivo log gerado será sobrescrito ao se executar novemente o script|"
echo "|  * Não serão apresentados os erros de acesso à diretórios ou a arquivos que        |"
echo "|    você não tenhapermissão de acesso.                                              |"
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
  ajuda "Procedimentos de execução do script                                             |"
fi
if [ -z "$1" ]; then
  ajuda "Procedimentos de execução do script                                             |"
fi
if [ "$#" -gt "1" ]; then
  ajuda "Procedimentos de execução do script                                             |"
fi
# Valida aceso ao diretório
if [ ! -d "$1" ]; then
  echo "O diretório $1 não existe ou foi digitado incorretamente"
  exit
fi
if [ ! -r "$1" ]; then
  echo "Voce não tem permissão de leitura no diretório $1"
  exit
fi

BACKUPFILE="backupfile.log"
eval BKP="~/$BACKUPFILE"

if [ -d "$1" ] && [ -r "$1" ]; then
  find $1 -name "*.bak" -or -name "*~" > "$BKP" 2> /dev/null
  if [ ! -s "$BKP" ]; then
    echo "Não foram encontrados nenhum arquivo com as extensões .bak e *~"
#  else
# Não foi solicitada nenhuma apresentação de resultados.
#    OPCAO="S"
#    echo "Deseja ver o conteúdo da pesquisa? (S/N)" read $OPCAO
#    case $OPCAO in
#	"S") cat $BKP; ;;
#	"*") break; 
#    esac
  fi
else
  echo "O parâmetro $1 é inadequado ou foi digitado incorretamente"
fi