#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

## clash
echo '=== clash start ==='
echo 'Rule: ' > $DIR/Clash/Rule.yml
cat $DIR/src/proxy-keyword |awk '{print "- DOMAIN-KEYWORD,"$0",Proxy"}' >> $DIR/Clash/Rule.yml
cat $DIR/src/proxy-suffix |awk '{print "- DOMAIN-SUFFIX,"$0",Proxy"}' >> $DIR/Clash/Rule.yml
cat $DIR/src/direct-suffix |awk '{print "- DOMAIN-SUFFIX,"$0",DIRECT"}' >> $DIR/Clash/Rule.yml
cat $DIR/src/direct-ipcidr |awk '{print "- IP-CIDR,"$0",DIRECT"}' >> $DIR/Clash/Rule.yml
cat $DIR/src/direct-geoip |awk '{print "- GEOIP,"$0",DIRECT"}' >> $DIR/Clash/Rule.yml
echo '- MATCH,Proxy' >> $DIR/Clash/Rule.yml
echo '=== clash finished ==='

echo '=== AnyFlow start ==='
echo '[Rule]' > $DIR/AnyFlow/custom.conf
cat $DIR/src/proxy-keyword |awk '{print "DOMAIN-KEYWORD,"$0",PROXY"}' >> $DIR/AnyFlow/custom.conf
cat $DIR/src/proxy-suffix |awk '{print "DOMAIN-SUFFIX,"$0",PROXY"}' >> $DIR/AnyFlow/custom.conf
cat $DIR/src/direct-suffix |awk '{print "DOMAIN-SUFFIX,"$0",DIRECT"}' >> $DIR/AnyFlow/custom.conf
cat $DIR/src/direct-ipcidr |awk '{print "IP-CIDR,"$0",DIRECT"}' >> $DIR/AnyFlow/custom.conf
cat $DIR/src/direct-geoip |awk '{print "GEOIP,"$0",DIRECT"}' >> $DIR/AnyFlow/custom.conf
echo '=== AnyFlow reject from lhie1 ==='
curl 'https://raw.githubusercontent.com/lhie1/Rules/master/Surge3/reject.list' -k > $DIR/tmpReject
echo '[Rule]' > $DIR/AnyFlow/reject.conf
cat $DIR/tmpReject|sort|awk '/^DOMAIN/{print $0",REJECT"}' >> $DIR/AnyFlow/reject.conf
cat $DIR/tmpReject|sort|awk -F ',' '/^IP-CIDR/{print $1","$2",REJECT,"$3}' >> $DIR/AnyFlow/reject.conf

echo '=== AnyFlow finished ==='

echo '=== clean up ==='
rm -f $DIR/tmp*