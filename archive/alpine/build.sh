#!/bin/sh

apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers # nano

cd /root/system
rm -r xmrig
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
cp xmrig/build/xmrig idle
