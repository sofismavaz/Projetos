#!/bin/gawk
# Aluno: Lucir Rocio Vaz ARL108053 / ARL108

# Encontra todas as ocorrencias a partir de um intervalo de tempo informado
#awk --assign=INICIO="$DT_INICIAL" --assign=FIM="$DT_FINAL" '
BEGIN {
	MESES="Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"
	ANO=2010
	INICIO=mktime(ANO" "mes" "dia" "00" "00" "00)
      }
{

# Separa a Hora, minuto e segundo
split($3,HORA,":")

# Obtem o Mes
MES=(index(MESES,$1)+3)/4
DIA=$2

# Gera Nova DAta no padrão Timestamp
#H_TMSTP = mktime(ANO" "MES" "dia" "HORA[1]" "HORA[2]" "HORA[3])
H_TMSTP = mktime(ANO" "MES" "DIA" "00" "00" "00)

if ( (H_TMSTP == INICIO) ) { print $0 }
}