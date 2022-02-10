#!/bin/bash

echo Content-type: text/html

echo

Debug=true
$Debug && exec 2>&1

INICIO=`date "+%d%m%Y-%A"`
CFG="/etc/htb"
ETH="eth0-qos.cfg"
BASE="/var/www/cgi-bin"
SBIN="/sbin"
ETH0="eth0-qos.cfg"
ETH1="eth1-qos.cfg"
PN=${0##*/}	# Program name
VER="1.0"
gerente="gerente"

echo "<HTML> <body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

IDCAMPOS() {
k=1
for nome_valor; do
# Extrai cada componente do seu par: class bandwidth limit burst priority client dst
nome_campo=$( echo "$nome_valor" | cut -d= -f1)
valor_campo=$( echo "$nome_valor" | cut -d= -f2 )

eval $nome_campo=\"$valor_campo\"
done
}
read TRIPA

IDCAMPOS "$TRIPA"

MENSAGEM_ERRO () {
DT=`date "+%c"`
echo "<H3>Erros de Processamento</H3>"
echo "<H5>$PN - $VER</H5><HR>"
echo "<UL>"

for i in "${erro[@]}"; do
  echo "<LI>$i</LI>"
done 
echo "</UL>"
exit 
}

if [ ! -x "$SBIN/q_parser" ] || [ ! -x "$SBIN/q_show" ] || [ ! -x "$SBIN/q_checkcfg" ] ||  [ ! -x "$SBIN/htb" ] ||  [ ! -x "$SBIN/htbgen" ] || [ ! -d "$CFG" ]; then
  erro[1]="Nao foi possivel identificar a presenca dos binarios do aplicativo HTB-Tools no sistema."
fi

if [[ ! -n "${#erro[@]}" ]]; then
  case "$opcao" in
      'start')
      /sbin/htb eth0 start
      sleep 5
      /sbin/htb eth1 start
	;;
      'stop')
      /sbin/htb eth0 stop
      /sbin/htb eth1 stop
  	;;
     'start_eth0')
      /sbin/htb eth0 start
	;;
     'stop_eth0')
      /sbin/htb eth0 stop
	;;
     'start_eth1')
      /sbin/htb eth1 start
	;;
     'stop_eth1')
      /sbin/htb eth1 stop
	;;
     'show_eth0')
      /sbin/q_show -i eth0 -f /etc/htb/eth0-qos.cfg
	;;
     'show_eth1')
      /sbin/q_show -i eth1 -f /etc/htb/eth1-qos.cfg
	;;
     'sair') break ;;
     *) break ;;
  esac
else
  MENSAGEM_ERRO "${erro[@]}"
fi

echo "</form> </body> </html>"
