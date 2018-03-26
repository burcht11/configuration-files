# read bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

#. $(brew --prefix root6)/libexec/thisroot.sh
. /usr/local/bin/thisroot.sh

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#PATH='/usr/local/bin/python2.7:${PATH}'
export PATH

#export ROOTSYS='/usr/local/Cellar/root/6.08.02'
export ROOTSYS='/usr/local/Cellar/root/6.10.04/'
#/Users/tburch/root'
export PYTHONDIR='/usr/local/bin/'
#
#export PATH=$ROOTSYS/bin:$PATH
export LD_LIBRARY_PATH=$ROOTSYS/lib:$PYTHONDIR/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$ROOTSYS/lib/root:$PYTHONPATH


export PATH=/usr/local/bin:$PATH
export PATH=${HOME}/.local/bin${PATH:+:$PATH}
export PATH="/usr/local/bin/python2.7:${PATH}"


# Iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


export MYSQL_PATH=/usr/local/Cellar/mysql/5.7.18_1/
export PATH=$PATH:$MYSQL_PATH/bin

# Terminal Configuration
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad
export PS1=' \W -> '
alias python='python2.7'

# Additional python modules to pythonpath
export PYTHONPATH=/usr/local/Cellar/root/6.10.08/lib/root/:$PYTHONPATH;
export PYTHONPATH=/Users/tburch/Documents/customPythonModules/:$PYTHONPATH

# Add command for png converting
alias png2pdf="sips -s format pdf" # file.png --out file.pdf

# Lazy SSH aliases
alias t3i='ssh -Y tburch@t3int0.nicadd.niu.edu'
alias t3='ssh tburch@t3int0.nicadd.niu.edu'
alias lx='ssh tburch@lxplus.cern.ch'
alias lxi='ssh -Y tburch@lxplus.cern.ch'
alias lxVNC='ssh -Y tburch@lxplus078.cern.ch'
alias ll='ls -lG'
alias cern='cd /mnt/afs/afs/cern.ch/user/t/tburch'
alias testbed='ssh -Y tburch@pc-tbed-pub.cern.ch'

# Command for quick mounting AFS
alias mount_afs='sudo sshfs -o allow_other,defer_permissions tburch@lxplus.cern.ch:/ /mnt/afs'
alias unmount_afs='sudo umount /mnt/afs'

# set default editor
export VISUAL=emacs
export EDITOR="$VISUAL"
