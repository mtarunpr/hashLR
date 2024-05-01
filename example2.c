unsigned int func(unsigned int val)
{
    return val + 2;
}

int main()
{
    unsigned int sum = 0;
    for (unsigned int i = 0; i < 10; i++)
    {
        sum += func(i);
    }
    return sum;
}
