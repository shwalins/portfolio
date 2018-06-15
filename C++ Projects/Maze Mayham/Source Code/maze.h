//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 4/23/14
//  Program Name: P3
//  Program File: maze.h
//  Input Files: User Defined
//  Output Files: none
//  Modules Used: list/STL
//  Purpose: Class that holds all the functions 
//
//************************************************************************************
#ifndef MAZE_H_
#define MAZE_H_

#include <iostream>
#include <string>
#include <fstream>
#include <list>
using namespace std;

class mazemadness				
{
public:
	void print();				//prints maze
	void input();				//gets the file and reads it in
	bool solve();				//starts the algorithm
	void start();				//gets starting postion
	bool goodSpace(int, int);	//checks for good space
	void check(int, int);		//checks all spaces around current postion
	void move(int, int);		//moves to new position
	void backTrack();			//moves backwards if needed
	void results();				//displays results
	list<int> X;				//stack for x coordinates
	list<int> Y;				//stack for y coordinates
private:
	char maze[12][12];			//the maze
	int currentX;				//keeps track of x position
	int currentY;				//keeps track of y position
	bool win;					//keeps track of if maze is solved
	bool lose;					//keeps track of if maze can't be solved
};

#endif