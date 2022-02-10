#
# Script executado ao termino do backup TSEfull
#

# Restarta os bancos de dados da maquina tse1
ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/startdiv2002.sh"
