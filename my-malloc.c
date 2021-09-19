#include <assert.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

/* initial stuff, not actually started yet */
void *malloc(size_t size) {
  void *p = sbrk(0);
  void *request = sbrk(size);
  if (request == (void*) -1) {
    return NULL; // sbrk failed.
  } else {
    assert(p == request); // Not thread safe.
    return p;
  }
}