#include <stdio.h> 
#include <conio.h> 
#include <string.h>

#pragma warning (disable: 4996)

struct student {

	char name[10];
	int kurs;
	int marks[5];
};


void main() {
	
	struct student mas[10];

	for (int i = 0; i < 10; i++) {
		printf("Name? ");
		scanf( "%s",mas[i].name);
		printf("Kurs? ");
		scanf("%d", &mas[i].kurs);
		printf("Marks? ");
		for (int j = 0; j < 5; j++) {
			scanf("%d", &mas[i].marks[j]);
		}
	}

	
	struct student a;
	double sum,sum_ind;
	sum = sum_ind = 0;

		for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 9; j++) 
				if (strcmp(mas[j].name, mas[j + 1].name) > 0)
				{
					
					a = mas[j];
					mas[j] = mas[j + 1];
					mas[j + 1] = a;
				}
		}
	for (int i = 0; i < 10; i++) {
		printf("%s ",mas[i].name);
	}

	printf("\n");

	for (int i = 0; i < 10; i++) 
		for (int j = 0; j < 5; j++) {
			{
				sum += mas[i].marks[j];
			};
		};

	sum /= 50;

	for (int i = 0; i < 10; i++) {
		
		sum_ind = 0;
		for (int j = 0; j < 5; j++) {

			{
				sum_ind += mas[i].marks[j];
			};
		}
		sum_ind /= 5;
		if (sum_ind > sum)
			printf("%s%s", mas[i].name, " ");
	}
	_getch();
}