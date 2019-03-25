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
max=82
for i in `seq 81 $max`
do
    echo "$i"

    terminalString="Student@Student:~/Desktop/600041700$i$ "
#
# Make a text file of output
    python3 ./preet.py>output.txt
#
# Make a text file of code
    echo "$(cat ./sample.py)">code.txt
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
    echo $terminalString>>finaldown.txt
#
# Append progPath to finaldown
    cat progPath.txt>>finaldown.txt
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
    echo
    echo "----------------------------------------"
    echo "File successfully created ----> OP.docx"
    echo "----------------------------------------"
    echo
    pandoc OP.docx -o OP$i.pdf
    echo
    echo "----------------------------------------"
    echo "File successfully created ----> OP$i.pdf"
    echo "----------------------------------------"
    echo
done
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