#!/usr/bin/sh
# 
# Script para o Pos-exec do datacist ORACLE para o Omniback II 2.55
# remocao dos archives dos Bancos do Oracle ( ac1). 
#
# HP-Brasil - 10/05/99 - 01/06/99
# Marcia Ferreira
#

# Identifica o $HOME do Oracle e verifica a existencia de archives (ac1)

ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/archives1.sh"

