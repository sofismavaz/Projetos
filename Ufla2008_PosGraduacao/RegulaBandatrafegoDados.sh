#!/bin/bash
# Jose Lutiano José Lutiano Costa da Silva - ARL207023 e Lucir Rocio Vaz - ARL108053

# Trabalho Final de Automação
# Funções do aplicativo

# Valida linguagem
unset ${!LC_*}
export LANG=pt_BR.UTF-8

INICIO=`date "+%d %m %Y %A"`
APT="/usr/bin/apt-get"
DPKG="/usr/bin/dpkg"
CFG="/etc/htb"
VERSAO="0.2.7b"
HTB="HTB-tools-$VERSAO"
ARQHTB="$HTB.tar.gz"
REQ_BASICOS="requisitos_basicos.txt"
SBIN="/sbin"
ETH0="eth0-qos.cfg"
ETH1="eth1-qos.cfg"
DIALOG_PKG="dialog_1.1-20080316-1_i386.deb"
INSTRUCOES="Instrucoes_Config_HTB.txt"
BASE=`pwd`
DIALOG_INSTALL="$BASE/dialog.log"
DIALOG="/usr/bin/dialog"
HTB_ETH_QOS="eth0-qos.cfg"
HEADERS_SOURCE="linux-headers-`uname -r`"
LINUX_SOURCE="linux-source-2.6.26"

> $DIALOG_INSTALL
> $HTB_ETH_QOS
> $ETH0
> $ETH1
echo "inicializa os arquivos: $ETH1 $DIALOG_INSTALL $HTB_ETH_QOS $ETH0" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL

echo "avalia a existência e permissão de execução do comando apt-get - $INICIO" >> $DIALOG_INSTALL
if [ ! -x  "$APT" ]; then
echo "+========================================================================+"
echo "|                                                                        |"
echo "| A execução desse aplicativo é baseada no uso do comando apt-get        |"
echo "| para instalar os pacotes necessários a sua execução. Por favor         |"
echo "| certifique-se de sua presença para prosseguir com a execução do script |"
echo "|                                                                        |"
echo "+========================================================================+"
read
exit
fi

echo "avalia a existência e permissão de execução do comando dpkg - $INICIO" >> $DIALOG_INSTALL
if [ ! -x "$DPKG" ]; then
echo "+=========================================================================+"
echo "|                                                                         |"
echo "| A execução desse aplicativo é baseada no uso do comando dpkg para       |"
echo "| instalar os pacotes necessários a sua execução. Por favor certifique-se |"
echo "|  de sua presença para prosseguir com a execução do script               |"
echo "|                                                                         |"
echo "+=========================================================================+"
read
exit 
fi

SUDO="/usr/bin/sudo"
echo "avalia a existência e permissão de execução do comando o sudo - $INICIO" >> $DIALOG_INSTALL
if [ ! -x "$SUDO" ]; then
echo "+=====================================================================+"
echo "|                                                                     |"
echo "| A execução desse aplicativo é baseada no uso do comando sudo para   |"
echo "| obter os privilégios de root. O pacote que o contém não deve estar  |"
echo "| presente na distribuição. Por favor certifique-se de sua presença   |"
echo "| para prosseguir com a execução do script.                           |"
echo "|                                                                     |"
echo "+=====================================================================+"
read
exit 
fi

echo "aviso da necessidade de privilegios de administrador - $INICIO" >> $DIALOG_INSTALL
echo "+=====================================================================+"
echo "|                                                                     |"
echo "| Para utilizar este aplicativo é necessário  ter privilégio de root  |"
echo "| Se concordar, você deverá precionar qualquer tecla de posse da      |"
echo "| senha de root. Se não concordar, por favor precione Ctrl C, para    |"
echo "| CANCELAR a execução do script                                       |"
echo "|                                                                     |"
echo "+=====================================================================+"
read
# comando para simplesmente apanhar a senha
sudo ls >/dev/null 2>/dev/null

MSG_ERRO () {
echo "+==========================================================================+"
echo "|                                                                          |"
echo "| Para a execução desse aplicativo é necessário que os pacotes do dialog e |"
echo "| htb-tools estejam instalados e foi constatado que os mesmos não estão    |"
echo "| presentes ou não foi possível instalar um deles.                         |"
echo "|                                                                          |"
echo "| Por favor, verifique o arquivo dialog.log para identificar quais foram   |"
echo "| os motivos de não ter sido possível descompactar os pacotes e instalá-los|"
echo "|                                                                          |"
echo "+==========================================================================+"
echo ""
exit
}

INSTALA_DIALOG () {
echo "+===========================================================================+"
echo "|                                                                           |"
echo "| Será necessário  instalar o pacote dialog. Se concordar com a instalação, |"
echo "| você deverá precionar qualquer tecla de posse da senha de root. Se não    |"
echo "| concordar, por favor precione Ctrl C, para CANCELAR a execução do script  |"
echo "|                                                                           |"
echo "+===========================================================================+"
read

echo "Procedimento de instalacao do pacote dialog $INICIO" >> $DIALOG_INSTALL
sudo dpkg --install "$DIALOG_PKG" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? ]; then
  SUCESSO="1"
fi
}

AVALIA_INSTALL_SOURCE () {
CABECALHO=""
SOURCE=""
PENDENCIA=""

echo "Avalia se os fontes do linux estão presente, conforme exige o HTB-tools, para ser  compilado. Utiliza o conteúdo das variáveis: $HEADERS_SOURCE e $LINUX_SOURCE" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
sudo dpkg -l "$HEADERS_SOURCE" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? = 0 ]; then
  CABECALHO="SIM"
fi

sudo dpkg -l "$LINUX_SOURCE" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? = 0 ]; then
  SOURCE="SIM"
fi
if [ ! $CABECALHO ] || [ ! $SOURCE ]; then
  echo "Os fontes do linux não está presente, o HTB-tools necessita dos mesmos para compilar. Verificar se a versão definida nas variáveis: $HEADERS_SOURCE e $LINUX_SOURCE estão corretas ou se estas versões correspondem a versão utilizada do kernel." >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'Os fontes do linux não está presente, o HTB-tools necessita dos mesmos para compilar. Verificar se a versão definida nas variáveis: "$HEADERS_SOURCE"='$HEADERS_SOURCE' e "$LINUX_SOURCE"='$LINUX_SOURCE' estão corretas ou se estas versões correspondem a versão utilizada do kernel.' 0 0
  PENDENCIA="SIM"
  return
fi

echo "Identificar a presença do compactado da aplicação HTB-tolls $ARQHTB" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ ! -f $ARQHTB ]; then
  echo "O arquivo $ARQHTB não está presente para ser descompactado" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O arquivo '$ARQHTB' não está presente para ser descompactado' 0 0
  PENDENCIA="SIM"
  return
fi

echo "Avaliar se o sistema está apto a compilar o aplicativo" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
dpkg -l make >>$DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? -ne 0 ]; then
  echo "O compilador não está instalado, por favor consulte como instalá-lo em sua distribuição para concluir este procedimento" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O compilador não está instalado, por favor consulte como instalá-lo em sua distribuição e para concluir este procedimento' 0 0
  PENDENCIA="SIM"
  return
else
  MAKE=$(which make)
fi

dpkg -l flex >>$DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? -ne 0 ]; then
  echo "O flex - A fast lexical analyzer generator é utilizado pelo aplicativo HTB-tools e também, é necessário para a compilação" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O flex - A fast lexical analyzer generator é utilizado pelo aplicativo HTB-tools e também, é necessário para a compilação' 0 0
  PENDENCIA="SIM"
  return
fi

dpkg -l iproute >>$DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ $? -ne 0 ]; then
  ERRO=1
  echo "O iproute é necessário para a compilação do aplicativo HTB-tools" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O iproute é necessário para a compilação do aplicativo HTB-tools' 0 0 
  PENDENCIA="SIM"
  return
fi

if [ ! -f /usr/src/linux-headers-2.6.26-2-common/include/linux/bitops.h ]; then
  echo "O arquivo bitops.h é essencial para compilar o HTB-tools e ele não está presente nesta distribuição, baixar os fontes e headers do linux e se assegurar da presença do mesma para continuar o processo" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O arquivo bitops.h é essencial para compilar o HTB-tools e ele não está presente nesta distribuição, baixar os fontes e headers do linux e se assegurar da presença do mesma para continuar o processo' 0 0
  PENDENCIA="SIM"
  return
else
  if [ ! -h /usr/include/asm/bitops.h ]; then
    echo "Cria link para o arquivo bitops.h" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    sudo ln -s /usr/src/linux-headers-2.6.26-2-common/include/linux/bitops.h /usr/include/asm/bitops.h >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  fi
fi
}

INSTALA_HTB () {

echo "Procedimento de instalacao do HTB-tools, conforme instruções contidas no site oficial da distribuição\n http://htb-tools.skydevel.ro/e107_plugins/content/content.php?content.7" $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
echo "Verifica a existência do htb e executa o procedimento de instalacao se não estiver presente" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL

if [ -d "$CFG" ]; then
  echo "O aplicativo HTB-tools já está instalado" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O aplicativo HTB-tools já está instalado. Se desejar re-instalar o aplicativo você deverá desinstalá-lo antes de prosseguir' 0 0
  return
else
  echo "Descompactar arquivos de instalação do HTB " >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  sudo tar -xzvf "$ARQHTB" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  if [ $? -ne 0 ]; then
    echo "Erros durante a descompactação dos arquivos de instalação do HTB" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    dialog --title 'Instalacao do HTB' --msgbox 'Houve problemas com o arquivo compactado do aplicativo HTB-tools, por favor verifique sua integridade' 0 0
    return
  fi
  cd $HTB

  echo "Compilação do HTB" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  sudo $MAKE >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  if [ $? -ne 0 ]; then
    echo "Erros durante a compilação do aplicativo HTB-tools." >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    dialog --title 'Instalacão do HTB' --msgbox 'Erros durante a compilação do aplicativo HTB-tools, por favor verifique o arquivo dialog.log' 0 0
    return
  fi

#  echo "Compilação do HTB, para instalação" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
#  sudo $MAKE all >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL

  echo "Instalação dos binários: q_parser, q_show, q_checkcfg, htb, htbgen para o diretório /sbin e dos arquivos de configuração: eth0-qos.cfg e eth1-qos.cfg para o diretório /etc/htb, além de incluir o script: rc.htb para inicialização automática" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  sudo $MAKE full >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  if [ $? -ne 0 ]; then
    echo "Erros durante a compilação e cópia dos binários: q_parser, q_show, q_checkcfg, htb, htbgen para o diretório /sbin e dos arquivos de configuração: eth0-qos.cfg e eth1-qos.cfg para o diretório /etc/htb, além de incluir o script: rc.htb para inicialização automática" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    dialog --title 'Instalacão do HTB' --msgbox 'Erros durante a compilação e cópia dos binários: q_parser, q_show, q_checkcfg, htb, htbgen para o diretório /sbin e dos arquivos de configuração: eth0-qos.cfg e eth1-qos.cfg para o diretório /etc/htb, além de incluir o script: rc.htb para inicialização automática, por favor verifique o arquivo dialog.log' 0 0
    return
  fi
  cd ../
fi

echo "Avalia se a instalação do aplicativo HTB-tools foi concluída com sucesso." >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ ! -x "$SBIN/q_parser" ] || [ ! -x "$SBIN/q_show" ] || [ ! -x "$SBIN/q_checkcfg" ] ||  [ ! -x "$SBIN/htb" ] ||  [ ! -x "$SBIN/htbgen" ] || [ ! -d "$CFG" ]; then
  echo "Erro durante a instalação do aplicativo HTB-tools. Não foi possível identificar a presença do aplicativo no sistema, é necessário avaliar o motivo do compilador não ter copiado os referidos arquivos para o diretório especificado." >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'Não foi possível identificar a presença do aplicativo no sistema, é necessário avaliar o motivo do compilador não ter copiado os referidos arquivos para o diretório especificado, também, verifique o arquivo de dialog.log para obter mais informaçoes.' 0 0
else   
  echo "O aplicativo HTB-tolls foi instalado com sucesso. Agora, é necessário configurar o aplicativo, editando as classes de usuários" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Instalacao do HTB' --msgbox 'O aplicativo HTB-tools foi instalado com sucesso. Agora, é necessário configurar o aplicativo, editando as classes de usuários' 0 0
fi       

if [ ! -z $REINSTALACAO ]; then
  echo "Substiruir arquivos já existentes"  >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  sudo cp -f "$HTB/q_show"  "$HTB/q_checkcfg"  "$HTB/htb"   "$HTB/htbgen" "$SBIN" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  sudo tar -czvf "$CFG/$BKP_CONFIG_`date`"  *.cfg >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL	#formato da data
  sudo cp -f "$HTB/eth0-qos.cfg" "$HTB/eth1-qos.cfg"  "$CFG" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  if [ ! $? ] || [ ! -z $ERRO_CP ]; then
    dialog --title 'Re-instalacao do HTB' --msgbox 'Erros durante a substituição dos arquivos binários: q_parser, q_show, q_checkcfg, htb, htbgen para o diretório /sbin ou dos arquivos de configuração: eth0-qos.cfg e eth1-qos.cfg para o diretório /etc/htb ou compactação, para backup, dos arquivos de configuração anteriores, por favor verifique o arquivo dialog.log' 0 0
  fi
fi

REINSTALACAO=""
}

Cria_classe () {
echo "Parametros recebidos para especificação da classe: $class $bandwidth $limit $burst $priority" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
echo "" >> $HTB_ETH_QOS
echo -e "class $1 {" >> $HTB_ETH_QOS
echo -e "\tbandwidth $2;" >> $HTB_ETH_QOS
echo -e "\tlimit $3;" >> $HTB_ETH_QOS
echo -e "\tburst $4;" >> $HTB_ETH_QOS
echo -e "\tpriority $5;" >> $HTB_ETH_QOS
echo "" >> $HTB_ETH_QOS
}

Cria_cliente () {
echo "Parametros recebidos para especificação dos cliente: $client $bandwidth $limit $burst $priority $src" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
echo -e "\t\tclient $1 {" >> $HTB_ETH_QOS
echo -e "\t\t\tbandwidth $2;" >> $HTB_ETH_QOS
echo -e "\t\t\tlimit $3;" >> $HTB_ETH_QOS
echo -e "\t\t\tburst $4;" >> $HTB_ETH_QOS
echo -e "\t\t\tpriority $5;" >> $HTB_ETH_QOS
echo -e "\t\t\tsrc {" >> $HTB_ETH_QOS
echo -e "\t\t\t\t$6;" >> $HTB_ETH_QOS
echo -e "\t\t\t};" >> $HTB_ETH_QOS
echo -e "\t\t};" >> $HTB_ETH_QOS
echo "" >> $HTB_ETH_QOS
}

CONFIGURA_REDE () {
echo "Procedimento de edição dos arquivos de configuração da rede principal (classes ) e da secundária (clientes) através do HTB-tools" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL

if [ ! -f "$CFG/$ETH0" ]; then
  ERRO=1
  echo "O arquivo de configuração /etc/htb/eth0-qos.cfg não está presente" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
fi

if [ ! -f "$CFG/$ETH1" ]; then
  ERRO=1
  echo "O arquivo de configuração /etc/htb/eth1-qos.cfg não está presente" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
fi

if [ -z $ERRO ]; then
  HTB_ETH_QOS="$1"
  echo "Define que a interface $HTB_ETH_QOS será configurada" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL

  qtde_classes=$(dialog --stdout \
  --backtitle 'Configuração QoS - Classe/Clientes' \
  --inputbox 'Quantas classes serão criadas?' 0 0)

  echo "# Modelo $HTB_ETH_QOS editado pela aplicação banda.sh #" >> $HTB_ETH_QOS
  echo "# Autores: José Lutiano e Lucir vaz" >> $HTB_ETH_QOS
  echo "# Versão 1.0 - abril/2010" >> $HTB_ETH_QOS
  echo "#" >> $HTB_ETH_QOS
  echo "# Para saber mais sobre a configuração do HTB-tools veja o docs/HowTo/" >> $HTB_ETH_QOS

  for (( i=0; $i < "$qtde_classes"; i++ )); do
    class=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox '(Class) Nome da classe, Sem espaçoes ou caracteres especiais:' 0 0 "$class")
    if [ ! `echo "$class" | egrep '^[A-Z]([A-Z]|[a-z]|[_]){1,}$'` ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O Nome da Classe não está de acordo com os padrões aceitos pelo HTB-tools, reveja a sintaxe' 0 0
    fi
    bandwidth=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox '(bandwidth) Largura da Banda Ex.: 192' 0 0 "$bandwidth")
    if [ ! `echo "$bandwidth" | egrep '^[0-9]{1,4}$'` ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O tamanho da banda deve ser menor que 9999 kbits, reveja a sintaxe' 0 0
    fi
    limit=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox '(limit) Limite maximo Ex. 256' 0 0 "$limit")
    if [ ! `echo "$limit" | egrep '^[0-9]{1,4}$'` ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O tamanho da banda deve ser menor que 9999 kbits, reveja a sintaxe' 0 0
    fi
    if [ $limit < $bandwidth ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O limite deve ser maior que a banda, reveja a sintaxe' 0 0
    fi
    burst=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox '(burst) Valor Máximo de Kbits enviado pela classe Ex.: 2' 0 0 "$burst")
    if [ ! `echo "$burst" | egrep '^[1-9]$'` ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O número máximo de kbits enviado por cliente de uma só vez parece fora do normal,reveja a sintaxe' 0 0
    fi
    priority=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox '(priority) Prioridade da classe Ex.: 0 a 7' 0 0 "$priority")
    if [ ! `echo "$priority" | egrep '^[0-7]$'` ]; then
      dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O limite deve estar no intervalo entre 0 a 7,reveja a sintaxe' 0 0
    fi

    Cria_classe $class $bandwidth $limit $burst $priority
 
    qtde_clientes=$(dialog --stdout \
    --backtitle 'Configuração QoS - Classe/Clientes' \
    --inputbox 'Quantos cliente serão adicionados?' 0 0 "$qtde_clientes")
    for (( j=0; $j < "$qtde_clientes"; j++ )); do
      client=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(Client) Nome do cliente, Sem espaçoes ou caracteres especiais::' 0 0 "$client")
      if [ ! `echo "$client" | egrep '^[A-Z]([A-Z]|[a-z]|[_]){1,}$'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O Nome do Cliente não está de acordo com os padrões aceitos pelo HTB-tools, reveja a sintaxe' 0 0
      fi
      bandwidth=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(bandwidth) Largura da Banda Ex.: 48' 0 0 "$bandwidth")
      if [ ! `echo "$bandwidth" | egrep '^[0-9]{1,4}$'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O tamanho da banda deve ser menor que 9999 kbits, reveja a sintaxe' 0 0
      fi
      limit=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(limit) Limite maximo Ex. 64' 0 0 "$limit")
      if [ ! `echo "$limit" | egrep '^[0-9]{1,4}$'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O tamanho da banda deve ser menor que 9999 kbits, reveja a sintaxe' 0 0
      fi
      if [ $limit < $bandwidth ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O limite deve ser maior que a banda, reveja a sintaxe' 0 0
      fi
      burst=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(burst) Valor Máximo de Kbits enviado pela classe Ex.: 2' 0 0 "$burst")
      if [ ! `echo "$burst" | egrep '^[1-9]$'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O número máximo de kbits enviado por cliente de uma só vez parece fora do normal,reveja a sintaxe' 0 0
      fi
      priority=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(priority) Prioridade da classe Ex.: 0 a 7:' 0 0 "$priority")
      if [ ! `echo "$priority" | egrep '^[0-7]$'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O limite deve estar no intervalo entre 0 a 7,reveja a sintaxe' 0 0
      fi
      src=$(dialog --stdout \
      --backtitle 'Configuração QoS - Classe/Clientes' \
      --inputbox '(source) Rede/Estação Origem Ex. Rede 192.168.1.0/24 - Estação 192.168.1.1/32' 0 0 "$src")
      if [ ! `echo "$src" | egrep '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/'` ]; then
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'O formato do endereço IP (Rede ou Estação) não está de acordo com os padrões aceitos pelo HTB-tools, reveja a sintaxe' 0 0
      fi

      Cria_cliente $client $bandwidth $limit $burst $priority $src
    done
    echo "};" >> $HTB_ETH_QOS
  done

  echo "class default { bandwidth 8; }; " >> $HTB_ETH_QOS

  CONCLUIDO="nao"
  echo "Confirma a substituição do arquivo /etc/htb/$HTB_ETH_QOS pela nova configuração" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  dialog --title 'Configuração QoS - Classe/Clientes' \
       --yesno 'Confirma a substituição dos arquivos /etc/htb/ pela nova configuração?' 0 0
  if [ $? = 0 ]; then
    while : ; do
       DIR_BKP=$( dialog --title 'Configuração QoS - Classe/Clientes' --stdout --fselect $BASE/Bkp_Eth_Config_`date "+%d%m%Y_%H%M%S"`.tar.gz 0 0 )
      echo "Cria compactado para backup da origem: $CFG para o arquivo $DIR_BKP" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      sudo tar -czvf $DIR_BKP $CFG >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      if [ $? -ne 0 ]; then
        echo "Erros durante a compactação dos arquivos de configuração anterior do HTB " >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
        dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'Houve problemas com a compactação dos arquivos de configuração anterior do HTB-tools, por favor verifique se você tem permissão para gravar no diretório escolhido, ou consulte o dialog.log para mais informações' 0 0
      else
        echo "Move arquivo: $HTB_ETH_QOS para a pasta: $CFG" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
        sudo mv -f $HTB_ETH_QOS $CFG >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
	sudo chown root:root $CFG/$HTB_ETH_QOS >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
        break
      fi
    done
  fi
else
  dialog --title 'Configuração QoS - Classe/Clientes' --msgbox 'Arquivos de configuração /etc/htb/eth0-qos.cfg ou /etc/htb/eth1-qos.cfg não estão presente' 0 0
fi
}

REMOVE_HTB () {
CARGA_VARIAVEIS

if [ ! -d "$CFG" ]; then
  echo "O diretório da aplicação não está presente, avalie se será necessário reinstalá-lo" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  ERRO=1
  dialog --title 'Desinstalacao do HTB' --msgbox 'O diretório da aplicação não está presente, avalie se será necessário reinstalá-lo' 0 0
else
  echo "Remove a instalação do aplicativo HTB-tools" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  ERRO=1
  dialog --title 'Desinstalacao do HTB' --yesno 'Este procedimento irá REMOVER o aplicativo HTB-tools. Tem certeza que deseja fazê-lo?' 0 0
  if [ $? = 0 ]; then
    if [ ! -x "$SBIN/q_parser" ] || [ ! -x "$SBIN/q_show" ] || [ ! -x "$SBIN/q_checkcfg" ] ||  [ ! -x "$SBIN/htb" ] ||  [ ! -x "$SBIN/htbgen" ] || [ ! -d "$CFG" ]; then
      echo "Não foi possível identificar a presença de algum componente do aplicativo no sistema, é necessário avaliar o motivo do compilador o não ter instalado. Avalie se será necessário reinstalá-lo." >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      dialog --title 'Desinstalacao do HTB' --msgbox 'Não foi possível identificar a presença de algum componente do aplicativo no sistema, é necessário avaliar o motivo do compilador o não ter instalado. Avalie se será necessário reinstalá-lo.' 0 0
    else
      sudo rm  "$SBIN/q_parser" "$SBIN/q_show" "$SBIN/q_checkcfg" "$SBIN/htb" "$SBIN/htbgen" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      sudo rm -rf "$CFG" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      dialog --title 'Desinstalacao do HTB' --msgbox 'O aplicativo HTB-tools foi desinstalado com sucesso.' 0 0
    fi
  fi
fi

}

AJUDA_CONFIG () {
dialog --title 'Instruções para a correta configuração do HTB-tolls' --textbox $INSTRUCOES 0 0
}

VISUALIZA_CONFIG () {
echo "Mostrar o conteudo dos arquivos de configuracao das rede e sub-rede" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ -e "$CFG/$ETH0" ] && [ -e "$CFG/$ETH1" ]; then
  dialog --title 'Visualização Configuração' --textbox $CFG/$ETH0 0 0
  dialog --title 'Visualização Configuração' --textbox $CFG/$ETH1 0 0
else
  dialog --title 'Visualização Configuração' --msgbox 'Os arquivos de configuração do aplicativo HTB-tools não estão presente, por favor verifique se o mesmo foi instalado ou avalie o arquivo de dialog.log para obter mais informações.' 0 0
fi
}

VISUALIZA_LOG () {
dialog --title 'Visualização do log de instalação' --textbox $DIALOG_INSTALL 0 0
}

DESCRICAO_TRABALHO () {
echo "Mostrar o enunciado com a descricao do trabalho de automacao"  >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
dialog --title 'Descricao do Trabalho' --textbox enunciado.txt 0 0
}

echo "Verifica a existência do dialog e executa o procedimento de instalacao se não estiver presente"  >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
if [ ! -x "$DIALOG" ]; then
  INSTALA_DIALOG
  if [ "$SUCESSO" = "1" ]; then
    MSG_ERRO
  else
   dialog --title 'Instalação do dialog' --textbox $DIALOG_INSTALL 0 0
  fi
fi

# Loop que mostra o menu principal
while : ; do
# Mostra o menu na tela, com as opcoes disponi­veis
resposta=$( dialog                            \
	--stdout                              \
	--title 'Menu de Configuracao do HTB' \
	--menu 'Escolha qual opcao deseja'    \
	0 0 0                                 \
	1 'Instalar o aplicativo HTB'         \
	2 'Configurar Parâmetros da rede Externa'     \
	3 'Configurar Parâmetros da rede Local'     \
	4 'Remove HTB'       \
	5 'Visualizar Configuracao HTB'       \
	6 'Visualizar log instalação'         \
	7 'Descricao trabalho'                \
	8 'Inicializa o Serviço HTB'        \
	9 'Dicas sobre a Configuração Redes'  \
	0 'Sair'                              )
# Para opcao CANCELAR ou ESC, abandonar o aplicativo
[ $? -ne 0 ] && break

# De acordo com a opcao escolhida, dispara programas
  case "$resposta" in
	1) AVALIA_INSTALL_SOURCE 
	   if [ -z $PENDENCIA ]; then
             INSTALA_HTB
   	   fi ;;
	2) CONFIGURA_REDE "eth1-qos.cfg";;
	3) CONFIGURA_REDE "eth0-qos.cfg" ;;
	4) REMOVE_HTB ;;
	5) VISUALIZA_CONFIG ;;
	6) VISUALIZA_LOG ;;
	7) DESCRICAO_TRABALHO ;;
	8) INICIALIZA ;;
	9) AJUDA_CONFIG ;;
	0) break ;;
  esac
done