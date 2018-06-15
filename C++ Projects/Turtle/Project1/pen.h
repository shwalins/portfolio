#ifndef PEN_H_
#define PEN_H_

//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Class Name: pen
//	Class File: pen.h
//  Structure: class
//	Purpose: Used to keep track of and change the turtles pen
//	Other Classes Used: none
//
//	Data Members: 
//		bool penStatus - keeps track of whether the pen is up or down
//		char penHead - keeps track of the current brush
//
//  Member Fuctions:
//		pen - constructor
//		bool penPosition - toggles the pen between up and down - returns its status
//		void penStyle - changes the brush
//		void clear - re-constructor
//		bool currentPen - returns the value of penStatus to be used by other functions
//		char currentHead - returns the value of penHead to be used by other functions
//
//***********************************************************************************

#include <iostream>
using namespace std;

class pen
{
public:
	pen();
	bool penPosition();
	void penStyle();
	void clear();
	bool currentPen();
	char currentHead();
private:
	bool penStatus;
	char penHead;
};

#endif