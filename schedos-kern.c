#include "schedos-kern.h"
#include "x86.h"
#include "lib.h"

/*****************************************************************************
 * schedos-kern
 *
 *   This is the schedos's kernel.
 *   It sets up process descriptors for the 4 applications, then runs
 *   them in some schedule.
 *
 *****************************************************************************/

// The program loader loads 4 processes, starting at PROC1_START, allocating
// 1 MB to each process.
// Each process's stack grows down from the top of its memory space.
// (But note that SchedOS processes, like MiniprocOS processes, are not fully
// isolated: any process could modify any part of memory.)

#define NPROCS		5
#define PROC1_START	0x200000
#define PROC_SIZE	0x100000

// +---------+-----------------------+--------+---------------------+---------/
// | Base    | Kernel         Kernel | Shared | App 0         App 0 | App 1
// | Memory  | Code + Data     Stack | Data   | Code + Data   Stack | Code ...
// +---------+-----------------------+--------+---------------------+---------/
// 0x0    0x100000               0x198000 0x200000              0x300000
//
// The program loader puts each application's starting instruction pointer
// at the very top of its stack.
//
// System-wide global variables shared among the kernel and the four
// applications are stored in memory from 0x198000 to 0x200000.  Currently
// there is just one variable there, 'cursorpos', which occupies the four
// bytes of memory 0x198000-0x198003.  You can add more variables by defining
// their addresses in schedos-symbols.ld; make sure they do not overlap!


// A process descriptor for each process.
// Note that proc_array[0] is never used.
// The first application process descriptor is proc_array[1].
static process_t proc_array[NPROCS];

// A pointer to the currently running process.
// This is kept up to date by the run() function, in mpos-x86.c.
process_t *current;

// The preferred scheduling algorithm.
int scheduling_algorithm;

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.A
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
// #define __PRIORITY_1__ 1
// #define __PRIORITY_2__ 2
// #define __PRIORITY_3__ 3
// #define __PRIORITY_4__ 4

// UNCOMMENT THESE LINES IF YOU DO EXERCISE 4.B
// Use these #defines to initialize your implementation.
// Changing one of these lines should change the initialization.
// #define __SHARE_1__ 1
// #define __SHARE_2__ 2
// #define __SHARE_3__ 3
// #define __SHARE_4__ 4

// USE THESE VALUES FOR SETTING THE scheduling_algorithm VARIABLE.
#define __EXERCISE_1__   0  // the initial algorithm
#define __EXERCISE_2__   2  // strict priority scheduling (exercise 2)
#define __EXERCISE_4A__ 41  // p_priority algorithm (exercise 4.a)
#define __EXERCISE_4B__ 42  // p_share algorithm (exercise 4.b)
#define __EXERCISE_7__   7  // any algorithm for exercise 7


/*****************************************************************************
 * start
 *
 *   Initialize the hardware and process descriptors, then run
 *   the first process.
 *
 *****************************************************************************/

void
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
	interrupt_controller_init(0);
	//interrupt_controller_init(1);
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Exercise 4B test
		// preset everyone to 1 so everyone can start
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
	cursorposLock = 0;	// lock is available

	// Initialize the scheduling algorithm.
	// USE THE FOLLOWING VALUES:
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);

	// Should never get here!
	while (1)
		/* do nothing */;
}



/*****************************************************************************
 * interrupt
 *
 *   This is the weensy interrupt and system call handler.
 *   The current handler handles 4 different system calls (two of which
 *   do nothing), plus the clock interrupt.
 *
 *   Note that we will never receive clock interrupts while in the kernel.
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;

	switch (reg->reg_intno) {

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();

	case INT_SYS_EXIT:
		// 'sys_exit' exits the current process: it is marked as
		// non-runnable.
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
		current->p_exit_status = reg->reg_eax;
		schedule();

	//case INT_SYS_USER1:
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_priority = reg->reg_eax;
		schedule();

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
		current->p_share_left = current->p_share_amt;
		schedule();
	
	case INT_SYS_LOTTERY:
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_lottery_amt = reg->reg_eax;
		schedule();
	
	case INT_SYS_PRINT:
		*cursorpos++ = reg->reg_eax;
		schedule();

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();

	default:
		while (1)
			/* do nothing */;

	}
}



/*****************************************************************************
 * schedule
 *
 *   This is the weensy process scheduler.
 *   It picks a runnable process, then context-switches to that process.
 *   If there are no runnable processes, it spins forever.
 *
 *   This function implements multiple scheduling algorithms, depending on
 *   the value of 'scheduling_algorithm'.  We've provided one; in the problem
 *   set you will provide at least one more.
 *
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
	unsigned int firstPriority;
	pid_t firstPid;
	int i;
	int p_share_reset;	// 4B

	// Exercise 7
	uint32_t seed;
	unsigned int lotteryTotal;
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
		while (1) {
			pid = (pid + 1) % NPROCS;

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
			pid = (pid + 1) % NPROCS;
		}
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
		run(&proc_array[firstPid]);
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
		if (proc_array[pid].p_share_left > 0 && proc_array[pid].p_state == P_RUNNABLE) {
			proc_array[pid].p_share_left--;
			run(&proc_array[pid]);
		} else {
			while(1) {
				// first find a process that's runnable
				for (i = 0; i < NPROCS - 1; i++) {
					pid = (pid + 1) % NPROCS;
					if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0)
						break;
				}
				
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0) {
					// there's at least one runnalbe, check share priority
					firstPid = pid;
					firstPriority = proc_array[pid].p_share_amt;
					
					for (i = 0; i < NPROCS - 1; i++) {
						pid = (pid + 1) % NPROCS;
						if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0 && proc_array[pid].p_share_amt > firstPriority) {
							firstPid = pid;
							firstPriority = proc_array[pid].p_share_amt;
						}
					}
					
					proc_array[firstPid].p_share_left--;
					run(&proc_array[firstPid]);
				} else {
					// nothing runnable
					// reset p_share_left
					for (i = 1; i < NPROCS; i++)
						proc_array[i].p_share_left = proc_array[i].p_share_amt;
				}
				
				//if (proc_array[firstPid].p_state == P_RUNNABLE && proc_array[firstPid]
			}
		}

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
		}
		
		while (1) {
			seed = (uint32_t) read_cycle_counter();
			//seed ^= seed >> 11;
			//seed ^= seed << 7 & 0x9D2C5680;
			//seed ^= seed << 15 & 0xEFC60000;
			//seed ^= seed >> 18;
			/**************
			Reference from en.cppreference.com/w/app/numeric/random
			**************/
			seed ^= seed >> 11 & 0x9908b0df;
			seed ^= seed << 7 & 0xffffffff;
			seed ^= seed << 15 & 0x9d2c5680;
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
				run(&proc_array[4]);
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
	while (1)
		/* do nothing */;
}
