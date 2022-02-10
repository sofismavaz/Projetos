#!/usr/bin/sh
# 
# Script para o Pre-exec do datacist ORACLE para o Omniback II 2.55
# para a parada dos Bancos das Eleicoes (TRE, ele96)
#
# Alterado por Lucir Rocio Vaz
#

# Identifica o $HOME do Oracle e para o Banco (ac1)

ORACLE_HOME=`grep ^oracle: /etc/passwd | cut -d: -f6`
su - oracle -c  "/usr/suporte/omni/shut_eleicoes"
