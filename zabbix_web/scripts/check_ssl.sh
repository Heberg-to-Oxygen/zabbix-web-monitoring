#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Validity dat of an SSL/TLS certificate
# Creation Date : 08/30/2023
# Modification Date : 08/30/2023
###########################

function ssl(){
    data=`echo | openssl s_client -servername $1 -connect $1:${2:-443} 2>/dev/null | openssl x509 -noout -enddate | sed -e 's#notAfter=##'`
    ssldate=`date -d "${data}" '+%s'`
    nowdate=`date '+%s'`
    diff="$((${ssldate}-${nowdate}))"
    echo $((${diff}/86400))
}

ssl "$1"
