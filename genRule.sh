#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

curl https://raw.githubusercontent.com/vokins/yhosts/master/hosts -k|awk '/^127.0.0.1/{if ($2!="XiaoQiang") print $0}' > $DIR/adbhosts
cat $DIR/extra >> $DIR/adbhosts

echo '[Rule]' > $DIR/chosts.conf
awk '/^127.0.0.1/{if ($2!="localhost" && $2!="XiaoQiang") print "DOMAIN-SUFFIX,"$2",REJECT"}' $DIR/adbhosts >> $DIR/chosts.conf

echo '[Rule]' > $DIR/chinaunicom.conf
echo '[Rule]' > $DIR/cmcc.conf
echo '[Rule]' > $DIR/chinanet.conf
curl https://raw.githubusercontent.com/huanz/surge-hosts/master/ChinaUnicom.conf -k|awk '/^DOMAIN/{print $0}' >> $DIR/chinaunicom.conf
curl https://raw.githubusercontent.com/huanz/surge-hosts/master/CMCC.conf -k|awk '/^DOMAIN/{print $0}' >> $DIR/cmcc.conf
curl https://raw.githubusercontent.com/huanz/surge-hosts/master/ChinaNet.conf -k|awk '/^DOMAIN/{print $0}' >> $DIR/chinanet.conf