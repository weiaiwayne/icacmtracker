#!/bin/sh
cd /home/curiositybits/icacmtracker/icacmtracker-public
read message
git add *
timestamp(){
   date +"%d.%m.%Y um %H:%M"
}
git commit -am "Auto Server Commit $(timestamp)"
git push --repo https://github.com/weiaiwayne/icacmtracker-public.git
