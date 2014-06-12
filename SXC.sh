#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://sxc.cryptominer.net:3353 salfter.${i} x clear ${i} 4029
done
