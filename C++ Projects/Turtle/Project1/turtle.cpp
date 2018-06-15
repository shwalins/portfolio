//***********************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 2/23/14
//  Program Name: Project1
//  Program File: turtle.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: turtle.h
//  Purpose: Holds all the definitions for the functions in the position class
//			 in the turtle.h file.
//
//***********************************************************************************

#include "turtle.h" //where the class is located

//***********************************************************************************
//
//	Function Name: command1
//  Purpose: Executes command 1 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: penPosition
//
//***********************************************************************************
void turtle::command1()
{
		cout << "The pen is now "; 
		int i = Turtlepen.penPosition(); //i becomes value of penPosition
		if (i == 0)
		{cout << "up." << endl;}
		else
		{cout << "down." << endl;} //displays the pens position based on i's value
		return;
}

//***********************************************************************************
//
//	Function Name: command2
//  Purpose: Executes command 2 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: change
//
//***********************************************************************************
void turtle::command2()
{
		Turtledirec.change(); //calls change function
		return;
}

//***********************************************************************************
//
//	Function Name: command3
//  Purpose: Executes command 3 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: currentPen, currentHead, current, curry, currx, move
//
//***********************************************************************************
void turtle::command3()
{
	int distance;
	int x;
	char pen; //intializes variables to store returned values

	if(Turtlepen.currentPen() == 1)
	{pen = Turtlepen.currentHead();}
	else {pen = '0';} //function call to determine pen character

	cout << "How many spaces?" << endl;
	cin >> distance; //user input for distance
		if(Turtledirec.current() == 'n') //if the direction is north
		{	
			x = Turtlepos.curry(); //stores current y positin in x
			while(x < distance)
			{cout << "Out of bounds" << endl;
			 cin >> distance;} //input validation
			Turtlepos.move(distance, pen, 'n'); //function call
		}

		if(Turtledirec.current() == 'e') //if the direction is east
		{	
			x = Turtlepos.currx(); //stores current x positin in x
			x = (19 - x); 
			while(x < distance)
			{cout << "Out of bounds" << endl;
			 cin >> distance;}  //input validation
			Turtlepos.move(distance, pen, 'e'); //function call
		}
		
		if(Turtledirec.current() == 's') //if the direction is south
		{	
			x = Turtlepos.curry(); //stores current y positin in x
			x = (19 - x);
			while(x < distance)
			{cout << "Out of bounds" << endl;
			 cin >> distance;}  //input validation
			Turtlepos.move(distance, pen, 's'); //function call
		}
		
		if(Turtledirec.current() == 'w') //if the direction is west
		{	
			x = Turtlepos.currx(); //stores current x positin in x
			while(x < distance)
			{cout << "Out of bounds" << endl;
			 cin >> distance;}  //input validation
			Turtlepos.move(distance, pen, 'w'); //function call
		}
		return;
}

//***********************************************************************************
//
//	Function Name: command4
//  Purpose: Executes command 4 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: display
//
//***********************************************************************************
void turtle::command4()
{
		Turtlepos.display(); //display function call
		return;
}

//***********************************************************************************
//
//	Function Name: command5
//  Purpose: Executes command 5 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: penStyle
//
//***********************************************************************************
void turtle::command5()
{
	Turtlepen.penStyle(); //penStyle function call
	return;
}

//***********************************************************************************
//
//	Function Name: command6
//  Purpose: Executes command 6 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: clear, clear, clear
//
//***********************************************************************************
void turtle::command6()
{
	Turtlepos.clear(); 
	Turtlepen.clear();
	Turtledirec.clear(); //clear function call from all three classes

	cout << endl << "Turtle reset." << endl; //display to user that the turtle
											//was reset
	return;
}

//***********************************************************************************
//
//	Function Name: command7
//  Purpose: Executes command 7 from driver file.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: currentPen, currentHead, jump
//
//***********************************************************************************
void turtle::command7()
{
	int x;
	int y;
	char pen; //variables to store returned values

	if(Turtlepen.currentPen() == 1) 
	{pen = Turtlepen.currentHead();}
	else {pen = '0';} //calls function to determine pen

		cout << "Jump to X:";
		cin >> x; //user input for new x position
		while((x < 0) || (x > 20))
			{cout << "Out of bounds" << endl;
			 cin >> x;} //input validation

		cout << "Jump to Y:";
		cin >> y; //user input for new y position
		while((y < 0) || (y > 20))
			{cout << "Out of bounds" << endl;
			 cin >> y;} //input validation

		Turtlepos.jump(x, y, pen); //jump function call 
		cout << "The Turtle has moved to (" << x << "," << y << ")" << endl;
		//message displaying turtles new position
}

//***********************************************************************************
//
//	Function Name: current
//  Purpose: Displays so user can keep track of turtle's position, pen position,
//					turtle's direction, and the pen style.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: none
//  Data Members Modified: none
//  Functions Called: currentPen, currentHead, current, curry, currx
//
//***********************************************************************************
void turtle::current()
{
	cout << "Current Position: (" << (Turtlepos.currx() + 1) << "," 
		<< (Turtlepos.curry() + 1) << ")" << endl << "Current Direction: ";
	//function call to gather turtles position, and display it to user

	if (Turtledirec.current() == 'n')
		cout << "North" << endl;
	if (Turtledirec.current() == 'e')
		cout << "East" << endl;
	if (Turtledirec.current() == 's')
		cout << "South" << endl;
	if (Turtledirec.current() == 'w')
		cout << "West" << endl;
	//function call to gather turtles current direction,
	//then displays it to user

	cout << "Pen Status: ";
	if (Turtlepen.currentPen() == 0)
		cout << "Up" << endl;
	else cout << "Down" << endl;
	//function call to determine the pens current position, and display
	//it to the user

	cout << "Current Brush: " << Turtlepen.currentHead() << endl;
	//function call to determine the current brush, and display
	//it to the user
	return;
}