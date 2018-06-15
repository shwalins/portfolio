#ifndef POSITION_H_
#define POSITION_H_

//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Class Name: position
//	Class File: position.h
//  Structure: class
//	Purpose: Used to keep track of and change the turtles position
//	Other Classes Used: none
//
//	Data Members: 
//		int xpos - used to keep track of the turtles x position
//      int ypos - used to keep track of the turtles y position
//      char map[20][20] - used as the map for the program 
//
//  Member Fuctions:
//		position - constructor
//		void display - displays the map
//		void jump - reads in new coordinates and changes turtles position to them
//		void clear - re-constructor
//		void move - reads in coordinates and direction and moves turtle based on them
//		int currx - returns the value of xpos to be used by other functions
//		int curry - returns the value of ypos to be used by other functions
//
//***********************************************************************************

#include <iostream>
using namespace std;

class position
  {
  public:
	position();	//constructor
	void display();
	void jump(int, int, char); // add a char for brush
	void clear();
	void move(int, char, char);
	int currx();
	int curry();
  private:
    char map[20][20];
	int xpos;
	int ypos;
  };

#endif