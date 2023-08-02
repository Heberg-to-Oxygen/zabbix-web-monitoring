#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/28/2023
# Modification Date : 08/02/2023
###########################

#
# VARIABLES
#
PATH=/usr/sbin:/usr/bin:/sbin:/bin
database="zabbix_website"

# Colors
_red='\033[1;31m'
_green='\033[0;32m'
_blue='\033[0;36m'
_reset='\033[0m'

#
# FUNCTIONS
#

function coming_soon(){
    printf "\n${_blue}Feature coming soon !${_reset}\n"
}

# Add Website
function add_website() {
    echo -n "Domaine du site: "
    read domain
    echo -n "URL du site: "
    read url
    echo -n "Serveur du site: "
    read server
    echo -n "Prod ou PréProd ou Dev ? (prod/pp/dev): "
    read env
    echo -n "Support Infra ? (24/7 ; 8/17): "
    read support
}

# Update Website
function update_website() {
    coming_soon "$@"
    sleep 2
    mgt_website "$@"
}

# Delete Website
function delete_website() {
    coming_soon "$@"
    sleep 2
    mgt_website "$@"
}

# List Website
function list_website() {
    coming_soon "$@"
    sleep 2
    mgt_website "$@"
}


# Management Website
function mgt_website(){
    cat <<EOF

  1 - Add website
  2 - Update website
  3 - Delete website
  4 - List website
  9 - Back
  0 - Exit
EOF
    read -p "Pleace choose your action : " choice
case $choice in
    1)
        add_website "$@"
        ;;
    2)
        update_website "$@"
        ;;
    3)
        delete_website "$@"
        ;;
    4)
        list_website "$@"
	;;
    9)
        main "$@"
	;;
    0)
        exit
        ;;
esac
}

# Add Server
function add_server() {
    coming_soon "$@"
    sleep 2
    mgt_server "$@"
}

# Update Server
function update_server() {
    coming_soon "$@"
    sleep 2
    mgt_server "$@"
}

# Delete Website
function delete_server() {
    coming_soon "$@"
    sleep 2
    mgt_server "$@"
}

# List Website
function list_server() {
    coming_soon "$@"
    sleep 2
    mgt_server "$@"
}

# Management server
function mgt_server(){
    cat <<EOF

  1 - Add server
  2 - Update server
  3 - Delete server
  4 - List server
  9 - Back
  0 - Exit
EOF
    read -p "Pleace choose your action : " choice
case $choice in
    1)
        add_server "$@"
        ;;
    2)
        update_server "$@"
        ;;
    3)
        delete_server "$@"
        ;;
    4)
        list_server "$@"
	;;
    9)
        main "$@"
	;;
    0)
        exit
        ;;
esac
}

# Main
function main(){
    cat <<EOF

  1 - Website
  2 - Server
  0 - Exit
EOF
    read -p "Pleace choose your action : " choice
case $choice in
    1)
        mgt_website "$@"
        ;;
    2)
        mgt_server "$@"
        ;;
    0)
        exit
        ;;
esac
}

main "$@"
