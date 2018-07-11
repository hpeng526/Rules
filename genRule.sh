#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

curl https://raw.githubusercontent.com/vokins/yhosts/master/hosts -k|awk '/^127.0.0.1/{if ($2!="XiaoQiang") print $0}' > $DIR/adbhosts
cat $DIR/extra >> $DIR/adbhosts

echo '[Rule]' > $DIR/chosts.conf
awk '/^127.0.0.1/{if ($2!="localhost" && $2!="XiaoQiang") print "DOMAIN-SUFFIX,"$2",REJECT"}' $DIR/adbhosts >> $DIR/chosts.conf

echo '[Rule]' > $DIR/adb.conf
curl https://raw.githubusercontent.com/huanz/surge-hosts/master/surge.conf -k|awk '/^DOMAIN/{print $0}' >> $DIR/adb.conf
