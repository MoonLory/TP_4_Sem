//Grishkin Andrei

//вывести из массива числа с наибольшей суммой цифр

#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int sum_num(int k) {
	int sum = 0;
	while (k > 9) {
		sum += k % 10;
		k /= 10;

	}
	return sum;
}


int main(int argc, char *argv[]) {
	int n = atoi(argv[1]);
	int* arr;
	arr = (int*)malloc(n * sizeof(int));
	int max_sum=0;
	
	for (int i = 0; i < n; i++)
	{
		arr[i] = rand();
		printf("%d%c", arr[i], ' ');
	}
	
	printf("%c", '\n');

	for (int i = 0; i < n; i++) 
		if (sum_num(arr[i]) > max_sum)
			max_sum = sum_num(arr[i]);
	
	for (int i = 0; i < n; i++)
		if (sum_num(arr[i]) == max_sum)
			printf("%d%c", arr[i], ' ');

	_getch();
}