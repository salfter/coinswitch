#!/bin/bash
source miners-sha256.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://mine1.coinmine.pl:6000 salfter.$i x clear $i 4028
#  php switchpool.php stratum+tcp://ch1.miningpool.co:7001 salfter.$i x clear $i 4028
  php switchpool.php stratum+tcp://pool.dsync.net:3333 s_alfter.$i x clear $i 4028
done
