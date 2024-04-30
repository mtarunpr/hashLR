#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>
#include <sys/ptrace.h>
#include <unistd.h>
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
        //assert(r >= 0);

        execlp("./mmapper", "./mmapper", nullptr);
        
        //assert(false);
    }

    sleep(1);

    int r = -1;

    struct user_regs_struct regs;
    int thing = 0;

    uintptr_t addr1 = -1;
    uintptr_t addr2 = -1;

    __asm__
    (
    "movq $0x237, %%rax \n"
    "movq %%rax, %%xmm7\n"
    "movq $0, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %0\n"
    "movq $1, %%rax\n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %1\n"
    : "=r"(addr1), "=r"(addr2) /* output */
    :      /* input */
    : "%rax", "%xmm7"        /* clobbered register */
    );

    printf("%p %p\n", (void*) addr1, (void*) addr2);

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

            r = ptrace(PTRACE_SETREGS, pid, 0, &regs);
            //assert(r >= 0);
        }

        r = ptrace(PTRACE_SYSCALL, pid, 0, 0);
        //assert(r >= 0);

        wait(0);
    }

    r = ptrace(PTRACE_GETREGS, pid, 0, &regs);

    /*
    000000000000113c <main>:
    113c:	f3 0f 1e fa          	endbr64 
    1140:	55                   	push   %rbp
    1141:	48 89 e5 *             	mov    %rsp,%rbp
    1144:	48 83 ec 10          	sub    $0x10,%rsp
    1148:	c7 45 f4 00 * 00 00 00 	movl   $0x0,-0xc(%rbp)
    114f:	c7 45 f8 00 00 * 00 00 	movl   $0x0,-0x8(%rbp)
    1156:	48 c7 c0 37 02 00 * 00 	mov    $0x237,%rax
    115d:	66 48 0f 6e f8       	movq   %rax,%xmm7
    1162:	eb 29 *               	jmp    118d <main+0x51>
    1164:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1167:	89 c7                	mov    %eax,%edi
    1169:	49 c7 c2 * 01 00 00 00 	mov    $0x1,%r10
    1170:	66 49 0f 6e * ca       	movq   %r10,%xmm1
    1175:	66 0f 38 dc cf       	aesenc %xmm7,%xmm1
    117a:	66 41 * 0f 7e ca       	movd   %xmm1,%r10d
    117f:	41 ff d2             	call   *%r10
    1182:	89 45 * fc             	mov    %eax,-0x4(%rbp)
    1185:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1189:	83 45 f8 * 01          	addl   $0x1,-0x8(%rbp)
    118d:	81 7d f8 fe ff ff 7f * 	cmpl   $0x7ffffffe,-0x8(%rbp)
    1194:	7e ce                	jle    1164 <main+0x28>
    1196:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1199:	c9                   	leave  
    119a:	c3                   	ret    
    */

    // Change 90 to 55
    r = ptrace(PTRACE_POKEDATA, pid, addr1, 0xe5894855fa1e0ff3); // endbr64, push, mov
    //assert(r >= 0);
    //printf("%p\n", (void*) ptrace(PTRACE_PEEKDATA, pid, addr1, 0));
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 8, 0x00f445c710ec8348); // sub movl*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 16, 0x0000f845c7000000); // *movl movl*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 24, 0x000237c0c7480000); // *movl mov*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 32, 0x29ebf86e0f486600); // *mov movq jmp
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 40, 0xc2c749c789f8458b); // mov mov mov*
    //assert(r >= 0); // Here
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 48, 0x6e0f496600000001); // *mov movq*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 56, 0x4166cfdc380f66ca); // *movq aesenc movd*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 64, 0x4589d2ff41ca7e0f); // *movd call mov*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 72, 0xf8458301f44583fc); // *mov addl addl*
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 80, 0x7ffffffef87d8101); // *addl cmpl
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr1 + 88, 0xc3c9f4458bce7e); // jle mov leave ret
    //assert(r >= 0);


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
    //assert(r >= 0);
    r = ptrace(PTRACE_POKEDATA, pid, addr2 + 8, 0xc35d90fc7d89); // mov nop pop ret
    //assert(r >= 0);

    regs.rip = addr1;

    r = ptrace(PTRACE_SETREGS, pid, 0, &regs);
    //assert(r >= 0);

    //r = ptrace(PTRACE_CONT, pid, 0, 0);
    int status = -5;

    r = ptrace(PTRACE_DETACH, pid, 0, 0);
    ////assert(r >= 0);

    r = waitpid(pid, &status, 0);

    exit(0);


    /*while(true)  {
        r = waitpid(pid, &status, 0);
        printf("Thingy %i %i\n", status, r);
        if(r == -1)  {
            printf("Oh dear, something went wrong with read()! %s\n", strerror(errno));
            exit(0);
        }

        ////assert(r >= 0);

        if ( WIFEXITED(status) ) {
            int es = WEXITSTATUS(status);
            printf("Exit status was %d\n", es);
            break;
        } else if(WIFSTOPPED(status))  {
            printf("Stopped\n");
            int sig = WSTOPSIG(status);
            printf("signal %i\n", sig);

            r = ptrace(PTRACE_GETREGS, pid, 0, &regs);
            //assert(r >= 0);

            uintptr_t please = ptrace(PTRACE_PEEKDATA, pid, regs.rip, 0);
            printf("peekdata is %p\n", (void*) please);
            printf("rip is %p\n", (void*) regs.rip);

            r = ptrace(PTRACE_CONT, pid, 0, sig);
        }
    }

    exit(0);*/
} 