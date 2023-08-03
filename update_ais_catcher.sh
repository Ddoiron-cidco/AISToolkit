#!/bin/bash

############################################################
# Help                                                     #
############################################################


Help()
{
   # Display Help
   echo "Install script for ais_catcher on a raspberry pi 3."
   echo
   echo "Syntax: update_ais_catcher.sh  [options]"
   echo "options:"
   echo "[help or h]        Print this Help."    
   echo
   echo "Command line exemple." 
   echo "updatel_rtl_ais.sh -help"
}

if [ "$1" = 'h' ] || [ "$1" = '-h' ] || [ "$1" = 'help' ] || [ "$1" = '-help' ]
then
  Help
  exit

else 
    echo "<*> disable auto-update"
    sudo systemctl stop unattended-upgrades
    echo "[+] Updating repositories"
    sudo apt update | tee ~/log.txt
    echo "[+] Updating applications"
    sudo apt upgrade -y | tee -a ~/log.txt
    echo "Stoping the service"
    sudo systemctl stop AIS-catcher
    echo "[-] Removing hold AIS-catcher"
    cd /home/ubuntu
    sudo rm -rd AIS-catcher
    echo "[+] Cloning AIS-catcher git repository"
    cd /home/ubuntu
    git clone https://github.com/jvde-github/AIS-catcher.git | tee -a ~/log.txt
    cd AIS-catcher
    mkdir build
    cd build
    cmake ..
    echo "[+] Building..."
    make
    sudo make install
    echo "[+] Starting the AIS-Catcher service"
    sudo systemctl start AIS-catcher
    echo "[+] AIS-catcher has started"
    echo "[+] UPDATE COMPLETE !"        
fi

