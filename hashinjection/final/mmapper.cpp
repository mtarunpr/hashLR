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

    __asm__
    (
    "movq $0x237, %%rax \n"
    "movq %%rax, %%xmm7\n"
    :  /* output */
    : /* input */
    : /* clobbered register */
    );

    uintptr_t max = (uintptr_t) 1 << 32;

    int failed = 0;

    int magic = 0xfeedface;

    while(true)  {
        int f = close(magic);
        assert(f != -1);
        if(f == 0xfafafafa)  {
            break;
        }
    }

    uintptr_t f = close(10234);

    printf("Return value %p\n", (void*) f);

    exit(0);
} 