#!/bin/bash
#
tput bold echo
echo "Checking for dependencies...."
if which gcc;then
if which kdialog;then
if which pandoc;then
if which gdrive;then
tput setaf 2;echo "All dependencies installed"
else
tput setaf 1;echo "Could not find package : gdrive"
echo 
tput setaf 2;echo "Follow these instructions: https://github.com/gdrive-org/gdrive"
exit
fi
else
tput setaf 1;echo "Could not find package : pandoc"
echo 
tput setaf 2;echo "Try: sudo apt-get install pandoc"
exit
fi
else
tput setaf 1;echo "Could not find package : kdialog"
echo 
tput setaf 2;echo "Try: sudo apt-get install kde-baseapps-bin"
exit
fi
else
tput setaf 1;echo "Could not find package : gcc"
echo 
tput setaf 2;echo "Try: sudo apt-get install gcc"
exit
fi
#
#
#
#
kdialog --title "Doc-ify" --yesno "Do you want to create multiple files ?"
if [ $? == 0 ];then
echo YES
else
./gui.sh
fi
