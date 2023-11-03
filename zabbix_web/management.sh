#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 07/28/2023
# Modification Date : 11/03/2023
###########################

#
# VARIABLES
#
source variable
source mgt_website.sh
source mgt_server.sh

#
# TEMPLATES FUNCTIONS
#

# Wrong choice
function error_choice(){
    error_text "Please make a correct choice !"
    $1 "$@"
}

# Error text
function error_text(){
    printf "${_red}${1}${_reset}\n"
}

# Good text
function good_text(){
    printf "${_green}${1}${_reset}\n"
}

# Info text
function info_text(){
    printf "${_blue}${1}${_reset}\n"
}


# Exit
function exit_cli(){
    info_text "\nThanks you for use this script :)\n"
    sleep 1
    exit
}

# Uppercase to Lowercase
function upper_to_lower(){
    lower=$(echo "$1" | awk '{print tolower($0)}')
    echo $lower
}


#
# FUNCTIONS
#

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
        main_menu "$@"
	;;
    0)
        exit_cli "$@"
        ;;
    *)
        error_choice "mgt_website"
	;;
esac
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
        main_menu "$@"
        ;;
    0)
        exit_cli "$@"
        ;;
    *)
        error_choice "mgt_server"
        ;;
esac
}

# Main Menu
function main_menu(){
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
        error_choice "main_menu"
	;;
esac
}

# Main
function main(){
    if [[ $(git pull origin --dry-run --quiet) ]];then
        info_text "A new version is available \nPlease use this command 'git pull origin'"
    fi
    main_menu "$@"
}

main "$@"
