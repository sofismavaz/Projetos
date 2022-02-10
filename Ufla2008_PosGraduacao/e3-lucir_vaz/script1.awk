#!/bin/gawk
# Aluno: Lucir Rocio Vaz ARL108053 / ARL108

#  Converte o formato data e hora para o formato timestamp, a partir do arquivo
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
print H_TMSTP RESTO >> FILENAME".timestamp"
}

