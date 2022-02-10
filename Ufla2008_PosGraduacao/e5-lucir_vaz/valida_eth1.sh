#!/bin/bash

echo "content-type: text/html"
echo

gerente="gerente"

echo "<HTML>"
echo "<body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

Debug=false
$Debug && exec 2>&1

INICIO=`date "+%d%m%Y-%A"`
CFG="/etc/htb"
ETH="eth1-qos.cfg"
BASE="/var/www/cgi-bin"
PN=${0##*/}	# Program name
VER="1.0"
HTB_ETH="eth1.cfg"
SBIN="/sbin"
Q_CHECKCFG="$SBIN/q_checkcfg"


IDCAMPOS() {
for nome_valor; do
# Extrai cada componente do seu par: class bandwidth limit burst priority client dst
nome_campo=$( echo "$nome_valor" | cut -d= -f1 )
valor_campo=$( echo "$nome_valor" | cut -d= -f2 )

eval $nome_campo=\"$valor_campo\"
done
}

URLDECODE () {
TRIPA=$( echo $DADOS_TRIPA | awk '
    BEGIN {
	hextab ["0"] = 0;	hextab ["8"] = 8;
	hextab ["1"] = 1;	hextab ["9"] = 9;
	hextab ["2"] = 2;	hextab ["A"] = hextab ["a"] = 10
	hextab ["3"] = 3;	hextab ["B"] = hextab ["b"] = 11;
	hextab ["4"] = 4;	hextab ["C"] = hextab ["c"] = 12;
	hextab ["5"] = 5;	hextab ["D"] = hextab ["d"] = 13;
	hextab ["6"] = 6;	hextab ["E"] = hextab ["e"] = 14;
	hextab ["7"] = 7;	hextab ["F"] = hextab ["f"] = 15;
	if ("'"$EncodedLF"'" == "yes") EncodedLF = 1; else EncodedLF = 0
    }
    {
    	decoded = ""
	i   = 1
	len = length ($0)
	while ( i <= len ) {
	    c = substr ($0, i, 1)
	    if ( c == "%" ) {
	    	if ( i+2 <= len ) {
		    c1 = substr ($0, i+1, 1)
		    c2 = substr ($0, i+2, 1)
		    if ( hextab [c1] == "" || hextab [c2] == "" ) {
			print "WARNING: invalid hex encoding: %" c1 c2 | \
				"cat >&2"
		    } else {
		    	code = 0 + hextab [c1] * 16 + hextab [c2] + 0
		    	#print "\ncode=", code
		    	c = sprintf ("%c", code)
			i = i + 2
		    }
		} else {
		    print "WARNING: invalid % encoding: " substr ($0, i, len - i)
		}
	    } else if ( c == "+" ) {	# special handling: "+" means " "
	    	c = " "
	    }
	    decoded = decoded c
	    ++i
	}
	if ( EncodedLF ) {
	    printf "%s", decoded	# no line newline on output
	} else {
	    print decoded
	}
    }' | sed 's/<\/TD//g' )
#    }' | sed 's/<\/TD//g; s/ /&/g' )
}

CONFIG_ETH1 () {

if [ -z "${class[0]}" ] ||  [ -z "${bandwidth[0]}" ] || [ -z "${limit[0]}" ]; then
  echo "<U><I>Prencha os parametros de Classe Principal, para serem validados.</I></U>"
  echo "</body></html>" 
  exit
fi

if [ -z "${client[2]}" ] ||  [ -z "${bandwidth[2]}" ] || [ -z "${limit[2]}" ] || [ -z "${priority[2]}" ] || [ -z "${dst[2]}" ]; then
  echo "<U><I>Prencha os parametros da Sub-rede de Cliente, para serem validados.</I></U>"
  echo "</body></html>" 
  exit
fi

echo "<TITLE>Configura Eth1 (Rede Interna)</TITLE>"
echo "<TR><TD><H4><I>Classe Principal da Rede Interna e seus Clientes</I></H4></TD></TR>"
echo '<TABLE BORDE="1" CELLPADDING="5">'

echo "<TR>
<TD>Classe Principal</T/T/T></TD>
<TD>Banda</T></TD>
<TD>Limite</T></TD>
<TD>Burst</T></TD>
<TD>Prioridade</TD>
</TR>"

#if [ [[ "${bandwidth[0]}" = ?(+|-)+([0-9]) ]] || [[ "${limit[0]}" = ?(+|-)+([0-9]) ]] ]; then
#if [ [ `echo "${bandwidth[0]}" | egrep "?(+|-)+([0-9])"` ] || [ `echo "${limit[0]}" | egrep "?(+|-)+([0-9])"`] ]; then
if [[ `echo "${bandwidth[0]}" | egrep '[^0-9]'` ]] || [[ `echo "${limit[0]}" | egrep '[^0-9]'` ]]; then
 erro[0]="<U><I>A Banda e Limite da Classe Principal devem ter valores numericos.</I></U>"
else
 if [ "${bandwidth[0]}" -ne "${limit[0]}" ]; then
   erro[0]="<U><I>O valor da banda e do limite da Classe Principal devem ser iguais.</I></U>"
 fi
fi

burst[0]="2"
priority[0]="0"

echo "<TR>
<TD><input value=\"${class[0]}\" size="30" maxlength="30" readonly="readonly" name=\"class[1]\" readonly="readonly"></TD>
<TD><input value=\"${bandwidth[0]}\" size="5" maxlength="5" readonly="readonly" name=\"bandwidth[1]\" readonly="readonly"></TD>
<TD><input value=\"${limit[0]}\" size="5" maxlength="5" readonly="readonly" name=\"limit[1]\" readonly="readonly"></TD>
<TD><input value=\"${burst[0]}\" size="1" maxlength="1" readonly="readonly" name=\"burst[1]\" readonly="readonly"></TD>
<TD><input value=\"${priority[0]}\" size="1" maxlength="1" readonly="readonly" name=\"priority[1]\" readonly="readonly"></TD>
<TD>\"${erro[0]}\"</TD>
</TR>"

echo "<TR>
<TD>Cliente Sub-rede</T/T/T></TD>
<TD>Banda</T></TD>
<TD>Limite</T></TD>
<TD>Burst</T></TD>
<TD>Prioridade</TD>
<TD>Endereco do Cliente</TD>
</TR>"

c=2
# while [ $c -le $total_clientes ] ; do
for i in "${client[@]}"; do

burst[$c]="2"

if [[ `echo "${bandwidth[$c]}" | egrep '[^0-9]'` ]]; then
  erro[$c]="<U><I>A Banda da Sub-rede de Cliente deve ter valor numerico.</I></U>"
else
  if [ "${bandwidth[$c]}" -gt "${bandwidth[0]}" ]; then
    erro[$c]="${erro[$c]} <U><I>A banda cliente deve ser menor que a principal.</I></U>"
  fi
fi

if [[ `echo "${limit[$c]}" | egrep '[^0-9]'` ]]; then
 erro[$c]="${erro[$c]} <U><I>O Limite da Sub-rede de Cliente deve ter valor numerico.</I></U>"
else
  if [ "${limit[$c]}" -gt "${limit[0]}" ]; then
    erro[$c]="${erro[$c]} <U><I>O limite da Sub-rede deve ser menor que o da Classe Principal.</I></U>"
  fi
  if [ "${bandwidth[$c]}" -gt "${limit[$c]}" ]; then
    erro[$c]="${erro[$c]} <U><I>A banda deve ter valor menor que o limite.</I></U>"
  fi
fi

if [[ `echo "${priority[$c]}" | egrep '[^0-9]'` ]]; then
 erro[$c]="${erro[$c]} <U><I>A prioridade da Sub-rede de Cliente deve ter valor numerico.</I></U>"
else
#  if [ "${priority[$c]}" < "0" ] || [ "${priority[$c]}" > "7" ]; then
  if [ "${priority[$c]}" -gt "7" ]; then
    erro[$c]="${erro[$c]} <U><I>A prioridade deve estar entre 0 e 7.</I></U>"
  fi
fi

  VLRIP="${dst[$c]}"
  IP=${VLRIP%%/*}
  MK=${VLRIP##*/}

  if [[ ! `echo $IP | egrep '^(([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.){3}([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$'` ]]; then
    erro[$c]="${erro[$c]} Endereco IP invalido."
  fi
  if [ "$MK" -gt "32" ]; then
    erro[$c]="${erro[$c]} Mascara Invalida."
  fi
  
echo "<TR>
<TD><input value=\"${client[$c]}\" size="30" maxlength="30" readonly="readonly" name=\"client[$c]\"</TD>
<TD><input value=\"${bandwidth[$c]}\" size="5" maxlength="5" readonly="readonly" name=\"bandwidth[$c]\"</TD>
<TD><input value=\"${limit[$c]}\" size="5" maxlength="5" readonly="readonly" name=\"limit[$c]\"</TD>
<TD><input value=\"${burst[$c]}\" size="1" maxlength="1" readonly="readonly" name=\"burst[$c]\" readonly="readonly"</TD>
<TD><input value=\"${priority[$c]}\" size="1" maxlength="1" readonly="readonly" name="priority[$c]"</TD>
<TD><input value=\"${dst[$c]}\" size="19" maxlength="19" readonly="readonly" name="dst[$c]"</TD>
<TD>"${erro[$c]}"</TD>
</TR>"
c=$((c+1))
done

echo "</TABLE>"
}

CRIA_ARQUIVO () {
> "$HTB_ETH"
echo "# Modelo editado pela aplicação banda.cgi #" >> "$HTB_ETH"
echo "# Autor: Lucir vaz" >> "$HTB_ETH"
echo "# Versão 1.0 - junho/2010" >> "$HTB_ETH"
echo "#" >> "$HTB_ETH"
echo "# Para saber mais sobre a configuração do HTB-tools veja o docs/HowTo/" >> "$HTB_ETH"
echo "#" >> "$HTB_ETH"

echo -e "class ${class[0]} {" >> "$HTB_ETH"
echo -e "\tbandwidth ${bandwidth[0]};" >> "$HTB_ETH"
echo -e "\tlimit ${limit[0]};" >> "$HTB_ETH"
echo -e "\tburst ${burst[0]};" >> "$HTB_ETH"
echo -e "\tpriority ${priority[0]};" >> "$HTB_ETH"
echo "" >> "$HTB_ETH"

c=2
for i in "${client[@]}"; do
  echo -e "\t\tclient ${client[$c]} {" >> "$HTB_ETH"
  echo -e "\t\t\tbandwidth ${bandwidth[$c]};" >> "$HTB_ETH"
  echo -e "\t\t\tlimit ${limit[$c]};" >> "$HTB_ETH"
  echo -e "\t\t\tburst ${burst[$c]};" >> "$HTB_ETH"
  echo -e "\t\t\tpriority ${priority[$c]};" >> "$HTB_ETH"
  echo -e "\t\t\tdst {" >> "$HTB_ETH"
  echo -e "\t\t\t\t${dst[$c]};" >> "$HTB_ETH"
  echo -e "\t\t\t};" >> "$HTB_ETH"
  echo -e "\t\t};" >> "$HTB_ETH"
  echo "" >> "$HTB_ETH"
  c=$((c+1))
done
echo "class default { bandwidth 8; };" >> "$HTB_ETH"
}

read DADOS_TRIPA

DADOS_TRIPA=$(echo $DADOS_TRIPA | tr '+' '_')

IFS='&'
set - $DADOS_TRIPA
URLDECODE $DADOS_TRIPA

IFS=' '
set - $TRIPA
IDCAMPOS $TRIPA

CONFIG_ETH1

if [ -z "${erro[@]}" ]; then
  CRIA_ARQUIVO
# if [[ eval $Q_CHECKCFG "$HTB_ETH" ]]; then
#    echo "<H3>Apos ser aplicado o comando $Q_CHECKCFG, o arquivo $HTB_ETH, gerado pela aplicacao, apresenta erros de parametros, por favor identificar se o mesmo está corrompido para promover a correcao.</H3>"
#   exit
#   echo "</form> </body> </html>"
  #else
     if [ -f "$CFG/$ETH" ] && [ ! -z "$CFG/$ETH" ] ; then
       if [ ! -w "$CFG/$ETH" ]; then
         echo "<H3>O arquivo de configuracao $CFG/$ETH ja existe e nao há permissao para substirui-lo, providencie as permissoes necessarias para que o mesmo possa ser substituido.</H3>"
         echo "</form> </body> </html>"
         exit
       else
         eval mv -f "$CFG/$ETH" "$CFG/$ETH_$INICIO"
         eval mv -f "$HTB_ETH" "$CFG/$ETH"
       fi
     else 
       eval mv -f "$HTB_ETH" "$CFG/$ETH"
     fi
     echo "<H3>Arquivo gerado com sucesso</H3>"
#  fi
else 
  echo "<H3>O arquivo gerado apresenta erros de parametros, por favor corrija-os.</H3>"
fi

echo "</form> </body> </html>"
