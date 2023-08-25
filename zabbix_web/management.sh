#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/28/2023
# Modification Date : 08/16/2023
###########################

#
# VARIABLES
#
source variable


#
# FUNCTIONS
#

# Coming soon
function coming_soon(){
    printf "\n${_blue}Feature coming soon !${_reset}\n"
}

# Wrong choice
function error_choice(){
    printf "\n${_red}Please make a correct choice !${_reset}\n"
    $1 "$@"
}

# Exit
function exit_cli(){
    printf "\n${_blue}Thanks you for use this script :)${_reset}\n\n"
    sleep 1
    exit
}

# Error text
function error_text(){
    printf "\n${_red}${1}${_reset}\n"
}
# Good text
function good_text(){
    printf "\n${_green}${1}${_reset}\n"
}

# Add Website
function add_website() {
    read -p "Site Domaine : " domain
    read -p "Site URL : " url
    read -p "Site Serveur : " server
    # read -p "Environment (prod;pp;dev) : " env
    # read -p "Infra Support (24/7;hours working) : " support
    choose_env_add_website "$@"
    choose_support_add_website "$@"
    if [ -n "${domain}" ] && [ -n ${url} ] && [ -n ${server} ] && [ -n ${env} ] && [ -n ${support} ]; then
       created=$(date "+%Y-%m-%d %T")
       echo "INSERT INTO web (web_domain, web_url, web_server, web_env, web_support, web_created, web_updated) VALUES ('${domain}', '${url}', '${server}', '${env}', '${support}', '${created}', '${created}');" | mysql -u${db_user} -h${db_host} -P${db_port} -p${db_password} ${db_database}
        good_text "You added website with this informations : ${domain}, ${url}, ${server}, ${env}, ${support}"
    else
        error_text "You have an empty variable please fill all informations !"
    fi
    mgt_website "$@"
}

# Choose Env Add Website
function choose_env_add_website(){
    cat <<EOF

  1 - Production
  2 - Acceptance
  3 - Approval
  4 - Development
  5 - Laboratory
  9 - Other
  0 - Cancel
EOF
    read -p "Pleace choose your environment: " env
case $env in
    1)
        env="production"
 	;;
    2)
        env="acceptance"
 	;;
    3)
        env="approval"
	;;
    4)
        env="development"
	;;
    5)
        env="laboratory"
	;;
    9)
        env="other"
	;;
    0)
        mgt_website "$@"
	;;
    *)
        error_choice "choose_env_add_website"
	;;
esac
}

# Choose Support Add Website
function choose_support_add_website(){
    cat <<EOF

  1 - 24/7
  2 - 24/5
  3 - 8/18 7/7
  4 - 8/18 5/7
  0 - Cancel
EOF
    read -p "Pleace choose your environment: " env
case $env in
    1)
        support="24/7"
 	;;
    2)
        support="24/5"
 	;;
    3)
        support="8/18 577"
	;;
    4)
        support="8/18 5/7"
	;;
    0)
        mgt_website "$@"
	;;
    *)
        error_choice "choose_support_add_website"
	;;
esac
}

# Update Website
function update_website() {
    cat <<EOF

  1 - Domain website
  2 - URL website
  3 - Env website
  4 - Support website
  5 - Server website
  9 - Back
  0 - Exit
EOF
    read -p "Pleace choose your action : " choice
case $choice in
    1)
        coming_soon "$@"
        sleep 2
        update_website "$@"
        ;;
    2)
        coming_soon "$@"
        sleep 2
        update_website "$@"
        ;;
    3)
        coming_soon "$@"
        sleep 2
        update_website "$@"
        ;;
    4)
        coming_soon "$@"
        sleep 2
        update_website "$@"
	;;
    5)
        coming_soon "$@"
        sleep 2
        update_website "$@"
	;;
    9)
        mgt_website "$@"
        ;;
    0)
        exit_cli "$@"
	;;
    *)
        error_choice "update_website"
	;;
esac
}

# Switch Status Website
function status_website() {
    id_website_list=()
    echo ""
    while read id server status
    do
        id_website_list+="${id} "
        printf "  ${id} - ${server} (${status})\n"
    done < <(mysql -u${db_user} -h${db_host} -P${db_port} -p${db_password} ${db_database} -N -e "SELECT web_id, web_domain, web_status FROM web")
    echo "  0 - Exit"
    read -p "Pleace choose your id website : " id_website
    if echo "${id_website_list[@]}" | grep -qw "${id_website}"; then
        datetime=$(date "+%Y-%m-%d %T")
        echo "UPDATE web SET web_status = !web_status, web_updated = '${datetime}' WHERE web_id=${id_website}" | mysql -u${db_user} -h${db_host} -p${db_password} ${db_database}
        read -e web_domain web_status <<<$(mysql -u${db_user} -h${db_host} -P${db_port} -p${db_password} ${db_database} -N -e "SELECT web_domain, web_status FROM web WHERE web_id='${id_website}'")
        if [ ${web_status} -ne 0 ]; then
            web_status="True"
        else
            web_status="False"
        fi
        good_text "Your are updated the website ${web_domain} to ${web_status}"
    else
        error_text "Error ${id_website} is not a valid value!"
    fi
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
    done < <(mysql -u${db_user} -h${db_host} -P${db_port} -p${db_password} ${db_database} -N -e "SELECT GROUP_CONCAT(web_domain SEPARATOR ','), web_server FROM web GROUP BY web_server")
    mgt_website "$@"
}


# Management Website
function mgt_website(){
    cat <<EOF

  1 - Add website
  2 - Update website
  3 - Switch status website
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
        status_website "$@"
        ;;
    4)
        list_website "$@"
	;;
    9)
        main "$@"
	;;
    0)
        exit_cli "$@"
        ;;
    *)
        error_choice "mgt_website"
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

# Switch Status Server
function status_server() {
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
  3 - Switch status server
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
        status_server "$@"
        ;;
    4)
        list_server "$@"
	;;
    9)
        main "$@"
	;;
    0)
        exit_cli "$@"
        ;;
    *)
        error_choice "mgt_server"
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
        exit_cli "$@"
        ;;
    *)
        error_choice "main"
	;;
esac
}

main "$@"
