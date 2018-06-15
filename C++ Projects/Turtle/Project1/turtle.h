#ifndef TURTLE_H_
#define TURTLE_H_

//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Class Name: turtle
//	Class File: turtle.h
//  Structure: class
//	Purpose: Used to run and drive all the functions in the program
//	Other Classes Used: position, pen, direction
//
//  Member Fuctions:
//		void command1 - call other functions to change pen position
//		void command2 - calls other function to change direction
//		void command3 - calls other functions to move turtle forward
//		void command4 - calls other function to display map
//		void command5 - calls other function to change pen brush
//		void command6 - calls other functions to start program from beginning
//		void command7 - calls other functions to move turtle to different position
//		void current - calls other functions to display the turtles status
//
//***********************************************************************************

#include <iostream>
#include "position.h"
#include "pen.h"
#include "direction.h"
using namespace std;

class turtle
{
	position Turtlepos;
	pen Turtlepen;
	direction Turtledirec;

public:
	void command1(); // change pen position
	void command2(); // turn
	void command3(); // move forward
	void command4(); // display map
	void command5(); // change brush
	void command6(); // start over
	void command7(); // jump
	void current();
};

#endif