// FileName  : array_v.t
// programmer bj streller and general folklore
// template implementations of the Array_V class


#ifndef ARRAY_V_T_
#define ARRAY_V_T_

#include <iostream>
using std::cout;
using std::endl;
using std::cerr;

#include <new>
using std::bad_alloc;

#include <cassert>  //for asset macro




template < typename IndexType, typename BaseData >
IndexType
Array_V< IndexType, BaseData >::getHiIndex()
{
  return  hiIndex;
}

template < typename IndexType, typename BaseData >
IndexType
Array_V< IndexType, BaseData >::getLoIndex()
{
  return  loIndex;
}


template < typename IndexType, typename BaseData >
void Array_V< IndexType, BaseData >::setLoIndex( IndexType index )
{
  loIndex = index;
}


template < typename IndexType, typename BaseData >
void Array_V< IndexType, BaseData >::setHiIndex( IndexType index )
{
  hiIndex = index;
}




//constructor
template < typename IndexType, typename BaseData >
Array_V< IndexType, BaseData >::Array_V(IndexType lo, IndexType hi)
{
  arrayData = new BaseData[ hi - lo + 1 ];
  assert( arrayData != 0 );
  loIndex = lo;
  hiIndex = hi;
  volume = hi - lo + 1;
  numElements = hi - lo + 1;
 
   // copy BaseData() into each array element
  int i;
  for (i = 0; i < hi - lo + 1 ; i++)
    arrayData[i] = BaseData( );
  
}




// constructor. initialize numElements and volume.
// allocate a dynamic array of numElements integers
// and initialize the array with T()
template < typename IndexType, typename BaseData >
Array_V< IndexType, BaseData >::Array_V( int size ):
    arrayData(NULL), loIndex(0), hiIndex(size - 1), volume(0), numElements(0)
{
  int i;

  // if size is 0, volume/numElements are 0 and arrayData is NULL.
  // just return
  if (size == 0)
    return;

  // set capacity to numElements. since we are building the array,
  // copy is false
  reserve( size, false );
  numElements = size; 

  // copy BaseData() into each array element
  for (i = 0; i < size; i++)
    arrayData[i] = BaseData( );


}



// set the volumw to n elements
template < typename IndexType, typename BaseData >
void Array_V< IndexType, BaseData >::reserve(int n, bool copy)
{

  BaseData *new_arrayData;
  int i;

  // allocate a new dynamic array with n elements
  new_arrayData = new BaseData[ n ];

  if (new_arrayData == NULL)
    {
      throw  bad_alloc ();
      cerr << "Array_V::reserve(): memory allocation failure";
     // abort();
    }



  // if copy is true, copy elements from the old list to the new list
  // may have to set loIndex and hiIndex if copy
  if ( copy )
    for ( i = 0; i < numElements; i++ )
      new_arrayData[ i ] = arrayData[ i ];


  // delete original dynamic array. if arrayData is NULL, the array was
  // originally empty and there is no memory to delete
  if ( arrayData != NULL )
    delete [] arrayData;


  // set arrayData to the value newArr. update volume
  arrayData = new_arrayData;
  volume = n;

}




// copy constructor. make the current object a copy of init.
// for starters, use initialization list to create an empty
// array
template < typename IndexType, typename BaseData >
Array_V< IndexType, BaseData >::Array_V( const Array_V< IndexType, BaseData > &initArray ):
    arrayData(NULL), loIndex(0), hiIndex(-1), volume(0), numElements(0)
{
  // if size is 0, numElements/volume  are 0 and arrayData is NULL - just return
  if ( initArray.numElements == 0 )
    return;
    

  //otherwise
  // set numElements to initArray.numElements. since we are building the array,
  // copy is false

  reserve( initArray.numElements, false );

  loIndex = initArray.loIndex;
  hiIndex = initArray.hiIndex;
  numElements = initArray.numElements;
 

  //the following is the object's []
  IndexType i;
  BaseData* p;
  p = initArray.arrayData;

  // copy items from the init.array to the newly allocated array
  for (i = loIndex; i <= hiIndex; i++, p++)
    ( (*this)[i] ) = *p;
    
  
}





//void return implies no chaining
// replace existing object (left-hand operand) by
// init ( the right-hand operand)
template < typename IndexType, typename BaseData >
Array_V< IndexType, BaseData >&
Array_V< IndexType, BaseData >::operator = ( const Array_V< IndexType, BaseData > &initArray )
{

  if (this == &initArray)
    return *this;   //avoid self assignment

  delete [] arrayData;
  IndexType i;

  // check volume to see if a new array must be allocated
  if ( volume < initArray.numElements )
    // make volume of current object the size of initArray. don't
    // do a copy, since we will replace the old values

    reserve( initArray.numElements, false );

  // assign current object to have same size as rhs and indices
  numElements = initArray.numElements;
  loIndex = initArray.loIndex;
  hiIndex = initArray.hiIndex;

  // copy items from initArray.arrayData to the this array

  BaseData* p;
  p = initArray.arrayData;

  for (i = loIndex; i <= hiIndex; i++, p++)
    ((*this)[i]) = *p;


  return *this;

}




template < typename IndexType, typename BaseData >
Array_V< IndexType, BaseData >::~Array_V()
{
  if ( arrayData != NULL)
    delete [] arrayData;
}



template < typename IndexType, typename BaseData >
int Array_V< IndexType, BaseData >::outOfRange(IndexType i)
{
  if ( (i < loIndex) || (i > hiIndex) )
    {
      cerr << "Index " << i <<  " out of range"<< endl;
      return (1);
    }
  else
    return (0);

}



template < typename IndexType, typename BaseData >
void Array_V< IndexType, BaseData >::assign( IndexType i, const BaseData &val )
{
  assert(!outOfRange(i));
  arrayData[ i - loIndex ] = val;
}



template < typename IndexType, typename BaseData >
BaseData Array_V< IndexType, BaseData >::retrieve(IndexType i)
{
  assert(!outOfRange(i));
  return(arrayData[ i - loIndex ]);
}



//returns an address so can be an lvalue
template < typename IndexType, typename BaseData >
BaseData& Array_V< IndexType, BaseData >::operator [] (IndexType i)
{
  assert(!outOfRange(i));
  return(arrayData[ i - loIndex ]);
}


//this ok
template < typename IndexType, typename BaseData >
int Array_V< IndexType, BaseData >::getVolume() const
  {
    return volume;
  }



template < typename IndexType, typename BaseData >
int Array_V< IndexType, BaseData >::getNumOf() const
  {
    return numElements;
  }



template < typename IndexType, typename BaseData >
bool Array_V< IndexType, BaseData >::empty() const
  {
    return  numElements == 0;
  }




// insure that list has sufficient volume,
// add the new item to the list, and increment numElements
template < typename IndexType, typename BaseData >
void Array_V< IndexType, BaseData >::push_back(const BaseData& item)
{
  // if space is full, allocate more capacity
  if ( numElements == volume )
    {
      if (volume == 0)
        // if volume is 0, set volume to 1.
        // set copy to false because there are
        // no existing elements
        reserve( 1, false );
      else
        // double the volume
        reserve( 2 * volume, true );

      hiIndex++;
    }

  else if ( hiIndex - loIndex + 1  == numElements )
    hiIndex++;

  // add item to the list, update numElements
  arrayData[ numElements ] = item;
  numElements++;

}




#endif

