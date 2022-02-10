#!/usr/bin/sh
#
# Script para o Pos-exec do Datalist ARCHIVES para o Omniback II 2.55
#
# HP-Brasil - 10/05/99
# Marcia Ferreira
#

# Inicializacao das variaveis

DIRARCH="/ora02/oraarch/"
DIRTMP="/usr/suporte/log"
ARQAPG="diario.tmp.*"		# Archives a serem removidos
datahora=`date +"%d%m%y"`
ARQLOG="${DIRTMP}/apg.$datahora"


# Se existir o arquivo, deleta os archives

cd ${DIRTMP}

if [ -f $ARQAPG ]
then

   for i in `cat $ARQAPG`
   do
      echo " ---------  Apagando ${DIRARCH}$i --------- " >> $ARQLOG
      rm -f ${DIRARCH}$i
   done
   rm $ARQAPG
fi
chmod o+r $ARQLOG
