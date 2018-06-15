
#include "array_v.h"
#include <cstdio>


#ifndef BTREE_ARRAY_H
#define BTREE_ARRAY_H




template < typename BaseData>
class BinTree : public Array_V < int , BaseData >
  {

  public:
    void print();
    int numNodes,maxAllowed;
    Array_V<int, BaseData>* nodes;   // array of data nodes
    BinTree(int maxNodes);  // constructor
    BinTree (const BinTree<BaseData> & initBinTree);  //   copy constructor
    void operator = (const BinTree<BaseData> & initBinTree);// assign
    ~BinTree();
    bool empty();
    bool full();
    virtual void add(BaseData item) = 0;
   // void preorderTrav(void (*processNode)(BaseData& item));
 // void postorderTrav(void (*processNode)(BaseData& item));
 //  void inorderTrav(void (*processNode)(BaseData& item));
  
  };


#include "BTree_array.t"


#endif
