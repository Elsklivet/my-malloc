CC = gcc
FLAGS = -O0 -g -W -Wall -Wextra -shared

all:
	$(CC) $(FLAGS) my-malloc.c -o my-malloc.so

assembly: 
	$(CC) $(FLAGS) -S my-malloc.c -o my-malloc.s