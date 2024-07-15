//program instructions: find and replace text in a string
#include <stdio.h>
#include <stdbool.h>

char text[] = "apples\noranges\npears\ntomatoes";
char searchTerm[] = "pears";
char replaceTerm[] = "pineapple";

int textLength = sizeof(text) / sizeof(text[0]);
int searchTermLength = sizeof(searchTerm) / sizeof(searchTerm[0]);
int replaceTermLength = sizeof(replaceTerm) / sizeof(replaceTerm[0]);

int find(char *text, char *search) {
  int offset, i;

  for (i=0;i<textLength;i++) {
    if (text[i] == search[0]) {
      offset = i; 
      while (text[i] == search[i - offset] && text[i] != '\0') {
        i++;
      }
      if (i - offset == searchTermLength - 1)
        return offset;
    }
  }
  return -1;
}

void replace(char *text, char *search, char *replace) {
  int offset = find(text, search);
  int i, j, k;
  
  for (i=0; i<offset; i++) {
    if (text[i] != '\0')
      printf("%c", text[i]);    
  }
  for (j=0; j < replaceTermLength; j++) {
    if (replace[j] != '\0')
      printf("%c", replace[j]);
  }
  for (k = offset + searchTermLength - 1; k < textLength; k++) {
    if(text[k] != '\0')
      printf("%c", text[k]);
  }
  printf("\n");
}

int main(void) {
  replace(text, searchTerm, replaceTerm);
}
