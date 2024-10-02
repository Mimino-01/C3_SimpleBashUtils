all: s21_grep

s21_grep: 
	gcc -Wall -Werror -Wextra s21_grep.c -o s21_grep

rebuild:
	rm s21_grep
	make all

test:
	sh test_s21_grep.sh

clean:
	rm -rf *.o ./s21_grep