 
#include "Car.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
 
void fgetsWithoutNewline(char *str, int size, FILE *file)
{
    fgets(str, size, file);
    int len = strlen(str);
    if (str[len - 1] == '\n')
        str[len - 1] = '\0';
}
 
Car * readCar(FILE *file)
{
    Car *car = malloc(sizeof(Car));
    fgetsWithoutNewline(car->brand, 256, file);
    fgetsWithoutNewline(car->color, 256, file);
    fgetsWithoutNewline(car->serialNumber, 256, file);
    fgetsWithoutNewline(car->regNumber, 256, file);
    fscanf(file, "%i", &car->year);
    fscanf(file, "%i", &car->examYear);
    fscanf(file, "%lf", &car->price);
    fgetc(file);
    return car;
}
 
void writeCar(FILE *file, Car *car)
{
    fprintf(file, "%s\n%s\n%s\n%s\n%i\n%i\n%lf\n",
    car->brand, car->color, car->serialNumber,
    car->regNumber, car->year, car->examYear,
    car->price);
}
 
ListNode * CreateCarList(FILE *file)
{
    ListNode *head = NULL, *curr;
   
    while (!feof(file))
    {
        curr = malloc(sizeof(ListNode));
        curr->info = readCar(file);
        curr->next = head;
        head = curr;
    }
   
    return head;
}
 
void PrintCarList(ListNode *head)
{
    ListNode *curr = head;
    while (curr != NULL)
    {
        writeCar(stdin, curr->info);
        curr = curr->next;
    }
}
 
void PrintOldCars(ListNode *head, int year)
{
    ListNode *curr = head;
    while (curr != NULL)
    {
        if (year - curr->info->year > 2)
            writeCar(stdin, curr->info);
        curr = curr->next;
    }
}
 
void FreeCarList(ListNode *head)
{
    ListNode *temp = head;
    while (head != NULL)
    {
        temp = head;
        head = head->next;
        free(temp->info);
        free(temp);
    }
}  
