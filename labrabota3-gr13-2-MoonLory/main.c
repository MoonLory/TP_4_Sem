#include "Car.h"
#include <stdio.h>
 
int main()
{
    FILE *inputFile = fopen("cars.txt", "r");  
    ListNode *head = CreateCarList(inputFile);
    fclose(inputFile);
   
    PrintCarList(head);
    PrintOldCars(head, 2020);
    FreeCarList(head);
}