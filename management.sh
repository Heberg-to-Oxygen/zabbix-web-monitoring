#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a website with zabbix discovery
# Creation Date : 28/07/2023
# Modification Date : 14/02/2023
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
function msgHelp(){
        printf '%s\n' "Help for monitoring websites zabbix

You can use the following Options:

  help                     => Help Dialog
  add [website|server]     => 
  update [website|server]  => 
  delete [website|server]  => 
  status [website|server]  => 
  list [website|server]    => 
  disable [website|server] => 
  enable [website|server]  => 

More Documentation can be found on Github: https://github.com/Heberg-to-Oxygen/zabbix-web-monitoring"
        exit 0
}

# New management script
function getParams(){
  while test $# -gt 0; do
    case "$1" in
      help)
        msgHelp "$@"
       	;;
      add)
        if [ -z $2 ];then
	  msgHelp "$@"
        elif [ $2 == "server" ] || [ $2 == "website" ];then
          add_$2 "$@"
	else
	  msgHelp "$@"
	fi
	break
       	;;
      *)
        msgHelp "$@"
        ;;
    esac
    shift
  done
}

# Main
function main(){
    if [[ $(git pull origin --dry-run --quiet) ]];then
        info_text "A new version is available \nPlease use this command 'git pull origin'"
    fi
    getParams "$@"
}

main "$@"
