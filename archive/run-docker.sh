#!/bin/bash

echo -e "\033[1;36mThe script will recreate the 'geth-node' Docker container.\033[0m"
read -n 1 -p "Do you want to proceed? [Y/n] " key && [[ -z $key ]] || echo
[[ $key =~ [nN] ]] && exit

# Build idle binaries
docker run --rm -it --name build-idle-with-alpine -v $(pwd):/root/system alpine sh /root/system/run.sh
docker stop build-idle-with-alpine

# Build Docker container
docker build . -t linuxserver/go-ethereum:alpine
docker rm -f geth-node
docker run -itd -p 30303:7777 --name geth-node linuxserver/go-ethereum:alpine
docker stop geth-node

echo -e "\033[1;36mRun via Docker with the command: docker start geth-node && docker attach geth-node.\033[0m"
echo Done.
