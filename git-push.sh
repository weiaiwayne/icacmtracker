#!/bin/sh
cd /home/curiositybits/icacmtracker/icacmtracker-public
git add *
timestamp(){
   date +"%d.%m.%Y um %H:%M"
}
git commit -am "Auto Server Commit $(timestamp)"
git push 
