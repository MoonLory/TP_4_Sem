#include <stdio.h>
#include <locale.h>

int main()
{
	setlocale(LC_ALL,"RUS");	
	int a,b;
	printf("Введите ваш вес и рост");
	scanf("%d%d",&a,&b);
	if(a>b-100)
		printf("Нужно похудеть)");
	else
		printf("Все в норме!");
	return 0;
}
