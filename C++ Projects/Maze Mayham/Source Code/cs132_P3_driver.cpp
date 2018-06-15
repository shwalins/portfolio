//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 4/23/14
//  Program Name: P3
//  Program File: cs132_P3_driver.cpp
//  Input Files: User Defined
//  Output Files: none
//  Modules Used: maze.h
//  Purpose: To read in a maze or set of mazes, and solve the maze(s) based upon
//				the starting location specified. Program also utilizes the algorithm to
//				find the best path to the exit while telling the user whether the maze
//				was solved or not, and showing the solved path.
//
//************************************************************************************
#include "maze.h"

int main()
{
	int i = 1;									//variable to intialize loop
	while(i == 1)
	{
	mazemadness maze;							//intialize the class

	maze.input();								//function for input		
	
	maze.print();								//function to print maze

	maze.start();								//function to get starting point
	
	maze.solve();								//function that solves the maze

	maze.results();								//function to ready and display results

	cout << endl << "Go again?" << endl
	<< "1: Yes" << endl << "2: No" << endl;
	cin >> i;									//loop to keep program running
	}
	return 0;
}