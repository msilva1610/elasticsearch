
###Filebeat

## Setup filebeat

Template
```
sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.110.10:9200", "192.168.110.11:9200"]'
```


Comando para reiniciar a busca por arquivos de logs

```
sudo rm -rf /var/lib/filebeat/registry
```

```
sudo filebeat setup --template -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'
```

setup dashbaord
```
sudo filebeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['192.168.110.10:9200'] -E setup.kibana.host=192.168.110.13:5601
```

var.paths: ["/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge.log","/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge[0-9].log","/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge[0-9][0-9].log","/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge[0-9][0-9][0-9].log","/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge[0-9][0-9][0-9][0-9].log","/vagrant/logs/cisco/tmptrace-edge/tmptrace-edge[0-9][0-9][0-9][0-9][0-9].log"]