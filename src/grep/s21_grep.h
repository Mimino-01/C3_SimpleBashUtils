#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  char* temp;
  int len_temp;
  int m_temp;

} Flags;

int parser_cmd(int argc, char* argv[], Flags** fl);

int create_reg(int argc, char* argv[], Flags fl);

int processing_files(char* argv, Flags fl, regex_t* regex);

void output_line(char* line, int n);
void find_match(char* line, regex_t* regex, int count_line, char* path,
                Flags fl);
void create_temp(Flags* fl, char* temp);
void create_temp_file(Flags* fl, char* tempfile);
void fl_analysis(int count_line, char* path, Flags fl);

#endif