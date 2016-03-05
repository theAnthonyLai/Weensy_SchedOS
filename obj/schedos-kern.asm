
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 7d 01 00 00       	call   100196 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 a8 00 00 00       	call   10011a <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	83 ec 0c             	sub    $0xc,%esp
	pid_t pid = current->p_pid;
  10009f:	a1 30 7a 10 00       	mov    0x107a30,%eax
  1000a4:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0) {
  1000a6:	a1 34 7a 10 00       	mov    0x107a34,%eax
  1000ab:	85 c0                	test   %eax,%eax
  1000ad:	75 19                	jne    1000c8 <schedule+0x2c>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000af:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b4:	8d 42 01             	lea    0x1(%edx),%eax
  1000b7:	99                   	cltd   
  1000b8:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000ba:	6b c2 54             	imul   $0x54,%edx,%eax
  1000bd:	83 b8 70 70 10 00 01 	cmpl   $0x1,0x107070(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
  1000c6:	eb 1b                	jmp    1000e3 <schedule+0x47>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000c8:	83 f8 02             	cmp    $0x2,%eax
  1000cb:	75 2c                	jne    1000f9 <schedule+0x5d>
  1000cd:	ba 01 00 00 00       	mov    $0x1,%edx
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
			pid = (pid + 1) % NPROCS;
  1000d2:	b9 05 00 00 00       	mov    $0x5,%ecx
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000d7:	6b c2 54             	imul   $0x54,%edx,%eax
  1000da:	83 b8 70 70 10 00 01 	cmpl   $0x1,0x107070(%eax)
  1000e1:	75 0e                	jne    1000f1 <schedule+0x55>
				run(&proc_array[pid]);
  1000e3:	83 ec 0c             	sub    $0xc,%esp
  1000e6:	05 24 70 10 00       	add    $0x107024,%eax
  1000eb:	50                   	push   %eax
  1000ec:	e8 b8 03 00 00       	call   1004a9 <run>
			pid = (pid + 1) % NPROCS;
  1000f1:	8d 42 01             	lea    0x1(%edx),%eax
  1000f4:	99                   	cltd   
  1000f5:	f7 f9                	idiv   %ecx
		}
  1000f7:	eb de                	jmp    1000d7 <schedule+0x3b>
		// TODO: "blocked and later became runnalbe again"
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1000f9:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1000ff:	50                   	push   %eax
  100100:	68 68 0a 10 00       	push   $0x100a68
  100105:	68 00 01 00 00       	push   $0x100
  10010a:	52                   	push   %edx
  10010b:	e8 3e 09 00 00       	call   100a4e <console_printf>
  100110:	83 c4 10             	add    $0x10,%esp
  100113:	a3 00 80 19 00       	mov    %eax,0x198000
  100118:	eb fe                	jmp    100118 <schedule+0x7c>

0010011a <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10011a:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10011b:	8b 3d 30 7a 10 00    	mov    0x107a30,%edi
  100121:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100126:	56                   	push   %esi
  100127:	53                   	push   %ebx
  100128:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10012c:	83 c7 04             	add    $0x4,%edi
  10012f:	89 de                	mov    %ebx,%esi
  100131:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100133:	8b 43 28             	mov    0x28(%ebx),%eax
  100136:	83 f8 31             	cmp    $0x31,%eax
  100139:	74 1f                	je     10015a <interrupt+0x40>
  10013b:	77 0c                	ja     100149 <interrupt+0x2f>
  10013d:	83 f8 20             	cmp    $0x20,%eax
  100140:	74 4d                	je     10018f <interrupt+0x75>
  100142:	83 f8 30             	cmp    $0x30,%eax
  100145:	74 0e                	je     100155 <interrupt+0x3b>
  100147:	eb 4b                	jmp    100194 <interrupt+0x7a>
  100149:	83 f8 32             	cmp    $0x32,%eax
  10014c:	74 23                	je     100171 <interrupt+0x57>
  10014e:	83 f8 33             	cmp    $0x33,%eax
  100151:	74 2e                	je     100181 <interrupt+0x67>
  100153:	eb 3f                	jmp    100194 <interrupt+0x7a>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100155:	e8 42 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10015a:	a1 30 7a 10 00       	mov    0x107a30,%eax
		current->p_exit_status = reg->reg_eax;
  10015f:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100162:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = reg->reg_eax;
  100169:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  10016c:	e8 2b ff ff ff       	call   10009c <schedule>
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		current->p_priority = reg->reg_eax;
  100171:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100174:	a1 30 7a 10 00       	mov    0x107a30,%eax
  100179:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  10017c:	e8 1b ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  100181:	83 ec 0c             	sub    $0xc,%esp
  100184:	ff 35 30 7a 10 00    	pushl  0x107a30
  10018a:	e8 1a 03 00 00       	call   1004a9 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10018f:	e8 08 ff ff ff       	call   10009c <schedule>
  100194:	eb fe                	jmp    100194 <interrupt+0x7a>

00100196 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100196:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100197:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10019c:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10019d:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10019f:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001a0:	bb 78 70 10 00       	mov    $0x107078,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1001a5:	e8 de 00 00 00       	call   100288 <segments_init>
	interrupt_controller_init(0);
  1001aa:	83 ec 0c             	sub    $0xc,%esp
  1001ad:	6a 00                	push   $0x0
  1001af:	e8 cf 01 00 00       	call   100383 <interrupt_controller_init>
	console_clear();
  1001b4:	e8 53 02 00 00       	call   10040c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001b9:	83 c4 0c             	add    $0xc,%esp
  1001bc:	68 a4 01 00 00       	push   $0x1a4
  1001c1:	6a 00                	push   $0x0
  1001c3:	68 24 70 10 00       	push   $0x107024
  1001c8:	e8 1f 04 00 00       	call   1005ec <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001cd:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001d0:	c7 05 24 70 10 00 00 	movl   $0x0,0x107024
  1001d7:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001da:	c7 05 70 70 10 00 00 	movl   $0x0,0x107070
  1001e1:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001e4:	c7 05 78 70 10 00 01 	movl   $0x1,0x107078
  1001eb:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001ee:	c7 05 c4 70 10 00 00 	movl   $0x0,0x1070c4
  1001f5:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001f8:	c7 05 cc 70 10 00 02 	movl   $0x2,0x1070cc
  1001ff:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100202:	c7 05 18 71 10 00 00 	movl   $0x0,0x107118
  100209:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10020c:	c7 05 20 71 10 00 03 	movl   $0x3,0x107120
  100213:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100216:	c7 05 6c 71 10 00 00 	movl   $0x0,0x10716c
  10021d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100220:	c7 05 74 71 10 00 04 	movl   $0x4,0x107174
  100227:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10022a:	c7 05 c0 71 10 00 00 	movl   $0x0,0x1071c0
  100231:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100234:	83 ec 0c             	sub    $0xc,%esp
  100237:	53                   	push   %ebx
  100238:	e8 83 02 00 00       	call   1004c0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10023d:	58                   	pop    %eax
  10023e:	5a                   	pop    %edx
  10023f:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100242:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100245:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10024b:	50                   	push   %eax
  10024c:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10024d:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10024e:	e8 a9 02 00 00       	call   1004fc <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100253:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100256:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  10025d:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100260:	83 fe 04             	cmp    $0x4,%esi
  100263:	75 cf                	jne    100234 <start+0x9e>
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  100265:	83 ec 0c             	sub    $0xc,%esp
  100268:	68 78 70 10 00       	push   $0x107078
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10026d:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100274:	80 0b 00 
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	scheduling_algorithm = 2;
  100277:	c7 05 34 7a 10 00 02 	movl   $0x2,0x107a34
  10027e:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100281:	e8 23 02 00 00       	call   1004a9 <run>
  100286:	90                   	nop
  100287:	90                   	nop

00100288 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100288:	b8 c8 71 10 00       	mov    $0x1071c8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10028d:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100292:	89 c2                	mov    %eax,%edx
  100294:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100297:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100298:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  10029d:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a0:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1002a6:	c1 e8 18             	shr    $0x18,%eax
  1002a9:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002af:	ba 30 72 10 00       	mov    $0x107230,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002b4:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002b9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002bb:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002c2:	68 00 
  1002c4:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002cb:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002d2:	c7 05 cc 71 10 00 00 	movl   $0x180000,0x1071cc
  1002d9:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002dc:	66 c7 05 d0 71 10 00 	movw   $0x10,0x1071d0
  1002e3:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e5:	66 89 0c c5 30 72 10 	mov    %cx,0x107230(,%eax,8)
  1002ec:	00 
  1002ed:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002f4:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1002f9:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1002fe:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100303:	40                   	inc    %eax
  100304:	3d 00 01 00 00       	cmp    $0x100,%eax
  100309:	75 da                	jne    1002e5 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10030b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100310:	ba 30 72 10 00       	mov    $0x107230,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100315:	66 a3 30 73 10 00    	mov    %ax,0x107330
  10031b:	c1 e8 10             	shr    $0x10,%eax
  10031e:	66 a3 36 73 10 00    	mov    %ax,0x107336
  100324:	b8 30 00 00 00       	mov    $0x30,%eax
  100329:	66 c7 05 32 73 10 00 	movw   $0x8,0x107332
  100330:	08 00 
  100332:	c6 05 34 73 10 00 00 	movb   $0x0,0x107334
  100339:	c6 05 35 73 10 00 8e 	movb   $0x8e,0x107335

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100340:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100347:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10034e:	66 89 0c c5 30 72 10 	mov    %cx,0x107230(,%eax,8)
  100355:	00 
  100356:	c1 e9 10             	shr    $0x10,%ecx
  100359:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10035e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100363:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100368:	40                   	inc    %eax
  100369:	83 f8 3a             	cmp    $0x3a,%eax
  10036c:	75 d2                	jne    100340 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10036e:	b0 28                	mov    $0x28,%al
  100370:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100377:	0f 00 d8             	ltr    %ax
  10037a:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100381:	5b                   	pop    %ebx
  100382:	c3                   	ret    

00100383 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100383:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100384:	b0 ff                	mov    $0xff,%al
  100386:	57                   	push   %edi
  100387:	56                   	push   %esi
  100388:	53                   	push   %ebx
  100389:	bb 21 00 00 00       	mov    $0x21,%ebx
  10038e:	89 da                	mov    %ebx,%edx
  100390:	ee                   	out    %al,(%dx)
  100391:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100396:	89 ca                	mov    %ecx,%edx
  100398:	ee                   	out    %al,(%dx)
  100399:	be 11 00 00 00       	mov    $0x11,%esi
  10039e:	bf 20 00 00 00       	mov    $0x20,%edi
  1003a3:	89 f0                	mov    %esi,%eax
  1003a5:	89 fa                	mov    %edi,%edx
  1003a7:	ee                   	out    %al,(%dx)
  1003a8:	b0 20                	mov    $0x20,%al
  1003aa:	89 da                	mov    %ebx,%edx
  1003ac:	ee                   	out    %al,(%dx)
  1003ad:	b0 04                	mov    $0x4,%al
  1003af:	ee                   	out    %al,(%dx)
  1003b0:	b0 03                	mov    $0x3,%al
  1003b2:	ee                   	out    %al,(%dx)
  1003b3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003b8:	89 f0                	mov    %esi,%eax
  1003ba:	89 ea                	mov    %ebp,%edx
  1003bc:	ee                   	out    %al,(%dx)
  1003bd:	b0 28                	mov    $0x28,%al
  1003bf:	89 ca                	mov    %ecx,%edx
  1003c1:	ee                   	out    %al,(%dx)
  1003c2:	b0 02                	mov    $0x2,%al
  1003c4:	ee                   	out    %al,(%dx)
  1003c5:	b0 01                	mov    $0x1,%al
  1003c7:	ee                   	out    %al,(%dx)
  1003c8:	b0 68                	mov    $0x68,%al
  1003ca:	89 fa                	mov    %edi,%edx
  1003cc:	ee                   	out    %al,(%dx)
  1003cd:	be 0a 00 00 00       	mov    $0xa,%esi
  1003d2:	89 f0                	mov    %esi,%eax
  1003d4:	ee                   	out    %al,(%dx)
  1003d5:	b0 68                	mov    $0x68,%al
  1003d7:	89 ea                	mov    %ebp,%edx
  1003d9:	ee                   	out    %al,(%dx)
  1003da:	89 f0                	mov    %esi,%eax
  1003dc:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003dd:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003e2:	89 da                	mov    %ebx,%edx
  1003e4:	19 c0                	sbb    %eax,%eax
  1003e6:	f7 d0                	not    %eax
  1003e8:	05 ff 00 00 00       	add    $0xff,%eax
  1003ed:	ee                   	out    %al,(%dx)
  1003ee:	b0 ff                	mov    $0xff,%al
  1003f0:	89 ca                	mov    %ecx,%edx
  1003f2:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1003f3:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1003f8:	74 0d                	je     100407 <interrupt_controller_init+0x84>
  1003fa:	b2 43                	mov    $0x43,%dl
  1003fc:	b0 34                	mov    $0x34,%al
  1003fe:	ee                   	out    %al,(%dx)
  1003ff:	b0 9c                	mov    $0x9c,%al
  100401:	b2 40                	mov    $0x40,%dl
  100403:	ee                   	out    %al,(%dx)
  100404:	b0 2e                	mov    $0x2e,%al
  100406:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100407:	5b                   	pop    %ebx
  100408:	5e                   	pop    %esi
  100409:	5f                   	pop    %edi
  10040a:	5d                   	pop    %ebp
  10040b:	c3                   	ret    

0010040c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10040c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10040d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10040f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100410:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100417:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10041a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100420:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100426:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100429:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10042e:	75 ea                	jne    10041a <console_clear+0xe>
  100430:	be d4 03 00 00       	mov    $0x3d4,%esi
  100435:	b0 0e                	mov    $0xe,%al
  100437:	89 f2                	mov    %esi,%edx
  100439:	ee                   	out    %al,(%dx)
  10043a:	31 c9                	xor    %ecx,%ecx
  10043c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100441:	88 c8                	mov    %cl,%al
  100443:	89 da                	mov    %ebx,%edx
  100445:	ee                   	out    %al,(%dx)
  100446:	b0 0f                	mov    $0xf,%al
  100448:	89 f2                	mov    %esi,%edx
  10044a:	ee                   	out    %al,(%dx)
  10044b:	88 c8                	mov    %cl,%al
  10044d:	89 da                	mov    %ebx,%edx
  10044f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100450:	5b                   	pop    %ebx
  100451:	5e                   	pop    %esi
  100452:	c3                   	ret    

00100453 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100453:	ba 64 00 00 00       	mov    $0x64,%edx
  100458:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100459:	a8 01                	test   $0x1,%al
  10045b:	74 45                	je     1004a2 <console_read_digit+0x4f>
  10045d:	b2 60                	mov    $0x60,%dl
  10045f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100460:	8d 50 fe             	lea    -0x2(%eax),%edx
  100463:	80 fa 08             	cmp    $0x8,%dl
  100466:	77 05                	ja     10046d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100468:	0f b6 c0             	movzbl %al,%eax
  10046b:	48                   	dec    %eax
  10046c:	c3                   	ret    
	else if (data == 0x0B)
  10046d:	3c 0b                	cmp    $0xb,%al
  10046f:	74 35                	je     1004a6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100471:	8d 50 b9             	lea    -0x47(%eax),%edx
  100474:	80 fa 02             	cmp    $0x2,%dl
  100477:	77 07                	ja     100480 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100479:	0f b6 c0             	movzbl %al,%eax
  10047c:	83 e8 40             	sub    $0x40,%eax
  10047f:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100480:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100483:	80 fa 02             	cmp    $0x2,%dl
  100486:	77 07                	ja     10048f <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100488:	0f b6 c0             	movzbl %al,%eax
  10048b:	83 e8 47             	sub    $0x47,%eax
  10048e:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10048f:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100492:	80 fa 02             	cmp    $0x2,%dl
  100495:	77 07                	ja     10049e <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100497:	0f b6 c0             	movzbl %al,%eax
  10049a:	83 e8 4e             	sub    $0x4e,%eax
  10049d:	c3                   	ret    
	else if (data == 0x53)
  10049e:	3c 53                	cmp    $0x53,%al
  1004a0:	74 04                	je     1004a6 <console_read_digit+0x53>
  1004a2:	83 c8 ff             	or     $0xffffffff,%eax
  1004a5:	c3                   	ret    
  1004a6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1004a8:	c3                   	ret    

001004a9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1004a9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004ad:	a3 30 7a 10 00       	mov    %eax,0x107a30

	asm volatile("movl %0,%%esp\n\t"
  1004b2:	83 c0 04             	add    $0x4,%eax
  1004b5:	89 c4                	mov    %eax,%esp
  1004b7:	61                   	popa   
  1004b8:	07                   	pop    %es
  1004b9:	1f                   	pop    %ds
  1004ba:	83 c4 08             	add    $0x8,%esp
  1004bd:	cf                   	iret   
  1004be:	eb fe                	jmp    1004be <run+0x15>

001004c0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004c0:	53                   	push   %ebx
  1004c1:	83 ec 0c             	sub    $0xc,%esp
  1004c4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004c8:	6a 44                	push   $0x44
  1004ca:	6a 00                	push   $0x0
  1004cc:	8d 43 04             	lea    0x4(%ebx),%eax
  1004cf:	50                   	push   %eax
  1004d0:	e8 17 01 00 00       	call   1005ec <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004d5:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004db:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004e1:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004e7:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1004ed:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1004f4:	83 c4 18             	add    $0x18,%esp
  1004f7:	5b                   	pop    %ebx
  1004f8:	c3                   	ret    
  1004f9:	90                   	nop
  1004fa:	90                   	nop
  1004fb:	90                   	nop

001004fc <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004fc:	55                   	push   %ebp
  1004fd:	57                   	push   %edi
  1004fe:	56                   	push   %esi
  1004ff:	53                   	push   %ebx
  100500:	83 ec 1c             	sub    $0x1c,%esp
  100503:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100507:	83 f8 03             	cmp    $0x3,%eax
  10050a:	7f 04                	jg     100510 <program_loader+0x14>
  10050c:	85 c0                	test   %eax,%eax
  10050e:	79 02                	jns    100512 <program_loader+0x16>
  100510:	eb fe                	jmp    100510 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100512:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100519:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10051f:	74 02                	je     100523 <program_loader+0x27>
  100521:	eb fe                	jmp    100521 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100523:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100526:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10052a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10052c:	c1 e5 05             	shl    $0x5,%ebp
  10052f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100532:	eb 3f                	jmp    100573 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100534:	83 3b 01             	cmpl   $0x1,(%ebx)
  100537:	75 37                	jne    100570 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100539:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10053c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10053f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100542:	01 c7                	add    %eax,%edi
	memsz += va;
  100544:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100546:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10054b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10054f:	52                   	push   %edx
  100550:	89 fa                	mov    %edi,%edx
  100552:	29 c2                	sub    %eax,%edx
  100554:	52                   	push   %edx
  100555:	8b 53 04             	mov    0x4(%ebx),%edx
  100558:	01 f2                	add    %esi,%edx
  10055a:	52                   	push   %edx
  10055b:	50                   	push   %eax
  10055c:	e8 27 00 00 00       	call   100588 <memcpy>
  100561:	83 c4 10             	add    $0x10,%esp
  100564:	eb 04                	jmp    10056a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100566:	c6 07 00             	movb   $0x0,(%edi)
  100569:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10056a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10056e:	72 f6                	jb     100566 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100570:	83 c3 20             	add    $0x20,%ebx
  100573:	39 eb                	cmp    %ebp,%ebx
  100575:	72 bd                	jb     100534 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100577:	8b 56 18             	mov    0x18(%esi),%edx
  10057a:	8b 44 24 34          	mov    0x34(%esp),%eax
  10057e:	89 10                	mov    %edx,(%eax)
}
  100580:	83 c4 1c             	add    $0x1c,%esp
  100583:	5b                   	pop    %ebx
  100584:	5e                   	pop    %esi
  100585:	5f                   	pop    %edi
  100586:	5d                   	pop    %ebp
  100587:	c3                   	ret    

00100588 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100588:	56                   	push   %esi
  100589:	31 d2                	xor    %edx,%edx
  10058b:	53                   	push   %ebx
  10058c:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100590:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100594:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100598:	eb 08                	jmp    1005a2 <memcpy+0x1a>
		*d++ = *s++;
  10059a:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  10059d:	4e                   	dec    %esi
  10059e:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005a1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005a2:	85 f6                	test   %esi,%esi
  1005a4:	75 f4                	jne    10059a <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1005a6:	5b                   	pop    %ebx
  1005a7:	5e                   	pop    %esi
  1005a8:	c3                   	ret    

001005a9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1005a9:	57                   	push   %edi
  1005aa:	56                   	push   %esi
  1005ab:	53                   	push   %ebx
  1005ac:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005b0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005b4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005b8:	39 c7                	cmp    %eax,%edi
  1005ba:	73 26                	jae    1005e2 <memmove+0x39>
  1005bc:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005bf:	39 c6                	cmp    %eax,%esi
  1005c1:	76 1f                	jbe    1005e2 <memmove+0x39>
		s += n, d += n;
  1005c3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005c6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005c8:	eb 07                	jmp    1005d1 <memmove+0x28>
			*--d = *--s;
  1005ca:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005cd:	4a                   	dec    %edx
  1005ce:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005d1:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005d2:	85 d2                	test   %edx,%edx
  1005d4:	75 f4                	jne    1005ca <memmove+0x21>
  1005d6:	eb 10                	jmp    1005e8 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005d8:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005db:	4a                   	dec    %edx
  1005dc:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005df:	41                   	inc    %ecx
  1005e0:	eb 02                	jmp    1005e4 <memmove+0x3b>
  1005e2:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005e4:	85 d2                	test   %edx,%edx
  1005e6:	75 f0                	jne    1005d8 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005e8:	5b                   	pop    %ebx
  1005e9:	5e                   	pop    %esi
  1005ea:	5f                   	pop    %edi
  1005eb:	c3                   	ret    

001005ec <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005ec:	53                   	push   %ebx
  1005ed:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005f1:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005f5:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005f9:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005fb:	eb 04                	jmp    100601 <memset+0x15>
		*p++ = c;
  1005fd:	88 1a                	mov    %bl,(%edx)
  1005ff:	49                   	dec    %ecx
  100600:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100601:	85 c9                	test   %ecx,%ecx
  100603:	75 f8                	jne    1005fd <memset+0x11>
		*p++ = c;
	return v;
}
  100605:	5b                   	pop    %ebx
  100606:	c3                   	ret    

00100607 <strlen>:

size_t
strlen(const char *s)
{
  100607:	8b 54 24 04          	mov    0x4(%esp),%edx
  10060b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10060d:	eb 01                	jmp    100610 <strlen+0x9>
		++n;
  10060f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100610:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100614:	75 f9                	jne    10060f <strlen+0x8>
		++n;
	return n;
}
  100616:	c3                   	ret    

00100617 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100617:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10061b:	31 c0                	xor    %eax,%eax
  10061d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100621:	eb 01                	jmp    100624 <strnlen+0xd>
		++n;
  100623:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100624:	39 d0                	cmp    %edx,%eax
  100626:	74 06                	je     10062e <strnlen+0x17>
  100628:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10062c:	75 f5                	jne    100623 <strnlen+0xc>
		++n;
	return n;
}
  10062e:	c3                   	ret    

0010062f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10062f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100630:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100635:	53                   	push   %ebx
  100636:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100638:	76 05                	jbe    10063f <console_putc+0x10>
  10063a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10063f:	80 fa 0a             	cmp    $0xa,%dl
  100642:	75 2c                	jne    100670 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100644:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10064a:	be 50 00 00 00       	mov    $0x50,%esi
  10064f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100651:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100654:	99                   	cltd   
  100655:	f7 fe                	idiv   %esi
  100657:	89 de                	mov    %ebx,%esi
  100659:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10065b:	eb 07                	jmp    100664 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10065d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100660:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100661:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100664:	83 f8 50             	cmp    $0x50,%eax
  100667:	75 f4                	jne    10065d <console_putc+0x2e>
  100669:	29 d0                	sub    %edx,%eax
  10066b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10066e:	eb 0b                	jmp    10067b <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100670:	0f b6 d2             	movzbl %dl,%edx
  100673:	09 ca                	or     %ecx,%edx
  100675:	66 89 13             	mov    %dx,(%ebx)
  100678:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10067b:	5b                   	pop    %ebx
  10067c:	5e                   	pop    %esi
  10067d:	c3                   	ret    

0010067e <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10067e:	56                   	push   %esi
  10067f:	53                   	push   %ebx
  100680:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100684:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100687:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10068b:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100690:	75 04                	jne    100696 <fill_numbuf+0x18>
  100692:	85 d2                	test   %edx,%edx
  100694:	74 10                	je     1006a6 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100696:	89 d0                	mov    %edx,%eax
  100698:	31 d2                	xor    %edx,%edx
  10069a:	f7 f1                	div    %ecx
  10069c:	4b                   	dec    %ebx
  10069d:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006a0:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006a2:	89 c2                	mov    %eax,%edx
  1006a4:	eb ec                	jmp    100692 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1006a6:	89 d8                	mov    %ebx,%eax
  1006a8:	5b                   	pop    %ebx
  1006a9:	5e                   	pop    %esi
  1006aa:	c3                   	ret    

001006ab <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1006ab:	55                   	push   %ebp
  1006ac:	57                   	push   %edi
  1006ad:	56                   	push   %esi
  1006ae:	53                   	push   %ebx
  1006af:	83 ec 38             	sub    $0x38,%esp
  1006b2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006b6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006ba:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006be:	e9 60 03 00 00       	jmp    100a23 <console_vprintf+0x378>
		if (*format != '%') {
  1006c3:	80 fa 25             	cmp    $0x25,%dl
  1006c6:	74 13                	je     1006db <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006c8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006cc:	0f b6 d2             	movzbl %dl,%edx
  1006cf:	89 f0                	mov    %esi,%eax
  1006d1:	e8 59 ff ff ff       	call   10062f <console_putc>
  1006d6:	e9 45 03 00 00       	jmp    100a20 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006db:	47                   	inc    %edi
  1006dc:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006e3:	00 
  1006e4:	eb 12                	jmp    1006f8 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006e6:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006e7:	8a 11                	mov    (%ecx),%dl
  1006e9:	84 d2                	test   %dl,%dl
  1006eb:	74 1a                	je     100707 <console_vprintf+0x5c>
  1006ed:	89 e8                	mov    %ebp,%eax
  1006ef:	38 c2                	cmp    %al,%dl
  1006f1:	75 f3                	jne    1006e6 <console_vprintf+0x3b>
  1006f3:	e9 3f 03 00 00       	jmp    100a37 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006f8:	8a 17                	mov    (%edi),%dl
  1006fa:	84 d2                	test   %dl,%dl
  1006fc:	74 0b                	je     100709 <console_vprintf+0x5e>
  1006fe:	b9 8c 0a 10 00       	mov    $0x100a8c,%ecx
  100703:	89 d5                	mov    %edx,%ebp
  100705:	eb e0                	jmp    1006e7 <console_vprintf+0x3c>
  100707:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100709:	8d 42 cf             	lea    -0x31(%edx),%eax
  10070c:	3c 08                	cmp    $0x8,%al
  10070e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100715:	00 
  100716:	76 13                	jbe    10072b <console_vprintf+0x80>
  100718:	eb 1d                	jmp    100737 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10071a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10071f:	0f be c0             	movsbl %al,%eax
  100722:	47                   	inc    %edi
  100723:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100727:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10072b:	8a 07                	mov    (%edi),%al
  10072d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100730:	80 fa 09             	cmp    $0x9,%dl
  100733:	76 e5                	jbe    10071a <console_vprintf+0x6f>
  100735:	eb 18                	jmp    10074f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100737:	80 fa 2a             	cmp    $0x2a,%dl
  10073a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100741:	ff 
  100742:	75 0b                	jne    10074f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100744:	83 c3 04             	add    $0x4,%ebx
			++format;
  100747:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100748:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10074b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10074f:	83 cd ff             	or     $0xffffffff,%ebp
  100752:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100755:	75 37                	jne    10078e <console_vprintf+0xe3>
			++format;
  100757:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100758:	31 ed                	xor    %ebp,%ebp
  10075a:	8a 07                	mov    (%edi),%al
  10075c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10075f:	80 fa 09             	cmp    $0x9,%dl
  100762:	76 0d                	jbe    100771 <console_vprintf+0xc6>
  100764:	eb 17                	jmp    10077d <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100766:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100769:	0f be c0             	movsbl %al,%eax
  10076c:	47                   	inc    %edi
  10076d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100771:	8a 07                	mov    (%edi),%al
  100773:	8d 50 d0             	lea    -0x30(%eax),%edx
  100776:	80 fa 09             	cmp    $0x9,%dl
  100779:	76 eb                	jbe    100766 <console_vprintf+0xbb>
  10077b:	eb 11                	jmp    10078e <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  10077d:	3c 2a                	cmp    $0x2a,%al
  10077f:	75 0b                	jne    10078c <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100781:	83 c3 04             	add    $0x4,%ebx
				++format;
  100784:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100785:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100788:	85 ed                	test   %ebp,%ebp
  10078a:	79 02                	jns    10078e <console_vprintf+0xe3>
  10078c:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  10078e:	8a 07                	mov    (%edi),%al
  100790:	3c 64                	cmp    $0x64,%al
  100792:	74 34                	je     1007c8 <console_vprintf+0x11d>
  100794:	7f 1d                	jg     1007b3 <console_vprintf+0x108>
  100796:	3c 58                	cmp    $0x58,%al
  100798:	0f 84 a2 00 00 00    	je     100840 <console_vprintf+0x195>
  10079e:	3c 63                	cmp    $0x63,%al
  1007a0:	0f 84 bf 00 00 00    	je     100865 <console_vprintf+0x1ba>
  1007a6:	3c 43                	cmp    $0x43,%al
  1007a8:	0f 85 d0 00 00 00    	jne    10087e <console_vprintf+0x1d3>
  1007ae:	e9 a3 00 00 00       	jmp    100856 <console_vprintf+0x1ab>
  1007b3:	3c 75                	cmp    $0x75,%al
  1007b5:	74 4d                	je     100804 <console_vprintf+0x159>
  1007b7:	3c 78                	cmp    $0x78,%al
  1007b9:	74 5c                	je     100817 <console_vprintf+0x16c>
  1007bb:	3c 73                	cmp    $0x73,%al
  1007bd:	0f 85 bb 00 00 00    	jne    10087e <console_vprintf+0x1d3>
  1007c3:	e9 86 00 00 00       	jmp    10084e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007c8:	83 c3 04             	add    $0x4,%ebx
  1007cb:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007ce:	89 d1                	mov    %edx,%ecx
  1007d0:	c1 f9 1f             	sar    $0x1f,%ecx
  1007d3:	89 0c 24             	mov    %ecx,(%esp)
  1007d6:	31 ca                	xor    %ecx,%edx
  1007d8:	55                   	push   %ebp
  1007d9:	29 ca                	sub    %ecx,%edx
  1007db:	68 94 0a 10 00       	push   $0x100a94
  1007e0:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007e5:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007e9:	e8 90 fe ff ff       	call   10067e <fill_numbuf>
  1007ee:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007f2:	58                   	pop    %eax
  1007f3:	5a                   	pop    %edx
  1007f4:	ba 01 00 00 00       	mov    $0x1,%edx
  1007f9:	8b 04 24             	mov    (%esp),%eax
  1007fc:	83 e0 01             	and    $0x1,%eax
  1007ff:	e9 a5 00 00 00       	jmp    1008a9 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100804:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100807:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10080c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10080f:	55                   	push   %ebp
  100810:	68 94 0a 10 00       	push   $0x100a94
  100815:	eb 11                	jmp    100828 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100817:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10081a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10081d:	55                   	push   %ebp
  10081e:	68 a8 0a 10 00       	push   $0x100aa8
  100823:	b9 10 00 00 00       	mov    $0x10,%ecx
  100828:	8d 44 24 40          	lea    0x40(%esp),%eax
  10082c:	e8 4d fe ff ff       	call   10067e <fill_numbuf>
  100831:	ba 01 00 00 00       	mov    $0x1,%edx
  100836:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10083a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  10083c:	59                   	pop    %ecx
  10083d:	59                   	pop    %ecx
  10083e:	eb 69                	jmp    1008a9 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100840:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100843:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100846:	55                   	push   %ebp
  100847:	68 94 0a 10 00       	push   $0x100a94
  10084c:	eb d5                	jmp    100823 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  10084e:	83 c3 04             	add    $0x4,%ebx
  100851:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100854:	eb 40                	jmp    100896 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100856:	83 c3 04             	add    $0x4,%ebx
  100859:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10085c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100860:	e9 bd 01 00 00       	jmp    100a22 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100865:	83 c3 04             	add    $0x4,%ebx
  100868:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10086b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  10086f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100874:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100878:	88 44 24 24          	mov    %al,0x24(%esp)
  10087c:	eb 27                	jmp    1008a5 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  10087e:	84 c0                	test   %al,%al
  100880:	75 02                	jne    100884 <console_vprintf+0x1d9>
  100882:	b0 25                	mov    $0x25,%al
  100884:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100888:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  10088d:	80 3f 00             	cmpb   $0x0,(%edi)
  100890:	74 0a                	je     10089c <console_vprintf+0x1f1>
  100892:	8d 44 24 24          	lea    0x24(%esp),%eax
  100896:	89 44 24 04          	mov    %eax,0x4(%esp)
  10089a:	eb 09                	jmp    1008a5 <console_vprintf+0x1fa>
				format--;
  10089c:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008a0:	4f                   	dec    %edi
  1008a1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1008a5:	31 d2                	xor    %edx,%edx
  1008a7:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008a9:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  1008ab:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008b5:	74 1f                	je     1008d6 <console_vprintf+0x22b>
  1008b7:	89 04 24             	mov    %eax,(%esp)
  1008ba:	eb 01                	jmp    1008bd <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008bc:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008bd:	39 e9                	cmp    %ebp,%ecx
  1008bf:	74 0a                	je     1008cb <console_vprintf+0x220>
  1008c1:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008c5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008c9:	75 f1                	jne    1008bc <console_vprintf+0x211>
  1008cb:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008ce:	89 0c 24             	mov    %ecx,(%esp)
  1008d1:	eb 1f                	jmp    1008f2 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008d3:	42                   	inc    %edx
  1008d4:	eb 09                	jmp    1008df <console_vprintf+0x234>
  1008d6:	89 d1                	mov    %edx,%ecx
  1008d8:	8b 14 24             	mov    (%esp),%edx
  1008db:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008df:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008e3:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008e7:	75 ea                	jne    1008d3 <console_vprintf+0x228>
  1008e9:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008ed:	89 14 24             	mov    %edx,(%esp)
  1008f0:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008f2:	85 c0                	test   %eax,%eax
  1008f4:	74 0c                	je     100902 <console_vprintf+0x257>
  1008f6:	84 d2                	test   %dl,%dl
  1008f8:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008ff:	00 
  100900:	75 24                	jne    100926 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100902:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100907:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10090e:	00 
  10090f:	75 15                	jne    100926 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100911:	8b 44 24 14          	mov    0x14(%esp),%eax
  100915:	83 e0 08             	and    $0x8,%eax
  100918:	83 f8 01             	cmp    $0x1,%eax
  10091b:	19 c9                	sbb    %ecx,%ecx
  10091d:	f7 d1                	not    %ecx
  10091f:	83 e1 20             	and    $0x20,%ecx
  100922:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100926:	3b 2c 24             	cmp    (%esp),%ebp
  100929:	7e 0d                	jle    100938 <console_vprintf+0x28d>
  10092b:	84 d2                	test   %dl,%dl
  10092d:	74 40                	je     10096f <console_vprintf+0x2c4>
			zeros = precision - len;
  10092f:	2b 2c 24             	sub    (%esp),%ebp
  100932:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100936:	eb 3f                	jmp    100977 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100938:	84 d2                	test   %dl,%dl
  10093a:	74 33                	je     10096f <console_vprintf+0x2c4>
  10093c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100940:	83 e0 06             	and    $0x6,%eax
  100943:	83 f8 02             	cmp    $0x2,%eax
  100946:	75 27                	jne    10096f <console_vprintf+0x2c4>
  100948:	45                   	inc    %ebp
  100949:	75 24                	jne    10096f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10094b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10094d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100950:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100955:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100958:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10095b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  10095f:	7d 0e                	jge    10096f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100961:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100965:	29 ca                	sub    %ecx,%edx
  100967:	29 c2                	sub    %eax,%edx
  100969:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10096d:	eb 08                	jmp    100977 <console_vprintf+0x2cc>
  10096f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100976:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100977:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10097b:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10097d:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100981:	2b 2c 24             	sub    (%esp),%ebp
  100984:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100989:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10098c:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10098f:	29 c5                	sub    %eax,%ebp
  100991:	89 f0                	mov    %esi,%eax
  100993:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100997:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10099b:	eb 0f                	jmp    1009ac <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  10099d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009a1:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  1009a7:	e8 83 fc ff ff       	call   10062f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009ac:	85 ed                	test   %ebp,%ebp
  1009ae:	7e 07                	jle    1009b7 <console_vprintf+0x30c>
  1009b0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009b5:	74 e6                	je     10099d <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009b7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009bc:	89 c6                	mov    %eax,%esi
  1009be:	74 23                	je     1009e3 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009c0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009c5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009c9:	e8 61 fc ff ff       	call   10062f <console_putc>
  1009ce:	89 c6                	mov    %eax,%esi
  1009d0:	eb 11                	jmp    1009e3 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009d2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009d6:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009db:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009dc:	e8 4e fc ff ff       	call   10062f <console_putc>
  1009e1:	eb 06                	jmp    1009e9 <console_vprintf+0x33e>
  1009e3:	89 f0                	mov    %esi,%eax
  1009e5:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009e9:	85 f6                	test   %esi,%esi
  1009eb:	7f e5                	jg     1009d2 <console_vprintf+0x327>
  1009ed:	8b 34 24             	mov    (%esp),%esi
  1009f0:	eb 15                	jmp    100a07 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009f2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009f6:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009f7:	0f b6 11             	movzbl (%ecx),%edx
  1009fa:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009fe:	e8 2c fc ff ff       	call   10062f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a03:	ff 44 24 04          	incl   0x4(%esp)
  100a07:	85 f6                	test   %esi,%esi
  100a09:	7f e7                	jg     1009f2 <console_vprintf+0x347>
  100a0b:	eb 0f                	jmp    100a1c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a0d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a11:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a16:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a17:	e8 13 fc ff ff       	call   10062f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a1c:	85 ed                	test   %ebp,%ebp
  100a1e:	7f ed                	jg     100a0d <console_vprintf+0x362>
  100a20:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a22:	47                   	inc    %edi
  100a23:	8a 17                	mov    (%edi),%dl
  100a25:	84 d2                	test   %dl,%dl
  100a27:	0f 85 96 fc ff ff    	jne    1006c3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a2d:	83 c4 38             	add    $0x38,%esp
  100a30:	89 f0                	mov    %esi,%eax
  100a32:	5b                   	pop    %ebx
  100a33:	5e                   	pop    %esi
  100a34:	5f                   	pop    %edi
  100a35:	5d                   	pop    %ebp
  100a36:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a37:	81 e9 8c 0a 10 00    	sub    $0x100a8c,%ecx
  100a3d:	b8 01 00 00 00       	mov    $0x1,%eax
  100a42:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a44:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a45:	09 44 24 14          	or     %eax,0x14(%esp)
  100a49:	e9 aa fc ff ff       	jmp    1006f8 <console_vprintf+0x4d>

00100a4e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a4e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a52:	50                   	push   %eax
  100a53:	ff 74 24 10          	pushl  0x10(%esp)
  100a57:	ff 74 24 10          	pushl  0x10(%esp)
  100a5b:	ff 74 24 10          	pushl  0x10(%esp)
  100a5f:	e8 47 fc ff ff       	call   1006ab <console_vprintf>
  100a64:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a67:	c3                   	ret    
