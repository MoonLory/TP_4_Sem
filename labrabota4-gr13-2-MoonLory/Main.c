// Author - Grishkin

#include <stdio.h>
#include "Menu.h"
#include "Route.h"

#pragma warning (disable: 4996)

int main(int argc, char **argv)
{
	if (argc != 2)
	{
		puts("Invalid number of arguments!");
		return -1;
	}

	sqlite3 *db;
	if (ConnectToDB(argv[1], &db) != SQLITE_OK)
	{
		printf("Error while opening database: %s\n", sqlite3_errmsg(db));
		return -2;
	}

	if (AddPhotos(db, "img/") != SQLITE_OK)
		puts("Couldn't add images!");

	MenuChoice choice = CHOICE_INITIAL;
	char *errMsg = NULL;
	int result;
	ParameterizedQueryType type;
	while (choice != CHOICE_EXIT)
	{
		choice = ShowMenu();
		getchar();
		switch (choice)
		{
			case CHOICE_SELECT:
				result = SendSelectQuery(db, &errMsg);
				break;

			case CHOICE_INSERT:
				result = SendInsertQuery(db, &errMsg);
				break;

			case CHOICE_DELETE:
				result = SendDeleteQuery(db, &errMsg);
				break;

			case CHOICE_PARAMETERIZED:
				type = ShowParameterizedMenu();
				getchar();
				SendParameterizedQuery(db, type);
				result = SQLITE_OK;
				break;
	
			case CHOICE_BEGIN_TRANSACTION:
				result = BeginTransaction(db, &errMsg);
				break;
			
			case CHOICE_COMMIT:
				result = Commit(db, &errMsg);
				break;

			case CHOICE_EXIT:
				result = SQLITE_OK;
				break;
		}

		if (result != SQLITE_OK)
		{
			printf("An error has occurred: %s", errMsg);
			sqlite3_free(errMsg);
		}
	}

	if (WritePhotos(db, "newImg/") != SQLITE_OK)
		puts("Couldn't write images!");

	sqlite3_close(db);

	puts("Bye!");
}