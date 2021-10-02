#include "dan-malloc.c"
#include <stdio.h>

int main()
{
    int* ptr = malloc(1*sizeof(int));
    *ptr = 0xbeefc0de;
    printf("%x\n", *ptr);
    free(ptr);
    return 0;
}