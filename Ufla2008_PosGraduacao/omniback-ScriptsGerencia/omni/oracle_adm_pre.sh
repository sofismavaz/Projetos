#
# Script executado ao inicio do backup TSEfull
#

# Desativa os bancos de dados da maquina local
ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/shutadm" 
