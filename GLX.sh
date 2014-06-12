#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://galaxy.cryptcoins.net:3329 salfter.${i} x clear ${i} 4029
done
