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

    for(int i = 0; i < 12; i++)  {
        int f = close(magic);
        assert(f > 0);
    }

    int (*funcPtr)() = &main;

    uintptr_t f = close(10234);

    //assert(false);

    printf("Return value %p\n", (void*) f);

    exit(0);
} 