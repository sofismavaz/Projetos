#!/bin/bash

echo "content-type: text/html"
echo

Debug=true
$Debug && exec 2>&1
CFG="/etc/htb"
ETH="eth1-qos.cfg"
gerente="gerente"

echo "<HTML>"
echo "<body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

if [ ! -f "$CFG/$ETH" ]; then
  echo "<br><H4>O arquivo $CFG/$ETH, nao existe. Por favor escolher a opcao de criacao da Rede<H4>"
  echo "</body></html>"
  exit
fi

echo "<form method=\"post\" action=\"/cgi-bin/carrega_eth1.sh\">"
echo "<H3>Acesso para manuten&ccedil;&atilde;o</H3>"

echo "<p>Informe a quantidade de sub-redes a serem editadas</I></B><input name="qtde_redes" value="1" size="5" maxlength="5">"

echo "<input value="Enviar" type="submit"> <input value="Corrigir" type="reset"></p>"
echo "<br>   <br>   <br> <hr>"
echo "</form> </body> </html>"

