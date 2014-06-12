#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://de3.miningpool.co:3905 salfter.${i} x clear ${i} 4029
done
