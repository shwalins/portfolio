//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Program Name: Project1
//  Program File: direction.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: direction.h
//  Purpose: Holds all the definitions for the functions in the direction class
//			 in the direction.h file.
//
//***********************************************************************************

#include "direction.h" //where the class is located

//***********************************************************************************
//
//	Function Name: direction
//  Purpose: Constructor
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: face
//  Data Members Modified: face
//  Functions Called: none
//
//***********************************************************************************
direction::direction()
{
	face = 'e'; //initializes turtle to face "east"
}

//***********************************************************************************
//
//	Function Name: change
//  Purpose: Asks user which way to turn the turtle, and "turns" it based on input
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: face
//  Data Members Modified: face
//  Functions Called: none
//
//***********************************************************************************
void direction::change()
{
	int choice; //initializes choice for user input
	cout << "Turn left or right?" << endl
		 << "1: Left" << endl << "2: Right" << endl; //asks user which way to turn
	
	cin >> choice;
	while ((choice != 1) && (choice != 2)) //input validation loop
	{cout << "Invalid Option" << endl;
	cin >> choice;}
	
	if (choice == 1) //if user chooses 1,
	{ if (face == 'e')
			{face = 'n';}
	  else if (face == 'n')
			{face = 'w';}
	  else if (face == 'w')
			{face = 's';}
	  else 
			{face = 'e';}} //the turtle turns left of the direction
						// based on which way it is currently
	
	if (choice == 2) //if user chooses 2
	{ if (face == 'e')
			{face = 's';}
	  else if (face == 's')
			{face = 'w';}
	  else if (face == 'w')
			{face = 'n';}
	  else 
			{face = 'e';}} //the turtle turns right of the direction
						// based on which way it is currently

	cout << "The turtle is now facing "; //displays the changed direction to the user
	if (face == 'n')
		cout << "north." << endl;
	if (face == 'e')
		cout << "east." << endl;
	if (face == 's')
		cout << "south." << endl;
	if (face == 'w')
		cout << "west." << endl;
	return; //end of function
}

//***********************************************************************************
//
//	Function Name: current
//  Purpose: Allows for functions outside of the direction class to look
//				at face member
//  Parameters: none
//		Input: none
//		Output: none
//	Return Value: char stored in face
//  Data Members Accessed: face
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
char direction::current()
{
	return face; //returns the character in face
}

//***********************************************************************************
//
//	Function Name: clear
//  Purpose: Act as a reconstructor, intializing face back to default
//  Parameters: none
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: face
//  Data Members Modified: face
//  Functions Called: none
//
//***********************************************************************************
void direction::clear()
{
	face = 'e'; //reinitalizes face back to "east"
	return;
}