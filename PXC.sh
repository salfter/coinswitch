#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://us-west.multipool.us:3347 s_alfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://pxc.minepool.net:3337 salfter.${i} x clear ${i} 4029
done
