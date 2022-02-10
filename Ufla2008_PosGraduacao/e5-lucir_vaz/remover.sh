#!/bin/bash
# Lucir Rocio Vaz - ARL108053

echo Content-type: text/html
echo

# Redireciona a saida de erro para um arquivo especifico

CFG="/etc/htb"
HTB="HTB-tools-$VERSAO"
SBIN="/sbin"
ETH0="eth0-qos.cfg"
ETH1="eth1-qos.cfg"
BASE="/var/www/cgi-bin"
ARQ_LOG="$BASE/htb_install_$INICIO.log"
ARQHTB="$BASE/$HTB.tar.gz"
HTB_ETH_QOS="eth0-qos.cfg"
PN=${0##*/}	# Program name
VER="1.0"
gerente="gerente"

echo "<HTML>"
echo "<body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

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

if [ ! -d "$CFG" ]; then
    erro[5]="O diretorio com os arquivos de configuracao do HTB-tools nao esta presente."
fi

if [ ! -f "$CFG/$ETH0" ]; then
  erro[1]="O arquivo de configuracao <I><U>$CFG/$ETH0</U></I> nao esta presente."
fi

if [ -f "$CFG/$ETH1" ]; then
  erro[2]="O arquivo de configuracao <I><U>$CFG/$ETH1</U></I> nao esta presente."
fi

if [ ! -w "$CFG/$ETH0" ]; then
  erro[1]="Nao ha permissao para remover o arquivo de configuracao <I><U>$CFG/$ETH0</U></I>."
fi

if [ -w "$CFG/$ETH1" ]; then
  erro[2]="Nao ha permissao para remover o arquivo de configuracao <I><U>$CFG/$ETH1</U></I>"
fi

if [ ! -x "$SBIN/q_parser" ] || [ ! -x "$SBIN/q_show" ] || [ ! -x "$SBIN/q_checkcfg" ] ||  [ ! -x "$SBIN/htb" ] ||  [ ! -x "$SBIN/htbgen" ] || [ ! -d "$CFG" ]; then
  erro[6]="Nao foi possivel identificar a presenca dos binarios do aplicativo HTB-Tools no sistema."
fi

if [ ! -w "$SBIN/q_parser" ] || [ ! -w "$SBIN/q_show" ] || [ ! -w "$SBIN/q_checkcfg" ] ||  [ ! -w "$SBIN/htb" ] ||  [ ! -w "$SBIN/htbgen" ]; then
  erro[6]="Nao ha permissao para remover os binarios do HTB-Tools."
fi

if [ ! -w "$CFG" ]; then
  erro[6]="Nao ha permissao para remover os arquivos de configuracao do HTB-Tools."
fi

if [[ ! -n "${#erro[@]}" ]]; then
  rm -f "$SBIN/q_parser" "$SBIN/q_show" "$SBIN/q_checkcfg" "$SBIN/htb" "$SBIN/htbgen" 2> "$ARQ_LOG"
  rm -rf "$CFG"
  echo "<H3>O aplicativo HTB-tolls foi removido com sucesso.<H3>"
else
  MENSAGEM_ERRO "${erro[@]}"
fi
