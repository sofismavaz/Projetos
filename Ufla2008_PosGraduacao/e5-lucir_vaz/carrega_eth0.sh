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

echo "<form method=\"post\" action=\"/cgi-bin/valida_eth0.sh\">"

IDCAMPOS() {
k=1
for nome_valor; do
# Extrai cada componente do seu par: class bandwidth limit burst priority client src
nome_campo=$( echo "$nome_valor" | cut -d= -f1)
valor_campo=$( echo "$nome_valor" | cut -d= -f2 )

eval $nome_campo=\"$valor_campo\"

if [ -z $client ]; then
  if [ $nome_campo = "class" ]; then
    class[$k]="$valor_campo"
  fi
  if [ $nome_campo = "bandwidth" ]; then
    bandwidth[$k]="$valor_campo"
  fi
  if [ $nome_campo = "limit" ]; then
    limit[$k]="$valor_campo"
  fi
  if [ $nome_campo = "burst" ]; then
    burst[$k]="$valor_campo"
  fi
  if [ $nome_campo = "priority" ]; then
    priority[$k]="$valor_campo"
    k=$((k+1))
  fi
else
  if [ "$client[$k]" != "$client_at" ]; then
    if [ $nome_campo = "client" ]; then
      client[$k]="$valor_campo"
    fi
    if [ $nome_campo = "bandwidth" ]; then
      bandwidth[$k]="$valor_campo"
    fi
    if [ $nome_campo = "limit" ]; then
      limit[$k]="$valor_campo"
    fi
    if [ $nome_campo = "burst" ]; then
      burst[$k]="$valor_campo"
    fi
    if [ $nome_campo = "priority" ]; then
      priority[$k]="$valor_campo"
    fi
    if [ $nome_campo = "src" ]; then
      src[$k]="$valor_campo"
      client_at=client[$k]
      total_clientes=$k
      k=$((k+1))
    fi
  fi
fi
done
}

CONFIG_eth0 () {
echo "<TITLE>Configura eth0 (Rede Externa)</TITLE>"
echo "<TR><TD><H4><I>Editar Classe Principal da Rede Externa (Eth0) e seus Clientes</I></H4></TD></TR>"
echo '<TABLE BORDE="1" CELLPADDING="5">'

echo "<TR><TD>"Classe Principal"</T/T/T></TD><TD>"Bandwidth"</T></TD><TD>"Limit"</T></TD><TD>"Burst"</T></TD><TD>"Priority"</TD></TR>"

echo "<TR>
<TD><input value=\"${class[1]}\" size="30" maxlength="30" name="class"></TD>
<TD><input value=\"${bandwidth[1]}\" size="5" maxlength="5" name="bandwidth"></TD>
<TD><input value=\"${limit[1]}\" size="5" maxlength="5" name="limit"></TD>
<TD><input value=\"2\" size="1" maxlength="1" name="burst" readonly="readonly"></TD>
<TD><input value=\"0\" size="1" maxlength="1" name="priority" readonly="readonly"></TD>
</TR>"

echo "<TR><TD>Cliente Sub-rede</T/T/T></TD><TD>Bandwidth</T></TD><TD>Limit</T></TD><TD>Burst</T></TD><TD>Priority</TD><TD>Rede Destino - Formato:<B><I>x.y.w.z/t</I></B></TD></TR>"

c=2
#while [ $c -le $total_clientes ] ; do

echo "<TR>
<TD><input value=\"${client[$c]}\" size="30" maxlength="30" name=\"client[$c]\"></TD>
<TD><input value=\"${bandwidth[$c]}\" size="5" maxlength="5" name=\"bandwidth[$c]\"></TD>
<TD><input value=\"${limit[$c]}\" size="5" maxlength="5" name=\"limit[$c]\"></TD>
<TD><input value=\"2\" size="1" maxlength="1" name=\"burst[$c]\" readonly="readonly"></TD>
<TD><input value=\"0\" size="1" maxlength="1" name="priority[$c]" readonly="readonly"></TD>
<TD><input value=\"${src[$c]}\" size="19" maxlength="19" name="src[$c]"></TD>
</TR>"
#c=$((c+1))
#done

echo "</TABLE>"

echo "<H4><B>Instrucoes para preenchimento:</B><H4>"
echo "<UL>"
echo "<LI>O campo <I><B>Bandwidth</B></I> deve ser o valor da banda disponivel para a Classe e Clientes</LI>"
echo "<LI>O campo <I><B>Limit Cliente</B></I> deve ser o maximo de banda disponivel para os Clientes</LI>"
echo "<LI>O campo <I><B>Priority</B></I> deve ser a prioridade do trafego de pacotes para os Clientes</LI>"
echo "<LI>O campo <I><B>Rede Destino</B></I> deve ser a rede dos Clientes</LI>"
echo "</UL>"
} 

if [ -f "$CFG/$ETH" ]; then
TRIPA=`awk '{ print $1"="$2 }' $CFG/$ETH | egrep '^[^}][^=]' | sed 's/;//g ; s/=$// ; s/{$//' | tr '\n' '&' | sed 's/src=&/src=/g'`

IFS='&'
set - $TRIPA

# Identifica e popula as variváveis recebidas da pag. autentica.html
IDCAMPOS $TRIPA
fi

echo "$TRIPA"

CONFIG_eth0

echo "<input value="Gravar" type="submit"> <input value="Corrigir" type="reset"> <input value="Cancelar" type="reset">"

echo "</form> </body> </html>"
