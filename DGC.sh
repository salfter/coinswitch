#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://de1.miningpool.co:9103 salfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://us1.stratum.cryptopools.com:3333 salfter.${i} x clear ${i} 4029
done
