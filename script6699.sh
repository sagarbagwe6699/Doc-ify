#! /bin/bash
echo
echo -------- Shell ---------
echo $SHELL
echo
echo -------- Os ---------
echo $OSTYPE
echo
echo -------- Path ---------
echo $PATH
echo
echo -------- Current working directory ---------
pwd
echo
echo -------- OS version ---------
lsb_release -r
echo
echo -------- Release number ---------
lsb_release -sr
echo
echo -------- Kernel ---------
uname -r
echo
echo -------- Sort ---------
sort ./name.txt
echo
sort ./number.txt
echo ---- Sort unique ----
sort -r -u ./name.txt
echo
sort -r -u ./number.txt
echo ---- Sort numbers ----
sort -r -u -n ./number.txt
echo
echo -------- Grep ---------
grep Lucifer ./name.txt
echo -------- Grep -i ---------
grep -i "Lucifer" ./name.txt
echo
echo -------- AWK ---------
echo
echo -------- AWK print ---------
awk '{print}' ./name.txt
echo
echo -------- AWK word ---------
awk '/Lucifer/{print}' ./name.txt
echo
echo -------- AWK first and third ---------
awk '{print $1 , $3}' ./name.txt
echo
