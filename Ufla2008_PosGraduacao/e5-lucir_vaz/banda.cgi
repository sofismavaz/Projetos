#!/bin/bash

echo "content-type: text/html"
echo

echo "
<head>
<title>Configurar HTB-Tools</title>
</head>"

echo "
<frameset rows="20%,80%" cols="*" border="1">
  <frame src=\"/cgi-bin/topo.cgi\" name=\"menu\" />
  <frame src=\"/cgi-bin/conteudo.cgi\" name=\"conteudo\" />
</frameset>"
