#!/usr/bin/sh
# 
# Script para o Pos-exec do datacist ORACLE para o Omniback II 2.55
# para reiniciacizar os Bancos do Oracle (ac1). 
#
# HP-Brasil - 10/05/99 - 01/06/99
# Marcia Ferreira
#

# Identifica o $HOME do Oracle e iniciaciza o Banco (ac1)

ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/start"

