#include "s21_cat.h"

int main(int argc, char *argv[]) {
  Flags fl = {0};
  if (parser_cmd(argc, argv, &fl)) {
    printf("Unknown option\n");
    return 1;
  }

  while (optind < argc) {
    print_field(argv, &fl);
    optind++;
  }

  return 0;
}

int parser_cmd(int argc, char *argv[], Flags *fl) {
  int f = 0;
  int rez;
  int option_index;

  struct option log_options[] = {{"number-nonblank", no_argument, NULL, 'b'},
                                 {"number", no_argument, NULL, 'n'},
                                 {"squeeze-blank", no_argument, NULL, 's'},
                                 {0, 0, 0, 0}};
  while ((rez = getopt_long(argc, argv, "+beEvnstT", log_options,
                            &option_index)) != -1) {
    switch (rez) {
      case 'b':
        fl->b = 1;
        break;

      case 'e':
        fl->e = 1;
        fl->v = 1;
        break;

      case 'E':
        fl->e = 1;
        break;

      case 'n':
        fl->n = 1;
        break;

      case 's':
        fl->s = 1;
        break;

      case 't':
        fl->t = 1;
        fl->v = 1;
        break;

      case 'T':
        fl->t = 1;
        break;

      case 'v':
        fl->v = 1;
        break;

      case '?':
        f = 1;
        break;
    }
  }
  if (fl->b) {
    fl->n = 0;
  }
  return f;
}

int print_field(char *argv[], Flags *fl) {
  FILE *file_point;
  int f = 0;
  int c;
  int past_c = '\n';

  file_point = fopen(argv[optind], "r");

  if (file_point == NULL) {
    fprintf(stderr, "cat: %s No such file in directory ", argv[optind]);
    exit(1);
  }
  int count_str = 1;
  int count_str_s = 0;

  while ((c = fgetc(file_point)) != EOF) {
    if (fl->s == 1 && past_c == '\n' && c == '\n') {
      count_str_s++;
      if (count_str_s > 1) {
        continue;
      }
    } else {
      count_str_s = 0;
    }

    if (fl->n && past_c == '\n') {
      printf("%6d\t", count_str++);
    }

    if (fl->b && past_c == '\n' && c != '\n') {
      printf("%6d\t", count_str++);
    }

    if (fl->t && c == '\t') {
      printf("^");
      c = 'I';
    }

    if (fl->e && c == '\n') {
      if (fl->b && c == '\n' && past_c == '\n') {
        printf("      \t");
      }
      printf("$");
    }

    if (fl->v) {
      if (c > 127 && c < 160) printf("M-^");
      if ((c < 32 && c != '\n' && c != '\t') || c == 127) printf("^");
      if ((c < 32 || (c > 126 && c < 160)) && c != '\n' && c != '\t')
        c = c > 126 ? c - 64 : c + 64;
    }

    printf("%c", c);
    past_c = c;
  }

  fclose(file_point);

  return f;
}
