#include <stdio.h>

int main()
{
    // Read int from stdin
    int a;
    scanf("%d", &a);
    // If a is 0, print "Hello, LLVM Pass!"
    if (a == 0)
    {
        printf("Hello, LLVM Pass!\n");
    }
    else
    {
        int b = a * a >> 2;
        printf("Bye, LLVM Pass %d!\n", 2);
    }
    return 0;
}

int hello()
{
    printf("test");
    int b;

    if (b == 3)
    {
        return 8;
    }
    else
    {
        return 9;
    }
    return 0;
}
