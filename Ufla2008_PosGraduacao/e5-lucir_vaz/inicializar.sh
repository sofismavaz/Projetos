#!/bin/bash

echo Content-type: text/html

echo

Debug=true
$Debug && exec 2>&1

INICIO=`date "+%d%m%Y-%A"`
CFG="/etc/htb"
ETH="eth0-qos.cfg"
BASE="/var/www/cgi-bin"
PN=${0##*/}	# Program name
VER="1.0"
gerente="gerente"

echo "<HTML> <body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

echo "<form method=\"post\" action=\"/cgi-bin/executa_htb.sh\">"

echo "<BR><H2>Escolha uma op&ccedil;&atilde;o:</H2> <BR>"

echo "
<input type="radio" name="opcao" value="start"> Inicia o Servi&ccedil;o <BR>
<input type="radio" name="opcao" value="stop"> P&aacute;ra o Servi&ccedil;o <BR>
<input type="radio" name="opcao" value="start_eth0"> Incia a Interface Eth0 <BR>
<input type="radio" name="opcao" value="start_eth1"> Incia a Interface Eth1 <BR>
<input type="radio" name="opcao" value="stop_eth1"> P&aacute;ra a Interface Eth0 <BR>
<input type="radio" name="opcao" value="stop_eth1"> P&aacute;ra a Interface Eth1 <BR>
<input type="radio" name="opcao" value="show_eth0"> Mostra Tr&aacute;fego da Interface Eth0 <BR>
<input type="radio" name="opcao" value="show_eth1"> Mostra Tr&aacute;fego da Interface Eth0 <BR>
<BR>"

echo "<input value="Executar" type="submit"> <input value="Corrigir" type="reset"> <input value="Cancelar" type="reset">"

echo "</form> </body> </html>"
