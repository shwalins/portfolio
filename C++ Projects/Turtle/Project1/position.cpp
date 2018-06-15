//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Program Name: Project1
//  Program File: position.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: position.h
//  Purpose: Holds all the definitions for the functions in the position class
//			 in the position.h file.
//
//***********************************************************************************

#include "position.h" //where the class is located

//***********************************************************************************
//
//	Function Name: position
//  Purpose: Constructor
//  Parameters:
//		Input: none
//		Output: map
//	Return Value: none
//  Data Members Accessed: xpos, ypos, map
//  Data Members Modified: xpos, ypos, map
//  Functions Called: none
//
//***********************************************************************************
position::position()
{
	xpos = 0; 
	ypos = 0; //intializes the turtles position in the array
	for(int i = 0; i < 20; i++)
	{for(int j = 0; j < 20; j++)
	{map[i][j] = '0';}} //initializes a 20 x 20 array of 0s
	map[0][0] = '#'; //sets turtle's default position
    return;
}

//***********************************************************************************
//
//	Function Name: display
//  Purpose: displays the map
//  Parameters:
//		Input: none
//		Output: map
//	Return Value: none
//  Data Members Accessed: map
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
void position::display()
{
	for(int i = 0; i < 20; i++) //for loop for y position
	{for(int j = 0; j < 20; j++) // for loop for x position
	{cout << map[i][j];}  
	cout << endl;} //displays map
    return;
}

//***********************************************************************************
//
//	Function Name: jump
//  Purpose: jumps turtle from its current position to new position on the map
//			     that is provided by user
//  Parameters:
//		Input: int, int, char
//		Output: map
//	Return Value: none
//  Data Members Accessed: map, xpos, ypos
//  Data Members Modified: map, xpos, ypos
//  Functions Called: none
//
//***********************************************************************************
void position::jump(int x, int y, char pen)
{
	x = x - 1;  
	y = y - 1;  //subtracts 1 so it corresponds to array location
	map[ypos][xpos] = pen; //marks the turtle's prev location with the pen
	map[y][x] = '#'; //moves turtle to new location
	ypos = y; 
	xpos = x; //turtles new position is kept tract of
	return;
}

//***********************************************************************************
//
//	Function Name: currx
//  Purpose: Allows for functions outside of the position class to look
//				at xpos member
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: xpos
//  Data Members Accessed: xpos
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
int position::currx()
{
	return xpos; //returns value in xpos
}

//***********************************************************************************
//
//	Function Name: curry
//  Purpose: Allows for functions outside of the position class to look
//				at ypos member
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: ypos
//  Data Members Accessed: ypos
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
int position::curry()
{
	return ypos; //returns value in ypos
}

//***********************************************************************************
//
//	Function Name: move
//  Purpose: Moves the turtle forward based on its current direction, and
//         number of spaces provided by user. Also marks the locations the turtle
//			has been if the pen is down.
//  Parameters:
//		Input: int, char, char
//		Output: map
//	Return Value: none
//  Data Members Accessed: map, xpos, ypos
//  Data Members Modified: map, xpos, ypos
//  Functions Called: none
//
//***********************************************************************************
void position::move(int distance, char pen, char face)
{
	int temp; //temp variable 

	if (face == 'n') //if the turtle is facing north
	{temp = (ypos - distance);  //temp becomes about of available spaces
	for (int i = ypos; i > temp; i--) //until i is greater than temp
	{map[i][xpos] = pen;} //where the turtle was becomes marked
	map[temp][xpos] = '#'; //the turtles new location is marked
	ypos = temp;} //the new location is kept track of

	if (face == 'e') //if the turtle is facing east
	{temp = (xpos + distance);  //temp becomes the amount of available spaces
	for (int i = xpos; i < temp; i++) //until i is less than temp
	{map[ypos][i] = pen;} //where turtle was becomes marked
	map[ypos][temp] = '#'; //the turtles new location is marked
	xpos = temp;} //the new location is kept track of

	if (face == 's') //if the turtle is facing south
	{temp = (ypos + distance);   //temp becomes the amount of available spaces
	for (int i = ypos; i < temp; i++) //where turtle was becomes marked
	{map[i][xpos] = pen;}  //where turtle was becomes marked
	map[temp][xpos] = '#'; //the turtles new location is marked
	ypos = temp;} //the new location is kept track of

	if (face == 'w') //if the turtle is facing west
	{temp = (xpos - distance);   //temp becomes the amount of available spaces
	for (int i = xpos; i > temp; i--) //where turtle was becomes marked
	{map[ypos][i] = pen;}  //where turtle was becomes marked
	map[ypos][temp] = '#'; //the turtles new location is marked
	xpos = temp;} //the new location is kept track of
}

//***********************************************************************************
//
//	Function Name: clear
//  Purpose: Re-constructor, intialize map, xpos, and ypos back to default
//  Parameters:
//		Input: none
//		Output: map
//	Return Value: none
//  Data Members Accessed: map, xpos, ypos
//  Data Members Modified: map, xpos, ypos
//  Functions Called: none
//
//***********************************************************************************
void position::clear()
{
	xpos = 0; 
	ypos = 0; //re-intializes the turtles position in the array
	for(int i = 0; i < 20; i++)
	{for(int j = 0; j < 20; j++)
	{map[i][j] = '0';}} //re-initializes the array
	map[0][0] = '#'; //re-sets turtle's default position
    return;
}