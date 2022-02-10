#!/bin/bash
# Aluno: Lucir Rocio Vaz
# matricula: ARL108053 / ARL108
# Script que, procura em um determinado diretório e seus sub-diretórios, arquivos de uma determinada extensão e de um tamanho mínimo, previamente informados.
# Questão 02 - Prof. Herlon - Módulo Automação - março/2009
#

MSG () {
  echo
  echo "Erro de execução: a sintaxe do script é: $0 -e extensao -l tamanho_mínimo path"
  echo "Por favor informe os parâmetros solicitados"
  echo
  exit 1
}

if [ $# != 5 ]
then
  MSG
fi
if [ -z $1 ]
then
  MSG
fi
 
i=1		# Contador posicional
SINAL="+"	# Sinal da pesquisa, + maior, - Menor
UNID="M"	# Unidade de medida, M=Mega, K=Kbyte
ARQ="*"		#Prefixo dos arquivos a serem pesquisados
B="/"		#representa a barra do dispositivo

#for i in "$*" 
while [ "$i" -le $# ]
do
  OPCAO=`echo ${!i}`		# simplificação do uso do comando "eval"
				# que executa o shell duas vezes. pg 246
  if [ -z "$OPCAO" ]		# GANBIARRA!!! Passei mais de 6 horas 
#  if [ "$OPCAO" = "-e" ]	# Lutando pra entender o motivo e não 
  then 				# consegui resolver a parada !!!
    if [ "$i" -le $# ]		# fiz uma gandiarra.
    then
      i=`expr $i + 1`
    fi
    EXT=`echo $ARQ${!i}`
    next
  fi

  if [ "$OPCAO" = "-l" ]
  then
    if [ "$i" -le $# ]
    then
      i=`expr $i + 1`
    fi
    TAM=`echo ${!i}`
    if [ `expr $TAM + 1` ]
    then
      continue
    else
      MSG	# A variável não é um número
    fi
    TAM=`echo $SINAL${!i}$UNID`
    next
  fi
  j=`echo -e "$OPCAO" | cut -c 1`
  
  if [ "$j" = "$B" ]
  then
    DIR=`echo ${!i}`
  fi
  if [ "$i" -le $# ]
    then
      i=`expr $i + 1`
  fi
done

echo "saida Final:" $EXT, $TAM, $DIR, $OPCAO

# busca os arquivos, de acordo com os parâmetros montados no filtro anterior
find $DIR -size $TAM -name $EXT