#!/bin/bash

echo "content-type: text/html

<html> <head> <title>conteudo</title> </head> <body>

Esta ferramenta se prop&otilde;e a configurar as interfaces de rede:
eth0 (externa) e eth1 (interna), para que o HTB-Tools possa gerenciar a
largura de banda dispon&iacute;vel.
<br>
<br>
A interface de rede: eth1 (interna) &eacute; composta de sub-redes. Com
o HTB-tools ser&aacute; poss&iacute;vel configurar a largura de banda permitida
para cada sub-rede. N&atilde;o h&aacute; um n&uacute;mero fixo de sub-redes.
<br>
<br>
O arquivo de configura&ccedil;&atilde;o /etc/htb/eth1-qos.cfg possui formato
pr&oacute;prio, permitindo que seja configurado o nome da sub-rede, a
largura de banda m&iacute;nima e m&aacute;xima garantida e a prioridade dos pacotes na fila.
<br>
<br>
Esta ferramenta &eacute; capaz de criar a configura&ccedil;&atilde;o da rede principal
e de CADA sub-rede, listar as configura&ccedil;&otilde;es da rede e de todas as sub-redes, apagar as
configura&ccedil;&otilde;es da rede e de CADA sub-rede, iniciar e parar o servi&ccedil;o
htb, mostrar o status on-line da divis&atilde;o da banda, al&eacute;m de validar os campos: ip de rede no formato x.y.w.z/t, largura de banda m&iacute;nima e m&aacute;xima, e se a
prioridade est&aacute; no intervalo entre 0 e 7.
<br>

</body> </html>"
