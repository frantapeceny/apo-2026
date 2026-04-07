#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#define SIZE 8388608

long int pole[SIZE];

int main() {
  for (int i=0; i<SIZE; i++) {
    pole[i] = (rand()%10000) - 5000;  
  }
  long int max=pole[0];
  long int min=pole[0];
  for (int j=0; j<3; j++) {
    for (int i=j; i<SIZE; i+=3) {
      if (max<pole[i]) {
          max = pole[i];
      }
    }
  }
  for (int j=0; j<3; j++) {
    for (int i=j; i<SIZE; i+=3) {
      if (min>pole[i]) {
          min = pole[i];
      }
    }
  }
  printf("Min %li max %li\n", min, max);
  return 0;
}
