CC = gcc
FLAGS = -O0 -g -W -Wall -Wextra -fPIC -shared

all:
	$(CC) $(FLAGS) my-malloc.c -o my-malloc.so
	$(CC) $(FLAGS) dan-malloc.c -o dan-malloc.so
	$(CC) -O0 -g -W -Wall -Wextra test-malloc.c -o test-malloc 
assembly:
	$(CC) $(FLAGS) -S my-malloc.c -o my-malloc.s
	$(CC) $(FLAGS) -S dan-malloc.c -o dan-malloc.s
	$(CC) -O0 -g -W -Wall -Wextra -S test-malloc.c -o test-malloc.s
my: 
	$(CC) $(FLAGS) my-malloc.c -o my-malloc.so
	$(CC) -O0 -g -W -Wall -Wextra -S test-malloc.c -o test-malloc.s
dan: 
	$(CC) $(FLAGS) -S dan-malloc.c -o dan-malloc.s
	$(CC) -O0 -g -W -Wall -Wextra -S test-malloc.c -o test-malloc.s
clean:
	rm *.so *.o *~ *.s test-malloc