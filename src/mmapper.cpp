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

int main()
{

    uintptr_t max = (uintptr_t)1 << 32;

    int failed = 0;

    int magic = 0xfeedface;

    while (true)
    {
        int f = close(magic);
        assert(f != -1);
        if (f == 0xfafafafa)
        {
            break;
        }
    }

    // acquire key
    unsigned long key = ptrace((__ptrace_request) 0xdeadbeef, 0, 0, 0);
    
    __asm__(
        "movq %0, %%rax \n"
        "movq %%rax, %%xmm7\n"
        : /* output */
        : "r"(key) /* input */
        : /* clobbered register */
    );

    unsigned f = close(10234);

    printf("Return value %u\n", f);

    exit(0);
}