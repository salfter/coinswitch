#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://cap.cryptotroll.com:3335 salfter.${i} x clear ${i} 4029
done
