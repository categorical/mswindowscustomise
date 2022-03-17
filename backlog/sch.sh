#!/bin/bash
set -euo pipefail
#_infof(){ local f=$1;shift;_info "$(printf "$f" "$@")";}
#_info(){ printf "\033[96minfo: \033[0m%s\n" "$*";}
#_errorf(){ local f=$1;shift;_error "$(printf "$f" "$@")";}
#_error(){ printf "\033[31merror: \033[0m%s\n" "$*";}
_infof(){ local f=$1;shift;printf "\033[96minfo: \033[0m%s\n" "$(printf "$f" "$@")";}
_errorf(){ local f=$1;shift;printf "\033[91merror: \033[0m%s\n" "$(printf "$f" "$@")";}
_warnf(){ local f=$1;shift;printf "\033[33mwarning: \033[0m%s\n" "$(printf "$f" "$@")";}
#dthis="$(dirname "$(readlink -f "$0")")"
dthis="$(cd "$(dirname "$0")"&&pwd)"
_usage(){
	cat<<-EOF
	SYNOPSIS
	    $0 -h
	EOF
    exit $1
}

_list(){
    
    local i=0
    local cr=
    local u=
    while IFS= read -r;do
        [ "$cr" = 't' ]&&{ printf '\n|%4d|' "$i";cr=;((++i));}
        [ -z "$REPLY" ]&&{ cr='t';continue;}
        #local k="$(awk -F: '{print $1}'<<<"$REPLY")"
        #local v="$(awk -F: '{print $2}'<<<"$REPLY")"
        local k="${REPLY%%:*}"
        #local v="${REPLY#*:}";v="${v// }"
        local v="${REPLY#*:}";v="${v#${v%%[^ ]*}}"
        local w=10
        case "${k,,}" in
            folder*)u="$v";;
            taskname)w=80;;&
            next*)w=20;;&
            hostname);;
            status);;&
            logon*);;
            #info)w=60;;&
            info)w=80;printf "\e[31m%-${w}s\e[0m|" "${v:0:$w}";w=31;v="$u";;&
            *)printf "%-${w}s|" "${v:0:$w}";;
        esac
    done< <(schtasks /query /fo list|sed 's/\x0d$//')
    echo
}

_listsort(){
    _list|grep -iv 'disabled'|awk -F'|' '{print $5,$0}'|sort|cut -f2- -d'|'
}

_kill(){
    local v="$1"
    sudo schtasks /change /tn "$1" '/disable'
}
_spare(){
    local v="$1"
    sudo schtasks /change /tn "$1" '/enable'
}

declare -a vs=(
    '\Microsoft\XblGameSave\XblGameSaveTask'
    '\Microsoft\Windows\Windows Error Reporting\QueueReporting'
    '\Microsoft\Windows\WindowsUpdate\Scheduled Start'    
    '\Microsoft\Windows\UNP\RunUpdateNotificationMgr' # persistent
    '\Microsoft\Windows\InstallService\ScanForUpdates'
    '\Microsoft\Windows\InstallService\ScanForUpdatesAsUser'
    '\Microsoft\Windows\Flighting\OneSettings\RefreshCache'
    '\Microsoft\Windows\DiskCleanup\SilentCleanup'
    '\Microsoft\Windows\DiskFootprint\StorageSense'
    '\Microsoft\Windows\DiskFootprint\Diagnostics'
    '\Microsoft\Windows\Data Integrity Scan\Data Integrity Scan'
    '\Microsoft\Windows\Customer Experience Improvement Program\Consolidator'
    '\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip'
    '\Microsoft\Windows\CloudExperienceHost\CreateObjectTask'
    '\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives' # persistent
    '\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser'
    '\Microsoft\Windows\Application Experience\ProgramDataUpdater'
    '\Microsoft\Windows\Application Experience\StartupAppTask'

    #'\Microsoft\Windows\Device Setup\Metadata Refresh'

    '\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload'
    '\Microsoft\Windows\Feedback\Siuf\DmClient'
    '\Microsoft\Windows\InstallService\SmartRetry'
    '\Microsoft\Windows\HelloFace\FODCleanupTask'
    '\Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures'
    '\Microsoft\Windows\LanguageComponentsInstaller\Installation'
    '\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources'
    '\Microsoft\Windows\Location\Notifications'
    '\Microsoft\Windows\Location\WindowsActionDialog'
    '\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem'
    '\Microsoft\Windows\PushToInstall\Registration'
    '\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTask'
    '\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskLogon'
    '\Microsoft\Windows\SoftwareProtectionPlatform\SvcRestartTaskNetwork'
    '\Microsoft\Windows\Speech\HeadsetButtonPress'
    '\Microsoft\Windows\Speech\SpeechModelDownloadTask'
    '\Microsoft\Windows\SpacePort\SpaceAgentTask'
    '\Microsoft\Windows\SpacePort\SpaceManagerTask'
    '\Microsoft\Windows\Storage Tiers Management\Storage Tiers Management Initialization'
    '\Microsoft\Windows\termsrv\RemoteFX\RemoteFXWarningTask'
    '\Microsoft\Windows\termsrv\RemoteFX\RemoteFXvGPUDisableTask'
        
    '\Microsoft\Windows\Work Folders\Work Folders Logon Synchronization'
    '\Microsoft\Windows\Work Folders\Work Folders Maintenance Work'
 
)
# https://www.tenforums.com/customization/180514-project-scheduled-tasks-can-disabled-without-drastic-impact.html
# https://gist.github.com/IntergalacticApps/675339c2b805b4c9c6e9a442e0121b1d

_kk(){
    iselevated ||{ sudo "$0" -kk;return;}
    
    for v in "${vs[@]}";do
        _kill "$v" ||_warnf '%s' "$v"
    done
}

_usage(){
    cat<<-EOF
	SYNOPSIS
	    [sudo] $0 -l|--list
	    [sudo] $0 -ls
	EXAMPLES
	    $0 -kk
	    $0 -k '\Microsoft\XblGameSave\XblGameSaveTask'
	    $0 --spare '\Microsoft\XblGameSave\XblGameSaveTask'
	EOF
}

[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    -l|--list)_list;;
    -ls)_listsort;;
    -k|--kill)_kill "$2";break;;
    -kk)_kk;;
    --spare)_spare "$2";break;;
    *)_usage 0;;
esac;shift;done


