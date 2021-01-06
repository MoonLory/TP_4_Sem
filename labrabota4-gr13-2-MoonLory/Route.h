// Author - Grishkin

#ifndef ROUTE_H

	#define ROUTE_H

	#include "sqlite3.h"

	typedef enum ParameterizedQueryType
	{
		QUERY_BY_ID = 1,
		QUERY_BY_SURNAME_MASK,
		QUERY_BY_NATIONALITY
	}
	ParameterizedQueryType;

	int ConnectToDB(const char *, sqlite3 **);

	int AddPhotos(sqlite3 *, const char *);
	int WritePhotos(sqlite3 *, const char *);

	int SendSelectQuery(sqlite3 *, char **);
	int SendInsertQuery(sqlite3 *, char **);
	int SendDeleteQuery(sqlite3 *, char **);
	void SendParameterizedQuery(sqlite3 *, ParameterizedQueryType);
	
	int InTransactionMode(sqlite3 *);
	int BeginTransaction(sqlite3 *, char **);
	int Commit(sqlite3 *, char **);
	
	void CloseDB(sqlite3 *);

#endif
