#include "stdio.h"

#define DLLEXPORT
extern "C" DLLEXPORT void write_integer(int X) {
  printf("%d\n", X);
}

