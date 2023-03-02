#include <stdio.h>

int transformare(char);
char x[];
int v[100], i,j;
int main()
{
	strcpy(x, '0');
	i = 0;
	while (strcmp(x,'$'))
	{
		scanf("%s", x);
		v[i] =transformare(x);
		i++;
	}
	for (j = 0; j < i; j++)
		printf("%d", v[j]);
	return 0;
}

