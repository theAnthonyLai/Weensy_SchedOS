/*****************************************************************************
 * schedos-3
 *
 *   See schedos-1.
 *
 *****************************************************************************/

#define PRINTCHAR	('3' | 0x0900)

#include "schedos-1.c"

//Exercise 4A test
//#include "schedos-app.h"
//#include "x86sync.h"

/*****************************************************************************
 * schedos-1
 *
 *   This tiny application prints red "1"s to the console.
 *   It yields the CPU to the kernel after each "1" using the sys_yield()
 *   system call.  This lets the kernel (schedos-kern.c) pick another
 *   application to run, if it wants.
 *
 *   The other schedos-* processes simply #include this file after defining
 *   PRINTCHAR appropriately.
 *
 *****************************************************************************/

//#ifndef PRINTCHAR
//#define PRINTCHAR	('3' | 0x0900)
//#endif

// UNCOMMENT THE NEXT LINE TO USE EXERCISE 8 CODE INSTEAD OF EXERCISE 6
// #define __EXERCISE_8__
// Use the following structure to choose between them:
// #infdef __EXERCISE_8__
// (exercise 6 code)
// #else
// (exercise 8 code)
// #endif

/*
void
start(void)
{
	int i;
	//sys_share(15);
	//sys_priority(0);
	//sys_lottery(25);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
		sys_yield();
	}

	// Yield forever.
	//while (1)
	//	sys_yield();
	sys_exit(0);
}*/
