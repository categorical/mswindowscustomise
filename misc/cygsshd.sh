#/bin/bash

Installs sshd and requires openssh of cygwin.


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





