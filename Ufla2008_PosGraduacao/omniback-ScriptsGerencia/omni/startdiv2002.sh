# 
# Script para o Pos-exec do Omniback II 2.55
# para inicializar o Banco de Divulgacao da Eleicao 2002 no Oracle. 
# Chamada a partir do script /usr/suporte/omni/oracle_div2002_pos.sh
# Alterado por Lucir Rocio Vaz em 19/09/2002 13:49h
#

# Cria Variavel
datahora=`date +"%d%m%y"`
ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
ORACLE_SID=div2002
arqlog="/usr/suporte/log/startora_div2002.$datahora"
> $arqlog

export ORACLE_SID

# Para cada banco

echo "=========    Start do Banco de Dados $ORACLE_SID    ==========" >> $arqlog
  $ORACLE_HOME/bin/svrmgrl >> $arqlog 2>&1  <<!
  connect internal
  startup 
!
