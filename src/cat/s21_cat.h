#ifndef S21_CAT_H
#define S21_CAT_H

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
} Flags;

int parser_cmd(int argc, char *argv[], Flags *fl);
int print_field(char *argv[], Flags *fl);

#endif