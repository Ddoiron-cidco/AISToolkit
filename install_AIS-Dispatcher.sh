#!/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Install script for RTL_Dispatcher."
   echo
   echo "Syntax: install_AIS-Dispatcher.sh"
   echo
   echo "Command line exemple."
   echo "install_RTL-Dispatcher.sh -help"
   echo "install_RTL-Dispatcher.sh"
   
}


if [ "$1" = 'h' ] || [ "$1" = '-h' ] || [ "$1" = 'help' ] || [ "$1" = '-help' ]
then
  Help
  exit
else 
  echo "[+] Install and compile libssl.so.1.1"
  cd ~/
  sudo apt update
  sudo apt -y bzip2 make gcc g++ lib6-dev-arm64*
  wget https://www.openssl.org/source/openssl-1.1.1o.tar.gz
  tar -zxvf openssl-1.1.1o.tar.gz
  cd openssl-1.1.1o
  ./config -mfloat-abi=hard -mfpu=vfp
  make
  make test
  sudo make install
  find / -name libssl.so.1.1
  sudo ln -s /usr/local/lib/libssl.so.1.1  /usr/lib/libssl.so.1.1
  find / -name libcrypto.so.1.1
  sudo ln -s /home/ubuntu/openssl-1.1.1o/libcrypto.so.1.1     /usr/lib/libcrypto.so.1.1


  echo "[+] Installing aisdispatcher"
  sudo apt-get install -y aha
  cd ~/
  
  wget https://www.aishub.net/downloads/dispatcher/install_dispatcher
  chmod 755 install_dispatcher
  sudo ./install_dispatcher
  rm install_dispatcher


  exit
fi
