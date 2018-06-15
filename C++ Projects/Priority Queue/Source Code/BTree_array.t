
#include "array_v.h"
#include <stdio.h>

#ifndef BTREE_ARRAY_T_
#define BTREE_ARRAY_T_

#include <iostream>
using std::cout;


template <class BaseData>
void BinTree<BaseData>::print()
 {
    for (int i=1;i<=maxAllowed;i++)
   cout <<  (*nodes)[i] << '\t';
   cout << endl;
 }

// Interface for alternate binary tree constructor
// GIVEN:   An uninitialized binary tree object;
//          maxNodes ©© a positive integer.
// RETURN:  The binary tree object is initialized to an empty
//          tree with the capacity to store maxNodes nodes.

template <class BaseData>
BinTree<BaseData>::BinTree(int maxNodes)
{
  numNodes = 0;                             // currently no nodes in tree
  maxAllowed = maxNodes;                    // no more than maxNodes allowed
  nodes = new Array_V<int,BaseData>(1,maxNodes);   // allocate array with
  // maxNodes nodes
  assert (nodes != 0);
}

template <class BaseData>
BinTree<BaseData>::BinTree(const BinTree<BaseData> & initBinTree)
{
  numNodes=initBinTree.numNodes;
  maxAllowed=initBinTree.maxAllowed;
  nodes=new Array_V<int, BaseData>(1,maxAllowed);
  assert(nodes !=0);
  for (int i=1;i<=maxAllowed;i++)
    (*nodes)[i]=(*initBinTree.nodes)[i];
}

template <class BaseData>
void BinTree<BaseData>::operator =(const BinTree<BaseData> & initBinTree)
{
  numNodes=initBinTree.numNodes;
  maxAllowed=initBinTree.maxAllowed;
  delete nodes;
  nodes=new Array_V<int, BaseData>(1,maxAllowed);
  assert(nodes !=0);
  for (int i=1;i<=maxAllowed;i++)
    (*nodes)[i]=(*initBinTree.nodes)[i];
}

// Interface for binary tree destructor
// GIVEN:   A previously initialized binary tree object.
// RETURN:  All storage associated with the binary tree is
//          deallocated.
template<class BaseData>
BinTree<BaseData>::~BinTree()
{}

// Interface for empty operation
// GIVEN:   A previously initialized binary tree object.
// RETURN as value of function:  TRUE if the binary tree is
//                               empty, FALSE otherwise.
template<class BaseData>
bool BinTree<BaseData>::empty()
{
  if (numNodes==0) return(true);
  else return(false);
}



// GIVEN:   A previously initialized binary tree object.
// RETURN as value of function:  TRUE if the binary tree will allow no further
//                               additions, FALSE otherwise.
template<class BaseData>
bool BinTree<BaseData>::full()
{
  if (numNodes==maxAllowed) return(true);
  else return(false);
}



// Interface for pure virtual add operation
// GIVEN:   A binary tree object;
//          item ©© of type BaseData.
// RETURN:  item is added to the binary tree according to the
//          hierarchical property that defines the tree.
// RETURN as value of function: void
// NOTE:    This is a "pure virtual" function that must be
//          overridden.

// virtual void add(BaseData item) = 0;

/*
template<class BaseData>
void BinTree<BaseData>::preorderTrav(BinTree<BaseData> *p)
{ 
	
}

*/






















#endif
////////////////////////////////////////////////////////////////

