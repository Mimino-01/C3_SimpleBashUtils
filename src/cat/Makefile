all: s21_cat

s21_cat: 
	gcc -Wall -Werror -Wextra s21_cat.c -o s21_cat

rebuild:
	rm s21_cat
	make all

test:
	sh test_s21_cat.sh

clean:
	rm -rf *.o ./s21_cat