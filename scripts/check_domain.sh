#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Validity dat of an SSL/TLS certificate
# Creation Date : 09/03/2023
# Modification Date : 09/03/2023
###########################

function domain(){
    DOMAIN="$1"
    exdate=`whois $DOMAIN | grep -E 'paid|Expir|Expires' | grep --max-count=1 -o -E '[0-9]{4}.[0-9]{2}.[0-9]{2}|[0-9]{2}/[0-9]{2}/[0-9]{4}|[0-9]{4}-[0-9]{2}-[0-9]{2}'`
    expire=$((`date -d "$exdate" '+%s'`))
    today=$((`date '+%s'`))
    leftsec=$(($expire - $today))
    leftdays=$(($leftsec/86400))
    echo $leftdays
}

domain "$1"
