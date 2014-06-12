#!/bin/bash
source miners-sha256.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://xjo.coin-pool.org:3335 salfter.$i x clear $i 4028
  php switchpool.php stratum+tcp://de1.miningpool.co:11001 salfter.$i x clear $i 4028
done
