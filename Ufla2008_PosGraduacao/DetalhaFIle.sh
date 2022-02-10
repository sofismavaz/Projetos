#!/bin/bash
# Lucir Rocio Vaz matricula: ARL108053 / ARL108

function ajuda() {
echo "+====================================================================================+"
echo "|                                                                                    |"
echo "| Mostra informações sobre um arquivo programa/aplicativo informado pelo usuario     |"
echo "|                                                                                    |"
echo "| A sintaxe para execucao do script é: ./script1.sh programa/aplicativo              |"
echo "|                                                                                    |"
echo "| => $1"
echo "|                                                                                    |"
echo "| Os erros de processamento podem ser relativos a:                                   |"
echo "|  * Parâmetro incorreto, ocorrerá quando o programa/aplicativo  não existir         |"
echo "|    ou quando você não tiver permissão de leitura                                   |"
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

# Encontra o arquivo no path
if [ "$1" = "-h" ]; then 
  ajuda "Procedimentos de execução do script                                             |"
fi
if [ -z "$1" ]; then
  ajuda "Procedimentos de execução do script                                             |"
fi
if [ "$#" -gt "1" ]; then
  ajuda "Procedimentos de execução do script                                             |"
fi
if [ -d "$1" ]; then
  echo "O parâmetro $1 é um diretório, você deve informar um programa/aplicativo"
  exit
fi
if [ -h "$1" ]; then
  echo "O parâmetro $1 é um link simbólico, você deve informar um programa/aplicativo"
  exit
fi

# Pesquisa a existência do arquivo/aplicação
for i in `find / -name "$1" 2>/dev/null`; do
  if [ ! -d  "$i" ]; then
    TIPO=`eval file -b "$i"`
    find "$i" -printf "Caminho do executável: %p\nTipo de arquivo: $TIPO\nTamanho do executável: %s bytes \nDono do executável: %u\nPermissões em octal: %m\n\n"
    A="1"
  fi
done

if [ -z $A ];then
  echo "Comando/aplicativo não existe ou não está no path."
fi