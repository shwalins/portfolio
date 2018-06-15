//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 4/23/14
//  Program Name: P3
//  Program File: maze.cpp
//  Input Files: User Defined
//  Output Files: none
//  Modules Used: maze.h
//  Purpose: Holds all the function definitions for the program.
//
//************************************************************************************
#include "maze.h"

//***********************************************************************************
//
//	Function Name: input
//  Purpose: Reads in the maze from a file, and initializes the array using the file
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: win, lose, maze
//  Data Members Modified: win, lose, maze
//  Functions Called: none
//
//***********************************************************************************
void mazemadness::input()
{
	ifstream infile;
	char location[100];
	char in;
	cout << endl << endl << "Enter the location of the file: ";
	win = false;
	lose = false;									//initializes variables needed

	cin >> location;
	infile.open(location);							//reads in location of the file	

	if(!infile)
	{cout << endl << "Invalid File." << endl;		//exits if invalid file
	exit(0);}								

	for(int i = 0; i < 12; i++)
	{
		maze[0][i] = 219;
		maze[11][i] = 219;
		maze[i][0] = 219;
		maze[i][11] = 219;							//creates the wall for maze
	}

	for(int i = 1; i < 11; i++)
	{for(int j = 1; j < 11; j++)
	{	
		infile >> in;								//reads in character from file
		if(in == '1')
		{in = 219;}									//if 1, its a wall
		else if(in == '0')
		{in = ' ';}									//if 0, its an open space
		maze[i][j] = in;								
	}}
	cout << endl << "File Uploaded." << endl;
	infile.close();									//closes the file
return;
}

//***********************************************************************************
//
//	Function Name: print
//  Purpose: Displays the list in its current state
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: maze
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
void mazemadness::print()
{
	for(int i = 0; i < 12; i++)
	{for(int j = 0; j < 12; j++)
	{cout << maze[i][j];}
	cout << endl;}									//loop to print the maze 
	return;
}

//***********************************************************************************
//
//	Function Name: start
//  Purpose: Prepares the program to solve the maze, and gets starting position
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: currentX, currentY
//  Data Members Modified: currentX, currentY
//  Functions Called: none
//
//***********************************************************************************
void mazemadness::start()
{
	int startx, starty, done = 0;
	char wall = 219;								//ascii for wall character		

	while(done == 0)								//loop for starting position
	{cout << endl << "Enter your starting position:" 
	<< endl << "X: ";
	cin >> startx;									//reads in starting x
	while(startx > 10 || startx < 1)
	{cout << "Out of range, try again: ";
	cin >> startx;}									//checks it/failsafe
	cout << "Y: ";
	cin >> starty;									//reads in starting y
	while(starty > 10 || starty < 1)
	{cout << "Out of range, try again: ";
	cin >> starty;}									//checks it/failsafe

	if(maze[starty][startx] == wall)
	{cout << "Wall located here, try again.";}		//checks for wall, repeats
	else {currentX = startx;						//if needed.
		  currentY = starty;						//assigns with starting pos.
		  done = 1;}								//if spot is good, loop is done
	}
	return;
}

//***********************************************************************************
//
//	Function Name: solve
//  Purpose: Mother function that runs the algoirthm to solve the maze.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: bool
//  Data Members Accessed: maze, currentX, currentY, win, lose
//  Data Members Modified: maze, currentX, currentY
//  Functions Called: check
//
//***********************************************************************************
bool mazemadness::solve()
{
	bool go = 1;
	while(go)						//initializes a variable to start loop
	{
		if(maze[currentY][currentX] == 'E')
		{win = true;				//checks if current space is exit
		return true;}				
		check(currentX, currentY);	//reads in position and checks spaces around it
		if(win == true)
		{return true;}				//if maze is solved, return true
		else if(lose == true)
		{return false;}				//else if maze isn't solved, return false
	}
}

//***********************************************************************************
//
//	Function Name: check
//  Purpose: Loop to check all the spaces around the current postion. Moves in a right,
//				down, left, up (clockwise) direction. If a space is good, it moves there.
//				if all spaces are bad, then it backtracks.
//  Parameters:
//		Input: int x, int y
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: goodSpace, move, backTrack
//
//***********************************************************************************
void mazemadness::check(int x, int y)
{
	if(goodSpace(x+1,y))			//checks one up east
		move(x+1,y);	
	else if(goodSpace(x,y+1))		//checks one up south
		move(x,y+1);
	else if(goodSpace(x-1,y))		//checks one up west
		move(x-1,y);
	else if(goodSpace(x,y-1))		//checks one up north
		move(x,y-1);				//if good, move to that space
	else backTrack();				//if all bad, backtrack one space

	return;
}

//***********************************************************************************
//
//	Function Name: goodSpace
//  Purpose: Checks to see if the current space is accessible, and if its the win
//				space, and returns true or false based on this.
//  Parameters:
//		Input: int x, int y
//		Output: none
//	Return Value: bool
//  Data Members Accessed: maze
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
bool mazemadness::goodSpace(int x, int y)
{
	if(maze[y][x] == ' ')				//if space is whitespace
	{return true;}						//the space is good
	else if(maze[y][x] == 'E')			//if its a win sapce,
	{win = true;						//the maze is solved, and space is good
	return true;}
	else								//anything else, the space is bad
	{return false;}

}

//***********************************************************************************
//
//	Function Name: move
//  Purpose: Move in the direction based on the read in values.
//  Parameters:
//		Input: int x, int y
//		Output: none
//	Return Value: none
//  Data Members Accessed: list x, list y, maze, currentX, currentY
//  Data Members Modified: list x, list y, maze, currentX, currentY
//  Functions Called: none
//
//***********************************************************************************
void mazemadness::move(int x, int y)
{
	X.push_back(x);						//adds the new postion to the stack
	Y.push_back(y);
	maze[y][x] = '*';					//marks the new postion
	currentX = x;		
	currentY = y;						//assigns the new postion 
	return;
}

//***********************************************************************************
//
//	Function Name: backTrack
//  Purpose: Moves backwards until a valid accessible space can be found. Otherwise,
//					the maze cannot be solved (stack is empty)
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: list x, list y, maze, lose, currentX, currentY
//  Data Members Modified: list x, list y, maze, lose, currentX, currentY
//  Functions Called: none
//
//***********************************************************************************
void mazemadness::backTrack()
{
	maze[currentY][currentX] = '!';			//assigns current space to indicate backtrack
	X.pop_back();
	Y.pop_back();							//pops stack to move backwards
	if(X.empty())	
	{lose = true;							//if the stack is empy, the maze is unsolvable
	return;}
	currentX = X.back();					//assign current postion with the backed space
	currentY = Y.back();
	return;
}

//***********************************************************************************
//
//	Function Name: results
//  Purpose: Tells user whether the maze could be solved. Also replaces backtrack
//				spaces with white space and reprints the maze.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: maze, win, lose
//  Data Members Modified: maze
//  Functions Called: print
//
//***********************************************************************************
void mazemadness::results()
{
	if(win == true)
	{cout << endl << "I am FREE!" << endl << endl;}		//tells user maze was solved

	else if(lose == true)
	{cout << endl << "I am TRAPPED!" << endl << endl;}	//tells user maze wasn't solved

	for(int i = 0; i < 12; i++)
	{for(int j = 0; j < 12; j++)
	{if(maze[i][j] == '!')								//runs through array and replaces
	{maze[i][j] = ' ';}}}								//backtrack spaces with whitespace

	print();											//calls print to reprint maze
	return;	
}