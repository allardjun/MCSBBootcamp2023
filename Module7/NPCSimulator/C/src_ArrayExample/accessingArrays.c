/******************************************************************************/
//  INCLUDES
/******************************************************************************/

#include <math.h>
#include <stdio.h>

/******************************************************************************/
//  MACROS
/******************************************************************************/

#define RAND genrand_real3()
#define PI 3.14159265359

/******************************************************************************/
//  Variable declarations
/******************************************************************************/

double myArray[10];
double myOtherArray[10];

int arrayCounter;

/******************************************************************************/
//  Main function
/******************************************************************************/

int main( int argc, char *argv[] )
{

  for(arrayCounter=0;arrayCounter<10;arrayCounter++)
    myArray[arrayCounter] = arrayCounter;

  for(arrayCounter=0;arrayCounter<10;arrayCounter++)
    myOtherArray[arrayCounter] = 99.0 + arrayCounter;

  printf("The fourth element of myArray is: myArray[3]=%lf\n",myArray[3]);

  printf("The 13th element of myArray is: myArray[12]=%lf\n",myArray[12]);

  return 0;
} // finished main
