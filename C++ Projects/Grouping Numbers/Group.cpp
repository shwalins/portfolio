// Lab 11
// 12/4/13

#include <iostream>

using namespace std;

class group
{
	public:
		int smallest();		// function to find the smallest element of the array
		int biggest();		// function to find the biggest element of the array
		int position(int);	// function which returns the position of the parameter value
		                    // (-1 if not in the array)
		void assignVals();	// function which asks the user for values to put in the array
		void printVals();	// function which prints the values in the array
		group();			// The default constructor,
		                    // every element of the array will be set to zero
		group(int);			// constructor which sets every element of the array to the parameter
	private:
		static const int SIZE = 10;  // Initializes the constant SIZE to 10 
									 // EVERY time an object of this type is created
		int members[SIZE];			 // an array of integers
};

int main()
{
	int num, pos;

	group numbers;
	group numbers2(5);
	
	numbers.printVals();
	numbers2.printVals();

	numbers.assignVals();
	numbers2.assignVals();

	cout << "What number are you looking for? ";
	cin >> num;
	pos = numbers.position(num);
	if(pos == -1)
		cout << "The number " << num <<  "is not in the first group\n";
	else
		cout << "The number " << num <<  "is at position " << pos << " of the first group\n";

	pos = numbers2.position(num);
	if(pos == -1)
		cout << "The number " << num << " is not in the second group\n";
	else
		cout << "The number " << num << " is at position " << pos << " of the second group\n";

	cout << "The smallest value in the group is: " << numbers.smallest() << endl;
	cout << "The largest value in the group is: " << numbers.biggest() << endl;
 	cout << "The smallest value in the second group is: " << numbers2.smallest() << endl;
	cout << "The largest value in the second group is: " << numbers2.biggest() << endl;

	numbers.printVals();
	numbers2.printVals();

	return 0;
}


// You need to define the 2 constructors AND the member functions of the class 'group'.
group::group()
{for(int i = 0; i < 10; i++)
	{members[i] = 0;} }

group::group(int num)
{
	for(int i = 0; i < 10; i++)
	{members[i] = num;} }


void group::printVals()
{
	for(int i = 0; i < 10; i++)
	{cout << members[i];}
}

void group::assignVals()
{
	for(int i = 0; i < 10; i++)
	{cin >> members[i];}
}

int group::position(int num)
{
	for(int i = 0; i < 10; i++)
	{if(members[i] == num)
	{return i;}
	else return -1;
	}
}

int group::biggest()
{
	int num = 1;

	return num;
}

int group::smallest()
{
	int num = 1;
	return num;
}