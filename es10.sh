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
echo -e "-- Instalando elasticsearch\n"
sudo yum install elasticsearch -y
# SETUP ELK ##########################################################################
echo -e "-- Setup elasticsearch.yml\n"
sudo cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.bcp
sudo cat > /etc/elasticsearch/elasticsearch.yml <<EOD
cluster.name: production
node.name: ${HOSTNAME}
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch
network.host: 192.168.110.10
discovery.seed_hosts: ["192.168.110.11"]
cluster.initial_master_nodes: ["192.168.110.10", "192.168.110.11"]
EOD
# SETUP systemctl ##########################################################################
echo -e "-- iniciando elasticsearch\n"
sudo systemctl start elasticsearch
# SETUP reiniciar no boot ##########################################################################
sudo systemctl enable elasticsearch
echo -e "-- FIM\n"
