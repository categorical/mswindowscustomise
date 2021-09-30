#!/bin/bash



reg query 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion' \
    |grep -i releaseid \
    |awk '{print $3}'

