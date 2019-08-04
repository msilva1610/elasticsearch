#!/usr/bin/env bash
# BEGIN ########################################################################
echo -e "-- ----------------- --\n"
echo -e "-- INICIO ${HOSTNAME} --\n"
echo -e "-- ----------------- --\n"
# BOX ##########################################################################
echo -e "-- Atualizando packages list\n"
sudo yum update -y -qq
# SETUP ##########################################################################
echo -e "-- Maximo de arquivos que podem ser abertos\n"
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p
# JAVA ##########################################################################
echo -e "-- Instalando o java\n"
sudo yum install java-1.8.0-openjdk -y
# TOOLS ##########################################################################
echo -e "-- Instalando TOOLS\n"
sudo yum install net-tools wget vim -y
# RPM ##########################################################################
echo -e "-- Instalando Repositorio ELK\n"
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
# RPM ELK ##########################################################################
echo -e "-- Criando repositorio RPM ELK\n"
sudo cat > /etc/yum.repos.d/elasticsearch.repo <<EOD
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOD
# RPM UPDATE ##########################################################################
echo -e "-- UPDATE Repositorio ELK\n"
sudo yum update -y
# ELK ##########################################################################
echo -e "-- Instalando logstash\n"
sudo yum install logstash -y
# SETUP ELK ##########################################################################
echo -e "-- Setup logstash.yml\n"
sudo cp /etc/logstash/logstash.yml /etc/logstash/logstash.bcp
sudo cat > /etc/logstash/logstash.yml <<EOD
http.host: "0.0.0.0"
xpack.monitoring.elasticsearch.hosts: [ "http://192.168.110.10:9200", "http://192.168.110.11:9200" ]
xpack.monitoring.enabled: true
EOD
# SETUP systemctl ##########################################################################
echo -e "-- iniciando logstash\n"
sudo systemctl start logstash
# SETUP reiniciar no boot ##########################################################################
sudo systemctl enable logstash
echo -e "-- FIM\n"
