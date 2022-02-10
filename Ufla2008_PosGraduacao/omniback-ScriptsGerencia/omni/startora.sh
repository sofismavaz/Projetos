#!/usr/bin/sh
# 
# Script para o Pre-exec do datacist ORACLE para o Omniback II 2.55
# para a parada dos Bancos do Oracle (ac1). 
#
# HP-Brasil - 10/05/99 - 01/06/99
# Marcia Ferreira
#

# Identifica o $HOME do Oracle e para o Banco (ac1)

/sbin/init.d/oracle start

mailx -s"Banco baixou AC1 -OK  " lrocio@tre-ac.gov.br
