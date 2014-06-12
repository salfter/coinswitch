coinswitch: a mining profitability switcher
===========================================

CoinChoose's data has apparently gotten worse over the past few months due
to a lack of maintenance, which has made CryptoSwitcher somewhat less
useful.  This package doesn't try to do all of the things that
CryptoSwitcher did, but what it does, it should do well.  Its workflow is
roughly as follows:

* see what coins are tradable for BTC on Cryptsy
* check CoinWarz for profitability information (tested with scrypt coins,
  but others should work)
* find the most profitable coin to mine that we'll be able to trade for BTC
* call a shell script to switch pools, if necessary
* wait and repeat

You'll need API keys for both Cryptsy and CoinWarz.  CoinWarz charges for
use of its API after the first 1000 calls; checking once per hour, you
should be able to try out this script for six weeks before running out.

To set up coinswitch, copy coinswitch.conf.sample to coinswitch.conf and
edit as appropriate.  For each coin, set up a script named $ABBREV.sh (such
as LTC.sh for Litecoin or DOGE.sh for Dogecoin) that will switch your miners
to the appropriate pool.  

If you notice that a coin is having issues (as I wrote this, Neocoin pools
were having orphan problems), you can rename the script to something like
$ABBREV.sh.disabled; on the next round, it will be removed from
consideration.  Likewise, if you add or reenable a pool, it will be
considered in the next round.  Changes can be made to the configuration
while coinswitch is running; restarts shouldn't be necessary most of the
time.

By way of example, I've included the scripts I'm using for the pools that
I've currently configured.  My scripts, in turn, have two dependencies.
miners.sh declares a variable with miner hostnames.  switchpool.php is used
to communicate with a running cgminer or bfgminer instance (this means the
miner's RPC interface needs to be enabled for writing).  Note that my
SHA-256 miners are on port 4028 and my scrypt miners are on port 4029;
you'll want to edit your scripts according to your configuration.

At each pool, you'll want to configure your payout address to send to
Cryptsy and to auto-pay after a couple hours' worth of coin has accumulated
(CoinWarz will give you an estimate of how many coins you can expect per
hour).  At Cryptsy, you'll want to enable auto-trade for the coins you will
mine.

Finally, you might want to auto-withdraw your BTC proceeds from Cryptsy. 
withdraw.py will check your BTC balance at Cryptsy and sweep it to a
preapproved address when it reaches the minimum you select.

If this script helps you out, tips are appreciated:

BTC: 1TipsGocnz2N5qgAm9f7JLrsMqkb3oXe2
LTC: LTipsVC7XaFy9M6Zaf1aGGe8w8xVUeWFvR
BTG: gTipsVB9qmyYHuqMMKTuCYMHpfkUFBXKrZ

(last updated 11 June 2014)
