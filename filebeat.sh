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
# Install Filebeat ##########################################################################
echo -e "-- Instalando filebeat\n"
sudo yum install filebeat -y
# SETUP filebeat ##########################################################################
echo -e "-- Setup filebeat.yml\n"
sudo mv /etc/filebeat/filebeat.yml /etc/filebeat/filebeat.bcp
# SETUP systemctl ##########################################################################
echo -e "-- FIM\n"
