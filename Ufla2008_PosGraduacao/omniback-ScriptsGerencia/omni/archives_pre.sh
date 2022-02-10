#!/usr/bin/sh
# 
# Script para o Pre-exec do datalist ORACLE para o Omniback II 2.55
# para parar os Bancos do Oracle. 
#
# HP-Brasil - 10/05/99
# Marcia Ferreira
#

# Identifica o $HOME do Oracle

ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/archives.sh"

