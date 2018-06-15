// Note: uses  BOOLEAN (priority)(const BaseData & x, const BaseData & y);
// which returns if x has >= priority than y

#ifndef PQUEUE_T_
#define PQUEUE_T_

//------------------------------------------------------------------
// Interface for priority queue constructor:
// GIVEN:    An uninitialized priority queue object; 
//           priority -- an integer-valued function that will be used to
//           prioritize items in the queue.
// RETURN:   Priority queue object initialized to an empty queue with priority as
//             underlying priority function.

template <class BaseData>
PriorityQueue<BaseData>::PriorityQueue(int maxNodes,  bool (*priority)(const BaseData & x, const BaseData & y)):Heap(maxNodes, priority)
{
}

//------------------------------------------------------------------
// Interface for priority queue destructor:
// GIVEN:    A previously allocated priority queue object
// RETURN:   Priority queue object deallocated

template<class BaseData>
PriorityQueue<BaseData>::~PriorityQueue()
{
}

//------------------------------------------------------------------
// Interface for front operator:
// GIVEN:    A non-empty priority queue object.
// RETURN as value of function: the data of type BaseData that is being
//                              stored at the front node of the queue.  The
//                              front node of the queue is the node with
//                              the highest priority value.  If there is more
//                              than one node with this value, the front node
//                              is the one among all such nodes that has been
//                              in the queue for the longest time.

template <class BaseData>
BaseData PriorityQueue<BaseData>::front()
{
}

//------------------------------------------------------------------
// Interface for empty operator:
// GIVEN:    A priority queue object,
// RETURN value of function: TRUE if no removals can be made from the queue;
//                           FALSE otherwise

template <class BaseData>
bool PriorityQueue<BaseData>::empty()
{
}

//------------------------------------------------------------------
// Interface for full operator:
// GIVEN:    A priority queue object,
// RETURN as value of function: TRUE if no additions can be made to the queue;
//                              FALSE otherwise
template <class BaseData>
bool PriorityQueue<BaseData>::full()
{
}

//------------------------------------------------------------------
// Interface for enqueue operator:
// GIVEN:    A priority queue object that is not full,
//           item -- a data item to inserted into the  queue
// RETURN:   the queue with item inserted in its proper place in the
//           the prority queue as determined by item's priority..
// RETURN as value of function: void
template <class BaseData>  
void PriorityQueue<BaseData>::enqueue (BaseData item)
{
}
  

//***********************************************************************************
//
//	Function Name: dequeue
//  Purpose: Removes first item in the Queue.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: nodes
//  Data Members Modified: n/a
//  Functions Called: remove();
//
//***********************************************************************************
template <class BaseData>
void PriorityQueue<BaseData>::dequeue()
{
	cout << "Person: " << (*nodes)[1] << " Removed" << endl << endl;
	remove();
}


//***********************************************************************************
//
//	Function Name: preorder
//  Purpose: Displays list in PreOrder.
//  Parameters:
//		Input: int
//		Output: none
//	Return Value: none
//  Data Members Accessed: node, numNodes
//  Data Members Modified: none
//  Functions Called: preorder
//
//***********************************************************************************
template <class BaseData> 
void PriorityQueue<BaseData>::preorder(int number)
{
		{cout << (*nodes)[number] << endl;
		if((2 * number) <= numNodes)
		{preorder(2*number);}
		if((2 * number + 1) <= numNodes)
		{preorder(2*number + 1);}}

}

//***********************************************************************************
//
//	Function Name: Print
//  Purpose: Displays Queue.
//  Parameters:
//		Input: none
//		Output: none
//	Return Value: none
//  Data Members Accessed: numNodes, nodes
//  Data Members Modified: none
//  Functions Called: none
//
//***********************************************************************************
template <class BaseData>  
void PriorityQueue<BaseData>::Print()
{
	for (int i=1;i<=numNodes;i++)
   {cout <<  (*nodes)[i] << '\t';
	cout << endl;}
}

#endif