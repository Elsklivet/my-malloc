#include <unistd.h>
#include <string.h>
#include <pthread.h>
#include <stdio.h>

/* sixteen bit alignment for header union */
typedef char ALIGN[16];

/* size of a union is the size of its larger member */
union header {
  struct header_t {
    /* how big is this block */
    size_t size;
    /* is this block free? */
    unsigned is_free;
    /* next node in contiguous chain of blocks */
    struct header_t* next;
  } s;
  ALIGN stub;
};
typedef union header header_t;

header_t *head, *tail;

pthread_mutex_t global_malloc_lock;

#if 0
/* A basic, primitive, malloc. */
void *malloc(size_t size)
{
  /* block pointer */
	void *block;
  /* call sbrk, which changes the program break
     to allocate onto the heap  with byte size "size" */
	block = sbrk(size);
  /* if the allocation was unsuccessful return null */
	if (block == (void*) -1)
		return NULL;
  /* return the block pointer on success */
	return block;
}
#endif

header_t *get_free_block(size_t size){
  header_t *curr = head;
  while(curr){
    /* if current block is free and fits, return it, else keep going */
    if(curr->s.is_free && curr->s.size >= size) return curr;
    curr = curr->s.next;
  }
  return NULL; /* no free blocks left */
}

void *malloc(size_t size){
  size_t total_size;
  void* block;
  header_t* header;

  /* empty block */
  if(!size) return NULL;

  /* thread locks it so we can make this thread safe */
  pthread_mutex_lock(&global_malloc_lock);
  /* get a free block */
  header = get_free_block(size);
  /* if it succeeded ...*/
  if(header){
    /* block no longer free */
    header->s.is_free = 0;
    /* unlock */
    pthread_mutex_unlock(&global_malloc_lock);
    /* return the next spot in memory after header, which is where block starts */
    return (void*) (header + 1);
  }

  /* if it did not succeed, we need to sbrk room for it */
  total_size = sizeof(header_t) + size;
  block = sbrk(total_size);
  /* if that still didn't succeed, we're out */
  if(block == (void*) -1){
    /* allow other processes to use malloc again and then fail out */
    pthread_mutex_unlock(&global_malloc_lock);
    return NULL;
  }
  /* otherwise initiate a header */
  header = block;
  header->s.size = size;
  header->s.is_free = 0;
  header->s.next = NULL;
  /* if there's not a head in memory then this is it. */
  if(!head) head = header;
  /* if there is a tail then its next is this block */
  if(tail) tail->s.next = header;
  /* tail becomes this block regardless */
  tail = header;
  /* unlock and return the location for use */
  pthread_mutex_unlock(&global_malloc_lock);
  return (void*)(header + 1);

}

void free(void *block)
{
  header_t *header, *tmp;
  void *programbreak;

  /* if the block is null anyway */
  if(!block)
    return;

  /* lock malloc */
  pthread_mutex_lock(&global_malloc_lock);
  /* get block header */
  header = (header_t*)block - 1;
  programbreak = sbrk(0);
  /* if the block is at the end of the heap, shrink the heap and
    release that space to the OS */
  if(((char*)block + header->s.size) == programbreak)
  {
    if(head == tail)
    {
      head = tail = NULL;
    }
    else
    {
      tmp = head;
      while(tmp)
      {
        if(tmp->s.next == tail)
        {
          tmp->s.next = NULL;
          tail = tmp;
        }
        tmp = tmp->s.next;
      }
    }
    /* negative value frees heap */
    sbrk(0 - sizeof(header_t) - header->s.size);
    pthread_mutex_unlock(&global_malloc_lock);
    return;
  }
  /* otherwise flip free flag */
  header->s.is_free = 1; /* <!> segfaults <!> */
  pthread_mutex_unlock(&global_malloc_lock);
}

void *calloc(size_t num, size_t nsize)
{
  size_t size;
  void *block;
  if(!num || !nsize) return NULL;
  size = num * nsize;
  /* check for a multiplicative overflow */
  if(nsize != size / num) return NULL;
  block = malloc(size);
  if(!block) return NULL;
  memset(block, 0, size);
  return block;
}

void *realloc(void *block, size_t size)
{
  header_t *header;
  void *return_block;
  if(!block || !size) return malloc(size);
  header = (header_t*) block - 1;
  /* if the block already has enough space to fit the realloc, do nothing */
  if(header->s.size >= size) return block;
  /* otherwise malloc more room and do a memcpy to move it over */
  return_block = malloc(size);
  if(return_block)
  {
    memcpy(return_block, block, header->s.size);
    free(block);
  }
  return return_block;
}