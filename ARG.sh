#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://arg.cryptopools.com:3305 salfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://arg.minepool.net:3331 salfter.${i} x clear ${i} 4029
#  php switchpool.php stratum+tcp://us-west.multipool.us:3346 s_alfter.${i} x clear ${i} 4029
done
