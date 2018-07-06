#!/bin/bash
mkdir -p /data
cd /data
/usr/bin/createrepo -pdo /data/ /data/
#/usr/bin/python -m SimpleHTTPServer 10088 &
/etc/init.d/nginx start
/usr/bin/inotifywait -mrq  --format '%w%f %e' \
        -e modify,create,delete --exclude '^/data/(.repodata|.olddata|repodata|.repodata/.*)' /data \
        | while read x
        do
	  file_action="$x"
          file=`echo $file_action|awk '{print $1}'`
          action=`echo $file_action|awk '{print $2}'` 
          if [[ "$file" =~ "repodata" ]]
          then
            echo ""
          else
            /usr/bin/createrepo -update /data    
          fi
        done
