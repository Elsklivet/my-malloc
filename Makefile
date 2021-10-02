CC = gcc
FLAGS = -O0 -g -W -Wall -Wextra -fPIC -shared

all: test-malloc.c my-malloc.c
	$(CC) $(FLAGS) my-malloc.c -o my-malloc.so
	$(CC) -O0 -g -W -Wall -Wextra test-malloc.c -o test-malloc 
assembly: 
	$(CC) $(FLAGS) -S my-malloc.c -o my-malloc.s
	$(CC) -O0 -g -W -Wall -Wextra -S test-malloc.c -o test-malloc.s
clean:
	rm *.so *.o *~ *.s