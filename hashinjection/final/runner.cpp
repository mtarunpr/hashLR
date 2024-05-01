void func(int i)  {
    return;
}

int main()  {
    int j = 0;

    for(int i = 0; i < 0x7fffffff; i++)  {
        func(i);
        j += 1;
    }

    return j;
}