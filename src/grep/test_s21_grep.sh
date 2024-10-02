#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF_RES=""
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
BASE="$(tput setaf 7)"

declare -a extra=(
    "-n for test_1_grep.txt test_2_grep.txt"
    "-n for test_1_grep.txt"
    "-n -e ^\} test_1_grep.txt"
    "-ce ^int test_1_grep.txt test_2_grep.txt"
    "-ne = -e out test_5_grep.txt"
    "-e ^int test_1_grep.txt"
    "-nivh = test_1_grep.txt test_2_grep.txt"
    "-o int test_1_grep.txt test_2_grep.txt"
    "-ie INT test_5_grep.txt"
    "-echar test_1_grep.txt test_2_grep.txt"
    "-ne = -e out test_5_grep.txt"
    "-iv int test_5_grep.txt"
    "-in int test_5_grep.txt"
    "-c -l aboba test_1_grep.txt test_5_grep.txt"
    "-v test_1_grep.txt -e ank"
    "-in -l int test_5_grep.txt"
    "-noe ) test_5_grep.txt"
    "-l for test_1_grep.txt test_2_grep.txt"
    "-o -e int test_4_grep.txt"
    "-v test_1_grep.txt -e ank"
    "-e = -e out test_5_grep.txt"
    "-noe ing -e as -e the -e not -e is test_6_grep.txt"
    "-e ing -e as -e the -e not -e is test_6_grep.txt"
    "-l for no_file.txt test_2_grep.txt"
    "-f test_3_grep.txt test_5_grep.txt"
)


testing()
{
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_grep $t > test_s21_grep.log
    grep $t > test_sys_grep.log
    DIFF_RES="$(diff -s test_s21_grep.log test_sys_grep.log)"
    RESULT="SUCCESS"
    (( COUNTER++ ))
    if [ "$DIFF_RES" == "Files test_s21_grep.log and test_sys_grep.log are identical" ]
    then
      (( SUCCESS++ ))
        RESULT="SUCCESS"
    else
      (( FAIL++ ))
        RESULT="FAIL"
    fi
    echo "[${GREEN}${SUCCESS}${BASE}/${RED}${FAIL}${BASE}] ${GREEN}${RESULT}${BASE} grep $t"
    rm test_s21_grep.log test_sys_grep.log
}

# специфические тесты
for i in "${extra[@]}"
do
    var="-"
    testing $i
done


echo "${RED}FAIL: ${FAIL}${BASE}"
echo "${GREEN}SUCCESS: ${SUCCESS}${BASE}"
echo "ALL: $COUNTER"
