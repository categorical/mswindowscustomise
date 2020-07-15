#/!bin/bash

thisdir=$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)
thisdirw=$(cygpath -w "$thisdir")


sudo lgpo /b "$thisdirw"';sleep 60'
#lgpo /b "$thisdirw" /n 'backupxxxx'




