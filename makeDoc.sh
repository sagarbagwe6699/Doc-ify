#!/bin/bash
#
#
# ------------------------------------------------
# ---------------- Requiremments ----------------
#
# pandoc ----> sudo apt-get install pandoc
#
# ------------------------------------------------
# ------------------------------------------------
#
#
# Read me
# ------------------------
#
# These files should be present for the script to work
#
# Go through these files before reading the script:
# -header.txt
# -Footer.txt
# -pagePath.txt
#
# header and Footer have the markdown
# header and Footer will will not change
# pagePath will store the path of the file
#
#
#
# ------------------------
#
echo  "Select file type :"
echo
echo "1 ---- Python" 
echo "2 ---- C"
read fType
echo Enter SAP ID :
read sapId
terminalStringtemp="Student@Student:~/Desktop/$sapId$ "
#
if [ $fType == 1 ];then
# Make a text file of output
terminalString="$terminalStringtemp ./sample.py"
python3 ./sample.py>output.txt
#
# Make a text file of code
echo "$(cat ./sample.py)">code.txt
elif [ $fType == 2 ];then
gcc ./sample.c
terminalString="$terminalStringtemp ./a.out"
./a.out>output.txt
echo "$(cat ./sample.c)">codetemp.txt
sed 's/^#/ #/' codetemp.txt > code.txt
fi
#
# Remove these two files if they already exist
#
# Planning to add a if condition
rm finalup.txt
rm finaldown.txt
#
# Make two text files to create the upper(Code) and lower(Output) part of the final file
#
# These are temporary files
#
touch finalup.txt
touch finaldown.txt
#
# Append header to finalup
cat header.txt>>finalup.txt
#
# Append code to finalup
cat code.txt>>finalup.txt
#
# Append newline
echo "">>finalup.txt
echo "">>finalup.txt
#
# Append Footer to finaldown
cat Footer.txt>>finaldown.txt
#
# Append terminalString to finaldown
echo "$terminalString">>finaldown.txt
#
# Append progPath to finaldown
# cat progPath.txt>>finaldown.txt
#
# Append output to finaldown
cat output.txt>>finaldown.txt
#
# Append header to finalup
cat finaldown.txt>>finalup.txt
#
# Adding two spaces at the end of each line
#
# This acts as newline for markdown
#
sed 's/$/  /' finalup.txt > final.txt
#
# Converting the final text file to docx
pandoc -o OP.docx final.txt
#
tput bold echo
tput setaf 2; echo "----------------------------------------"
tput setaf 2; echo "File successfully created ----> OP.docx"
tput setaf 2; echo "----------------------------------------"
echo
# kdialog --title "File created successfully" --passivepopup \
# "Output saved in OP.docx" 10
#
#
#
#
#
#
# -------- Ignore --------
#
# templateText=`antiword -f ./template.doc`
# antiword -f ./template.doc>intermediate.txt
# echo $templateText
# cat output.txt>>code.txt
# cat ./intermediate.txt | sed -r "s/<CODEHERE>/"${code}"/" > temp1.txt
# cat ./intermediate.txt | sed -r "s@$name@myCode@g" > temp1.txt
# cat ./intermediate.txt | sed -r "s@<OUTPUTHERE>@$output@g" > temp2.txt