#include "my-malloc.c"
#include <stdio.h>

int main()
{
    char* string = malloc(6*sizeof(char));
    if(!string) return 0x1;
    string = "abcd\n";
    printf(string);
    free(string);
    return 0;
}