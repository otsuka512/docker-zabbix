#!/bin/sh
datestr=`date +%Y%m%d`
backupdir=$HOME/docker/zabbix/backup

echo -n "Stop Zabbix Okey [y/n]?"
read YN
case "$YN" in
    y|Y)
	docker exec -i -t zabbix monit -d 10 -c /etc/monitrc stop zabbix-server
	echo -n "Confirm to Stop Zabbix-server [enter to continue]"
	read YN
	docker exec -i -t zabbix mysqldump -uroot -pmypassword --default-character-set=utf8 --database zabbix > $backupdir/zabbix_dump_$datestr.db
	docker exec -i -t zabbix monit -d 10 -c /etc/monitrc start zabbix-server
	bzip2 $backupdir/zabbix_dump_$datestr.db
	;;
    *)
	echo "nothing to do"
	;;
esac
