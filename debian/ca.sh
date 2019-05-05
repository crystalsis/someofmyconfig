#!/usr/bin/env bash
#ca
mkdir ./demoCA
mkdir ./demoCA/certs
mkdir ./demoCA/newcerts
mkdir ./demoCA/private
mkdir ./demoCA/crl
touch ./demoCA/index.txt
echo 01 > ./demoCA/serial
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -out ca.csr
openssl x509 -req -days 36500 -in ca.csr -signkey ca.key -out ca.crt
openssl req -new -x509 -days 36500 -key ca.key -out ca.crt subj "/C=CN/ST=Shandong/L=Qingdao/O=guagua/OU=party/CN=consul.guagua.party"
openssl genrsa  -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl ca -in server.csr -out server.crt -cert ca.crt -keyfile ca.key