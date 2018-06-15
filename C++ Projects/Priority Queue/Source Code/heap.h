

#ifndef HEAP_H
#define HEAP_H

#include "BTree_array.h"
#include <cstdio>


 // overloaded < needed

template <class BaseData>
class Heap : public BinTree<BaseData>
{
  protected:

    // walkUp and walkDown are subordinate functions used by add 
    // and remove respectively

    void walkUp(int nodeIndex);
    void walkDown(int nodeIndex);

  public:          
  
    Heap (int maxNodes, bool (*precedes)(const BaseData& x, const BaseData& y));
    Heap(const Heap<BaseData> & initHeap);
    virtual void add (BaseData item);
    virtual BaseData remove();
	bool (*precedes)(const BaseData& x, const BaseData& y);
};







#include "heap.t"


#endif







