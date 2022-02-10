#!/bin/bash
# Script para instalar limitação de cotas nos file systems / 
#apt-get install quota
#sed 's/remount-ro/remount-ro,usrquota,grpquota' /etc/fstab > /etc/fstab.quota
#mv /etc/fstab /etc/fstab.original
#mv /etc/fstab.quota /etc/fstab
#cat /etc/fstab
sed -e 's/remount-ro/remount-ro,usrquota,grpquota' teste.txt > teste.quota
mv teste.txt teste.original
mv teste.quota teste.txt
cat teste.txt