#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/28/2023
# Modification Date : 07/28/2023
###########################

#
# VARIABLES
#
PATH=/usr/sbin:/usr/bin:/sbin:/bin
database="zabbix-website"

# Colors
_red='\033[1;31m'
_green='\033[0;32m'
_blue='\033[0;36m'
_reset='\033[0m'

#
# FUNCTIONS
#

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
    printf "\n${_blue}Feature coming soon !${_reset}\n\n"
    sleep 2
    main "$@"
}

# Delete Website
function delete_website() {
    printf "\n${_blue}Feature coming soon !${_reset}\n\n"
    sleep 2
    main "$@"
}

# List Website
function list_website() {
    printf "\n${_blue}Feature coming soon !${_reset}\n\n"
    sleep 2
    main "$@"
}


# Main
function main(){
    check_folder "$@"
    cat <<EOF

  1 - Add website
  2 - Update website
  3 - Delete website
  4 - List website
  0 - Exit
EOF
    read -p "Merci de choisir votre action : " choice
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
    0)
        exit
        ;;
esac
}


main "$@"
