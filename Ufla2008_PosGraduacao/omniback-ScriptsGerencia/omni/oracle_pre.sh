#!/usr/bin/sh
# 
# Script para o Pre-exec do datacist ORACLE para o Omniback II 2.55
# para a parada dos Bancos do Oracle (ac1). 
#
# HP-Brasil - 10/05/99 - 01/06/99
# Marcia Ferreira
#

# Identifica o $HOME do Oracle e para o Banco (ac1)

ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/shut"
