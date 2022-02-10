#!/bin/bash
# Lucir Rocio Vaz - ARL108053

echo Content-type: text/html
echo

# Redireciona a saida de erro para um arquivo especifico

INICIO=`date "+%d%m%Y-%A"`
APT="/usr/bin/apt-get"
DPKG="/usr/bin/dpkg"
CFG="/etc/htb"
VERSAO="0.2.7b"
HTB="HTB-tools-$VERSAO"
REQ_BASICOS="requisitos_basicos.txt"
SBIN="/sbin"
ETH0="eth0-qos.cfg"
ETH1="eth1-qos.cfg"
INSTRUCOES="Instrucoes_Config_HTB.txt"
BASE="/var/www/cgi-bin"
ARQ_LOG="$BASE/htb_install_$INICIO.log"
ARQHTB="$BASE/$HTB.tar.gz"
SOURCE="usr/src"
HEADERS_SOURCE="$SOURCE/linux-headers-`uname -r`"
LINUX_SOURCE="$SOURCE/linux-source-2.6.26.tar.bz2"
FLEX="/usr/bin/flex"
IPROUTE="/etc/iproute2"
SUDO="/usr/bin/sudo"
MAKE="/usr/bin/make"
BITOPS="/usr/src/linux-headers-2.6.26-2-common/include/linux/bitops.h"
BITOPS_L="/usr/include/asm/bitops.h"
PN=${0##*/}	# Program name
VER="1.0"
gerente="gerente"

> "$ARQ_LOG"

echo "<HTML> <body>"

if [ "$REMOTE_USER" != "$gerente" ]; then
  echo "<H2>Usuario sem permiss&atilde;o para realizar esta tarefa.</H2>"
  echo "</body></html>" 
  exit
fi  			

IDCAMPOS() {

# Usa o IFS para separar os pares de campo=valor
IFS='&'
set - $TRIPA

for nome_valor; do
# Extrai cada componente do seu par
nome_campo=$( echo "$nome_valor" | cut -d= -f1)
valor_campo=$( echo "$nome_valor" | cut -d= -f2 | tr + ' ')

eval $nome_campo=\"$valor_campo\"
done }

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

# Valores repassados pela pag. autentica.html
# usuario=root&senha=
read TRIPA

# Identifica e popula as varivaveis recebidas da pag. autentica.html
IDCAMPOS $TRIPA

if [ -d "$CFG" ]; then
    erro[1]="O diretório do aplicativo HTB-Tools ja existe."
fi

if [ -f "$CFG/$ETH0" ]; then
  erro[2]="O arquivo de configuracao <I><U>$CFG/$ETH0<U><I> ja esta presente"
fi

if [ -f "$CFG/$ETH1" ]; then
  erro[3]"O arquivo de configuracao <I><U>$CFG/$ETH1<U><I> ja esta presente"
fi

if [ -x "$SBIN/q_parser" ] || [ -x "$SBIN/q_show" ] || [ -x "$SBIN/q_checkcfg" ] ||  [ -x "$SBIN/htb" ] ||  [ -x "$SBIN/htbgen" ]; then
    erro[0]="Os binários do aplicativo HTB-tools estao presentes."
fi

if [[ ! -n "${#erro[@]}" ]]; then
  MENSAGEM_ERRO "${erro[@]}"
else
  if [ ! -f "$ARQHTB" ]; then
    erro[4]="O arquivo compactado com o aplicativo HTB-tools nao esta presente."
  fi

  if [ ! -x  "$APT" ]; then
    erro[5]="Essa aplicacao necessita usar o comando apt-get para instalar os pacotes necessarios a execucao do HTB-Tools. Nao foi possivel identificar sua presenca."
  fi

  if [ ! -x "$DPKG" ]; then
    erro[6]="Essa aplicacao necessita usar o comando dpkg para instalar os pacotes necessarios a execucao do HTB-Tools. Nao foi possivel identificar sua presenca."
  fi

  if [ ! -x "$SUDO" ]; then
    erro[7]="Essa aplicacao necessita usar o comando sudo para obter os privilegios de root. O pacote que o contem nao deve estar presente na distribuicao."
  fi

  if [ ! -d "$HEADERS_SOURCE" ]; then
    erro[8]="Os fontes do linux: <I><U>$HEADERS_SOURCE</U></I> nao estao presente, o HTB-tools necessita dos mesmos para compilar."
  fi

  if [ ! -f "$LINUX_SOURCE" ]; then
    erro[9]="Os fontes do linux: <I><U>$LINUX_SOURCE</U></I> nao estao presente, o HTB-tools necessita dos mesmos para compilar."
  fi

  if [ ! -f "$ARQHTB" ]; then
    erro[10]="O arquivo <I><U>$ARQHTB</U></I> nao esta presente para ser descompactado."
  fi

  if [ ! -x "$MAKE" ]; then
    erro[11]="O compilador nao esta presente, por favor consulte como instala-lo em sua distribuicao para concluir este procedimento."
  fi

  if [ ! -x "$FLEX" ]; then
    erro[12]="O <I><U>$FLEX</U>: A fast lexical analyzer generator</I> e utilizado pelo aplicativo HTB-tools e tambem, e necessario para a sua compilacao."
  fi

  if [ ! -d "$IPROUTE" ]; then
    erro[13]="O iproute e necessario para a compilacao do aplicativo HTB-tools."
  fi

  if [ ! -f "$BITOPS" ]; then
    erro[14]="O arquivo <I><U>bitops.h</I></U> eh essencial para compilar o HTB-tools e ele nao esta presente nesta distribuicao, eh necessario baixar os fontes e headers do linux e se assegurar de sua presenca para concluir a instalacao."
  else
    if [ ! -h "$BITOPS_L" ]; then
    # Cria link para o arquivo bitops.h
      ln -s "$BITOPS" "$BITOPS_L"
    fi
  fi
fi

if [[ ! -n "${#erro[@]}" ]]; then
  MENSAGEM_ERRO "${erro[@]}"
else
  tar -xzvf "$ARQHTB" >> "$ARQ_LOG" 2>> "$ARQ_LOG"
  if [ "$?" -ne "0" ]; then
    erro[15]="Houve problemas com o arquivo compactado do aplicativo HTB-tools, por favor verifique sua integridade"
  else
    cd $HTB

    $MAKE >> "$ARQ_LOG" 2>> "$ARQ_LOG"
    if [ "$?" -ne "0" ]; then
      erro[16]="Erros durante a compilacao do aplicativo HTB-tools."
    else
      $MAKE full >> "$ARQ_LOG" 2>> "$ARQ_LOG"
      if [ "$?" -ne "0" ]; then
      erro[17]="Erros durante a compilacao e copia dos binarios: <U><I>q_parser, q_show, q_checkcfg, htb, htbgen</I></U> para o diretorio /sbin e dos arquivos de configuracao: <U><I>eth0-qos.cfg e eth1-qos.cfg</I></U> para o diretorio /etc/htb, alem de incluir o script: rc.htb para inicializacao automatica"
      fi
      cd ../
    fi
  fi
# "Avalia se a instalacao do aplicativo HTB-tools foi concluida com sucesso." >> "$ARQ_LOG" 2>> "$ARQ_LOG"
  if [ ! -x "$SBIN/q_parser" ] || [ ! -x "$SBIN/q_show" ] || [ ! -x "$SBIN/q_checkcfg" ] ||  [ ! -x "$SBIN/htb" ] ||  [ ! -x "$SBIN/htbgen" ] || [ ! -d "$CFG" ]; then
    erro_conclusao="Erro durante a instalacao do aplicativo HTB-tools. Nao foi possivel identificar a presenca do aplicativo no sistema, e necessario avaliar o motivo do compilador nao ter copiado os referidos arquivos para o diretorio especificado."
    MENSAGEM_ERRO "${erro[@]}"
  else   
    sucesso="O aplicativo HTB-tolls foi instalado com sucesso. Agora, eh necessario configurar a rede, editando as classes e sub-classes de usuarios"
    MENSAGEM_ERRO $sucesso
  fi
fi

echo "</form> </body> </html>"
