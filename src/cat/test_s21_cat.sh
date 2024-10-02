#!/bin/bash

SUCCESS=0
FAIL=0
DIFF_RES=""
FLAGS="b e n s t v"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
BASE="$(tput setaf 7)"
declare -a tests=(
    "VAR test_case_cat.txt"
)
declare -a extra=(
    "-s test_case_cat.txt"
    "-b test_case_cat.txt"
    "-t test_case_cat.txt"
    "-n test_case_cat.txt"
    "no_file.txt"
    "-n -b test_case_cat.txt"
    "-s -n -e test_case_cat.txt"
    "-n ttest_case_cat.txt"
    "-n -e test_case_cat.txt"
    "-n test_case_cat.txt s21_cat.h"
    "-v test_case_cat.txt"
)
testing() {
    t=$(echo $@ | sed "s/VAR/$var/")
    ./s21_cat $t > test_s21_cat.log
    cat $t > test_sys_cat.log
    DIFF_RES="$(diff -s test_s21_cat.log test_sys_cat.log)"
    RESULT="SUCCESS"
    if [ "$DIFF_RES" == "Files test_s21_cat.log and test_sys_cat.log are identical" ]
    then
      (( SUCCESS++ ))
        RESULT="SUCCESS"
    else
      (( FAIL++ ))
        RESULT="FAIL"
    fi
    echo "[${GREEN}${SUCCESS}${BASE}/${RED}${FAIL}${BASE}] ${GREEN}${RESULT}${BASE} cat $t"
    rm test_s21_cat.log test_sys_cat.log
}

# специфические тесты
for i in "${extra[@]}"
do
    testing $i
done

echo "${RED}FAIL: ${FAIL}${BASE}"
echo "${GREEN}SUCCESS: ${SUCCESS}${BASE}"