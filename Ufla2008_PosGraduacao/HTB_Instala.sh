#!/bin/bash
# apaga logs de execução anteriores
DIALOG_INSTALL="`pwd`/dialog.log"
> $DIALOG_INSTALL
INICIO=$(date)
BASE=`pwd`

# Procedimento de instalacao do HTB-tools
CFG="/etc/htb"
VERSAO="0.2.6"
HTB="htb_tools-$VERSAO"
ARQHTB="htb_tools-$VERSAO.tar.gz"
REQ_BASICOS="requisitos_basicos.txt"

# Verifica a existência do htb e executa o procedimento de instalacao se não estiver presente
if [ -d "$CFG" ]; then
  dialog --title 'Instalacao do HTB' --msgbox 'O aplicativo HTB já está instalado' 0 0
else
#  wget http://htb-tools.skydevel.ro/download.php?list.13/$ARQHTB  >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  echo "Descompactar arquivos de instalação do HTB " $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  tar -xzvf "$ARQHTB" >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
  if [ $? -ne 0 ]; then
    echo "Erros durante a descompactação dos arquivos de instalação do HTB " $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    dialog --title 'Instalacao do HTB' --msgbox 'Houve problemas com o arquivo compactado do HTB-tools, por favor verifique o arquivo dialog.log' 0 0
  else
    echo "Compilação e instalação do HTB " $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
    MAKE=$(which make)
    if [ $? -ne 0 ]; then
      echo "O compilador é necessário para a instalação do aplicativo HTB-tools" $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
      cat $REQ_BASICOS >> $DIALOG_INSTALL
      dialog --title 'Instalacao do HTB' --msgbox 'O compilador não está instalado, por favor consulte os procedimentos de sua distribuição para instalá-lo e assim concluir este procedimento, também verifique o arquivo dialog.log para obter mais informações' 0 0
    else
      FLEX=$(which flex)
      if [ $? -ne 0 ]; then
        echo "O flex - A fast lexical analyzer generator é necessário para a compilação do aplicativo HTB-tools" $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
        dialog --title 'Instalacao do HTB' --msgbox 'O aplicativo flex não está instalado, por favor consulte os procedimentos de sua distribuição para instalá-lo e assim concluir este procedimento, também verifique o arquivo dialog.log para obter mais informações' 0 0
      else
	IPROUTE=$(which iproute)
	if [ $? -ne 0 ]; then
          echo "O iproute é necessário para a compilação do aplicativo HTB-tools" $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
	  dialog --title 'Instalacao do HTB' --msgbox 'O iproute não está instalado, por favor consulte os procedimentos de sua distribuição para instalá-lo e assim concluir este procedimento, também verifique o arquivo dialog.log para obter mais informações' 0 0
	else
	  cd $HTB
	  sudo $MAKE >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
          if [ $? -ne 0 ]; then
            echo "Erros durante a compilação do aplicativo HTB-tools " $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
            dialog --title 'Instalacão do HTB' --msgbox 'Erros durante a compilação do aplicativo HTB-tools, por favor verifique o arquivo dialog.log' 0 0
	  else
	    sudo $MAKE install >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
	    if [ $? -ne 0 ]; then
	      echo "Erros durante a instalação do aplicativo HTB-tools " $INICIO >> $DIALOG_INSTALL 2>> $DIALOG_INSTALL
	      dialog --title 'Instalacão do HTB' --msgbox 'Erros durante a instalação do aplicativo HTB-tools, por favor verifique o arquivo dialog.log' 0 0
            else
	      cd $HTB
	      dialog --title 'Instalacao do HTB' --msgbox 'O aplicativo HTB-tools foi instalado com sucesso' 0 0
	    fi
	  fi
	fi
      fi
    fi
  fi
fi
}