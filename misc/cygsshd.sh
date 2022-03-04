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
_config(){
    local f='/etc/sshd_config'
    local replace='authorizedkeysfile .ssh/authorised_keys'
    local d=' \t';local find="$(sed "s/^\([^$d]*\).*$/\1/" <<<$replace)";find="$(_esed "$find")"
    replace="$(_esed "$replace")"
    sed -i "/^$find[$d].*$/I{h;s//$replace/};\${x;/^\$/{s//$replace/;H};x}" "$f"
}


_usage(){
    cat <<EOF
SYNOPSIS
    $0 --setup
    $0 --configure
EOF
    exit $1
}
[ $# -gt 0 ]||set -- -h
while [ $# -gt 0 ];do case $1 in
    --setup)_setup;;
    --config)_config;;
    *)_usage 0;;
esac;shift;done


