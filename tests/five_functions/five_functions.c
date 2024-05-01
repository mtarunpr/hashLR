unsigned int random(unsigned int seed)
{
    unsigned int a = 75;
    unsigned int c = 74;
    unsigned int m = (1 << 16) + 1;
    return (a * seed + c) % m;
}

unsigned int perfectly_secret(unsigned int plaintext)
{
    return plaintext ^ 0xfeedface;
}

unsigned int djb2(const int num)
{
    unsigned int hash = 5381;
    int c;
    for (int i = num; i > 0; i /= 10)
    {
        c = i % 10;
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
    }
    return hash;
}

unsigned int mickens_favorite(unsigned int value)
{
    value *= 'b';
    value += 'i';
    value /= 't';
    value -= 'c';
    value *= 'o';
    value += 'i';
    value *= 'n';
    return value;
}

unsigned int aslr(unsigned int rip)
{
    return rip + 0xdeadbeef;
}

int main()
{
    unsigned int ret = 0;
    for (unsigned int i = 0; i < 0xfffffff; i++)
    {
        unsigned int index = ret % 5;
        if (index == 0)
        {
            ret += random(ret);
        }
        else if (index == 1)
        {
            ret += perfectly_secret(ret);
        }
        else if (index == 2)
        {
            ret += djb2(ret);
        }
        else if (index == 3)
        {
            ret += mickens_favorite(ret);
        }
        else if (index == 4)
        {
            ret += aslr(ret);
        }
    }
    return ret;
}
