#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://frk.coin-pool.org:3334 salfter.${i} x clear ${i} 4029
done
