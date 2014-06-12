#!/bin/bash
source miners-sha256.sh
for i in $miners
do
  php switchpool.php stratum+tcp://stratum.mining.eligius.st:3334 1mineSNbjsnJRzXpbW3xUsvtSUjhPRsNy_$i x clear $i 4028
done
