#!/usr/bin/env python

# coinswitch: a mining profitability switcher
#
# Copyright © 2014 Scott Alfter
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

import pprint
import simplejson
import os
import ConfigParser
import sys
import subprocess
import time
import StringIO
import pycurl
sys.path.insert(0, './PyCryptsy/')
from PyCryptsy import PyCryptsy

# get market info from Cryptsy

def GetMarkets(cfg):
  #return simplejson.loads(open("cryptsy.json").read()) # read from file for testing
  cryptsy=PyCryptsy(cfg.get("Cryptsy", "key"), cfg.get("Cryptsy", "secret"))
  return cryptsy.Query("getmarkets", {})

# get profitability info from CoinWarz

def GetProfitability(cfg): 
  #return simplejson.loads(open("coinwarz.json").read()) # read from file for testing
  b=StringIO.StringIO()
  ch=pycurl.Curl()
  url="http://www.coinwarz.com/v1/api/profitability/"
  args=""
  items=cfg.items("CoinWarz")
  for i in items:
    if (args!=""):
      args=args+"&"
    args=args+i[0]+"="+i[1]
  if (args!=""):
    url=url+"?"+args
  ch.setopt(pycurl.URL, url)
  ch.setopt(pycurl.WRITEFUNCTION, b.write)
  ch.perform()
  return simplejson.loads(b.getvalue())

# initialization

cfg=ConfigParser.ConfigParser()
cfg.optionxform=str

round=1
curr_coin=""
history={}

# main loop

while True:
  # check for configuration changes
  cfg.read("./coinswitch.conf")
  files=[]
  for file in os.listdir("."):
    files.append(file)

  # round header

  print ""
  print "###############"
  print "# Round "+str(round).rjust(5)+" #"
  print "###############"

  print ""
  print "Fetching updated information..."

  # get updated info from Cryptsy & CoinWarz

  markets=GetMarkets(cfg)
  profitability=GetProfitability(cfg)

  # find most profitable coin listed at Cryptsy for which we have a miner config

  on_cryptsy={}
  for pair in markets["return"]:
    if (pair["secondary_currency_code"]=="BTC"):
      on_cryptsy[pair["primary_currency_code"]]={"marketid": pair["marketid"]}
      
  unsorted_ratios={}
  for coin in profitability["Data"]:
    if (coin["CoinTag"] in on_cryptsy and coin["IsBlockExplorerOnline"]==True and coin["HealthStatus"]=="Healthy"):
      #unsorted_ratios[coin["CoinTag"]]=coin["AvgProfitRatio"]
      unsorted_ratios[coin["CoinTag"]]=coin["ProfitRatio"]
  ratios=sorted(unsorted_ratios.items(), reverse=True, key=lambda x:x[1])

  available=[]
  for coin in ratios:
    if (coin[0]+".sh" in files):
      available.append(coin)
  
  print ""  
  print "Most profitable: "+ratios[0][0]+", "+str(ratios[0][1])
  print "Most profitable that's configured: "+available[0][0]+", "+str(available[0][1])
  
  # switch and update history
  
  if (available[0][0]!=curr_coin):
    curr_coin=available[0][0]
    print ""
    print "Switching to "+curr_coin+"..."
    subprocess.call(["./"+curr_coin+".sh"])
  if (curr_coin in history):
    coinhist=history[curr_coin]
    coinhist["profitability"]=(coinhist["rounds"]*coinhist["profitability"]+available[0][1])/(coinhist["rounds"]+1)
    coinhist["rounds"]=coinhist["rounds"]+1
  else:
    coinhist={"rounds": 1, "profitability": available[0][1]}
  history[curr_coin]=coinhist
  
  # print history table
  
  print ""
  out="#"
  for i in range(0, len(history)):
    out=out+"########"
  print out
  out="#"
  for i in history:
    out=out+" "+i.ljust(5)+" # "
  print out
  out="#"
  for i in history:
    out=out+" "+str(history[i]["rounds"]).rjust(5)+" # "
  print out
  out="#"
  for i in history:
    out=out+" "+str(int(history[i]["profitability"]+0.5)).rjust(5)+" # "
  print out
  out="#"
  for i in range(0, len(history)):
    out=out+"########"
  print out  
    
  round=round+1
  
  # lather, rinse, repeat
  
  print ""
  print "Waiting "+cfg.get("Misc", "interval")+" seconds for next round..."
  time.sleep(float(cfg.get("Misc", "interval")))
  
