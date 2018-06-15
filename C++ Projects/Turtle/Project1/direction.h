#ifndef DIRECTION_H_
#define DIRECTION_H_

//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Class Name: direction
//	Class File: direction.h
//  Structure: class
//	Purpose: Used to keep track of and change the turtles direction
//	Other Classes Used: none
//
//	Data Members: 
//		char face - keeps track of direction turtle is facing
//
//  Member Fuctions:
//		direction - constructor
//		void change - changes direction of the turtle
//		void clear - re-constructor
//		char current - returns the value in face so that it can be used by other functions
//
//***********************************************************************************

#include <iostream>
using namespace std;

class direction
{
public:
	direction();
	void change();
	void clear();
	char current();
private:
	char face;
};

#endif