#!/bin/bash
# Aluno: Lucir Rocio Vaz ARL108053 / ARL108

function ajuda() {
echo "+====================================================================================+"
echo "|                                                                                    |"
echo "| Encontra todas as ocorrencias a partir de um intervalo de tempo informado          |"
echo "| A sintaxe para execucao do script é: ./script2.sh data_inicial data_final arquivo  |"
echo "|                                                                                    |"
echo "| => $1"
echo "|                                                                                    |"
echo "| Os erros de processamento podem ser relatios a:                                    |"
echo "|  * Parâmetro incorreto, por favor, verifique se a data está no formato adequado    |"
echo "|    ou se o nome do arquivo foi digitado errado e você tem permissão de leitura     |"
echo "|                                                                                    |"
echo "|  * Informe os parametros conforme a seguir:                                        |"
echo "|      script2.sh 09/06/2010-19:00:00 09/06/2010-22:00:00 filelog                    |"
echo "|      data e horário de início do intervalo: 09/06/2010-19:00:00                    |"
echo "|      data e horário de término do intervalo: 09/06/2010-22:00:00                   |"
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
  ajuda "Procedimentos de execução do script                                                  |"
fi

if [ "$#" = "0" ]; then
  ajuda "Procedimentos de execução do script                                                  |"
fi

if [ "$#" -gt "3" ]; then
  ajuda "Procedimentos de execução do script                                                  |"
fi

if [ -d "$3" ]; then
  ajuda "Você deve informar um arquivo no formato /var/log/messages                           |"
fi

if [ ! -e "$3" ]; then
  ajuda "O Arquivo $3 não existe ou não está no path                                  |"
fi

if [ ! -r "$3" ]; then
  ajuda "Voce não tem permissão de leitura no arquivo $3                              |"
fi

if [ -e "$3" ] && [ -r "$3" ]; then
# Trata variáveis período de início e fim
  D_I=`echo "$1" | cut -d"-" -f1`
  H_I=`echo "$1" | cut -d"-" -f2`
  D_F=`echo "$2" | cut -d"-" -f1`
  H_F=`echo "$2" | cut -d"-" -f2`

  DIA_I=`echo "$D_I" | cut -d"/" -f1`
  MES_I=`echo "$D_I" | cut -d"/" -f2`
  ANO_I=`echo "$D_I" | cut -d"/" -f3`
  DT_I=`echo "$MES_I/$DIA_I/$ANO_I $H_I"`

  DIA_F=`echo "$D_F" | cut -d"/" -f1`
  MES_F=`echo "$D_F" | cut -d"/" -f2`
  ANO_F=`echo "$D_F" | cut -d"/" -f3`
  DT_F=`echo "$MES_F/$DIA_F/$ANO_F $H_F"`

if [ ! `date -d "$DT_I $HR_I" +%s 2>/dev/null` ]; then
  ajuda "A data Inicial $1 não está num formato válido                  |"
fi

if [ ! `date -d "$DT_F $HR_F" +%s 2>/dev/null` ]; then
  ajuda "A data Final $2 não está num formato válido                    |"
fi

DT_INICIAL=`date -d "$DT_I $HR_I" "+%s"`
DT_FINAL=`date -d "$DT_F $HR_F" "+%s"`

awk --assign=INICIO="$DT_INICIAL" --assign=FIM="$DT_FINAL" '
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

if ( (H_TMSTP >= INICIO) && (H_TMSTP <= FIM) ) { print $0 }
}' "$3"
else
  ajuda "Procedimentos de execução do script                                                  |"
fi