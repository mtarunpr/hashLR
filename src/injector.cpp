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
#include <vector>
#include <fstream>
#include <string>
#include <chrono>
#include <cassert>

#define PAGESIZE 4096

using namespace std;
using namespace std::chrono;

static uintptr_t convert(long l)
{
    uintptr_t toret;
    __asm__(
        "movq $0x237, %%rax \n"
        "movq %%rax, %%xmm7\n"
        "movq %1, %%rax \n"
        "movq %%rax, %%xmm1\n"
        "aesenc %%xmm7, %%xmm1\n"
        "movd %%xmm1, %%eax \n"
        "movq %%rax, %0\n"
        : "=r"(toret)     /* output */
        : "r"(l)          /* input */
        : "%rax", "%xmm7" /* clobbered register */
    );

    return toret;
}

int main(int argc, char *argv[])
{
    string bytes_file_name = "temp.bytes";

    if (argc != 3)
    {
        printf("Usage: ./injector [binary file] [bb identifiers file]\n");
        exit(1);
    }

    struct user_regs_struct regs;
    int thing = 0;

    vector<uintptr_t> addr;
    vector<vector<uintptr_t>> insts;

    char buf[1024];
    snprintf(buf, sizeof(buf), "python3 src/binary_parser.py -b %s -i %s -o %s", argv[1], argv[2], bytes_file_name.c_str());
    system(buf);

    ifstream bytesFile(bytes_file_name);

    if (!bytesFile.is_open())
    {
        cerr << "Could not open file " << bytes_file_name << endl;
        exit(1);
    }

    string line;
    uintptr_t curr_addr = 0;
    uintptr_t rip = 0;

    while (getline(bytesFile, line))
    {
        if (line.length() >= 4)
        {
            // cout << "new line " << line << "\n";
            if (line[0] == '#')
            {
                continue;
            }
            else if (line[0] == '0' && line[1] == 'x')
            {
                unsigned long l = stoull(line, 0, 16);
                insts.back().push_back(l);
            }
            else if (line.substr(0, 4).compare("main") == 0)
            {
                unsigned long l = stoull(line.substr(5));
                curr_addr = convert(l);
                rip = curr_addr;
                addr.push_back(curr_addr);
                insts.push_back(*(new vector<uintptr_t>));
            }
            else
            {
                unsigned long l = stoull(line);
                curr_addr = convert(l);
                addr.push_back(curr_addr);
                insts.push_back(*(new vector<uintptr_t>));
            }
        }
    }

    // Close the file
    bytesFile.close();

    int num_basic_blocks = addr.size() * 2;
    int fulfilled = 0;

    pid_t pid = fork();

    if (pid == 0)
    {
        ptrace(PTRACE_TRACEME, 0, 0, 0);

        execlp("./src/mmapper", "./src/mmapper", nullptr);

        assert(false);
    }

    sleep(0.05);

    while (true)
    {

        ptrace(PTRACE_GETREGS, pid, 0, &regs);

        if (regs.rdi == 10234)
        {
            break;
        }
        else if (regs.rdi == 0xfeedface)
        {
            if (fulfilled == num_basic_blocks)
            {
                regs.orig_rax = -1;
                ptrace(PTRACE_SETREGS, pid, 0, &regs);
                ptrace(PTRACE_SYSCALL, pid, 0, 0);
                wait(0);
                regs.rax = 0xfafafafa;
                ptrace(PTRACE_SETREGS, pid, 0, &regs);
            }
            else
            {
                regs.orig_rax = SYS_mmap;
                if (fulfilled % 2 == 0)
                {
                    regs.rdi = addr[fulfilled / 2];
                }
                else
                {
                    regs.rdi = addr[fulfilled / 2] + 4096;
                }
                ++fulfilled;

                // Page align
                regs.rdi -= regs.rdi % 4096;

                regs.rsi = 4096;
                regs.rdx = PROT_EXEC | PROT_READ | PROT_WRITE;
                regs.r10 = MAP_ANON | MAP_SHARED | MAP_FIXED;
                regs.r8 = -1;
                regs.r9 = 0;

                ptrace(PTRACE_SETREGS, pid, 0, &regs);
                // Wait for system call return
                ptrace(PTRACE_SYSCALL, pid, 0, 0);
                wait(0);
            }
        }

        ptrace(PTRACE_SYSCALL, pid, 0, 0);

        wait(0);
    }

    ptrace(PTRACE_GETREGS, pid, 0, &regs);

    int index = 0;
    for (vector<uintptr_t> todo : insts)
    {
        uintptr_t place = addr[index];

        int offset = 0;

        for (uintptr_t code : todo)
        {
            ptrace(PTRACE_POKEDATA, pid, place + offset, code);
            offset += 8;
        }

        ++index;
    }

    regs.rip = rip;

    ptrace(PTRACE_SETREGS, pid, 0, &regs);

    int status = -5;

    auto start = chrono::high_resolution_clock::now();

    ptrace(PTRACE_DETACH, pid, 0, 0);

    waitpid(pid, &status, 0);

    auto end = chrono::high_resolution_clock::now();

    cout << "Time elapsed: " << chrono::duration_cast<milliseconds>(end - start).count() << " ms\n";

    exit(0);
}