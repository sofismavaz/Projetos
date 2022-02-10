# 
# Script para o Pre-exec do Omniback II 2.55
# para parar o Banco de Divulgacao da Eleicao 2002 no Oracle. 
# Chamada a partir do script /usr/suporte/omni/oracle_div2002_pre.sh
# Alterado por Lucir Rocio Vaz em 19/09/2002 as 12:53
#

# Cria Variavel do script

ORACLE_SID=div2002
ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
datahora=`date +"%d%m%y%H%M"`
arqlog="/usr/suporte/log/shutora_div2002.$datahora"
export ORACLE_SID ORACLE_HOME

>$arqlog
chmod o+r $arqlog

# Para cada banco

echo "=========    Shutdown do Banco de Dados Div2002    ==========" >> $arqlog
    $ORACLE_HOME/bin/svrmgrl  >> $arqlog 2>&1  <<!
    connect internal
    alter system checkpoint;
    startup force restrict;
    shutdown immediate
!
