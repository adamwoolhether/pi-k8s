#!/bin/sh

# Ensure ssh key is added to VM, replacing username with cloud accounts username
# Run on VM to automate: sudo echo "ssh -p 6000 ubuntu@localhost" >> /etc/.profile
# For manual: sudo echo 'alias pibast="ssh -p 6000 ubuntu@localhost"' >> ~/.bashrc

CLOUDIP=10.10.10.10
CLOUDUSER=adamwoolhether

cat <<EOF | sudo tee ${HOME}/pibast.sh
#!/bin/bash
NOW=\$(date)
piTunnel(){
     /usr/bin/ssh -N -R 6000:localhost:22 $CLOUDUSER@$CLOUDIP

     if [[ \$? -eq 0 ]]; then
         echo "\$NOW Tunnel to pibastion created successfully."
     else
         echo "\$NOW Error creating tunnel to pibastion. RC: \$?"
     fi
}

/bin/pidof ssh
if [[ \$? -ne 0 ]]; then
     echo "\$NOW Creating new tunnel connection"
     piTunnel
     fi
EOF

sudo chmod +x ${HOME}/pitunnel.sh

sudo crontab -u ubuntu - <<EOF
# Automate connection to Cloud instance for ssh tunneling
*/1 * * * * /bin/bash -c ~/pitunnel.sh >> pitunnel.log 2>&1
EOF
