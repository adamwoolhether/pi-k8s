#!/bin/bash

# Remember to setup SSH keys on your cloud VM
# Configure proper vars below and set cron job to run this script 
# To login from VM: ssh -p 6000 pi@localhost

USERNAME=
CLOUDIP=
NOW=$(date)
piTunnel(){
     /usr/bin/ssh -N -R 6000:localhost:22 $USERNAME@$CLOUDIP

     if [[ $? -eq 0 ]]; then
         echo "$NOW Tunnel to pibastion created successfully."
     else
         echo "$NOW Error creating tunnel to pibastion. RC: $?"
     fi
}

/bin/pidof ssh
if [[ $? -ne 0 ]]; then
     echo "$NOW Creating new tunnel connection"
     piTunnel
     fi
