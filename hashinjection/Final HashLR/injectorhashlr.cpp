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

        execlp("./mmapperhashlr", "./mmapperhashlr", nullptr);
        
        //assert(false);
    }

    sleep(0.05);

    int r = -1;

    struct user_regs_struct regs;
    int thing = 0;

    uintptr_t addr[6];

    __asm__
    (
    "movq $0x237, %%rax \n"
    "movq %%rax, %%xmm7\n"
    "movabs $0x377970a4e6433c7, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %0\n"
    "movabs $0x7271e70795fb0a2b, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %1\n"
    "movabs $0x7271e70795fb0a21, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %2\n"
    "movabs $0x7271e70795fb0a2d, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %3\n"
    "movabs $0x7271e70795fb0a2e, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %4\n"
    "movabs $0x7271e70795fb0a2f, %%rax \n"
    "movq %%rax, %%xmm1\n"
    "aesenc %%xmm7, %%xmm1\n"
    "movd %%xmm1, %%eax \n"
    "movq %%rax, %5\n"
    : "=r"(addr[0]), "=r"(addr[1]), "=r"(addr[2]), "=r"(addr[3]), "=r"(addr[4]), "=r"(addr[5]) /* output */
    :      /* input */
    : "%rax", "%xmm7"        /* clobbered register */
    );

    printf("%p %p %p %p %p %p\n", (void*) addr[0], (void*) addr[1], (void*) addr[2], (void*) addr[3], (void*) addr[4], (void*) addr[5]);

    int index = 0;
    uintptr_t addrs[12];
    for(int i = 0; i < 12; i++)  {
        addrs[i] = addr[i / 2] + (i % 2) * 4096;
        addrs[i] -= addrs[i] % 4096;
    }

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
    0000000000001129 <_Z4funci>:
    $0x377970a4e6433c7 hash value
    1129:	55                   	push   %rbp
    112a:	48 89 e5             	mov    %rsp,%rbp
    112d:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1130:	5d *                   	pop    %rbp
    1131:	c3                   	ret   
    */

    ptrace(PTRACE_POKEDATA, pid, addr[0], 0x5dfc7d89e5894855); // push, mov, mov, pop
    ptrace(PTRACE_POKEDATA, pid, addr[0] + 8, 0xc3); // ret

    /*
    0000000000001132 <main>:
    $0x7271e70795fb0a2b hash value
    1132:	55                   	push   %rbp
    1133:	48 89 e5             	mov    %rsp,%rbp
    1136:	48 83 ec 10 *          	sub    $0x10,%rsp
    113a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1141:	c7 * 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1148:	c7 45 * fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    114f:	48 c7 c0 * 37 02 00 00 	mov    $0x237,%rax
    1156:	66 48 0f 6e * f8       	movq   %rax,%xmm7
    115b:	49 ba 21 0a fb 95 07 * 	movabs $0x7271e70795fb0a21,%r10
    1162:	e7 71 72 
    1165:	66 49 0f 6e ca *       	movq   %r10,%xmm1
    116a:	66 0f 38 dc cf       	aesenc %xmm7,%xmm1
    116f:	66 0f 7e * c8          	movd   %xmm1,%eax
    1173:	ff e0                	jmp    *%rax
    */
    ptrace(PTRACE_POKEDATA, pid, addr[1], 0x10ec8348e5894855); // push, mov, sub
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 8, 0xc700000000f445c7); // movl movl*
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 16, 0x45c700000000f845); // *movl movl*
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 24, 0xc0c74800000000fc); // *movl mov*
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 32, 0x6e0f486600000237); // *mov movq*
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 40, 0x0795fb0a21ba49f8); // *movq movabs
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 48, 0xca6e0f49667271e7); // cont movq
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 56, 0x7e0f66cfdc380f66); // aesenc movd*
    ptrace(PTRACE_POKEDATA, pid, addr[1] + 64, 0xe0ffc8); // *movd jmp

    /*
    0000000000001175 <LBB1_1>:
    $0x7271e70795fb0a21 hash value
    1175:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%rbp)
    117c:	7d * 1a                	jge    1198 <LBB1_2>
    117e:	49 ba 2d 0a fb 95 07 * 	movabs $0x7271e70795fb0a2d,%r10
    1185:	e7 71 72 
    1188:	66 49 0f 6e ca *      	movq   %r10,%xmm1
    118d:	66 0f 38 dc cf       	aesenc %xmm7,%xmm1
    1192:	66 0f 7e * c8          	movd   %xmm1,%eax
    1196:	ff e0                	jmp    *%rax
    0000000000001198 <LBB1_2>: (NEW BASIC BLOCK BUT NEED TO KEEP TOGETHER)
    1198:	49 ba 2f 0a fb * 95 07 	movabs $0x7271e70795fb0a2f,%r10
    119f:	e7 71 72 
    11a2:	66 49 0f * 6e ca       	movq   %r10,%xmm1
    11a7:	66 0f 38 dc cf      	aesenc %xmm7,%xmm1
    11ac:	66 * 0f 7e c8          	movd   %xmm1,%eax
    11b0:	ff e0                	jmp    *%rax
    */
    ptrace(PTRACE_POKEDATA, pid, addr[2], 0x7d7ffffffffc7d81); // cmpl jge*
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 8, 0x0795fb0a2dba491a); // *jge movabs
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 16, 0xca6e0f49667271e7); // cont movq
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 24, 0x7e0f66cfdc380f66); // aesenc movd*
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 32, 0xfb0a2fba49e0ffc8); // *movd jmp movabs*
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 40, 0x0f49667271e70795); // *movabs cont movq*
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 48, 0x66cfdc380f66ca6e); // *movq aesenc movd*
    ptrace(PTRACE_POKEDATA, pid, addr[2] + 56, 0xe0ffc87e0f); // *movd jmp

    /*
    00000000000011b2 <LBB1_3>:
    $0x7271e70795fb0a2d hash value
    11b2:	8b 7d fc             	mov    -0x4(%rbp),%edi
    11b5:	49 ba c7 33 64 * 4e 0a 	movabs $0x377970a4e6433c7,%r10
    11bc:	97 77 03 
    11bf:	66 49 0f * 6e ca       	movq   %r10,%xmm1
    11c4:	66 0f 38 dc cf       	aesenc %xmm7,%xmm1
    11c9:	66 * 0f 7e c8          	movd   %xmm1,%eax
    1014:	ff d0 90                call   *%rax nop
    11d0:	8b 4d * f8             	mov    -0x8(%rbp),%ecx
    11d3:	83 c1 01             	add    $0x1,%ecx
    11d6:	89 4d f8             	mov    %ecx,-0x8(%rbp)
    11d9:	49 * ba 2e 0a fb 95 07 	movabs $0x7271e70795fb0a2e,%r10
    11e0:	e7 71 * 72 
    11e3:	66 49 0f 6e ca       	movq   %r10,%xmm1
    11e8:	66 0f * 38 dc cf       	aesenc %xmm7,%xmm1
    11ed:	66 0f 7e c8          	movd   %xmm1,%eax
    11f1:	ff * e0                	jmp    *%rax
    */
    ptrace(PTRACE_POKEDATA, pid, addr[3], 0x6433c7ba49fc7d8b); // mov movabs*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 8, 0x0f49660377970a4e); // *movabs cont movq*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 16, 0x66cfdc380f66ca6e); // *movq aesenc movd*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 24, 0x4d8b90d0ffc87e0f); // *movd call nop mov*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 32, 0x49f84d8901c183f8); // *mov add mov movabs*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 40, 0x71e70795fb0a2eba); // *movabs cont*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 48, 0x0f66ca6e0f496672); // *cont movq aesenc*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 56, 0xffc87e0f66cfdc38); // *aesenc movd jmp*
    ptrace(PTRACE_POKEDATA, pid, addr[3] + 64, 0xe0); // *jmp

    /*
    00000000000011f3 <LBB1_4>:
    $0x7271e70795fb0a2e hash value
    11f3:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    11f6:	83 c1 01             	add    $0x1,%ecx
    11f9:	89 4d * fc             	mov    %ecx,-0x4(%rbp)
    11fc:	49 ba 21 0a fb 95 07 *	movabs $0x7271e70795fb0a21,%r10
    1203:	e7 71 72 
    1206:	66 49 0f 6e ca *       	movq   %r10,%xmm1
    120b:	66 0f 38 dc cf       	aesenc %xmm7,%xmm1
    1210:	66 0f 7e * c8          	movd   %xmm1,%eax
    1214:	ff e0                	jmp    *%rax
    */
    ptrace(PTRACE_POKEDATA, pid, addr[4], 0x4d8901c183fc4d8b); // mov add mov*
    ptrace(PTRACE_POKEDATA, pid, addr[4] + 8, 0x0795fb0a21ba49fc); // *mov movabs
    ptrace(PTRACE_POKEDATA, pid, addr[4] + 16, 0xca6e0f49667271e7); // cont movq*
    ptrace(PTRACE_POKEDATA, pid, addr[4] + 24, 0x7e0f66cfdc380f66); // aesenc movd*
    ptrace(PTRACE_POKEDATA, pid, addr[4] + 32, 0xe0ffc8); // *movd jmp

    /*
    0000000000001216 <LBB1_5>:
    $0x7271e70795fb0a2f hash value
    1216:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1219:	48 83 c4 10          	add    $0x10,%rsp
    121d:	5d *                   	pop    %rbp
    121e:	c3                   	ret    
    */
    ptrace(PTRACE_POKEDATA, pid, addr[5], 0x5d10c48348f8458b); // mov add pop
    ptrace(PTRACE_POKEDATA, pid, addr[5] + 8, 0xc3); // ret

    regs.rip = addr[1];

    r = ptrace(PTRACE_SETREGS, pid, 0, &regs);

    //r = ptrace(PTRACE_CONT, pid, 0, 0);
    int status = -5;

    r = ptrace(PTRACE_DETACH, pid, 0, 0);
    ////assert(r >= 0);

    r = waitpid(pid, &status, 0);

    exit(0);
} 