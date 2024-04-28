#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <cassert>
#include <stdlib.h>
#include <sys/wait.h>
#include <stdint.h>
#include <sys/user.h>

int main() { 

    uintptr_t max = (uintptr_t) 1 << 32;

    int failed = 0;

    int magic = 0xfeedface;

    for(int i = 0; i < 2; i++)  {
        long hi = close(magic);
        assert(hi > 0);
        hi = close(magic);
        assert(hi > 0);
    }

    //void* stack_ptr = (void*) ((char*) malloc(65536) + 32768);
    //printf("Real stack at %p\n", stack_ptr);

    int (*funcPtr)() = &main;
    printf("main is at %p\n", (void*) funcPtr);

    //uintptr_t f = write(10234, (const void*) stack_ptr, 1);
    //uintptr_t f = open((const char*) stack_ptr, 10234);
    uintptr_t f = close(10234);

    //assert(false);

    printf("Return value %p\n", (void*) f);

    exit(0);
} 