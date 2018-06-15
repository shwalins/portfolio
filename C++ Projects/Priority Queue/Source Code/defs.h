//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 5/14/14
//  Program Name: P4
//  Program File: defs.h
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: n/a
//  Purpose: Structure that holds the persons name and priority, as well as overloaded
//				functions for comparison, and printing the data.
//
//************************************************************************************
#ifndef DEFS_H_
#define DEFS_H_

#include <iostream>

using namespace std;

struct Person
{
char name[20]; // persons name
int hasPriority; // persons priority

bool operator < (const Person &Person1);

friend ostream& operator << (ostream& out, const Person& person);

};

ostream& operator << (ostream& out,  const Person& person) 
{
	out << person.name;
	return out;
}

bool Person::operator < (const Person &Person1)
{
	return (hasPriority < Person1.hasPriority);

}

bool priority(const Person &Person1, const Person &Person2)
{
	return (Person1.hasPriority < Person2.hasPriority);
};

#endif
