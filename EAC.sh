#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://eac.poolerino.com:3334 salfter.${i} x clear ${i} 4029
done
