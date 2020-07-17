#!/bin/bash                                                             

function proxy(){                                                                        
    local -r vars=(                                                    
        'HTTP_PROXY'                                                    
        'HTTPS_PROXY'                                                   
        'http_proxy'                                                    
        'https_proxy'                                                   
        'ftp_proxy'                                                    
    )                                                                   
    case $@ in                                                         
        up)                                                             
            local -r proxy=''                  
            for v in "${vars[@]}";do                                    
                export "$v"="$proxy"                                    
            done                                                        
            ;;                                                          
        down) unset "${vars[@]}";;                                      
        *) echo "usage: $FUNCNAME {up | down}";;                        
    esac                                                                
}

 



