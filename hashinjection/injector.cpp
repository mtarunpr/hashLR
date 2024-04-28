#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ptrace.h>
#include <unistd.h>
#include <assert.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/reg.h>
#include <sys/user.h>
#include <stdint.h>
#include <sys/syscall.h>
#include <iostream>
#include <errno.h>
#include <string.h>

#define PAGESIZE 4096

int main() { 

    pid_t pid = fork();

    if(pid == 0)  {
        int r = ptrace(PTRACE_TRACEME, 0, 0, 0);
        assert(r >= 0);

        execlp("./mmapper", "./mmapper", nullptr);
        
        assert(false);
    }

    sleep(1);

    printf("Let's start!\n");

    int r = -1;

    struct user_regs_struct regs;
    int thing = 0;

    uintptr_t addr1 = -1;
    uintptr_t addr2 = -1;

    __asm__
    (
    "movq $0x237, %%rax \n"
    "movq %%rax, %%xmm0\n"
    "movq $0, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm0, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %0\n"
    "movq $1, %%rax\n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm0, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %1\n"
    : "=r"(addr1), "=r"(addr2) /* output */
    :      /* input */
    : "%rax", "%xmm0"        /* clobbered register */
    );

    int index = 0;
    uintptr_t addrs[4] = { addr1 - addr1 % 4096, addr1 + 4096 - addr1 % 4096, addr2 - addr2 % 4096, addr2 + 4096 - addr2 % 4096 };

    // Wait until exit
    while(true)  {

        r = ptrace(PTRACE_GETREGS, pid, 0, &regs);

        if(regs.rdi == 10234)  {
            break;
        } else if(regs.rdi == 0xfeedface)  {
            regs.orig_rax = SYS_mmap;
            regs.rdi = addrs[index];
            //printf("%p\n", (void*) regs.rdi);
            ++index;

            regs.rsi = 4096;
            regs.rdx = PROT_EXEC | PROT_READ | PROT_WRITE;
            regs.r10 = MAP_ANON|MAP_SHARED|MAP_FIXED;
            regs.r8 = -1;
            regs.r9 = 0;

            printf("inside loop, rip is %p\n", (void*) regs.rip);

            r = ptrace(PTRACE_SETREGS, pid, 0, &regs);
            assert(r >= 0);
        }

        r = ptrace(PTRACE_SYSCALL, pid, 0, 0);
        assert(r >= 0);

        wait(0);
    }

    r = ptrace(PTRACE_GETREGS, pid, 0, &regs);
    //uintptr_t stack = regs.rsi;
    //printf("Stack at %p\n", (void*) stack);

    //long thingy = ptrace(PTRACE_PEEKDATA, pid, 0x11000, 0);
    //printf("%p\n", (void*) thingy);

    printf("%p\n", (void*) addr1);
    printf("%p\n", (void*) addr2);

    /*
    
    0000000000001129 <_Z4funci>:
    1129:	f3 0f 1e fa          	endbr64 
    112d:	55                   	push   %rbp
    112e:	48 89 e5             	mov    %rsp,%rbp
    1131:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1134:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1137:	83 c0 01             	add    $0x1,%eax
    113a:	5d                   	pop    %rbp
    113b:	c3                   	ret    

    000000000000113c <main>:
    113c:	f3 0f 1e fa          	endbr64 
    1140:	55                   	push   %rbp
    1141:	48 89 e5  *            	mov    %rsp,%rbp
    1144:	48 83 ec 10          	sub    $0x10,%rsp
    1148:	c7 45 f4 00 * 00 00 00 	movl   $0x0,-0xc(%rbp)
    114f:	c7 45 f8 00 00 * 00 00 	movl   $0x0,-0x8(%rbp)
    1156:	48 c7 c0 37 02 00 * 00 	mov    $0x237,%rax
    115d:	66 48 0f 6e c0       	movq   %rax,%xmm0
    1162:	eb 27 *               	jmp    118b <main+0x4f>
    1164:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1167:	89 c7                	mov    %eax,%edi
    1169:	48 c7 c0 * 01 00 00 00 	mov    $0x1,%rax
    1170:	66 48 0f 6e * c8       	movq   %rax,%xmm1
    1175:	66 0f 38 dc c8       	aesenc %xmm0,%xmm1
    117a:	66 0f * 7e c8          	movd   %xmm1,%eax
    117e:	ff d0                	call   *%rax
    1180:	89 45 fc             	mov    %eax,-0x4(%rbp)
    1183:	83 * 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1187:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    118b:	81 * 7d f8 ff e0 f5 05 	cmpl   $0x5f5e0ff,-0x8(%rbp)
    1192:	7e d0 *               	jle    1164 <main+0x28>
    1194:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1197:	c9                   	leave  
    1198:	c3                   	ret   
  
    */

    // Change 90 to 55
    r = ptrace(PTRACE_POKEDATA, pid, addr1, 0xe5894855fa1e0ff3); // endbr64, push, mov
    assert(r >= 0);
    //printf("%p\n", (void*) ptrace(PTRACE_PEEKDATA, pid, addr1, 0));
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 8, 0x00f445c710ec8348); // sub movl*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 16, 0x0000f845c7000000); // *movl movl*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 24, 0x000237c0c7480000); // *movl mov*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 32, 0x27ebc06e0f486600); // *mov movq jmp*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 40, 0xc0c748c789f8458b); // mov mov mov*
    assert(r >= 0); // Here
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 48, 0x6e0f486600000001); // *mov movq*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 56, 0x0f66c8dc380f66c8); // *movq aesenc movd*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 64, 0x83fc4589d0ffc87e); // *movd call mov addl*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 72, 0x8101f8458301f445); // *addl addl cmpl*
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 80, 0xd07e05f5e0fff87d); // *cmpl jle
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 88, 0xc3c9f4458b); // mov leave ret
    assert(r >= 0);

   //int hi[] = { 0x48, 0xc7, 0xc0, 0x58, 0x04, 0x92, 0x43, 0x66, 0x48, 0x0f, 0x6e, 0xc8, 0x66, 0x0f, 0x38, 0xdc, 0xc8, 0x66, 0x0f, 0x7e, 0xc8, 0xff, 0x20};

    /*// Change 90 to 55
    r = ptrace(PTRACE_POKEDATA, pid, addr1, 0xe5894855fa1e0ff3);
    assert(r >= 0);
    //printf("%p\n", (void*) ptrace(PTRACE_PEEKDATA, pid, addr1, 0));
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 8, 0x00f445c710ec8348);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 16, 0x0000f845c7000000);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 24, 0x89f8458b29eb0000);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 32, 0x00000001c0c748c7);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 40, 0x380f66c86e0f4866);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 48, 0xd0ffc87e0f66c8dc);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 56, 0x4501fc458bfc4589);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 64, 0xf87d8101f84583f4);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 72, 0x458bce7e05f5e0ff);
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 80, 0xc3c9f4);
    assert(r >= 0);*/


    /*
    0000000000001129 <_Z4funci>:
    1129:	f3 0f 1e fa          	endbr64 
    112d:	55                   	push   %rbp
    112e:	48 89 e5             	mov    %rsp,%rbp
    1131:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1134:	90                   	nop
    1135:	5d                   	pop    %rbp
    1136:	c3                   	ret     
    */
    //addr2 = 0x427c7cb0;
    r = ptrace(PTRACE_POKEDATA, pid, addr2, 0xe5894855fa1e0ff3); // endbr64 push mov
    assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr2 + 8, 0xc35d90fc7d89); // mov nop pop ret
    assert(r >= 0);
    //r = ptrace(PTRACE_POKEDATA, pid, addr2 + 16, 0xc35d01); // *add pop ret
    //assert(r >= 0);

    //thingy = ptrace(PTRACE_PEEKDATA, pid, addr2, 0);
    //printf("%p\n", (void*) thingy);

    printf("rip before injection %p\n", (void*) regs.rip);

    regs.rip = addr1;
    //regs.rsp -= 8;
    //regs.rsp = stack;
    //regs.rbp = stack;

    printf("%p\n", (void*) regs.rsp);

    r = ptrace(PTRACE_SETREGS, pid, 0, &regs);
    assert(r >= 0);

    //r = ptrace(PTRACE_POKEDATA, pid, regs.rsp, 0x00005555555552c2);
    //assert(r >= 0);

    //exit(0);

    r = ptrace(PTRACE_CONT, pid, 0, 0);
    int status = -5;

    printf("pid is %i\n", pid);

    //r = ptrace(PTRACE_DETACH, pid, 0, 0);
    //assert(r >= 0);


    while(true)  {
        r = waitpid(pid, &status, 0);
        printf("Thingy %i %i\n", status, r);
        if(r == -1)  {
            printf("Oh dear, something went wrong with read()! %s\n", strerror(errno));
            exit(0);
        }

        //assert(r >= 0);

        if ( WIFEXITED(status) ) {
            int es = WEXITSTATUS(status);
            printf("Exit status was %d\n", es);
            break;
        } else if(WIFSTOPPED(status))  {
            printf("Stopped\n");
            int sig = WSTOPSIG(status);
            printf("signal %i\n", sig);

            r = ptrace(PTRACE_GETREGS, pid, 0, &regs);
            assert(r >= 0);

            uintptr_t please = ptrace(PTRACE_PEEKDATA, pid, regs.rip, 0);
            printf("peekdata is %p\n", (void*) please);
            printf("rip is %p\n", (void*) regs.rip);

            r = ptrace(PTRACE_CONT, pid, 0, sig);
        }
    }

    exit(0);
} 