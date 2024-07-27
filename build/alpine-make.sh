#!/bin/bash

cat <<EOF > run.sh

echo The script is supposed to be run only under a Docker container
uname -a
# apt-get update && apt-get install -y sudo
cd /root/system
rm -r xmrig

# https://xmrig.com/docs/miner/build/ubuntu (wget added, donate level fixed)
apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers # nano
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build

sed -i -e 's/DonateLevel = 1/DonateLevel = 0/g' xmrig/src/donate.h
cat xmrig/src/donate.h
sed -i -e 's/.\/build/sh build/g' xmrig/scripts/build_deps.sh
cat xmrig/scripts/build_deps.sh

cd xmrig/scripts && sh build_deps.sh && cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON
make -j$(nproc)

cd ../..
mv idle idle_$(date +%Y%m%d%H%M%S)_bak
mv xmrig/build/xmrig idle
rm -r xmrig
rm run.sh

EOF

echo -e "\033[1;36mThe script will recreate the folder '$(pwd)/xmrig'.\033[0m"
read -n 1 -p "Do you want to proceed? [Y/n] " key && [[ -z $key ]] || echo
[[ $key =~ [nN] ]] && exit

# Build idle binaries
docker run --rm -it --name build-idle-with-alpine -v $(pwd):/root/system alpine sh /root/system/run.sh
docker stop build-idle-with-alpine
