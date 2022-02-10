#!/usr/bin/sh
#
# Script para o Pre-exec do Datalist ARCHIVES para o Omniback II 2.55
#
# HP-Brasil - 10/05/99 
# Marcia Ferreira
#

# Inicializacao das variaveis

DIRARCH="/oraarch/adm"		# Diretorio onde estao os archives
DIREXP="/oraexp/adm"		# Diretorio onde estao os archives
DIRTMP="/usr/suporte/log"
ARQAPG="${DIRTMP}/diario.tmp"		# Archives a serem removidos
datahora=`date +"%d%m%y"`
ARQLOG="${DIRTMP}/apg.$datahora"

# Atualizacao dos Archives

instances=`grep ":Y$" /etc/oratab | cut -d: -f1 | grep -v "^#"`

#for banco in $instances
#do
  #ORACLE_SID=$banco
  #totproc=`ps -ef| grep ora_.*_${ORACLE_SID} | grep -v grep | wc -l`
  #if [ $totproc -gt 3 ]
  #then
    #ORACLE_TERM=hp
    #TERM=hp
    #export ORACLE_SID ORACLE_TERM TERM
    #echo "=========    Shutdown do Banco de Dados $ORACLE_SID =========" >>  $ARQLOG
    #/ora00/app/oracle/product/7.3.4/bin/svrmgrl  >> $ARQLOG 2>&1 <<!
    #connect internal
    #alter database archivelog 
#!
  #fi
#done

# Gera o nome dos archives que deverao subir no backup

cd ${DIRARCH}
dir=`ls ${DIRARCH}`
for i in $dir
do
ls -tr $i/*.arc >> $ARQAPG.$i
aux=`wc -l $ARQAPG.$i | cut -d" " -f1`

# Avalia se ha archives para apagar

echo "$datahora --------- Existem no total $aux Archives no Banco $i ---------- " >> $ARQLOG
if [ $aux -gt 30 ]
then		 	# Nao apaga os ultimos 05 archives
ed - $ARQAPG.$i <<!
\$-4,\$d
w
q
!
else 		 	# Menos de 05. Nao apaga os archives
  echo "$datahora --------- Removendo $ARQAPG$i ---------- " >> $ARQLOG
  rm $ARQAPG.$i
fi
done
chmod o+r $ARQLOG

# Gera o nome dos arquivos de export que deverao subir no backup

cd ${DIREXP}
dir=`ls ${DIREXP}`
for i in $dir
do
ls -tr $i/expadm* >> $ARQAPG.$i
aux=`wc -l $ARQAPG.$i | cut -d" " -f1`

# Avalia se ha arquivos de export para apagar

echo "$datahora --------- Existem no total $aux Arquivos de export $i ---------- " >> $ARQLOG
if [ $aux -gt 5 ]
then		 	# Nao apaga os ultimos 05 exports
ed - $ARQAPG.$i <<!
\$-4,\$d
w
q
!
else 		 	# Menos de 05. Nao apaga os arquivos de export
  echo "$datahora --------- Removendo $ARQAPG$i ---------- " >> $ARQLOG
  rm $ARQAPG.$i
fi
done
chmod o+r $ARQLOG


# Gera o nome dos arquivos de log que deverao subir no backup

cd ${DIRTMP}
dir=`ls ${DIRARCH}`
for i in $dir
do
ls -tr $i/apg.* >> $ARQAPG.$i
ls -tr $i/shut.* >> $ARQAPG1.$i
ls -tr $i/start.* >> $ARQAPG2.$i
aux=`wc -l $ARQAPG.$i | cut -d" " -f1`
aux1=`wc -l $ARQAPG1.$i | cut -d" " -f1`
aux2=`wc -l $ARQAPG2.$i | cut -d" " -f1`

# Avalia se ha arquivos para apagar

echo "$datahora --------- Existem no total $aux , $aux1, $aux2 Archives no Banco $i ---------- " >> $ARQLOG
if [ $aux -gt 5 ]
then		 	# Nao apaga os ultimos 05 archives
ed - $ARQAPG.$i <<!
\$-4,\$d
ed - $ARQAPG1.$i <<!
\$-4,\$d
ed - $ARQAPG2.$i <<!
\$-4,\$d
w
q
!
else 		 	# Menos de 05. Nao apaga os archives
  echo "$datahora --------- Removendo $ARQAPG$i ---------- " >> $ARQLOG
  rm $ARQAPG.$i
fi
done
chmod o+r $ARQLOG
