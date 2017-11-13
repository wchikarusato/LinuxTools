#!/bin/sh

rm -rf 1kizon.log
prod="prod"
prodhttps="prodhttps"
devauth="devauth"
if [ $1 = $prod ]; then
  for f in `cat 1kizon.txt `; do wget -a 1kizon.log -x --trust-server-names --no-check-certificate $f; done
elif [ $1 = $prodhttps ]; then
  for f in `cat 1kizon.https.txt `; do wget -a 1kizon.log -x --trust-server-names --no-check-certificate $f; done
elif [ $1 = $devauth ]; then
  for f in `cat 1kizon.dev.txt `; do wget -a 1kizon.log -x --trust-server-names --no-check-certificate --http-user=$2 --http-password=$3 --auth-no-challenge $f; done
else
  for f in `cat 1kizon.dev.txt `; do wget -a 1kizon.log -x --trust-server-names --no-check-certificate $f; done
fi

ruby -Ku sort_wgetlog.rb 1kizon.log > sort_1kizon.log

if [ $1 = $prod ] || [ $1 = $prodhttps ]; then
  rm -rf bike.sateiomakase.com
  rm -rf m.sateiomakase.com
  rm -rf hikkoshi.mobi
else
  rm -rf bike-dev.sateiomakase.com
  rm -rf m-dev.sateiomakase.com
  rm -rf dev.hikkoshi.mobi
fi
