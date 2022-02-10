#!/bin/bash

echo "content-type: text/html"
echo

Debug=true
$Debug && exec 2>&1

echo "<html>"
echo "<head>   <title>topo</title>  </head>"
echo "<body>"

echo "<strong>ARL - Administra&ccedil;&atilde;o em Redes Linux<br></strong>"
echo "<strong>Configura&ccedil;&atilde;o Ferramenta HTB-Tools</strong>
      <br> Lucir Vaz - ARL108053 <br>"

echo "
<div style=\"text-align: right;\">
  <a href=\"/cgi-bin/conteudo.cgi\" target=\"conteudo\">Inicio</a>
| <a href=\"/cgi-bin/instalar.sh\" target=\"conteudo\">Instalar HTB-Tools</a>
| <a href=\"/cgi-bin/remover.sh\" target=\"conteudo\">Remover HTB-Tools</a>
| <a href=\"/cgi-bin/inicializar.sh\" target=\"conteudo\">Manuten&ccedil;&atilde;o Servi&ccedil;o</a> 
</div>
<div style=\"text-align: right;\">
 <a href=\"/cgi-bin/carrega_eth0.sh\" target=\"conteudo\">Configura Rede Externa (Eth0)</a> 
| <a href=\"/cgi-bin/qtde_redes.sh\" target=\"conteudo\">Cria Rede Interna (Eth1)</a>
| <a href=\"/cgi-bin/qtde_redes_alt.sh\" target=\"conteudo\">Altera Qtde Sub-redes (Eth1)</a>
</div>"
echo "<hr> </body> </html>"
