#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://us-west.multipool.us:3339 s_alfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://mnc.vircurpool.com salfter.${i} x clear ${i} 4029
done
