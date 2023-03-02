#include <iostream>
#include <cstring>
// functia folosita pentru a citi un sir de la tastatura
char citire();
char s[100];

int main()
{
    strcpy(s,"sad");
        while (strcmp(s,"$"))
        {
            strcpy(s, citire());
            if (s[0] == '-')
                x = 0 - int(s + 1)
            else
                x = int(s)
            cin.get(s, 100);
        }
    return 0;
}

