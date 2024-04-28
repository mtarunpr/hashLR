static long array[1000];

void func(int i)  {
    return;
}

int main()  {
    int j = 0;

    for(int i = 0; i < 0x7fffffff; i++)  {
        func(i);
        int k = array[0];
        j += 1;
    }

    return j;
}