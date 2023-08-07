#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/28/2023
# Modification Date : 08/07/2023
###########################

#
# VARIABLES
#
source variable


#
# FUNCTIONS
#

# Coming Soon
function coming_soon(){
    printf "\n${_blue}Feature coming soon !${_reset}\n"
}

function good_text(){
    printf "\n${_green}${1}${_reset}\n"
}

# Add Website
function add_website() {
   echo -n "Site Domaine : "
   read domain
   echo -n "Site URL : "
   read url
   echo -n "Site Serveur : "
   read server
   echo -n "Environment (prod;pp;dev) : "
   read env
   echo -n "Infra Support (24/7;hours working) : "
   read support
   created=$(date "+%Y-%m-%d %T")
   echo "INSERT INTO web (web_domain, web_url, web_server, web_env, web_support, web_created) VALUES ('${domain}', '${url}', '${server}', '${env}', '${support}', '${created}');" | mysql -u${db_user} -p${db_password} ${db_database}
    good_text "You added website with this informations : ${domain}, ${url}, ${server}, ${env}, ${support}"
    mgt_website "$@"
}

# Update Website
function update_website() {
    coming_soon "$@"
    sleep 2
    mgt_website "$@"
}

# Disabled Website
function delete_website() {
    coming_soon "$@"
    sleep 2
    mgt_website "$@"
}

# List Website
function list_website() {
    echo ""
    while read domain server
    do
        printf "  - ${server}:\n"
        while read -d"," item || [[ -n "$item" ]]
        do
            echo "    - $item"
        done <<<$domain
    done < <(mysql -u${db_user} -p${db_password} ${db_database} -N -e "SELECT GROUP_CONCAT(web_domain SEPARATOR ','), web_server FROM web GROUP BY web_server")
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

# Disabled Server
function delete_server() {
    coming_soon "$@"
    sleep 2
    mgt_server "$@"
}

# List Server
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
