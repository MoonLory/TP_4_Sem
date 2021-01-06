// Author - Grishkin

#include "Menu.h"
#include <stdio.h>

#pragma warning (disable: 4996)

MenuChoice ShowMenu()
{
	int result = CHOICE_INITIAL;
	while (result < CHOICE_SELECT || result > CHOICE_EXIT)
	{
		puts("Make your choice:\n" \
			 "1. Send SELECT query\n" \
			 "2. Send INSERT query\n" \
			 "3. Send DELETE query\n" \
			 "4. Send a parameterized query\n" \
			 "5. Begin transaction\n" \
			 "6. Commit transaction\n" \
			 "7. Exit");
		scanf("%i", &result);
	}
	return result;
}

ParameterizedQueryType ShowParameterizedMenu()
{
	int result = 0;
	while (result < QUERY_BY_ID || result > QUERY_BY_NATIONALITY)
	{
		puts("Make your choice:\n" \
			 "1. Query by ID\n" \
			 "2. Query by model with the mask\n" \
			 "3. Query by color");
		scanf("%i", &result);
	}
	return result;
}
