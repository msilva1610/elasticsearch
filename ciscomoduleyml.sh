# CISCO MODULE ##########################################################################
echo -e "-- Habilitando CISCO MODULE\n"
sudo filebeat modules enable cisco 
# Setup Cisco module ##########################################################################
echo -e "-- Setup Cisco modules\n"
sudo mv /etc/filebeat/modules.d/cisco.yml /etc/filebeat/modules.d/cisco.bcp
sudo cat > /etc/filebeat/modules.d/cisco.yml <<'EOD'
# Docs: https://www.elastic.co/guide/en/beats/filebeat/7.3/filebeat-module-cisco.html
- module: cisco
  asa:
    enabled: true
    var.input: file
    var.paths: ["/vagrant/logs/cisco/*.log"]
  ios:
    enabled: false
    # Set which input to use between syslog (default) or file.
    #var.input: syslog
EOD
# Dashboard e Pipeline##########################################################################
echo -e "-- Setup indice\n"
sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["192.168.110.10:9200", "192.168.110.11:9200"]'
echo -e "-- Setup Template\n"
sudo filebeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['192.168.110.10:9200'] -E setup.kibana.host=192.168.110.13:5601



