#install.packages("git2r")
library(git2r)

# Insure you have navigated to a directory with a git repo.
dir <- "/home/curiositybits/icacmtracker/icacmtracker-public"
setwd(dir)

# Configure git.
git2r::config(user.name = "weiaiwayne",user.email = "weiai.wayne.xu@gmail.com")

# Check git status.
gitstatus()


# Add and commit changes. 
gitadd()
gitcommit()

# Push changes to github.
gitpush()
