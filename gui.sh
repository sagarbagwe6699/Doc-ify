#!/bin/bash
# $ pass=`kdialog --password "Enter password"`
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
sapId=`kdialog --title "SAP ID" --inputbox "Enter SAP ID :"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
terminalStringtemp="Student@Student:~/Desktop/$sapId$ "
fType=`kdialog --title "Select file type" --combobox "Select programming language :" "Python" "C/C++"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
#
if [ $fType == "Python" ];then
fPath=`kdialog --getopenfilename . '*.py'`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
terminalString="$terminalStringtemp ./sample.py"
python3 ./sample.py>output.txt
echo "$(cat $fPath)">code.txt
#
elif [ $fType == "C/C++" ];then
fPath=`kdialog --getopenfilename . '*.c'`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
gcc ./sample.c
terminalString="$terminalStringtemp ./a.out"
./a.out>output.txt
echo "$(cat $fPath)">codetemp.txt
sed 's/^#/ #/' codetemp.txt > code.txt
fi
#
#
if test -e finalup.txt;then
rm finalup.txt
rm finaldown.txt
else
echo
fi
#
touch finalup.txt
touch finaldown.txt
#
cat header.txt>>finalup.txt
#
cat code.txt>>finalup.txt
#
echo "">>finalup.txt
echo "">>finalup.txt
#
cat Footer.txt>>finaldown.txt
#
echo "$terminalString">>finaldown.txt
#
cat output.txt>>finaldown.txt
#
cat finaldown.txt>>finalup.txt
#
sed 's/$/  /' finalup.txt > final.txt
#
mkdir $sapId
pandoc -o ./$sapId/$sapId.docx final.txt
if [ $? == 0 ];then
kdialog --title "Operation Successfull" --msgbox "Word Document created successfully"
else
kdialog --title "Operation Unsuccessfull" --error "Word Document could not be created"
fi

kdialog --title "Doc-ify" --yesno "Do you want to upload your document to google drive?"
if [ $? == 0 ];then
    filePath=`kdialog --getopenfilename . '*.*'`
    filename=$(basename "$filePath")
    if [ $? == 0 ];then
        cd $sapId
        gdrive upload $filename  #for uploading a folder, use gdrive --recursive <folderName>
    fi
fi

