


#ifndef HEAP_T_
#define HEAP_T_


#include <cstdio>


 // overloaded < needed




 //--------------------------------------------------------
  // Interface for Heap constructor
  // GIVEN:   An uninitialized Heap object,
  //          maxNodes -- the maximum number of nodes allowed in 
  //                      the heap
  //          precedes -- a function to compare BaseData values:
  //             GIVEN:   x and y -- values to compare
  //             RETURN as function value:
  //                 TRUE     if x < y,
  //                 FALSE    if x and y are =, or
  //                          if y < x
  // RETURN:  The Heap object is initialized to the empty tree 
  //          with the capacity to store maxNodes data nodes and 
  //          with precedes establishing the hierarchical ordering
  //          of the tree










  

template <class BaseData>
Heap<BaseData>::Heap(int maxNodes, bool (*precedes)(const BaseData& x, const BaseData& y))
	  : BinTree<BaseData> (maxNodes)
{
  this->precedes = precedes;       // set precedes to precedence
				  // relationship for tree
}

template <class BaseData>
Heap<BaseData>::Heap(const Heap<BaseData> & initHeap)
 :BinTree<BaseData> (initHeap)
 {
  precedes=initHeap.precedes;
 }

template <class BaseData>
void Heap<BaseData>::walkUp(int nodeIndex)
{
  int l,k;
  BaseData key;

  l = nodeIndex;
  key = (*nodes)[l];    // key compared to values along appropriate
								// path in tree
  k = l / 2;            // initially k references parent of key
  while (k > 0)         // continually try new parents for key
	 if (precedes((*nodes)[k], key))
	 {
      (*nodes)[l] = (*nodes)[k];         
      l = k;                             
      k = l / 2;                         
    }                                
    else                             
      break;                            
  (*nodes)[l] = key;
}

template <class BaseData>
void Heap<BaseData>::add(BaseData item)
{
  if (numNodes < maxAllowed)
  {
    numNodes++;
    (*nodes)[numNodes] = item;
    walkUp(numNodes);
  }
}
template <class BaseData>
void Heap<BaseData>::walkDown(int nodeIndex)
{
  int l,k;
  BaseData key;

  l = nodeIndex;
  key = (*nodes)[l];   // key compared to values along appropriate 
                       // path in tree
  k = 2*l;             // initially k references left child
  while (k <= numNodes)
  {
    if (k < numNodes)   // then have k reference largest child
      if (precedes((*nodes)[k], (*nodes)[k+1]))
        ++k;
    if (precedes(key, (*nodes)[k]))  // then child must move up
   {                                                              
   (*nodes)[l] = (*nodes)[k];                                   
   l = k;                                                      

    k = 2*l;
   }
  else                            // appropriate spot has been found 
      break;
 }
  (*nodes)[l] = key;
}
template <class BaseData>
BaseData Heap<BaseData>::remove()
{
  BaseData temp;

  assert (numNodes > 0);  // verify pre©condition that heap is non©empty  
  temp = (*nodes)[1];
  (*nodes)[1] = (*nodes)[numNodes];
  numNodes--;
  walkDown(1);
  return(temp);
}

































/*
template <class BaseData>
Heap<BaseData>::Heap(int maxNodes) : BinTree<BaseData> (maxNodes)
{
 
}



//  copy constructor

template <class BaseData>
Heap<BaseData>::Heap(const Heap<BaseData> & initHeap)
 :BinTree<BaseData> (initHeap)
 {
 
 }





template < class BaseData>
void Heap<BaseData>::walkUp(int nodeIndex)
{
  int l,k;
  BaseData key;

  l = nodeIndex;
 // key =  (*nodes)[l];    // key compared to values along appropriate
 						// path in tree	
						
    key =  ( *(BinTree<BaseData>::nodes) )[l];  					
						
							
  k = l / 2;            // initially k references parent of key
  while (k > 0)         // continually try new parents for key
	 if (   ( *(BinTree<BaseData>::nodes) )[k] <  key  )
	 {
      (   ( *(BinTree<BaseData>::nodes) ))[l] = ( ( *(BinTree<BaseData>::nodes) ))[k];         
      l = k;                             
      k = l / 2;                         
    }                                
    else                             
      break;                            
  ( ( *(BinTree<BaseData >::nodes) ))[l] = key;
}

template < class BaseData>
void Heap<BaseData>::add(BaseData item)
{
  if (  BinTree<BaseData>::numNodes <  BinTree<BaseData>::maxAllowed)
  {
     BinTree<BaseData>::numNodes++;
    ( ( *(BinTree<BaseData >::nodes) ))[  BinTree<BaseData>::  numNodes] = item;
    walkUp(  BinTree<BaseData>:: numNodes);
  }
}




// Interface for walkDown function
// The nodes array is viewed as a dense binary tree, with all indices
// between 1 and numNodes containing tree data.  The nodes array is
// modified so that data originally at nodeIndex is "walked down" a
// path in the tree; that is, repeatedly exchanged with the larger of
// its children until it is greater than its children according to the
// precedence relation for the tree.
// This is phase 1 of R.W. Floyd's heap sort algorithm orginally 
// presented in Communications of the ACM (December 1964) under 
// the title "Alogorithn 245: Tree Sort 3"

template < class BaseData>
void Heap<BaseData>::walkDown(int nodeIndex)
{
  int l,k;
  BaseData key;

  l = nodeIndex;
  key = ( ( *(BinTree<BaseData >::nodes) ))[l];   // key compared to values 
                                                  // along appropriate  path in tree
  k = 2*l;                                        // initially k references left child
  while (k <=  BinTree<BaseData>::numNodes)
  {
    if (k <  BinTree<BaseData>::numNodes)   // then have k reference largest child
      if ( ( ( *(BinTree<BaseData>::nodes) ))[k] < 
                               ( ( *(BinTree<BaseData>::nodes) ))[k+1] )
        ++k;
    if ( key < ( ( *(BinTree<BaseData>::nodes) ))[k] )  // then child must move up
   {                                                              
   ( ( *(BinTree<BaseData>::nodes) ))[l] = 
                         ( ( *(BinTree<BaseData>::nodes) ))[k];                                   
   l = k;                                                      

    k = 2*l;
   }
  else                            // appropriate spot has been found 
      break;
 }
  ( ( *(BinTree<BaseData >::nodes) ))[l] = key;
}



template < class BaseData>
BaseData Heap<BaseData>::remove()
{
  BaseData temp;

  assert ( BinTree<BaseData >::numNodes > 0);  // verify pre©condition that heap is non©empty  
  temp = ( ( *(BinTree<BaseData >::nodes) ))[1];
  (( *(BinTree<BaseData >::nodes) ))[1] = 
              ( ( *(BinTree<BaseData >::nodes) ))[ BinTree<BaseData >::numNodes];
   BinTree<BaseData >::numNodes--;
  walkDown(1);
  return(temp);
}
*/


#endif

















