#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://us-west.multipool.us:3348 s_alfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://us3.miningpool.co:4202 salfter.${i} x clear ${i} 4029
done
