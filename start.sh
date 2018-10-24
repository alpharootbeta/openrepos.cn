#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mkdir -p /data
cd /data
/etc/init.d/nginx start
pip3 install requests bs4 html5lib
while :
  do
  python3 get_publishers.py |tee publisher.txt
  while read line
  do
   repos="https://sailfish.openrepos.net/${line}/"
   wget --header="Referer: https://sailfish.openrepos.net/${line}/personal/main/" \
    --header="User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36" \
    -c -r -np -k -L -p -q ${repos}
   #find . -name index.html -delete
   sed -i 's/sailfish.openrepos.net/openrepos.cn/' $(grep -rl "sailfish.openrepos.net" .)
   createrepo -update sailfish.openrepos.net/${line}/personal/main/
  done < publisher.txt
  sleep 3600
done
