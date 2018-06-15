//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Program Name: Project1
//  Program File: cs132_P1_driver.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: turtle.h
//  Purpose: To simulate Logo Language through the control of a "turtle" that
//			 the user can move about on a map and draw on with different symbols.
//
//***********************************************************************************

#include <iostream>
#include "turtle.h"
using namespace std;

int main() //program begins
{
	turtle tort; //initializes the turtle class from turtle.h
	int option = 0; //initializes option variable to be used in while loop

	while (option != 9) //while loop that ends when option is equal to 9
	{
		cout << "Turtle Commands:" << endl << endl
			 << "   1:           change pen position" << endl
			 << "   2:           turn" << endl
			 << "   3:           move foreward" << endl
			 << "   4:           print" << endl
			 << "   5:           change brush" << endl
			 << "   6:           erase/start over" << endl
			 << "   7:           jump" << endl
			 << "   8:           see menu again" << endl
			 << "   9:           end program" << endl << endl; 
								//list of available commands
		tort.current(); //displays turtle's status
		cin >> option; //asks for user to pick a command
		
		while ((option != 8) && (option != 9)) //enters in while loop
		{		//that only ends when user chooses option 8 or 9
		switch (option) //switch statement that will repeat until loop ends
		{	
			case 1:
				tort.command1(); //function call - command #1
				break;
			case 2:
				tort.command2(); //function call - command #2
				break;
			case 3:
				tort.command3(); //function call - command #3
				break;
			case 4:
				tort.command4(); //function call - command #4
				break;
			case 5:
				tort.command5(); //function call - command #5
				break;
			case 6: 
				tort.command6(); //function call - command #6
				break;
			case 7:
				tort.command7(); //function call - command #7
				break;
	/*although command 8 is not listed, when the loop breaks from option = 8,
	the other loop doesnt break, and thus displays the list of commands
	and re-enters the while loop with the switch statement. */
			default:
				break; //any other input just restarts the loop
		}
		tort.current(); //displays turtle's status
		cin >> option; //asks for new input to avoid infinite loop
		}
	}
	return 0; //end of program
}