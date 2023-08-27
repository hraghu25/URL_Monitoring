#This script will help us to monitor URLs

#!/bin/bash 

set -e 

LOG_FILE=./urlmonitoring.log 

exec > >(tee -a ${LOG_FILE} ) 2>&1 

log_info() {
    echo "[INFO] ${date} :: $@"
}

log_error(){
    echo "[ERROR] ${date} :: $@"
}

log_debug(){
    echo "[DEBUG] ${date} :: $@"
}

check_url_isEmpty(){
    local $url 
    if [ -z "$url" ]; then 
        log_error "Empty URL encountered... Skipping"
        exit 1
    fi 
    exit 0
}

check_status(){
    local $url 
    http_status=$(curl -Is $url | head -1 | awk '{print $2}')
    log_debug "Received HTTP Status code for an $url is $http_status

    if [ "$http_status" = "200" ]; then
        log_info "Response code for $url is $http_status
    else 
        log_info "Failed to get response code for $url and code optained $http_status
    fi 
}


main(){
    while read -r $url; do 
        log_debug "Processing URL: $url"
        if check_url_isEmpty "$url"; then
                check_status "$url"
        fi 
        sleep 2 
    done < url.txt
}

main 