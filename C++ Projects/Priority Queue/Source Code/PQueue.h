//************************************************************************************
//
//	Programmer: Steven Walinski
//	Instructor: B.J. Streller
//  Course: CS132
//	Date: 5/14/14
//  Program Name: P4
//  Program File: PQueue.h
//  Input Files: n/a
//  Output Files: n/a
//  Modules Used: heap.h
//  Purpose: Class that holds all the function definitions. Inherits from class Heap.
//
//************************************************************************************
#ifndef PQUEUE_H_
#define PQUEUE_H_

#include "heap.h"

template <class BaseData>
class PriorityQueue : public Heap<BaseData>
{
  public:
  PriorityQueue(int maxNodes,  bool (*priority)(const BaseData & x, const BaseData & y));
 ~PriorityQueue();
  BaseData front();
  bool empty();
  bool full();
  void enqueue (BaseData item);
  void dequeue();
  void Print();
  void preorder(int);
};
#include "PQueue.t"

#endif
