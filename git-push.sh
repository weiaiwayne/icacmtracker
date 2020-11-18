echo "tracker updated"
read message
git add .
git commit -m"updated" 
if [ -n "$(git status - porcelain)" ];
then
 echo "IT IS CLEAN"
else
 git status
 echo "Pushing data to server!!!"
 git push -u origin master
fi
-m"${message}"
