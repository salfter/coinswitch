#!/bin/bash
source miners.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://bitgem.dyndns.org:3333 salfter.${i} x clear ${i} 4029
  php switchpool.php stratum+tcp://bitgem.gotdns.org:3333 salfter.${i} x clear ${i} 4029
done
