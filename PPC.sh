#!/bin/bash
source miners-sha256.sh
for i in $miners
do
#  php switchpool.php stratum+tcp://stratum.d7.lt:3333 salfter.$i x clear $i 4028
  php switchpool.php stratum+tcp://coinotron.com:3338 salfter.${i}_ppc x clear $i 4028
done
