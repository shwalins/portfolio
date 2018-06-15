//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 5/14/14
//  Program Name: P4
//  Program File: cs132_P$_driver.cpp
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: PQueue.h, defs.h
//  Purpose: To create a priority queue, which reads in items and adds them to a heap
//				to where it orders the items based on priority.
//
//************************************************************************************
#include "PQueue.h"
#include "defs.h"
#include <iostream>
using namespace std;

int main()
{
	int choice = 0;
	PriorityQueue<Person> A(50, priority);
	Person temp;

	while(choice != 5)
	{
	cout << "1:	Add to Queue" << endl << "2:	Remove from Queue" << endl 
		<< "3:	Print Normal" << endl << "4:	Print Preorder" << endl
		<< "5:	Exit" << endl << endl;
	cin >> choice;
	cout << endl;

	if(choice == 1)
	{
	cout << "Enter this Person's Priority: ";
	cin >> temp.hasPriority;
	cout << endl << "Enter this Person's Name: ";
	cin >> temp.name;
	cout << endl;
	A.add(temp);}

	if(choice == 2)
	{A.dequeue();}
	
	if(choice == 3)
	{cout << "Normal Order:" << endl << endl;
	A.Print();
	cout << endl;}

	if(choice == 4)
	{cout << "PreOrder:" << endl << endl;
	A.preorder(1);
	cout << endl;}
	}
	return 0;
}