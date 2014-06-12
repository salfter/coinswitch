#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://stratum.wemineftc.com:3333 salfter.${i} x clear ${i} 4029
done
