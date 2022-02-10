#!/bin/bash

echo "content-type: text/html"
echo

Debug=true
$Debug && exec 2>&1

INICIO=`date "+%d%m%Y-%A"`
CFG="/etc/htb"
ETH="eth1-qos.cfg"
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

echo "<form method=\"post\" action=\"/cgi-bin/valida_eth1.sh\">"

IDCAMPOS() {
for nome_valor; do
# Extrai cada componente do seu par: class bandwidth limit burst priority client dst
nome_campo=$( echo "$nome_valor" | cut -d= -f1)
valor_campo=$( echo "$nome_valor" | cut -d= -f2 )

eval $nome_campo=\"$valor_campo\"
done
}

CONFIG_ETH1 () {
echo "<TITLE>Cria Sub-redes Interna (Eth1)</TITLE>"
echo "<TR><TD><H4><I>Editar Classe Principal da Rede Interna e seus Clientes</I></H4></TD></TR>"
echo '<TABLE BORDE="1" CELLPADDING="5">'

echo "<TR>
<TD>Classe Principal</T/T/T></TD>
<TD>Banda</T></TD>
<TD>Limite</T></TD>
<TD>Burst</T></TD>
<TD>Prioridade</TD>
</TR>"

echo "<TR>
<TD><input value=\"${class[1]}\" size="30" maxlength="30" name=\"class\"></TD>
<TD><input value=\"${bandwidth[1]}\" size="5" maxlength="5" name=\"bandwidth\"></TD>
<TD><input value=\"${limit[1]}\" size="5" maxlength="5" name=\"limit\"></TD>
<TD><input value=\"${burst[1]}\" size="1" maxlength="1" name=\"burst\" readonly="readonly"></TD>
<TD><input value=\"${priority[1]}\" size="1" maxlength="1" name=\"priority\" readonly="readonly"></TD>
</TR>"

  echo "<TR>
  <TD>Cliente Sub-rede</T/T/T></TD>
  <TD>Banda</T></TD>
  <TD>Limite</T></TD>
  <TD>Burst</T></TD>
  <TD>Prioridade</TD>
  <TD>Endereco do Cliente</TD>
  </TR>"
qtde_redes=$((qtde_redes+1))
c=2
while [ $c -le $qtde_redes ] ; do
echo "<TR>
<TD><input value=\"${client[$c]}\" size="30" maxlength="30" name=\"client[$c]\"></TD>
<TD><input value=\"${bandwidth[$c]}\" size="5" maxlength="5" name=\"bandwidth[$c]\"></TD>
<TD><input value=\"${limit[$c]}\" size="5" maxlength="5" name=\"limit[$c]\"></TD>
<TD><input value=\"${burst[$c]}\" size="1" maxlength="1" name=\"burst[$c]\" readonly="readonly"></TD>
<TD><input value=\"${priority[$c]}\" size="1" maxlength="1" name=\"priority[$c]\"></TD>
<TD><input value=\"${dst[$c]}\" size="19" maxlength="19" name=\"dst[$c]\"></TD>
</TR>"
c=$((c+1))
done

echo "</TABLE>"

echo "<H4><B>Instrucoes para preenchimento:</B><H4>"
echo "<UL>"
echo "<LI>O campo <I><B>Bandwidth</B></I> deve ser o valor da banda disponivel para a Classe e Clientes</LI>"
echo "<LI>O campo <I><B>Limit Cliente</B></I> deve ser o maximo de banda disponivel para os Clientes</LI>"
echo "<LI>O campo <I><B>Priority</B></I> deve ser a prioridade do trafego de pacotes para os Clientes</LI>"
echo "<LI>O campo <I><B>Rede Destino</B></I> deve ser a rede dos Clientes</LI>"
echo "</UL>"
}

read TRIPA

if [ -f "$CFG/$ETH" ]; then
  echo "<br><H4>O arquivo $CFG/$ETH, ja existe. Por favor escolher a opcao: Alterar Qtde Sub-redes<H4>"
  echo "</body></html>" 
#  exit
fi

IFS='&'
set - $TRIPA

# Identifica e popula as variváveis recebidas da pag. autentica.html
IDCAMPOS $TRIPA

# Apresenta dados para alteração
CONFIG_ETH1

echo "<input value="Gravar" type="submit"> <input value="Corrigir" type="reset"> <input value="Cancelar" type="reset">"

echo "</form> </body> </html>"
