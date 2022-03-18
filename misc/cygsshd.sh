#/bin/bash


_setup(){
# Installs sshd and requires openssh of cygwin.


# n.b. the default sshd_config file works fine,
# but mind the permissions of .ssh (and $HOME) in case of server rejecting a key.
# cygcheck -c openssh
# ssh -v lo
#

thisdir=$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)
# Writes $HOME to nsswitch.conf,
# otherwise ssh and sshd look for files in /home/$USER/.ssh which does not exist,
# and when logged on, bash even copies skeleton files .bashrc, etc to /home/$USER,
# thinking that is the home directory.
"$thisdir/sethome.sh"

# Removes Windows OpenSSH service.
sc query sshd
sudo sc delete sshd

# Removes Cygwin OpenSSH service.
sudo net stop cygsshd
sc query cygsshd
sudo sc delete cygsshd

ps|grep ssh|awk '{print $1}'|xargs kill -9
sudo ssh-host-config --yes
sudo net start cygsshd

#ssh-host-config asks less questions with Cygwin 2.905 then before.
#Questions asked:
#1.Overwrite /etc/ssh_config	(y)
#2.Overwrite /etc/sshd_config	(y)
#3.StrictModes			(y)
#4.Install as a service		(y)
#5."Enter the value of CYGWIN for the daemon"
#(I think he means setting the environment variable named "CYGWIN" for the daemon)
#The sshd service is run by "Local System"

#With previous version 2.881 of Cygwin,
#username(cyg_server) and password are required to create an account to run sshd.
#This observation is verified by this link,
#https://www.mail-archive.com/cygwin@cygwin.com/msg159887.html.
}

_esed(){ printf '%s' "$1"|sed 's/[.[\*^$/]/\\&/g';}
_configure(){
    
    _sub '/etc/sshd_config' 'authorizedkeysfile .ssh/authorised_keys'

    _sub '/etc/ssh_config' 'hashknownhosts no'
    _sub '/etc/ssh_config' 'stricthostkeychecking no'
    _sub '/etc/ssh_config' 'updatehostkeys no'
    _sub '/etc/ssh_config' 'pubkeyacceptedkeytypes +ssh-rsa'

    _reload
}
_sub(){
    local f="$1"
    local replace="$2"
    local d=' \t';local find="$(sed "s/^\([^$d]*\).*$/\1/" <<<$replace)";find="$(_esed "$find")"
    replace="$(_esed "$replace")"


    #sed -i "/^$find[$d].*$/I{h;s//$replace/};\${x;/^\$/{s//$replace/;H};x}" "$f"
    
    
    # a bug?
    #
    # $ ls -la /etc/sshd_config
    #   -rw-r--r-- 1 SYSTEM Administrators 3096 Mar 18 19:55 /etc/sshd_config
    # $ sudo sed -i ...
    #   sed: preserving permissions for ‘/etc/sedw2Bjql’: Permission denied
    # $ sed -i ...
    #   -rw-r--r-- 1 `whoami` Administrators 3096 Mar 18 19:59 /etc/sshd_config
    #   
    local g="$(mktemp)";trap '(set -x;rm "$g");trap - RETURN' RETURN
    sed "/^$find[$d].*$/I{h;s//$replace/};\${x;/^\$/{s//$replace/;H};x}" "$f">"$g"
    sudo bash -c "cat $g|tee $f >/dev/null"
}

_reload(){ sudo bash -c 'sc stop cygsshd;sc start cygsshd';}


_usage(){
    cat <<EOF
SYNOPSIS
    $0 --setup
    $0 --configure
    $0 --reload
EOF
    exit $1
}
[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    --setup)_setup;;
    --configure)_configure;;
    --reload)_reload;;
    *)_usage 0;;
esac;shift;done


