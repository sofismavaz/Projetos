#
# Script executado ao inicio do backup TSEfull
#

# Desativa o banco de Divulgacao na maquina local
ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/shutdiv2002.sh" 
