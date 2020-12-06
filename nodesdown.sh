#!/bin/bash
for i in {1..3}; do ssh -o ConnectTimeout=5 node$i 'sudo poweroff'; done
echo "all nodes powered off"
for ((i=5; i>1; i--)); do echo "shutown in $i" && sleep 1; done
echo "goodbye"
#sudo poweroff
exit
