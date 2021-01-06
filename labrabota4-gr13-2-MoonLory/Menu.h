// Author - Grishkin

#ifndef MENU_H

	#define MENU_H
	
	#include "Route.h"

	typedef enum MenuChoice
	{
		CHOICE_INITIAL,
		CHOICE_SELECT,
		CHOICE_INSERT,
		CHOICE_DELETE,
		CHOICE_PARAMETERIZED,
		CHOICE_BEGIN_TRANSACTION,
		CHOICE_COMMIT,
		CHOICE_EXIT
	}
	MenuChoice;

	MenuChoice ShowMenu();
	ParameterizedQueryType ShowParameterizedMenu();

#endif