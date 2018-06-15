

// FileName  : array_v.h
// programmer bj streller and general folklore

// PURPOSE : Provides an extended definition of an Array ADT.
// We assume IndexType is a finite collection of consecutively
// enumerated values such as integers, characters, or enum values,
// and that BaseData is any type.
// Bounds checking via the assert macro is also done.
// Furthermore, this array class as been given features similar to
// the STL vector class. Namely, array can be dynamically resized
// via the push_back method if the array is full.


#ifndef ARRAY_V_H
#define ARRAY_V_H

#include <cassert>





template < typename IndexType, typename BaseData >
class Array_V
  {
  public:
   
    IndexType getHiIndex();
    IndexType getLoIndex();
    void setHiIndex( IndexType index );
    void setLoIndex( IndexType index );

    Array_V( IndexType lo, IndexType hi );  //constructor
    Array_V( int size = 0 );
    Array_V ( const Array_V< IndexType, BaseData >  &initArray );  //copy constructor
    ~Array_V();  //destructor

    BaseData& operator [] ( IndexType );

    Array_V< IndexType, BaseData >&
    operator = ( const Array_V< IndexType, BaseData > &initArray );


    void assign( IndexType i, const BaseData &val );
    // assigns val at location i

    BaseData retrieve( IndexType i );
    // returns the current value at i the array

    int getVolume() const;
    // returns the current volume of the array

    int getNumOf() const;
    // returns current number of elements in array

    bool empty() const;
    // returns true if array is empty and false otherwise


    void push_back( const BaseData& val );
    // insert item at the rear of the array.
    // as a result the array size is increased by 1




    //protected necessary for any derived classes
  private :
    BaseData *arrayData;		// the dynamic array
    IndexType loIndex, hiIndex;
    int volume;				// amount of available space
    int numElements;			// number of elements in the list

    int outOfRange( IndexType i );

    void reserve(int n, bool copy);
    // called by public functions only if n > volume. expands
    // the array capacity to n elements, copies the existing
    // elements to the new space if copy == true, and deletes
    // the old dynamic array. throws exception if memory allocation fails

  };



#include "array_v.t"


#endif

