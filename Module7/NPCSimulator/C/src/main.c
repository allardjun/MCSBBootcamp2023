/******************************************************************************/
// MCSB Bootcamp Dry
// Jun Allard jun.allard@uci.edu
// Simulate a transcription factor diffusing inside the cytoplasm, searching
// for a nuclear pore complex
/******************************************************************************/

/******************************************************************************/
//  INCLUDES
/******************************************************************************/

#include <math.h>
#include <stdio.h>

#include "twister.c" //random number generation

/******************************************************************************/
//  MACROS
/******************************************************************************/

#define RAND genrand_real3()
#define PI 3.14159265359
#define nSample 20000

/******************************************************************************/
//  Variable declarations
/******************************************************************************/

// Numerical parameters
float dt;
int ntmax;

// Model parameters
float D, L, NPCSize, NPCLocation[2], alpha;

// Simulation variables
float x[2], t;
float rand1, rand2, normRand1, normRand2;

int nt;

float tCapture[nSample];

int iSample;

/******************************************************************************/
//  Main function
/******************************************************************************/

int main( int argc, char *argv[] )
{

  // intialize random number generator
  RanInit(0,0);

  // Numerical parameters
  dt    = 0.001; // s
  ntmax = 1e6;

  // Model parameters
  D = 10; //microns^2/second
  L = 10; // microns

  NPCSize = 0.01; // microns
  NPCLocation[0] = -L/2;
  NPCLocation[1] = 0;

  alpha = sqrt(2*D*dt);

  for (iSample=1;iSample<nSample;iSample++)
  {

    // intial condition
    x[0] = L/2;
    x[1] = 0;

    /***************************************************************************/
    // Simulate!
    /***************************************************************************/

    t = 0;
    for (nt=1;nt<ntmax;nt++)
    {
        // the Box-Muller method for generating a pair of normal random variables
        //start with 2 uniform(0,1) random numbers
        rand1=RAND;
        rand2=RAND;
        //tranform to normally distributed
        normRand1=sqrt(-2*log(rand1))*cos(2*PI*rand2);
        normRand2=sqrt(-2*log(rand1))*sin(2*PI*rand2);

        // dynamics
        x[0] = x[0] + alpha*normRand1;
        x[1] = x[1] + alpha*normRand2;

        // boundaries
        if (x[0]>L/2)
            x[0]=L/2;
        else if (x[0]<-L/2)
            x[0]=-L/2;
        if (x[1]>L/2)
            x[1]=L/2;
        else if (x[1]<-L/2)
            x[1]=-L/2;

        // test for NPC capture
        if ( (x[0]-NPCLocation[0])*(x[0]-NPCLocation[0]) + (x[1]-NPCLocation[1])*(x[1]-NPCLocation[1]) < NPCSize*NPCSize )
        {
           tCapture[iSample] = t;
           break;
        }

        t += dt; // update time

    } //finished for-loop

    //printf("Capture at t=%lf seconds.\n", t);

  }
  return 0;
} // finished main
