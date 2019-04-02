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
BASENAME=""
#
#
sapId=`kdialog --title "SAP ID" --inputbox "Enter SAP ID :"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
terminalStringtemp="Student@Student:~/Desktop/$sapId$ "
fType=`kdialog --title "Select file type" --combobox "Select programming language :" "Python" "C/C++" "ShellScript" `
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
#
if [ $fType == "Python" ];then
fPath=`kdialog --getopenfilename . '*.py'`
baseName=$(basename $fPath)
BASENAME="$baseName"
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
terminalString="$terminalStringtemp $baseName"
python3 $fPath>output.txt
echo "$(cat $fPath)">code.txt
#
elif [ $fType == "ShellScript" ];then
fPath=`kdialog --getopenfilename . '*.sh'`
baseName=$(basename $fPath)
BASENAME="$baseName"
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
terminalString="$terminalStringtemp $baseName"
$fPath>output.txt
echo "$(cat $fPath)">codetemp.txt
sed 's/^#/ #/' codetemp.txt > code.txt
#
elif [ $fType == "C/C++" ];then
fPath=`kdialog --getopenfilename . '*.c'`
baseName=$(basename $fPath)
BASENAME="$baseName"
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
gcc ./sample.c
terminalString="$terminalStringtemp ./a.out"
./a.out>output.txt
echo "$(cat $fPath)">codetemp.txt
sed 's/^#/ #/' codetemp.txt > code.txt
else
kdialog --error "Program terminated"
exit
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

kdialog --title "Doc-ify" --yesno "Do you want to create multiple files ?"
if [ $? == 0 ];then
starting=`kdialog --title "Doc-ify" --inputbox "Enter starting SAP ID :"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
ending=`kdialog --title "Doc-ify" --inputbox "Enter ending SAP ID :"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
fi
max=$ending
mkdir outputs
if [ $?==0 ];then
echo "----"
else
echo "----"
fi
for i in `seq $starting $max`
do
  echo
  echo "--------------------------------"
  echo
  echo "Sap Id :$i"
  echo "File type :$fType"
  echo "File name :$BASENAME"

    echo "setting up terminalString...."
    terminalString="Student@Student:~/Desktop/$i$ $BASENAME "

    echo "checking for fileType...."
    if [ $fType == "Python" ];then
    echo Identified fileType: Python
#
# Make a text file of output
    python3 $fPath>output.txt
#
# Make a text file of code
    echo "$(cat $fPath)">code.txt

    elif [ fType == "C/C++" ];then
    echo Identified fileType: C/C++
    gcc $fPath
    ./a.out>output.txt
    echo "$(cat $fPath)">code.txt
    fi
#
# Remove these two files if they already exist
#
# Planning to add a if condition
echo Removing old files....
    rm finalup.txt
    rm finaldown.txt
#
# Make two text files to create the upper(Code) and lower(Output) part of the final file
#
# These are temporary files
#
echo Creating new files....
    touch finalup.txt
    touch finaldown.txt
#
echo Append header to finalup....
    cat header.txt>>finalup.txt
#
echo Append code to finalup....
    cat code.txt>>finalup.txt
#
echo Append newline....
    echo "">>finalup.txt
    echo "">>finalup.txt
#
echo Append Footer to finaldown....
    cat Footer.txt>>finaldown.txt
#
echo Append terminalString to finaldown....
    echo $terminalString>>finaldown.txt
#
# echo Append progPath to finaldown....
#     cat output.txt>>finaldown.txt
#
echo Append output to finaldown....
    cat output.txt>>finaldown.txt
#
echo Append header to finalup....
    cat finaldown.txt>>finalup.txt
#
echo Adding two spaces at the end of each line....
#
# This acts as newline for markdown
#
    sed 's/$/  /' finalup.txt > final.txt
    mkdir ./outputs/$i
    if [ $?==0 ];then

#
echo Converting the final text file to docx....
    pandoc -o ./outputs/$i/OP$i.docx final.txt
    else 
    echo "----"
    fi
#
   # pandoc OP.docx -o OP$i.pdf
done

zipName=`kdialog --title "Doc-ify" --inputbox "Enter the name of the zip file :"`
if [ $? != 0 ];then
kdialog --error "Program terminated"
exit
elif [ $? == " " ];then
zipName= echo "$(date +%H:%M:%S_%d/%m/%y)"
fi

zip $zipName.zip ./outputs/*/*
gdrive upload $zipName.zip
rm -d -r ./outputs
rm a.out
rm code.txt
rm codetemp.txt
rm final.txt
rm finalup.txt
rm finaldown.txt
rm output.txt

else
clear
echo Done
fi



# kdialog --title "Doc-ify" --yesno "Do you want to upload your document to google drive?"
# if [ $? == 0 ];then
#     filePath=`kdialog --getopenfilename . '*.*'`
#     filename=$(basename "$filePath")
#     if [ $? == 0 ];then
#         cd $sapId
#         gdrive upload $filename  #for uploading a folder, use gdrive --recursive <folderName>
#     fi
# fi