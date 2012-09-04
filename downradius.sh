#!/bin/sh
echo "I will download freeradius-client-1.1.6 and install it"
#wget -c ftp://ftp.freeradius.org/pub/freeradius/freeradius-client-1.1.6.tar.gz
#tar -zxf freeradius-client-1.1.6.tar.gz
cd /root/freeradius-client-1.1.6
echo "update environment"
#apt-get -f install libgcrypt11 libgcrypt11-dbg libgcrypt11-dev libgpg-error-dev libcrypt-gcrypt-perl libcrypto++-dev libcrypto++-utils
echo "will install"
./configure
make && make install 

