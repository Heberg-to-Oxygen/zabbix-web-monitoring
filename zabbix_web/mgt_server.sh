#/bin/bash
###########################
# Author : DJERBI Florian
# Object : Management a server for website in a zabbix discovery
# Creation Date : 10/24/2023
# Modification Date : 10/24/2023
###########################

#
# FUNCTIONS
#

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

