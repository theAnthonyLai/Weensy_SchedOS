
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
  100014:	e8 72 01 00 00       	call   10018b <start>
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
  10009f:	a1 1c 7a 10 00       	mov    0x107a1c,%eax
  1000a4:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0) {
  1000a6:	a1 20 7a 10 00       	mov    0x107a20,%eax
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
  1000ba:	6b c2 50             	imul   $0x50,%edx,%eax
  1000bd:	83 b8 6c 70 10 00 01 	cmpl   $0x1,0x10706c(%eax)
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
  1000d7:	6b c2 50             	imul   $0x50,%edx,%eax
  1000da:	83 b8 6c 70 10 00 01 	cmpl   $0x1,0x10706c(%eax)
  1000e1:	75 0e                	jne    1000f1 <schedule+0x55>
				run(&proc_array[pid]);
  1000e3:	83 ec 0c             	sub    $0xc,%esp
  1000e6:	05 24 70 10 00       	add    $0x107024,%eax
  1000eb:	50                   	push   %eax
  1000ec:	e8 ac 03 00 00       	call   10049d <run>
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
  100100:	68 5c 0a 10 00       	push   $0x100a5c
  100105:	68 00 01 00 00       	push   $0x100
  10010a:	52                   	push   %edx
  10010b:	e8 32 09 00 00       	call   100a42 <console_printf>
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
  10011b:	a1 1c 7a 10 00       	mov    0x107a1c,%eax
  100120:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100125:	56                   	push   %esi
  100126:	53                   	push   %ebx
  100127:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10012b:	8d 78 04             	lea    0x4(%eax),%edi
  10012e:	89 de                	mov    %ebx,%esi
  100130:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100132:	8b 53 28             	mov    0x28(%ebx),%edx
  100135:	83 fa 31             	cmp    $0x31,%edx
  100138:	74 1f                	je     100159 <interrupt+0x3f>
  10013a:	77 0c                	ja     100148 <interrupt+0x2e>
  10013c:	83 fa 20             	cmp    $0x20,%edx
  10013f:	74 43                	je     100184 <interrupt+0x6a>
  100141:	83 fa 30             	cmp    $0x30,%edx
  100144:	74 0e                	je     100154 <interrupt+0x3a>
  100146:	eb 41                	jmp    100189 <interrupt+0x6f>
  100148:	83 fa 32             	cmp    $0x32,%edx
  10014b:	74 23                	je     100170 <interrupt+0x56>
  10014d:	83 fa 33             	cmp    $0x33,%edx
  100150:	74 29                	je     10017b <interrupt+0x61>
  100152:	eb 35                	jmp    100189 <interrupt+0x6f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100154:	e8 43 ff ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100159:	a1 1c 7a 10 00       	mov    0x107a1c,%eax
		current->p_exit_status = reg->reg_eax;
  10015e:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100161:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100168:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10016b:	e8 2c ff ff ff       	call   10009c <schedule>

	case INT_SYS_USER1:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		run(current);
  100170:	83 ec 0c             	sub    $0xc,%esp
  100173:	ff 35 1c 7a 10 00    	pushl  0x107a1c
  100179:	eb 04                	jmp    10017f <interrupt+0x65>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  10017b:	83 ec 0c             	sub    $0xc,%esp
  10017e:	50                   	push   %eax
  10017f:	e8 19 03 00 00       	call   10049d <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100184:	e8 13 ff ff ff       	call   10009c <schedule>
  100189:	eb fe                	jmp    100189 <interrupt+0x6f>

0010018b <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10018b:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10018c:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100191:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100192:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100194:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100195:	bb 74 70 10 00       	mov    $0x107074,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10019a:	e8 dd 00 00 00       	call   10027c <segments_init>
	interrupt_controller_init(0);
  10019f:	83 ec 0c             	sub    $0xc,%esp
  1001a2:	6a 00                	push   $0x0
  1001a4:	e8 ce 01 00 00       	call   100377 <interrupt_controller_init>
	console_clear();
  1001a9:	e8 52 02 00 00       	call   100400 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1001ae:	83 c4 0c             	add    $0xc,%esp
  1001b1:	68 90 01 00 00       	push   $0x190
  1001b6:	6a 00                	push   $0x0
  1001b8:	68 24 70 10 00       	push   $0x107024
  1001bd:	e8 1e 04 00 00       	call   1005e0 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001c2:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001c5:	c7 05 24 70 10 00 00 	movl   $0x0,0x107024
  1001cc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001cf:	c7 05 6c 70 10 00 00 	movl   $0x0,0x10706c
  1001d6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001d9:	c7 05 74 70 10 00 01 	movl   $0x1,0x107074
  1001e0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001e3:	c7 05 bc 70 10 00 00 	movl   $0x0,0x1070bc
  1001ea:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1001ed:	c7 05 c4 70 10 00 02 	movl   $0x2,0x1070c4
  1001f4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1001f7:	c7 05 0c 71 10 00 00 	movl   $0x0,0x10710c
  1001fe:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100201:	c7 05 14 71 10 00 03 	movl   $0x3,0x107114
  100208:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10020b:	c7 05 5c 71 10 00 00 	movl   $0x0,0x10715c
  100212:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100215:	c7 05 64 71 10 00 04 	movl   $0x4,0x107164
  10021c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10021f:	c7 05 ac 71 10 00 00 	movl   $0x0,0x1071ac
  100226:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100229:	83 ec 0c             	sub    $0xc,%esp
  10022c:	53                   	push   %ebx
  10022d:	e8 82 02 00 00       	call   1004b4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100232:	58                   	pop    %eax
  100233:	5a                   	pop    %edx
  100234:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100237:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10023a:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100240:	50                   	push   %eax
  100241:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100242:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100243:	e8 a8 02 00 00       	call   1004f0 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100248:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10024b:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  100252:	83 c3 50             	add    $0x50,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100255:	83 fe 04             	cmp    $0x4,%esi
  100258:	75 cf                	jne    100229 <start+0x9e>
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  10025a:	83 ec 0c             	sub    $0xc,%esp
  10025d:	68 74 70 10 00       	push   $0x107074
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100262:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100269:	80 0b 00 
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	scheduling_algorithm = 2;
  10026c:	c7 05 20 7a 10 00 02 	movl   $0x2,0x107a20
  100273:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100276:	e8 22 02 00 00       	call   10049d <run>
  10027b:	90                   	nop

0010027c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10027c:	b8 b4 71 10 00       	mov    $0x1071b4,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100281:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100286:	89 c2                	mov    %eax,%edx
  100288:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10028b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10028c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100291:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100294:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10029a:	c1 e8 18             	shr    $0x18,%eax
  10029d:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002a3:	ba 1c 72 10 00       	mov    $0x10721c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002a8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002ad:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002af:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1002b6:	68 00 
  1002b8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1002bf:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1002c6:	c7 05 b8 71 10 00 00 	movl   $0x180000,0x1071b8
  1002cd:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1002d0:	66 c7 05 bc 71 10 00 	movw   $0x10,0x1071bc
  1002d7:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002d9:	66 89 0c c5 1c 72 10 	mov    %cx,0x10721c(,%eax,8)
  1002e0:	00 
  1002e1:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1002e8:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1002ed:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1002f2:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1002f7:	40                   	inc    %eax
  1002f8:	3d 00 01 00 00       	cmp    $0x100,%eax
  1002fd:	75 da                	jne    1002d9 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1002ff:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100304:	ba 1c 72 10 00       	mov    $0x10721c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100309:	66 a3 1c 73 10 00    	mov    %ax,0x10731c
  10030f:	c1 e8 10             	shr    $0x10,%eax
  100312:	66 a3 22 73 10 00    	mov    %ax,0x107322
  100318:	b8 30 00 00 00       	mov    $0x30,%eax
  10031d:	66 c7 05 1e 73 10 00 	movw   $0x8,0x10731e
  100324:	08 00 
  100326:	c6 05 20 73 10 00 00 	movb   $0x0,0x107320
  10032d:	c6 05 21 73 10 00 8e 	movb   $0x8e,0x107321

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100334:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10033b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100342:	66 89 0c c5 1c 72 10 	mov    %cx,0x10721c(,%eax,8)
  100349:	00 
  10034a:	c1 e9 10             	shr    $0x10,%ecx
  10034d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100352:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100357:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10035c:	40                   	inc    %eax
  10035d:	83 f8 3a             	cmp    $0x3a,%eax
  100360:	75 d2                	jne    100334 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100362:	b0 28                	mov    $0x28,%al
  100364:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10036b:	0f 00 d8             	ltr    %ax
  10036e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100375:	5b                   	pop    %ebx
  100376:	c3                   	ret    

00100377 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100377:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100378:	b0 ff                	mov    $0xff,%al
  10037a:	57                   	push   %edi
  10037b:	56                   	push   %esi
  10037c:	53                   	push   %ebx
  10037d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100382:	89 da                	mov    %ebx,%edx
  100384:	ee                   	out    %al,(%dx)
  100385:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10038a:	89 ca                	mov    %ecx,%edx
  10038c:	ee                   	out    %al,(%dx)
  10038d:	be 11 00 00 00       	mov    $0x11,%esi
  100392:	bf 20 00 00 00       	mov    $0x20,%edi
  100397:	89 f0                	mov    %esi,%eax
  100399:	89 fa                	mov    %edi,%edx
  10039b:	ee                   	out    %al,(%dx)
  10039c:	b0 20                	mov    $0x20,%al
  10039e:	89 da                	mov    %ebx,%edx
  1003a0:	ee                   	out    %al,(%dx)
  1003a1:	b0 04                	mov    $0x4,%al
  1003a3:	ee                   	out    %al,(%dx)
  1003a4:	b0 03                	mov    $0x3,%al
  1003a6:	ee                   	out    %al,(%dx)
  1003a7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1003ac:	89 f0                	mov    %esi,%eax
  1003ae:	89 ea                	mov    %ebp,%edx
  1003b0:	ee                   	out    %al,(%dx)
  1003b1:	b0 28                	mov    $0x28,%al
  1003b3:	89 ca                	mov    %ecx,%edx
  1003b5:	ee                   	out    %al,(%dx)
  1003b6:	b0 02                	mov    $0x2,%al
  1003b8:	ee                   	out    %al,(%dx)
  1003b9:	b0 01                	mov    $0x1,%al
  1003bb:	ee                   	out    %al,(%dx)
  1003bc:	b0 68                	mov    $0x68,%al
  1003be:	89 fa                	mov    %edi,%edx
  1003c0:	ee                   	out    %al,(%dx)
  1003c1:	be 0a 00 00 00       	mov    $0xa,%esi
  1003c6:	89 f0                	mov    %esi,%eax
  1003c8:	ee                   	out    %al,(%dx)
  1003c9:	b0 68                	mov    $0x68,%al
  1003cb:	89 ea                	mov    %ebp,%edx
  1003cd:	ee                   	out    %al,(%dx)
  1003ce:	89 f0                	mov    %esi,%eax
  1003d0:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1003d1:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1003d6:	89 da                	mov    %ebx,%edx
  1003d8:	19 c0                	sbb    %eax,%eax
  1003da:	f7 d0                	not    %eax
  1003dc:	05 ff 00 00 00       	add    $0xff,%eax
  1003e1:	ee                   	out    %al,(%dx)
  1003e2:	b0 ff                	mov    $0xff,%al
  1003e4:	89 ca                	mov    %ecx,%edx
  1003e6:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1003e7:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1003ec:	74 0d                	je     1003fb <interrupt_controller_init+0x84>
  1003ee:	b2 43                	mov    $0x43,%dl
  1003f0:	b0 34                	mov    $0x34,%al
  1003f2:	ee                   	out    %al,(%dx)
  1003f3:	b0 9c                	mov    $0x9c,%al
  1003f5:	b2 40                	mov    $0x40,%dl
  1003f7:	ee                   	out    %al,(%dx)
  1003f8:	b0 2e                	mov    $0x2e,%al
  1003fa:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1003fb:	5b                   	pop    %ebx
  1003fc:	5e                   	pop    %esi
  1003fd:	5f                   	pop    %edi
  1003fe:	5d                   	pop    %ebp
  1003ff:	c3                   	ret    

00100400 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100400:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100401:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100403:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100404:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10040b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10040e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100414:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10041a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10041d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100422:	75 ea                	jne    10040e <console_clear+0xe>
  100424:	be d4 03 00 00       	mov    $0x3d4,%esi
  100429:	b0 0e                	mov    $0xe,%al
  10042b:	89 f2                	mov    %esi,%edx
  10042d:	ee                   	out    %al,(%dx)
  10042e:	31 c9                	xor    %ecx,%ecx
  100430:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100435:	88 c8                	mov    %cl,%al
  100437:	89 da                	mov    %ebx,%edx
  100439:	ee                   	out    %al,(%dx)
  10043a:	b0 0f                	mov    $0xf,%al
  10043c:	89 f2                	mov    %esi,%edx
  10043e:	ee                   	out    %al,(%dx)
  10043f:	88 c8                	mov    %cl,%al
  100441:	89 da                	mov    %ebx,%edx
  100443:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100444:	5b                   	pop    %ebx
  100445:	5e                   	pop    %esi
  100446:	c3                   	ret    

00100447 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100447:	ba 64 00 00 00       	mov    $0x64,%edx
  10044c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10044d:	a8 01                	test   $0x1,%al
  10044f:	74 45                	je     100496 <console_read_digit+0x4f>
  100451:	b2 60                	mov    $0x60,%dl
  100453:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100454:	8d 50 fe             	lea    -0x2(%eax),%edx
  100457:	80 fa 08             	cmp    $0x8,%dl
  10045a:	77 05                	ja     100461 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10045c:	0f b6 c0             	movzbl %al,%eax
  10045f:	48                   	dec    %eax
  100460:	c3                   	ret    
	else if (data == 0x0B)
  100461:	3c 0b                	cmp    $0xb,%al
  100463:	74 35                	je     10049a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100465:	8d 50 b9             	lea    -0x47(%eax),%edx
  100468:	80 fa 02             	cmp    $0x2,%dl
  10046b:	77 07                	ja     100474 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10046d:	0f b6 c0             	movzbl %al,%eax
  100470:	83 e8 40             	sub    $0x40,%eax
  100473:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100474:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100477:	80 fa 02             	cmp    $0x2,%dl
  10047a:	77 07                	ja     100483 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10047c:	0f b6 c0             	movzbl %al,%eax
  10047f:	83 e8 47             	sub    $0x47,%eax
  100482:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100483:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100486:	80 fa 02             	cmp    $0x2,%dl
  100489:	77 07                	ja     100492 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10048b:	0f b6 c0             	movzbl %al,%eax
  10048e:	83 e8 4e             	sub    $0x4e,%eax
  100491:	c3                   	ret    
	else if (data == 0x53)
  100492:	3c 53                	cmp    $0x53,%al
  100494:	74 04                	je     10049a <console_read_digit+0x53>
  100496:	83 c8 ff             	or     $0xffffffff,%eax
  100499:	c3                   	ret    
  10049a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10049c:	c3                   	ret    

0010049d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10049d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1004a1:	a3 1c 7a 10 00       	mov    %eax,0x107a1c

	asm volatile("movl %0,%%esp\n\t"
  1004a6:	83 c0 04             	add    $0x4,%eax
  1004a9:	89 c4                	mov    %eax,%esp
  1004ab:	61                   	popa   
  1004ac:	07                   	pop    %es
  1004ad:	1f                   	pop    %ds
  1004ae:	83 c4 08             	add    $0x8,%esp
  1004b1:	cf                   	iret   
  1004b2:	eb fe                	jmp    1004b2 <run+0x15>

001004b4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1004b4:	53                   	push   %ebx
  1004b5:	83 ec 0c             	sub    $0xc,%esp
  1004b8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1004bc:	6a 44                	push   $0x44
  1004be:	6a 00                	push   $0x0
  1004c0:	8d 43 04             	lea    0x4(%ebx),%eax
  1004c3:	50                   	push   %eax
  1004c4:	e8 17 01 00 00       	call   1005e0 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1004c9:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1004cf:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1004d5:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1004db:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1004e1:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1004e8:	83 c4 18             	add    $0x18,%esp
  1004eb:	5b                   	pop    %ebx
  1004ec:	c3                   	ret    
  1004ed:	90                   	nop
  1004ee:	90                   	nop
  1004ef:	90                   	nop

001004f0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1004f0:	55                   	push   %ebp
  1004f1:	57                   	push   %edi
  1004f2:	56                   	push   %esi
  1004f3:	53                   	push   %ebx
  1004f4:	83 ec 1c             	sub    $0x1c,%esp
  1004f7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1004fb:	83 f8 03             	cmp    $0x3,%eax
  1004fe:	7f 04                	jg     100504 <program_loader+0x14>
  100500:	85 c0                	test   %eax,%eax
  100502:	79 02                	jns    100506 <program_loader+0x16>
  100504:	eb fe                	jmp    100504 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100506:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10050d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100513:	74 02                	je     100517 <program_loader+0x27>
  100515:	eb fe                	jmp    100515 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100517:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10051a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10051e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100520:	c1 e5 05             	shl    $0x5,%ebp
  100523:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100526:	eb 3f                	jmp    100567 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100528:	83 3b 01             	cmpl   $0x1,(%ebx)
  10052b:	75 37                	jne    100564 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10052d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100530:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100533:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100536:	01 c7                	add    %eax,%edi
	memsz += va;
  100538:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10053a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10053f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100543:	52                   	push   %edx
  100544:	89 fa                	mov    %edi,%edx
  100546:	29 c2                	sub    %eax,%edx
  100548:	52                   	push   %edx
  100549:	8b 53 04             	mov    0x4(%ebx),%edx
  10054c:	01 f2                	add    %esi,%edx
  10054e:	52                   	push   %edx
  10054f:	50                   	push   %eax
  100550:	e8 27 00 00 00       	call   10057c <memcpy>
  100555:	83 c4 10             	add    $0x10,%esp
  100558:	eb 04                	jmp    10055e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10055a:	c6 07 00             	movb   $0x0,(%edi)
  10055d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10055e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100562:	72 f6                	jb     10055a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100564:	83 c3 20             	add    $0x20,%ebx
  100567:	39 eb                	cmp    %ebp,%ebx
  100569:	72 bd                	jb     100528 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10056b:	8b 56 18             	mov    0x18(%esi),%edx
  10056e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100572:	89 10                	mov    %edx,(%eax)
}
  100574:	83 c4 1c             	add    $0x1c,%esp
  100577:	5b                   	pop    %ebx
  100578:	5e                   	pop    %esi
  100579:	5f                   	pop    %edi
  10057a:	5d                   	pop    %ebp
  10057b:	c3                   	ret    

0010057c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10057c:	56                   	push   %esi
  10057d:	31 d2                	xor    %edx,%edx
  10057f:	53                   	push   %ebx
  100580:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100584:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100588:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10058c:	eb 08                	jmp    100596 <memcpy+0x1a>
		*d++ = *s++;
  10058e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100591:	4e                   	dec    %esi
  100592:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100595:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100596:	85 f6                	test   %esi,%esi
  100598:	75 f4                	jne    10058e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10059a:	5b                   	pop    %ebx
  10059b:	5e                   	pop    %esi
  10059c:	c3                   	ret    

0010059d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10059d:	57                   	push   %edi
  10059e:	56                   	push   %esi
  10059f:	53                   	push   %ebx
  1005a0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1005a4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1005a8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1005ac:	39 c7                	cmp    %eax,%edi
  1005ae:	73 26                	jae    1005d6 <memmove+0x39>
  1005b0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1005b3:	39 c6                	cmp    %eax,%esi
  1005b5:	76 1f                	jbe    1005d6 <memmove+0x39>
		s += n, d += n;
  1005b7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1005ba:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1005bc:	eb 07                	jmp    1005c5 <memmove+0x28>
			*--d = *--s;
  1005be:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1005c1:	4a                   	dec    %edx
  1005c2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1005c5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1005c6:	85 d2                	test   %edx,%edx
  1005c8:	75 f4                	jne    1005be <memmove+0x21>
  1005ca:	eb 10                	jmp    1005dc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1005cc:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1005cf:	4a                   	dec    %edx
  1005d0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1005d3:	41                   	inc    %ecx
  1005d4:	eb 02                	jmp    1005d8 <memmove+0x3b>
  1005d6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1005d8:	85 d2                	test   %edx,%edx
  1005da:	75 f0                	jne    1005cc <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1005dc:	5b                   	pop    %ebx
  1005dd:	5e                   	pop    %esi
  1005de:	5f                   	pop    %edi
  1005df:	c3                   	ret    

001005e0 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1005e0:	53                   	push   %ebx
  1005e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1005e5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1005e9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1005ed:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1005ef:	eb 04                	jmp    1005f5 <memset+0x15>
		*p++ = c;
  1005f1:	88 1a                	mov    %bl,(%edx)
  1005f3:	49                   	dec    %ecx
  1005f4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1005f5:	85 c9                	test   %ecx,%ecx
  1005f7:	75 f8                	jne    1005f1 <memset+0x11>
		*p++ = c;
	return v;
}
  1005f9:	5b                   	pop    %ebx
  1005fa:	c3                   	ret    

001005fb <strlen>:

size_t
strlen(const char *s)
{
  1005fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  1005ff:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100601:	eb 01                	jmp    100604 <strlen+0x9>
		++n;
  100603:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100604:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100608:	75 f9                	jne    100603 <strlen+0x8>
		++n;
	return n;
}
  10060a:	c3                   	ret    

0010060b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10060b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10060f:	31 c0                	xor    %eax,%eax
  100611:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100615:	eb 01                	jmp    100618 <strnlen+0xd>
		++n;
  100617:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100618:	39 d0                	cmp    %edx,%eax
  10061a:	74 06                	je     100622 <strnlen+0x17>
  10061c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100620:	75 f5                	jne    100617 <strnlen+0xc>
		++n;
	return n;
}
  100622:	c3                   	ret    

00100623 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100623:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100624:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100629:	53                   	push   %ebx
  10062a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10062c:	76 05                	jbe    100633 <console_putc+0x10>
  10062e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100633:	80 fa 0a             	cmp    $0xa,%dl
  100636:	75 2c                	jne    100664 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100638:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10063e:	be 50 00 00 00       	mov    $0x50,%esi
  100643:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100645:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100648:	99                   	cltd   
  100649:	f7 fe                	idiv   %esi
  10064b:	89 de                	mov    %ebx,%esi
  10064d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10064f:	eb 07                	jmp    100658 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100651:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100654:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100655:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100658:	83 f8 50             	cmp    $0x50,%eax
  10065b:	75 f4                	jne    100651 <console_putc+0x2e>
  10065d:	29 d0                	sub    %edx,%eax
  10065f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100662:	eb 0b                	jmp    10066f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100664:	0f b6 d2             	movzbl %dl,%edx
  100667:	09 ca                	or     %ecx,%edx
  100669:	66 89 13             	mov    %dx,(%ebx)
  10066c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10066f:	5b                   	pop    %ebx
  100670:	5e                   	pop    %esi
  100671:	c3                   	ret    

00100672 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100672:	56                   	push   %esi
  100673:	53                   	push   %ebx
  100674:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100678:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10067b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10067f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100684:	75 04                	jne    10068a <fill_numbuf+0x18>
  100686:	85 d2                	test   %edx,%edx
  100688:	74 10                	je     10069a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10068a:	89 d0                	mov    %edx,%eax
  10068c:	31 d2                	xor    %edx,%edx
  10068e:	f7 f1                	div    %ecx
  100690:	4b                   	dec    %ebx
  100691:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100694:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100696:	89 c2                	mov    %eax,%edx
  100698:	eb ec                	jmp    100686 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10069a:	89 d8                	mov    %ebx,%eax
  10069c:	5b                   	pop    %ebx
  10069d:	5e                   	pop    %esi
  10069e:	c3                   	ret    

0010069f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10069f:	55                   	push   %ebp
  1006a0:	57                   	push   %edi
  1006a1:	56                   	push   %esi
  1006a2:	53                   	push   %ebx
  1006a3:	83 ec 38             	sub    $0x38,%esp
  1006a6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1006aa:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1006ae:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1006b2:	e9 60 03 00 00       	jmp    100a17 <console_vprintf+0x378>
		if (*format != '%') {
  1006b7:	80 fa 25             	cmp    $0x25,%dl
  1006ba:	74 13                	je     1006cf <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1006bc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1006c0:	0f b6 d2             	movzbl %dl,%edx
  1006c3:	89 f0                	mov    %esi,%eax
  1006c5:	e8 59 ff ff ff       	call   100623 <console_putc>
  1006ca:	e9 45 03 00 00       	jmp    100a14 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006cf:	47                   	inc    %edi
  1006d0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1006d7:	00 
  1006d8:	eb 12                	jmp    1006ec <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1006da:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1006db:	8a 11                	mov    (%ecx),%dl
  1006dd:	84 d2                	test   %dl,%dl
  1006df:	74 1a                	je     1006fb <console_vprintf+0x5c>
  1006e1:	89 e8                	mov    %ebp,%eax
  1006e3:	38 c2                	cmp    %al,%dl
  1006e5:	75 f3                	jne    1006da <console_vprintf+0x3b>
  1006e7:	e9 3f 03 00 00       	jmp    100a2b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1006ec:	8a 17                	mov    (%edi),%dl
  1006ee:	84 d2                	test   %dl,%dl
  1006f0:	74 0b                	je     1006fd <console_vprintf+0x5e>
  1006f2:	b9 80 0a 10 00       	mov    $0x100a80,%ecx
  1006f7:	89 d5                	mov    %edx,%ebp
  1006f9:	eb e0                	jmp    1006db <console_vprintf+0x3c>
  1006fb:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1006fd:	8d 42 cf             	lea    -0x31(%edx),%eax
  100700:	3c 08                	cmp    $0x8,%al
  100702:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100709:	00 
  10070a:	76 13                	jbe    10071f <console_vprintf+0x80>
  10070c:	eb 1d                	jmp    10072b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10070e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100713:	0f be c0             	movsbl %al,%eax
  100716:	47                   	inc    %edi
  100717:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10071b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10071f:	8a 07                	mov    (%edi),%al
  100721:	8d 50 d0             	lea    -0x30(%eax),%edx
  100724:	80 fa 09             	cmp    $0x9,%dl
  100727:	76 e5                	jbe    10070e <console_vprintf+0x6f>
  100729:	eb 18                	jmp    100743 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10072b:	80 fa 2a             	cmp    $0x2a,%dl
  10072e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100735:	ff 
  100736:	75 0b                	jne    100743 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100738:	83 c3 04             	add    $0x4,%ebx
			++format;
  10073b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10073c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10073f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100743:	83 cd ff             	or     $0xffffffff,%ebp
  100746:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100749:	75 37                	jne    100782 <console_vprintf+0xe3>
			++format;
  10074b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10074c:	31 ed                	xor    %ebp,%ebp
  10074e:	8a 07                	mov    (%edi),%al
  100750:	8d 50 d0             	lea    -0x30(%eax),%edx
  100753:	80 fa 09             	cmp    $0x9,%dl
  100756:	76 0d                	jbe    100765 <console_vprintf+0xc6>
  100758:	eb 17                	jmp    100771 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10075a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10075d:	0f be c0             	movsbl %al,%eax
  100760:	47                   	inc    %edi
  100761:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100765:	8a 07                	mov    (%edi),%al
  100767:	8d 50 d0             	lea    -0x30(%eax),%edx
  10076a:	80 fa 09             	cmp    $0x9,%dl
  10076d:	76 eb                	jbe    10075a <console_vprintf+0xbb>
  10076f:	eb 11                	jmp    100782 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100771:	3c 2a                	cmp    $0x2a,%al
  100773:	75 0b                	jne    100780 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100775:	83 c3 04             	add    $0x4,%ebx
				++format;
  100778:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100779:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10077c:	85 ed                	test   %ebp,%ebp
  10077e:	79 02                	jns    100782 <console_vprintf+0xe3>
  100780:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100782:	8a 07                	mov    (%edi),%al
  100784:	3c 64                	cmp    $0x64,%al
  100786:	74 34                	je     1007bc <console_vprintf+0x11d>
  100788:	7f 1d                	jg     1007a7 <console_vprintf+0x108>
  10078a:	3c 58                	cmp    $0x58,%al
  10078c:	0f 84 a2 00 00 00    	je     100834 <console_vprintf+0x195>
  100792:	3c 63                	cmp    $0x63,%al
  100794:	0f 84 bf 00 00 00    	je     100859 <console_vprintf+0x1ba>
  10079a:	3c 43                	cmp    $0x43,%al
  10079c:	0f 85 d0 00 00 00    	jne    100872 <console_vprintf+0x1d3>
  1007a2:	e9 a3 00 00 00       	jmp    10084a <console_vprintf+0x1ab>
  1007a7:	3c 75                	cmp    $0x75,%al
  1007a9:	74 4d                	je     1007f8 <console_vprintf+0x159>
  1007ab:	3c 78                	cmp    $0x78,%al
  1007ad:	74 5c                	je     10080b <console_vprintf+0x16c>
  1007af:	3c 73                	cmp    $0x73,%al
  1007b1:	0f 85 bb 00 00 00    	jne    100872 <console_vprintf+0x1d3>
  1007b7:	e9 86 00 00 00       	jmp    100842 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1007bc:	83 c3 04             	add    $0x4,%ebx
  1007bf:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1007c2:	89 d1                	mov    %edx,%ecx
  1007c4:	c1 f9 1f             	sar    $0x1f,%ecx
  1007c7:	89 0c 24             	mov    %ecx,(%esp)
  1007ca:	31 ca                	xor    %ecx,%edx
  1007cc:	55                   	push   %ebp
  1007cd:	29 ca                	sub    %ecx,%edx
  1007cf:	68 88 0a 10 00       	push   $0x100a88
  1007d4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1007d9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1007dd:	e8 90 fe ff ff       	call   100672 <fill_numbuf>
  1007e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1007e6:	58                   	pop    %eax
  1007e7:	5a                   	pop    %edx
  1007e8:	ba 01 00 00 00       	mov    $0x1,%edx
  1007ed:	8b 04 24             	mov    (%esp),%eax
  1007f0:	83 e0 01             	and    $0x1,%eax
  1007f3:	e9 a5 00 00 00       	jmp    10089d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1007f8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1007fb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100800:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100803:	55                   	push   %ebp
  100804:	68 88 0a 10 00       	push   $0x100a88
  100809:	eb 11                	jmp    10081c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10080b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10080e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100811:	55                   	push   %ebp
  100812:	68 9c 0a 10 00       	push   $0x100a9c
  100817:	b9 10 00 00 00       	mov    $0x10,%ecx
  10081c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100820:	e8 4d fe ff ff       	call   100672 <fill_numbuf>
  100825:	ba 01 00 00 00       	mov    $0x1,%edx
  10082a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10082e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100830:	59                   	pop    %ecx
  100831:	59                   	pop    %ecx
  100832:	eb 69                	jmp    10089d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100834:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100837:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10083a:	55                   	push   %ebp
  10083b:	68 88 0a 10 00       	push   $0x100a88
  100840:	eb d5                	jmp    100817 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100842:	83 c3 04             	add    $0x4,%ebx
  100845:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100848:	eb 40                	jmp    10088a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10084a:	83 c3 04             	add    $0x4,%ebx
  10084d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100850:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100854:	e9 bd 01 00 00       	jmp    100a16 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100859:	83 c3 04             	add    $0x4,%ebx
  10085c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10085f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100863:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100868:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10086c:	88 44 24 24          	mov    %al,0x24(%esp)
  100870:	eb 27                	jmp    100899 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100872:	84 c0                	test   %al,%al
  100874:	75 02                	jne    100878 <console_vprintf+0x1d9>
  100876:	b0 25                	mov    $0x25,%al
  100878:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10087c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100881:	80 3f 00             	cmpb   $0x0,(%edi)
  100884:	74 0a                	je     100890 <console_vprintf+0x1f1>
  100886:	8d 44 24 24          	lea    0x24(%esp),%eax
  10088a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10088e:	eb 09                	jmp    100899 <console_vprintf+0x1fa>
				format--;
  100890:	8d 54 24 24          	lea    0x24(%esp),%edx
  100894:	4f                   	dec    %edi
  100895:	89 54 24 04          	mov    %edx,0x4(%esp)
  100899:	31 d2                	xor    %edx,%edx
  10089b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10089d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10089f:	83 fd ff             	cmp    $0xffffffff,%ebp
  1008a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1008a9:	74 1f                	je     1008ca <console_vprintf+0x22b>
  1008ab:	89 04 24             	mov    %eax,(%esp)
  1008ae:	eb 01                	jmp    1008b1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1008b0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008b1:	39 e9                	cmp    %ebp,%ecx
  1008b3:	74 0a                	je     1008bf <console_vprintf+0x220>
  1008b5:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008b9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1008bd:	75 f1                	jne    1008b0 <console_vprintf+0x211>
  1008bf:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1008c2:	89 0c 24             	mov    %ecx,(%esp)
  1008c5:	eb 1f                	jmp    1008e6 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1008c7:	42                   	inc    %edx
  1008c8:	eb 09                	jmp    1008d3 <console_vprintf+0x234>
  1008ca:	89 d1                	mov    %edx,%ecx
  1008cc:	8b 14 24             	mov    (%esp),%edx
  1008cf:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1008d3:	8b 44 24 04          	mov    0x4(%esp),%eax
  1008d7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1008db:	75 ea                	jne    1008c7 <console_vprintf+0x228>
  1008dd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1008e1:	89 14 24             	mov    %edx,(%esp)
  1008e4:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1008e6:	85 c0                	test   %eax,%eax
  1008e8:	74 0c                	je     1008f6 <console_vprintf+0x257>
  1008ea:	84 d2                	test   %dl,%dl
  1008ec:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1008f3:	00 
  1008f4:	75 24                	jne    10091a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1008f6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1008fb:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100902:	00 
  100903:	75 15                	jne    10091a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100905:	8b 44 24 14          	mov    0x14(%esp),%eax
  100909:	83 e0 08             	and    $0x8,%eax
  10090c:	83 f8 01             	cmp    $0x1,%eax
  10090f:	19 c9                	sbb    %ecx,%ecx
  100911:	f7 d1                	not    %ecx
  100913:	83 e1 20             	and    $0x20,%ecx
  100916:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  10091a:	3b 2c 24             	cmp    (%esp),%ebp
  10091d:	7e 0d                	jle    10092c <console_vprintf+0x28d>
  10091f:	84 d2                	test   %dl,%dl
  100921:	74 40                	je     100963 <console_vprintf+0x2c4>
			zeros = precision - len;
  100923:	2b 2c 24             	sub    (%esp),%ebp
  100926:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  10092a:	eb 3f                	jmp    10096b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10092c:	84 d2                	test   %dl,%dl
  10092e:	74 33                	je     100963 <console_vprintf+0x2c4>
  100930:	8b 44 24 14          	mov    0x14(%esp),%eax
  100934:	83 e0 06             	and    $0x6,%eax
  100937:	83 f8 02             	cmp    $0x2,%eax
  10093a:	75 27                	jne    100963 <console_vprintf+0x2c4>
  10093c:	45                   	inc    %ebp
  10093d:	75 24                	jne    100963 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  10093f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100941:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100944:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100949:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  10094c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  10094f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100953:	7d 0e                	jge    100963 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100955:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100959:	29 ca                	sub    %ecx,%edx
  10095b:	29 c2                	sub    %eax,%edx
  10095d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100961:	eb 08                	jmp    10096b <console_vprintf+0x2cc>
  100963:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  10096a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  10096b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  10096f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100971:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100975:	2b 2c 24             	sub    (%esp),%ebp
  100978:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  10097d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100980:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100983:	29 c5                	sub    %eax,%ebp
  100985:	89 f0                	mov    %esi,%eax
  100987:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10098b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  10098f:	eb 0f                	jmp    1009a0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100991:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100995:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  10099a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  10099b:	e8 83 fc ff ff       	call   100623 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009a0:	85 ed                	test   %ebp,%ebp
  1009a2:	7e 07                	jle    1009ab <console_vprintf+0x30c>
  1009a4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  1009a9:	74 e6                	je     100991 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  1009ab:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b0:	89 c6                	mov    %eax,%esi
  1009b2:	74 23                	je     1009d7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  1009b4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  1009b9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009bd:	e8 61 fc ff ff       	call   100623 <console_putc>
  1009c2:	89 c6                	mov    %eax,%esi
  1009c4:	eb 11                	jmp    1009d7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  1009c6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009ca:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009cf:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  1009d0:	e8 4e fc ff ff       	call   100623 <console_putc>
  1009d5:	eb 06                	jmp    1009dd <console_vprintf+0x33e>
  1009d7:	89 f0                	mov    %esi,%eax
  1009d9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  1009dd:	85 f6                	test   %esi,%esi
  1009df:	7f e5                	jg     1009c6 <console_vprintf+0x327>
  1009e1:	8b 34 24             	mov    (%esp),%esi
  1009e4:	eb 15                	jmp    1009fb <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  1009e6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009ea:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  1009eb:	0f b6 11             	movzbl (%ecx),%edx
  1009ee:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009f2:	e8 2c fc ff ff       	call   100623 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  1009f7:	ff 44 24 04          	incl   0x4(%esp)
  1009fb:	85 f6                	test   %esi,%esi
  1009fd:	7f e7                	jg     1009e6 <console_vprintf+0x347>
  1009ff:	eb 0f                	jmp    100a10 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a05:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a0a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a0b:	e8 13 fc ff ff       	call   100623 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a10:	85 ed                	test   %ebp,%ebp
  100a12:	7f ed                	jg     100a01 <console_vprintf+0x362>
  100a14:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a16:	47                   	inc    %edi
  100a17:	8a 17                	mov    (%edi),%dl
  100a19:	84 d2                	test   %dl,%dl
  100a1b:	0f 85 96 fc ff ff    	jne    1006b7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a21:	83 c4 38             	add    $0x38,%esp
  100a24:	89 f0                	mov    %esi,%eax
  100a26:	5b                   	pop    %ebx
  100a27:	5e                   	pop    %esi
  100a28:	5f                   	pop    %edi
  100a29:	5d                   	pop    %ebp
  100a2a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a2b:	81 e9 80 0a 10 00    	sub    $0x100a80,%ecx
  100a31:	b8 01 00 00 00       	mov    $0x1,%eax
  100a36:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100a38:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a39:	09 44 24 14          	or     %eax,0x14(%esp)
  100a3d:	e9 aa fc ff ff       	jmp    1006ec <console_vprintf+0x4d>

00100a42 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100a42:	8d 44 24 10          	lea    0x10(%esp),%eax
  100a46:	50                   	push   %eax
  100a47:	ff 74 24 10          	pushl  0x10(%esp)
  100a4b:	ff 74 24 10          	pushl  0x10(%esp)
  100a4f:	ff 74 24 10          	pushl  0x10(%esp)
  100a53:	e8 47 fc ff ff       	call   10069f <console_vprintf>
  100a58:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100a5b:	c3                   	ret    
