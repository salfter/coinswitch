#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://anc.cryptotroll.com:3338 salfter.${i} x clear ${i} 4029
done
