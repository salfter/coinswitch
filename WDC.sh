#!/bin/bash
source miners.sh
for i in $miners
do
  php switchpool.php stratum+tcp://us-west.multipool.us:3342 s_alfter.${i} x clear ${i} 4029
done
