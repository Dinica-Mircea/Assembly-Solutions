#include <stdio.h>
#include <string.h>
int transformare(char);
int main()
{
	char x[100];
	int v[100], i, j;
	strcpy(x, "dsadasd");
	i = 0;
	while (strcmp(x,"$"))
	{
		scanf("%s", x);
		v[i] =transformare(x[100]);
		i++;
	}
	for (j = 0; j < i; j++)
		printf("%d\n", v[j]);
	return 0;
}
