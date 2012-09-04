#!/bin/sh
echo "I will download freeradius-client-1.1.6 and install it"
wget -c ftp://ftp.freeradius.org/pub/freeradius/freeradius-client-1.1.6.tar.gz
tar -zxf freeradius-client-1.1.6.tar.gz
cd /root/freeradius-client-1.1.6
echo "update environment"
apt-get -f install libgcrypt11 libgcrypt11-dbg libgcrypt11-dev libgpg-error-dev libcrypt-gcrypt-perl libcrypto++-dev libcrypto++-utils
echo "will install"
./configure
make && make install 

cat >>/usr/local/etc/radiusclient/servers<<EOF
s.enjoydiy.com enjoydiy
EOF

sed -i 's/localhost/s.enjoydiy.com/g' /usr/local/etc/radiusclient/radiusclient.conf 

wget -c http://small-script.googlecode.com/files/dictionary.microsoft
mv ./dictionary.microsoft /usr/local/etc/radiusclient/

cat >>/usr/local/etc/radiusclient/dictionary<<EOF
INCLUDE /usr/local/etc/radiusclient/dictionary.sip
INCLUDE /usr/local/etc/radiusclient/dictionary.ascend
INCLUDE /usr/local/etc/radiusclient/dictionary.merit
INCLUDE /usr/local/etc/radiusclient/dictionary.compat
INCLUDE /usr/local/etc/radiusclient/dictionary.microsoft
EOF

sed -i 's/logwtmp/\#logwtmp/g' /etc/pptpd.conf
sed -i 's/radius_deadtime/\#radius_deadtime/g' /usr/local/etc/radiusclient/radiusclient.conf
sed -i 's/bindaddr/\#bindaddr/g' /usr/local/etc/radiusclient/radiusclient.conf 

cat >>/etc/ppp/pptpd-options<<EOF 
plugin /usr/lib/pppd/2.4.5/radius.so
radius-config-file /usr/local/etc/radiusclient/radiusclient.conf
EOF

cd /root
rm -rf freeradius* 

