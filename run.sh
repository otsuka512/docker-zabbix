#!/bin/sh
docker run --restart=always -d \
 --cap-add SYS_PTRACE --security-opt apparmor:unconfined \
 -p 8090:80 \
 -p 10051:10051 \
 -p 10052:10052 \
 --name zabbix  \
 -v /srv/docker/zabbix/mysql:/var/lib/mysql \
 -v /srv/docker/zabbix/alertscripts:/usr/lib/zabbix/alertscripts \
 -v /srv/docker/zabbix/externalscripts:/usr/lib/zabbix/externalscripts \
 -v /srv/docker/zabbix/zabbix_agentd.d:/etc/zabbix/zabbix_agentd.d otsuka512/docker-zabbix
