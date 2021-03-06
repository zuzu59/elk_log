#!/bin/bash
#petit script à lancer pour que cela tourne !
#zf180913.1357

zNAME="web2018"

THEIP=$(/sbin/ifconfig ens18 | /bin/grep "inet ad" | /usr/bin/cut -f2 -d: | /usr/bin/awk '{print $1}')
echo -e "
Afin de pouvoir garder logstash en marche tout en pouvant quitter la console, il serait bien de le faire tourner dans un 'screen' avec:
screen -S $zNAME    pour entrer dans screen
./start.sh            pour lancer le serveur WEB dans screen
CTRL+a,d              pour sortir de screen en laissant tourner le serveur
screen -r $zNAME    pour revenir dans screen
screen -x $zNAME    pour revenir à plusieurs dans screen
CTRL+d                pour terminer screen
screen -list          pour lister tous les screens en fonctionement

On peut voir les résultat sur Kibana avec:
http://$THEIP:5601
"
read -p "appuyer une touche pour démarrer Logstash"


#attention ceci efface toute la DB Elasticsearch
#curl -XDELETE http://zf-2:9200/*

zIndex="web2018_realtm_20180913"
#curl -XDELETE http://zf-2:9200/$zIndex

/usr/share/logstash/bin/logstash -f /home/ubuntu/elk_log/projets/www_epfl/web2018_realtm_grok.conf --path.data /home/ubuntu/elk_log/projets/www_epfl/logstash_data_$zIndex

