#!/bin/bash

echo -e "\033[1;33m⚠️ Before continuing, stop and optionally backup the original 'idle' file in all servers.\033[0m"
read -n 1 -p "Do you want to proceed? [Y/n] " key && [[ -z $key ]] || echo
[[ $key =~ [nN] ]] && exit

echo -e "\033[1;34m Hetzner #2 \033[0m"
scp idle root@95.216.154.146:/root/.system
echo -e "\033[1;34m Hetzner #3 \033[0m"
scp idle root@135.181.148.177:/root/.system
echo -e "\033[1;31m Oracle \033[0m"
scp idle ubuntu@129.152.11.146:/home/ubuntu
echo -e "\033[1;35m Demo \033[0m"
scp idle ubuntu@217.172.12.210:/home/ubuntu
echo -e "\033[1;35m Fiware \033[0m"
scp idle ubuntu@217.172.12.211:/home/ubuntu
echo -e "\033[1;36m Keyrock \033[0m"
scp idle ubuntu@46.17.108.137:/home/ubuntu
echo -e "\033[1;36m Orion \033[0m"
scp idle ubuntu@46.17.108.138:/home/ubuntu
echo -e "\033[1;36m Wilma \033[0m"
scp idle ubuntu@46.17.108.139:/home/ubuntu
