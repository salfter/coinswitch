#!/bin/bash
source miners-sha256.sh
for i in $miners
do
  php switchpool.php stratum+tcp://coinotron.com:3336 salfter.${i}_frc x clear $i 4028
done
