# Makefile for docker-node project

TAGNAME  = otsuka512/docker-zabbix
CONTNAME = zabbix

backup:
	./backup.sh

build:
	docker build -t $(TAGNAME) .

shell:
	docker exec -i -t zabbix /bin/bash

start:
	sudo initctl start docker-$(CONTNAME)

stop:
	sudo initctl stop docker-$(CONTNAME)

rm:
	docker rm $(CONTNAME)

run:
	sudo ./run.sh
	sudo initctl start docker-$(CONTNAME)

logs:
	docker logs $(CONTNAME)

tag:
	docker tag $(TAGNAME) $(TAGNAME):$(shell date +%Y%m%d)

# Eof
