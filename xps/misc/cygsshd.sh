#/bin/bash

sc query sshd
sc delete sshd

net stop cygsshd
sc query cygsshd
sc delete cygsshd


ssh-host-config --yes
net start cygsshd


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





