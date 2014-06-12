#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://us-west.multipool.us:3352 s_alfter.${i} x clear ${i} 4029
#  php switchpool.php stratum+tcp://de2.miningpool.co:23001 salfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://doberman.dogehouse.org:3336 salfter.${i} x clear ${i} 4029
done
