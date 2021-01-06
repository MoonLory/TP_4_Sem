// Author - Grishkin

#include "Route.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define BUFFER_SIZE 256

#pragma warning (disable: 4996)

void fgetsWithoutNewline(char *str, int size, FILE *file)
{
	fgets(str, size, file);
	int len = strlen(str);
	if (str[len - 1] == '\n')
		str[len - 1] = '\0';
}

int callback(void *data, int argc, char **argv, char **headers)
{
	for (int i = 0; i < argc; ++i)
		printf("%s = %s\n", headers[i], argv[i] ? argv[i] : "NULL");
	putchar('\n');
	return 0;
}

int maxIDCallback(void *data, int argc, char **argv, char **headers)
{
	*((int *)data) = strtol(argv[0], NULL, 10);
	return 0;
}

int addPhoto(sqlite3 *db, const char *name, int id)
{
	FILE *file = fopen(name, "rb");
	if (file == NULL) 
	{
		puts("Cannot open image file\n");
		return 1;
	}

	fseek(file, 0, SEEK_END);
	if (ferror(file)) 
	{
		puts("fseek() failed\n");
		int ret = fclose(file);
		if (ret == EOF) 
			puts("Cannot close file handler\n");
		return 1;
	}

	int fileLength = ftell(file);

	if (fileLength == -1) 
	{
		puts("error occurred");
		int ret = fclose(file);
		if (ret == EOF)
			puts("Cannot close file handler\n");
		return 1;
	}

	fseek(file, 0, SEEK_SET);

	if (ferror(file)) 
	{
		puts("fseek() failed\n");
		int ret = fclose(file);
		if (ret == EOF) 
			puts("Cannot close file handler\n");
		return 1;
	}

	char *data = malloc(fileLength + 1);
	int size = fread(data, 1, fileLength, file);

	if (ferror(file)) 
	{
		puts("fread() failed\n");
		int ret = fclose(file);
		if (ret == EOF) 
			puts("Cannot close file handler\n");
		return 1;
	}

	int ret = fclose(file);
	if (ret == EOF)
		puts("Cannot close file handler\n");

	char *errMsg = NULL;
	sqlite3_stmt *stmtQuery;
	char query[BUFFER_SIZE];
	sprintf(query, "UPDATE cars SET photo = @img WHERE id = %i;", id);
	int retCode = sqlite3_prepare(db, query, -1, &stmtQuery, 0);
	if (retCode != SQLITE_OK) 
	{
		printf("Cannot prepare statement: %s\n", sqlite3_errmsg(db));
		return 1;
	}

	int idx = sqlite3_bind_parameter_index(stmtQuery, "@img");
	sqlite3_bind_blob(stmtQuery, 1, data, size, SQLITE_STATIC);

	retCode = sqlite3_step(stmtQuery);
	if (retCode != SQLITE_DONE) 
		printf("Adding the photo failed: %s", sqlite3_errmsg(db));

	sqlite3_finalize(stmtQuery);
	free(data);
	return SQLITE_OK;
}

int writePhoto(sqlite3 *db, const char *name, int id)
{
	FILE *file = fopen(name, "wb");
	if (file == NULL) 
	{
		puts("Cannot open image file\n");
		return 1;
	}

	char *errMsg = NULL;
	char query[BUFFER_SIZE];
	sprintf(query, "SELECT photo FROM cars WHERE id = %i;", id);

	sqlite3_stmt *stmtQuery;
	int ret = sqlite3_prepare_v2(db, query, -1, &stmtQuery, 0);

	if (ret != SQLITE_OK) 
	{
		puts("Failed to prepare statement: %s\n", sqlite3_errmsg(db));
		return 1;
	}

	ret = sqlite3_step(stmtQuery);
	int bytes = 0;
	if (ret == SQLITE_ROW) 
		bytes = sqlite3_column_bytes(stmtQuery, 0);

	fwrite(sqlite3_column_blob(stmtQuery, 0), bytes, 1, file);

	if (ferror(file)) 
	{
		puts("fwrite() failed\n");
		return 1;
	}

	ret = fclose(file);
	if (ret == EOF)
		puts("Cannot close file handler\n");

	sqlite3_finalize(stmtQuery);
}

int ConnectToDB(const char *dbName, sqlite3 **db)
{
	return sqlite3_open(dbName, db);
}

void CloseDB(sqlite3 *db)
{
	sqlite3_close(db);
}

int AddPhotos(sqlite3 *db, const char *folder)
{
	const char *query = "SELECT max(cars.id) FROM Cars;";
	char *errMsg;
	int maxID;
	int retCode = sqlite3_exec(db, query, maxIDCallback, &maxID, &errMsg);
	if (retCode != SQLITE_OK)
	{
		printf("Adding photos failed, reason: %s", errMsg);
		sqlite3_free(errMsg);
		return retCode;
	}

	char buffer[BUFFER_SIZE];
	strcpy(buffer, folder);
	int len = strlen(folder);
	char *lastSymbol = buffer + len;

	for (int i = 1; i <= maxID; ++i)
	{
		*lastSymbol = '\0';
		sprintf(lastSymbol, "image%i.jpg", i);
		addPhoto(db, buffer, i);
	}

	return SQLITE_OK;
}

int WritePhotos(sqlite3 *db, const char *folder)
{
	const char *query = "SELECT max(Cars.id) FROM Cars;";
	char *errMsg;
	int maxID;
	int retCode = sqlite3_exec(db, query, maxIDCallback, &maxID, &errMsg);
	if (retCode != SQLITE_OK)
	{
		printf("Adding photos failed, reason: %s", errMsg);
		sqlite3_free(errMsg);
		return retCode;
	}

	char buffer[BUFFER_SIZE];
	strcpy(buffer, folder);
	int len = strlen(folder);
	char *lastSymbol = buffer + len;

	for (int i = 1; i <= maxID; ++i)
	{
		*lastSymbol = '\0';
		sprintf(lastSymbol, "image%i.jpg", i);
		writePhoto(db, buffer, i);
	}

	return SQLITE_OK;
}

int SendSelectQuery(sqlite3 *db, char **errMsg)
{
	const char *query =
	"SELECT Cars.*, vendor.ven_name, vendor.ven_description " \
	"FROM Cars LEFT JOIN vendor " \
	"ON Cars.vendor_id = vendor.id;";

	return sqlite3_exec(db, query, callback, NULL, errMsg);
}

int SendInsertQuery(sqlite3 *db, char **errMsg)
{
	char model[BUFFER_SIZE], color[BUFFER_SIZE], reg_num[BUFFER_SIZE],
		ven_name[BUFFER_SIZE], ven_description[BUFFER_SIZE];
	int vendor_id,y_made,c_year,ind_num;

	puts("Input model:");
	fgetsWithoutNewline(model, BUFFER_SIZE, stdin);
	puts("Input color:");
	fgetsWithoutNewline(color, BUFFER_SIZE, stdin);
	puts("Input reg_num:");
	fgetsWithoutNewline(reg_num, BUFFER_SIZE, stdin);
	puts("Input ven_name:");
	fgetsWithoutNewline(ven_name, BUFFER_SIZE, stdin);
	puts("Input ven_description:");
	fgetsWithoutNewline(ven_description, BUFFER_SIZE, stdin);
	puts("Input height in meters:");
	
	puts("Input vendor_id:");
	scanf("%i", &vendor_id);
	puts("Input y_made:");
	scanf("%i", &y_made);
	puts("Input c_year:");
	scanf("%i", &c_year);
	puts("Input ind_num:");
	scanf("%i", &ind_num);
	getchar();

	char query[256 * BUFFER_SIZE];
	query[0] = '\0';
	sprintf(query,
		"INSERT INTO cars (model, color, reg_num, gender, ven_name, "\
		"ven_description, vendor_id, y_made,c_year, ind_num)"\
		"VALUES ('%s', '%s', '%s', '%s', '%s',  %i,  %i,  %i,  %i,);",
		model, color, reg_num, ven_name,
		ven_description, vendor_id, y_made, c_year, ind_num);
	
	return sqlite3_exec(db, query, callback, NULL, errMsg);
}

int SendDeleteQuery(sqlite3 *db, char **errMsg)
{
	int id;
	puts("Input the ID of the cars to delete:");
	scanf("%i", &id);

	char query[BUFFER_SIZE];
	query[0] = '\0';
	sprintf(query, "DELETE FROM Cars WHERE id = %i;", id);

	return sqlite3_exec(db, query, callback, NULL, errMsg);
}

void SendParameterizedQuery(sqlite3 *db, ParameterizedQueryType type)
{
	char query[10 * BUFFER_SIZE] =
	"SELECT Cars.*, vendor.ven_name, vendor.ven_description " \
	"FROM People LEFT JOIN vendor " \
	"ON cars.vendor_id = vendor.id " \
	"WHERE ";
	
	switch (type)
	{
		case QUERY_BY_ID:
			strcat(query, "cars.id = @value;");
			break;

		case QUERY_BY_model_MASK:
			strcat(query, "model LIKE @value;");
			break;

		case QUERY_BY_color:
			strcat(query, "color = @value;");
			break;
	}

	sqlite3_stmt *stmtQuery;
	
	int retCode = sqlite3_prepare_v2(db, query, -1, &stmtQuery, 0);
	int idx = sqlite3_bind_parameter_index(stmtQuery, "@value");

	int id; 
	char buffer[BUFFER_SIZE];
	if (retCode == SQLITE_OK)
	{
		switch (type)
		{
			case QUERY_BY_ID:
				puts("Input the ID:");
				scanf("%i", &id);
				getchar();
				sqlite3_bind_int(stmtQuery, idx, id);
				break;

			case QUERY_BY_SURNAME_MASK:
				puts("Input the model mask:");
				fgetsWithoutNewline(buffer, BUFFER_SIZE, stdin);
				sqlite3_bind_text(stmtQuery, idx, buffer, -1, SQLITE_STATIC);
				break;

			case QUERY_BY_NATIONALITY:
				puts("Input color:");
				fgetsWithoutNewline(buffer, BUFFER_SIZE, stdin);
				sqlite3_bind_text(stmtQuery, idx, buffer, -1, SQLITE_STATIC);
				break;
		}
	}
	else
		return;

	int step = sqlite3_step(stmtQuery);
	while (step == SQLITE_ROW)
	{
		int N = sqlite3_column_count(stmtQuery);
		for (int i = 0; i < N; ++i)
		{
			char *value = sqlite3_column_text(stmtQuery, i);
			printf("%s = %s\n",
				   sqlite3_column_name(stmtQuery, i),
				   value ? value : "NULL");
		}
		putchar('\n');

		step = sqlite3_step(stmtQuery);
	}

	sqlite3_finalize(stmtQuery);
}

int InTransactionMode(sqlite3 *db)
{
	return !sqlite3_get_autocommit(db);
}

int BeginTransaction(sqlite3 *db, char **errMsg)
{
	if (InTransactionMode(db))
	{
		if (errMsg != NULL)
		{
			*errMsg = sqlite3_malloc(BUFFER_SIZE);
			strcpy(*errMsg, "A transaction already begun!");
		}
		return SQLITE_ERROR;
	}

	return sqlite3_exec(db, "BEGIN TRANSACTION;", NULL, NULL, errMsg);
}

int Commit(sqlite3 *db, char **errMsg)
{
	if (!InTransactionMode(db))
	{
		if (errMsg != NULL)
		{
			*errMsg = sqlite3_malloc(BUFFER_SIZE);
			strcpy(*errMsg, "No transaction can be committed!");
		}
		return SQLITE_ERROR;
	}

	return sqlite3_exec(db, "COMMIT;", callback, NULL, errMsg);
}