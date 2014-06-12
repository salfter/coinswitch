#!/bin/bash
source miners-sha256.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://uno.coin-pool.org:3331 salfter.$i x clear $i
  php switchpool.php stratum+tcp://de1.miningpool.co:10701 salfter.$i x clear $i 4028
done
