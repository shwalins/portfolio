//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Program Name: Project1
//  Program File: pen.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: pen.h
//  Purpose: Holds all the definitions for the functions in the pen class
//			 in the pen.h file.
//
//***********************************************************************************

#include "pen.h" //where the class is located

//***********************************************************************************
//
//	Function Name: pen
//  Purpose: Constructor
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: penStatus, penHead
//  Data Members Modified: penStatus, penHead
//  Functions Called: none
//
//***********************************************************************************
pen::pen()
{
	penStatus = false; 
	penHead = '+'; //intializes penStatus and penHead to default
}

//***********************************************************************************
//
//	Function Name: penPosition
//  Purpose: toggles bool value of penStatus between "down" and "up"
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: penStatus
//  Data Members Accessed: penStatus
//  Data Members Modified: penStatus
//  Functions Called: none
//
//***********************************************************************************
bool pen::penPosition()
{
	penStatus = !penStatus; //changes penStatus from 0 to 1, or vice versa
	return (penStatus); //returns penStatus' value
}

//***********************************************************************************
//
//	Function Name: penStyle
//  Purpose: changes penHead based on user input
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: penHead
//  Data Members Modified: penHead
//  Functions Called: none
//
//***********************************************************************************
void pen::penStyle()
{
	int choice; //initializes choice for user input
	cout << "Which brush would you like?" << endl 
		 << "1: +" << endl << "2: *" << endl 
		 << "3: -" << endl << "4: ~" << endl; //displays brush options

	cin >> choice; //asks user for choice

	while ((choice != 1) && (choice != 2) && (choice != 3) && (choice != 4))
	{cout << "Invalid Option" << endl;
	cin >> choice;} //input validation loop

		switch (choice) //switch based on input
		{
			case 1:
				penHead = '+';
				break;
			case 2:
				penHead = '*';
				break;
			case 3:
				penHead = '-';
				break;
			case 4:
				penHead = '~';
				break;
		} //changes penHead to char based on user input
	cout << "Brush has been changed to " << penHead << endl; 
	//message to display the changes have occured
	return;
}

//***********************************************************************************
//
//	Function Name: currentPen
//  Purpose: Allows for functions outside of the pen class to look
//				at penStatus member
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: penStatus
//  Data Members Modified: penStatus
//  Functions Called: none
//
//***********************************************************************************
bool pen::currentPen()
{
	return penStatus; //returns value in penStatus
}

//***********************************************************************************
//
//	Function Name: currentHead
//  Purpose: Allows for functions outside of the pen class to look
//				at penHead member
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: penHead
//  Data Members Modified: penHead
//  Functions Called: none
//
//***********************************************************************************
char pen::currentHead()
{
	return penHead; //returns value in penHead
}

//***********************************************************************************
//
//	Function Name: clear
//  Purpose: Re-constructor, intialize penStatus and penHead back to default
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: penStatus, penHead
//  Data Members Modified: penSatus, penHead
//  Functions Called: none
//
//***********************************************************************************
void pen::clear()
{
	penStatus = false; 
	penHead = '+'; //sets both back to default
	return;
}