#ifndef CAR_H
#define CAR_H
 
typedef struct Car
{
    char brand[256];
    char color[256];
    char serialNumber[256];
    char regNumber[256];
    int year;
    int examYear;
    double price;
}
Car;
 
typedef struct ListNode
{
    Car *info;
    struct ListNode *next;
}
ListNode;
 
ListNode * CreateCarList(FILE *);
void PrintCarList(ListNode *);
void PrintOldCars(ListNode *, int);
void FreeCarList(ListNode *);
 
#endif // CAR_H