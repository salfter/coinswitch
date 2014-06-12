#!/bin/bash
source miners-sha256.sh
for i in $miners
do
  php switchpool.php stratum+tcp://dem.coin-pool.org:3453 salfter.$i x clear $i 4028
done
