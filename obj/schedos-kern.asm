
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
  100014:	e8 d8 01 00 00       	call   1001f1 <start>
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
  10006d:	e8 03 01 00 00       	call   100175 <interrupt>

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
 *****************************************************************************/

void
schedule(void)
{
	pid_t pid = current->p_pid;
  10009c:	a1 04 7c 10 00       	mov    0x107c04,%eax
 *
 *****************************************************************************/

void
schedule(void)
{
  1000a1:	57                   	push   %edi
  1000a2:	56                   	push   %esi
  1000a3:	53                   	push   %ebx
	pid_t pid = current->p_pid;
  1000a4:	8b 10                	mov    (%eax),%edx
	unsigned int firstPriority;
	pid_t firstPid;
	int i;
	if (scheduling_algorithm == 0) {
  1000a6:	a1 08 7c 10 00       	mov    0x107c08,%eax
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
  1000bd:	83 b8 44 72 10 00 01 	cmpl   $0x1,0x107244(%eax)
  1000c4:	75 ee                	jne    1000b4 <schedule+0x18>
  1000c6:	eb 1b                	jmp    1000e3 <schedule+0x47>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000c8:	83 f8 02             	cmp    $0x2,%eax
  1000cb:	75 29                	jne    1000f6 <schedule+0x5a>
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
  1000da:	83 b8 44 72 10 00 01 	cmpl   $0x1,0x107244(%eax)
  1000e1:	75 0b                	jne    1000ee <schedule+0x52>
				run(&proc_array[pid]);
  1000e3:	83 ec 0c             	sub    $0xc,%esp
  1000e6:	05 f8 71 10 00       	add    $0x1071f8,%eax
  1000eb:	50                   	push   %eax
  1000ec:	eb 61                	jmp    10014f <schedule+0xb3>
			pid = (pid + 1) % NPROCS;
  1000ee:	8d 42 01             	lea    0x1(%edx),%eax
  1000f1:	99                   	cltd   
  1000f2:	f7 f9                	idiv   %ecx
		}
  1000f4:	eb e1                	jmp    1000d7 <schedule+0x3b>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000f6:	83 f8 29             	cmp    $0x29,%eax
  1000f9:	75 59                	jne    100154 <schedule+0xb8>
		//firstPriority = proc_array[pid].p_priority;
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1000fb:	bf 05 00 00 00       	mov    $0x5,%edi
		
		//firstPid = pid;
		//firstPriority = proc_array[pid].p_priority;
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
  100100:	6b c2 54             	imul   $0x54,%edx,%eax
  100103:	89 d6                	mov    %edx,%esi
  100105:	31 c9                	xor    %ecx,%ecx
  100107:	8b 98 40 72 10 00    	mov    0x107240(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  10010d:	8d 42 01             	lea    0x1(%edx),%eax
  100110:	99                   	cltd   
  100111:	f7 ff                	idiv   %edi
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  100113:	6b c2 54             	imul   $0x54,%edx,%eax
  100116:	83 b8 44 72 10 00 01 	cmpl   $0x1,0x107244(%eax)
  10011d:	75 0e                	jne    10012d <schedule+0x91>
  10011f:	8b 80 40 72 10 00    	mov    0x107240(%eax),%eax
  100125:	39 d8                	cmp    %ebx,%eax
  100127:	77 04                	ja     10012d <schedule+0x91>
  100129:	89 d6                	mov    %edx,%esi
  10012b:	eb 02                	jmp    10012f <schedule+0x93>
  10012d:	89 d8                	mov    %ebx,%eax
		//firstPid = pid;
		//firstPriority = proc_array[pid].p_priority;
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
  10012f:	41                   	inc    %ecx
  100130:	83 f9 04             	cmp    $0x4,%ecx
  100133:	74 04                	je     100139 <schedule+0x9d>
  100135:	89 c3                	mov    %eax,%ebx
  100137:	eb d4                	jmp    10010d <schedule+0x71>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  100139:	6b f6 54             	imul   $0x54,%esi,%esi
  10013c:	83 be 44 72 10 00 01 	cmpl   $0x1,0x107244(%esi)
  100143:	75 bb                	jne    100100 <schedule+0x64>
		run(&proc_array[firstPid]);
  100145:	83 ec 0c             	sub    $0xc,%esp
  100148:	81 c6 f8 71 10 00    	add    $0x1071f8,%esi
  10014e:	56                   	push   %esi
  10014f:	e8 b1 03 00 00       	call   100505 <run>
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100154:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10015a:	50                   	push   %eax
  10015b:	68 c4 0a 10 00       	push   $0x100ac4
  100160:	68 00 01 00 00       	push   $0x100
  100165:	52                   	push   %edx
  100166:	e8 3f 09 00 00       	call   100aaa <console_printf>
  10016b:	83 c4 10             	add    $0x10,%esp
  10016e:	a3 00 80 19 00       	mov    %eax,0x198000
  100173:	eb fe                	jmp    100173 <schedule+0xd7>

00100175 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100175:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100176:	8b 3d 04 7c 10 00    	mov    0x107c04,%edi
  10017c:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100181:	56                   	push   %esi
  100182:	53                   	push   %ebx
  100183:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100187:	83 c7 04             	add    $0x4,%edi
  10018a:	89 de                	mov    %ebx,%esi
  10018c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10018e:	8b 43 28             	mov    0x28(%ebx),%eax
  100191:	83 f8 31             	cmp    $0x31,%eax
  100194:	74 1f                	je     1001b5 <interrupt+0x40>
  100196:	77 0c                	ja     1001a4 <interrupt+0x2f>
  100198:	83 f8 20             	cmp    $0x20,%eax
  10019b:	74 4d                	je     1001ea <interrupt+0x75>
  10019d:	83 f8 30             	cmp    $0x30,%eax
  1001a0:	74 0e                	je     1001b0 <interrupt+0x3b>
  1001a2:	eb 4b                	jmp    1001ef <interrupt+0x7a>
  1001a4:	83 f8 32             	cmp    $0x32,%eax
  1001a7:	74 23                	je     1001cc <interrupt+0x57>
  1001a9:	83 f8 33             	cmp    $0x33,%eax
  1001ac:	74 2e                	je     1001dc <interrupt+0x67>
  1001ae:	eb 3f                	jmp    1001ef <interrupt+0x7a>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1001b0:	e8 e7 fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001b5:	a1 04 7c 10 00       	mov    0x107c04,%eax
		current->p_exit_status = reg->reg_eax;
  1001ba:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1001bd:	c7 40 4c 03 00 00 00 	movl   $0x3,0x4c(%eax)
		current->p_exit_status = reg->reg_eax;
  1001c4:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  1001c7:	e8 d0 fe ff ff       	call   10009c <schedule>
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		current->p_priority = reg->reg_eax;
  1001cc:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1001cf:	a1 04 7c 10 00       	mov    0x107c04,%eax
  1001d4:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  1001d7:	e8 c0 fe ff ff       	call   10009c <schedule>

	case INT_SYS_USER2:
		/* Your code here (if you want). */
		run(current);
  1001dc:	83 ec 0c             	sub    $0xc,%esp
  1001df:	ff 35 04 7c 10 00    	pushl  0x107c04
  1001e5:	e8 1b 03 00 00       	call   100505 <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1001ea:	e8 ad fe ff ff       	call   10009c <schedule>
  1001ef:	eb fe                	jmp    1001ef <interrupt+0x7a>

001001f1 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1001f1:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001f2:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1001f7:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001f8:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1001fa:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1001fb:	bb 4c 72 10 00       	mov    $0x10724c,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100200:	e8 df 00 00 00       	call   1002e4 <segments_init>
	interrupt_controller_init(0);
  100205:	83 ec 0c             	sub    $0xc,%esp
  100208:	6a 00                	push   $0x0
  10020a:	e8 d0 01 00 00       	call   1003df <interrupt_controller_init>
	console_clear();
  10020f:	e8 54 02 00 00       	call   100468 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100214:	83 c4 0c             	add    $0xc,%esp
  100217:	68 a4 01 00 00       	push   $0x1a4
  10021c:	6a 00                	push   $0x0
  10021e:	68 f8 71 10 00       	push   $0x1071f8
  100223:	e8 20 04 00 00       	call   100648 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100228:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10022b:	c7 05 f8 71 10 00 00 	movl   $0x0,0x1071f8
  100232:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100235:	c7 05 44 72 10 00 00 	movl   $0x0,0x107244
  10023c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10023f:	c7 05 4c 72 10 00 01 	movl   $0x1,0x10724c
  100246:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100249:	c7 05 98 72 10 00 00 	movl   $0x0,0x107298
  100250:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100253:	c7 05 a0 72 10 00 02 	movl   $0x2,0x1072a0
  10025a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10025d:	c7 05 ec 72 10 00 00 	movl   $0x0,0x1072ec
  100264:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100267:	c7 05 f4 72 10 00 03 	movl   $0x3,0x1072f4
  10026e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100271:	c7 05 40 73 10 00 00 	movl   $0x0,0x107340
  100278:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10027b:	c7 05 48 73 10 00 04 	movl   $0x4,0x107348
  100282:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100285:	c7 05 94 73 10 00 00 	movl   $0x0,0x107394
  10028c:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10028f:	83 ec 0c             	sub    $0xc,%esp
  100292:	53                   	push   %ebx
  100293:	e8 84 02 00 00       	call   10051c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100298:	58                   	pop    %eax
  100299:	5a                   	pop    %edx
  10029a:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  10029d:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002a0:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002a6:	50                   	push   %eax
  1002a7:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002a8:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1002a9:	e8 aa 02 00 00       	call   100558 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002ae:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1002b1:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
  1002b8:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1002bb:	83 fe 04             	cmp    $0x4,%esi
  1002be:	75 cf                	jne    10028f <start+0x9e>
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	scheduling_algorithm = __EXERCISE_4A__;

	// Switch to the first process.
	run(&proc_array[1]);
  1002c0:	83 ec 0c             	sub    $0xc,%esp
  1002c3:	68 4c 72 10 00       	push   $0x10724c
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1002c8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1002cf:	80 0b 00 
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	scheduling_algorithm = __EXERCISE_4A__;
  1002d2:	c7 05 08 7c 10 00 29 	movl   $0x29,0x107c08
  1002d9:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1002dc:	e8 24 02 00 00       	call   100505 <run>
  1002e1:	90                   	nop
  1002e2:	90                   	nop
  1002e3:	90                   	nop

001002e4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002e4:	b8 9c 73 10 00       	mov    $0x10739c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002e9:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002ee:	89 c2                	mov    %eax,%edx
  1002f0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1002f3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1002f4:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1002f9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1002fc:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100302:	c1 e8 18             	shr    $0x18,%eax
  100305:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10030b:	ba 04 74 10 00       	mov    $0x107404,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100310:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100315:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100317:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10031e:	68 00 
  100320:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100327:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10032e:	c7 05 a0 73 10 00 00 	movl   $0x180000,0x1073a0
  100335:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100338:	66 c7 05 a4 73 10 00 	movw   $0x10,0x1073a4
  10033f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100341:	66 89 0c c5 04 74 10 	mov    %cx,0x107404(,%eax,8)
  100348:	00 
  100349:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100350:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100355:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10035a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10035f:	40                   	inc    %eax
  100360:	3d 00 01 00 00       	cmp    $0x100,%eax
  100365:	75 da                	jne    100341 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100367:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10036c:	ba 04 74 10 00       	mov    $0x107404,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100371:	66 a3 04 75 10 00    	mov    %ax,0x107504
  100377:	c1 e8 10             	shr    $0x10,%eax
  10037a:	66 a3 0a 75 10 00    	mov    %ax,0x10750a
  100380:	b8 30 00 00 00       	mov    $0x30,%eax
  100385:	66 c7 05 06 75 10 00 	movw   $0x8,0x107506
  10038c:	08 00 
  10038e:	c6 05 08 75 10 00 00 	movb   $0x0,0x107508
  100395:	c6 05 09 75 10 00 8e 	movb   $0x8e,0x107509

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10039c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1003a3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003aa:	66 89 0c c5 04 74 10 	mov    %cx,0x107404(,%eax,8)
  1003b1:	00 
  1003b2:	c1 e9 10             	shr    $0x10,%ecx
  1003b5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003ba:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1003bf:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1003c4:	40                   	inc    %eax
  1003c5:	83 f8 3a             	cmp    $0x3a,%eax
  1003c8:	75 d2                	jne    10039c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1003ca:	b0 28                	mov    $0x28,%al
  1003cc:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1003d3:	0f 00 d8             	ltr    %ax
  1003d6:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1003dd:	5b                   	pop    %ebx
  1003de:	c3                   	ret    

001003df <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1003df:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1003e0:	b0 ff                	mov    $0xff,%al
  1003e2:	57                   	push   %edi
  1003e3:	56                   	push   %esi
  1003e4:	53                   	push   %ebx
  1003e5:	bb 21 00 00 00       	mov    $0x21,%ebx
  1003ea:	89 da                	mov    %ebx,%edx
  1003ec:	ee                   	out    %al,(%dx)
  1003ed:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1003f2:	89 ca                	mov    %ecx,%edx
  1003f4:	ee                   	out    %al,(%dx)
  1003f5:	be 11 00 00 00       	mov    $0x11,%esi
  1003fa:	bf 20 00 00 00       	mov    $0x20,%edi
  1003ff:	89 f0                	mov    %esi,%eax
  100401:	89 fa                	mov    %edi,%edx
  100403:	ee                   	out    %al,(%dx)
  100404:	b0 20                	mov    $0x20,%al
  100406:	89 da                	mov    %ebx,%edx
  100408:	ee                   	out    %al,(%dx)
  100409:	b0 04                	mov    $0x4,%al
  10040b:	ee                   	out    %al,(%dx)
  10040c:	b0 03                	mov    $0x3,%al
  10040e:	ee                   	out    %al,(%dx)
  10040f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100414:	89 f0                	mov    %esi,%eax
  100416:	89 ea                	mov    %ebp,%edx
  100418:	ee                   	out    %al,(%dx)
  100419:	b0 28                	mov    $0x28,%al
  10041b:	89 ca                	mov    %ecx,%edx
  10041d:	ee                   	out    %al,(%dx)
  10041e:	b0 02                	mov    $0x2,%al
  100420:	ee                   	out    %al,(%dx)
  100421:	b0 01                	mov    $0x1,%al
  100423:	ee                   	out    %al,(%dx)
  100424:	b0 68                	mov    $0x68,%al
  100426:	89 fa                	mov    %edi,%edx
  100428:	ee                   	out    %al,(%dx)
  100429:	be 0a 00 00 00       	mov    $0xa,%esi
  10042e:	89 f0                	mov    %esi,%eax
  100430:	ee                   	out    %al,(%dx)
  100431:	b0 68                	mov    $0x68,%al
  100433:	89 ea                	mov    %ebp,%edx
  100435:	ee                   	out    %al,(%dx)
  100436:	89 f0                	mov    %esi,%eax
  100438:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100439:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10043e:	89 da                	mov    %ebx,%edx
  100440:	19 c0                	sbb    %eax,%eax
  100442:	f7 d0                	not    %eax
  100444:	05 ff 00 00 00       	add    $0xff,%eax
  100449:	ee                   	out    %al,(%dx)
  10044a:	b0 ff                	mov    $0xff,%al
  10044c:	89 ca                	mov    %ecx,%edx
  10044e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10044f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100454:	74 0d                	je     100463 <interrupt_controller_init+0x84>
  100456:	b2 43                	mov    $0x43,%dl
  100458:	b0 34                	mov    $0x34,%al
  10045a:	ee                   	out    %al,(%dx)
  10045b:	b0 9c                	mov    $0x9c,%al
  10045d:	b2 40                	mov    $0x40,%dl
  10045f:	ee                   	out    %al,(%dx)
  100460:	b0 2e                	mov    $0x2e,%al
  100462:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100463:	5b                   	pop    %ebx
  100464:	5e                   	pop    %esi
  100465:	5f                   	pop    %edi
  100466:	5d                   	pop    %ebp
  100467:	c3                   	ret    

00100468 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100468:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100469:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10046b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10046c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100473:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100476:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10047c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100482:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100485:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10048a:	75 ea                	jne    100476 <console_clear+0xe>
  10048c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100491:	b0 0e                	mov    $0xe,%al
  100493:	89 f2                	mov    %esi,%edx
  100495:	ee                   	out    %al,(%dx)
  100496:	31 c9                	xor    %ecx,%ecx
  100498:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10049d:	88 c8                	mov    %cl,%al
  10049f:	89 da                	mov    %ebx,%edx
  1004a1:	ee                   	out    %al,(%dx)
  1004a2:	b0 0f                	mov    $0xf,%al
  1004a4:	89 f2                	mov    %esi,%edx
  1004a6:	ee                   	out    %al,(%dx)
  1004a7:	88 c8                	mov    %cl,%al
  1004a9:	89 da                	mov    %ebx,%edx
  1004ab:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1004ac:	5b                   	pop    %ebx
  1004ad:	5e                   	pop    %esi
  1004ae:	c3                   	ret    

001004af <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1004af:	ba 64 00 00 00       	mov    $0x64,%edx
  1004b4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1004b5:	a8 01                	test   $0x1,%al
  1004b7:	74 45                	je     1004fe <console_read_digit+0x4f>
  1004b9:	b2 60                	mov    $0x60,%dl
  1004bb:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1004bc:	8d 50 fe             	lea    -0x2(%eax),%edx
  1004bf:	80 fa 08             	cmp    $0x8,%dl
  1004c2:	77 05                	ja     1004c9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1004c4:	0f b6 c0             	movzbl %al,%eax
  1004c7:	48                   	dec    %eax
  1004c8:	c3                   	ret    
	else if (data == 0x0B)
  1004c9:	3c 0b                	cmp    $0xb,%al
  1004cb:	74 35                	je     100502 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1004cd:	8d 50 b9             	lea    -0x47(%eax),%edx
  1004d0:	80 fa 02             	cmp    $0x2,%dl
  1004d3:	77 07                	ja     1004dc <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1004d5:	0f b6 c0             	movzbl %al,%eax
  1004d8:	83 e8 40             	sub    $0x40,%eax
  1004db:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1004dc:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1004df:	80 fa 02             	cmp    $0x2,%dl
  1004e2:	77 07                	ja     1004eb <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1004e4:	0f b6 c0             	movzbl %al,%eax
  1004e7:	83 e8 47             	sub    $0x47,%eax
  1004ea:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1004eb:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1004ee:	80 fa 02             	cmp    $0x2,%dl
  1004f1:	77 07                	ja     1004fa <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1004f3:	0f b6 c0             	movzbl %al,%eax
  1004f6:	83 e8 4e             	sub    $0x4e,%eax
  1004f9:	c3                   	ret    
	else if (data == 0x53)
  1004fa:	3c 53                	cmp    $0x53,%al
  1004fc:	74 04                	je     100502 <console_read_digit+0x53>
  1004fe:	83 c8 ff             	or     $0xffffffff,%eax
  100501:	c3                   	ret    
  100502:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100504:	c3                   	ret    

00100505 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100505:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100509:	a3 04 7c 10 00       	mov    %eax,0x107c04

	asm volatile("movl %0,%%esp\n\t"
  10050e:	83 c0 04             	add    $0x4,%eax
  100511:	89 c4                	mov    %eax,%esp
  100513:	61                   	popa   
  100514:	07                   	pop    %es
  100515:	1f                   	pop    %ds
  100516:	83 c4 08             	add    $0x8,%esp
  100519:	cf                   	iret   
  10051a:	eb fe                	jmp    10051a <run+0x15>

0010051c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10051c:	53                   	push   %ebx
  10051d:	83 ec 0c             	sub    $0xc,%esp
  100520:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100524:	6a 44                	push   $0x44
  100526:	6a 00                	push   $0x0
  100528:	8d 43 04             	lea    0x4(%ebx),%eax
  10052b:	50                   	push   %eax
  10052c:	e8 17 01 00 00       	call   100648 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100531:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100537:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10053d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100543:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100549:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100550:	83 c4 18             	add    $0x18,%esp
  100553:	5b                   	pop    %ebx
  100554:	c3                   	ret    
  100555:	90                   	nop
  100556:	90                   	nop
  100557:	90                   	nop

00100558 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100558:	55                   	push   %ebp
  100559:	57                   	push   %edi
  10055a:	56                   	push   %esi
  10055b:	53                   	push   %ebx
  10055c:	83 ec 1c             	sub    $0x1c,%esp
  10055f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100563:	83 f8 03             	cmp    $0x3,%eax
  100566:	7f 04                	jg     10056c <program_loader+0x14>
  100568:	85 c0                	test   %eax,%eax
  10056a:	79 02                	jns    10056e <program_loader+0x16>
  10056c:	eb fe                	jmp    10056c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10056e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100575:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10057b:	74 02                	je     10057f <program_loader+0x27>
  10057d:	eb fe                	jmp    10057d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10057f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100582:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100586:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100588:	c1 e5 05             	shl    $0x5,%ebp
  10058b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10058e:	eb 3f                	jmp    1005cf <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100590:	83 3b 01             	cmpl   $0x1,(%ebx)
  100593:	75 37                	jne    1005cc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100595:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100598:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10059b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10059e:	01 c7                	add    %eax,%edi
	memsz += va;
  1005a0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1005a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1005a7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1005ab:	52                   	push   %edx
  1005ac:	89 fa                	mov    %edi,%edx
  1005ae:	29 c2                	sub    %eax,%edx
  1005b0:	52                   	push   %edx
  1005b1:	8b 53 04             	mov    0x4(%ebx),%edx
  1005b4:	01 f2                	add    %esi,%edx
  1005b6:	52                   	push   %edx
  1005b7:	50                   	push   %eax
  1005b8:	e8 27 00 00 00       	call   1005e4 <memcpy>
  1005bd:	83 c4 10             	add    $0x10,%esp
  1005c0:	eb 04                	jmp    1005c6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1005c2:	c6 07 00             	movb   $0x0,(%edi)
  1005c5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1005c6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1005ca:	72 f6                	jb     1005c2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1005cc:	83 c3 20             	add    $0x20,%ebx
  1005cf:	39 eb                	cmp    %ebp,%ebx
  1005d1:	72 bd                	jb     100590 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1005d3:	8b 56 18             	mov    0x18(%esi),%edx
  1005d6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1005da:	89 10                	mov    %edx,(%eax)
}
  1005dc:	83 c4 1c             	add    $0x1c,%esp
  1005df:	5b                   	pop    %ebx
  1005e0:	5e                   	pop    %esi
  1005e1:	5f                   	pop    %edi
  1005e2:	5d                   	pop    %ebp
  1005e3:	c3                   	ret    

001005e4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1005e4:	56                   	push   %esi
  1005e5:	31 d2                	xor    %edx,%edx
  1005e7:	53                   	push   %ebx
  1005e8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1005ec:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1005f0:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005f4:	eb 08                	jmp    1005fe <memcpy+0x1a>
		*d++ = *s++;
  1005f6:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1005f9:	4e                   	dec    %esi
  1005fa:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1005fd:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1005fe:	85 f6                	test   %esi,%esi
  100600:	75 f4                	jne    1005f6 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100602:	5b                   	pop    %ebx
  100603:	5e                   	pop    %esi
  100604:	c3                   	ret    

00100605 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100605:	57                   	push   %edi
  100606:	56                   	push   %esi
  100607:	53                   	push   %ebx
  100608:	8b 44 24 10          	mov    0x10(%esp),%eax
  10060c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100610:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100614:	39 c7                	cmp    %eax,%edi
  100616:	73 26                	jae    10063e <memmove+0x39>
  100618:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10061b:	39 c6                	cmp    %eax,%esi
  10061d:	76 1f                	jbe    10063e <memmove+0x39>
		s += n, d += n;
  10061f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100622:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100624:	eb 07                	jmp    10062d <memmove+0x28>
			*--d = *--s;
  100626:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100629:	4a                   	dec    %edx
  10062a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10062d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10062e:	85 d2                	test   %edx,%edx
  100630:	75 f4                	jne    100626 <memmove+0x21>
  100632:	eb 10                	jmp    100644 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100634:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100637:	4a                   	dec    %edx
  100638:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10063b:	41                   	inc    %ecx
  10063c:	eb 02                	jmp    100640 <memmove+0x3b>
  10063e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100640:	85 d2                	test   %edx,%edx
  100642:	75 f0                	jne    100634 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100644:	5b                   	pop    %ebx
  100645:	5e                   	pop    %esi
  100646:	5f                   	pop    %edi
  100647:	c3                   	ret    

00100648 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100648:	53                   	push   %ebx
  100649:	8b 44 24 08          	mov    0x8(%esp),%eax
  10064d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100651:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100655:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100657:	eb 04                	jmp    10065d <memset+0x15>
		*p++ = c;
  100659:	88 1a                	mov    %bl,(%edx)
  10065b:	49                   	dec    %ecx
  10065c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10065d:	85 c9                	test   %ecx,%ecx
  10065f:	75 f8                	jne    100659 <memset+0x11>
		*p++ = c;
	return v;
}
  100661:	5b                   	pop    %ebx
  100662:	c3                   	ret    

00100663 <strlen>:

size_t
strlen(const char *s)
{
  100663:	8b 54 24 04          	mov    0x4(%esp),%edx
  100667:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100669:	eb 01                	jmp    10066c <strlen+0x9>
		++n;
  10066b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10066c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100670:	75 f9                	jne    10066b <strlen+0x8>
		++n;
	return n;
}
  100672:	c3                   	ret    

00100673 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100673:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100677:	31 c0                	xor    %eax,%eax
  100679:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10067d:	eb 01                	jmp    100680 <strnlen+0xd>
		++n;
  10067f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100680:	39 d0                	cmp    %edx,%eax
  100682:	74 06                	je     10068a <strnlen+0x17>
  100684:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100688:	75 f5                	jne    10067f <strnlen+0xc>
		++n;
	return n;
}
  10068a:	c3                   	ret    

0010068b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10068b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10068c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100691:	53                   	push   %ebx
  100692:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100694:	76 05                	jbe    10069b <console_putc+0x10>
  100696:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10069b:	80 fa 0a             	cmp    $0xa,%dl
  10069e:	75 2c                	jne    1006cc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006a0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1006a6:	be 50 00 00 00       	mov    $0x50,%esi
  1006ab:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1006ad:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1006b0:	99                   	cltd   
  1006b1:	f7 fe                	idiv   %esi
  1006b3:	89 de                	mov    %ebx,%esi
  1006b5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1006b7:	eb 07                	jmp    1006c0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1006b9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006bc:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1006bd:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1006c0:	83 f8 50             	cmp    $0x50,%eax
  1006c3:	75 f4                	jne    1006b9 <console_putc+0x2e>
  1006c5:	29 d0                	sub    %edx,%eax
  1006c7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1006ca:	eb 0b                	jmp    1006d7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1006cc:	0f b6 d2             	movzbl %dl,%edx
  1006cf:	09 ca                	or     %ecx,%edx
  1006d1:	66 89 13             	mov    %dx,(%ebx)
  1006d4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1006d7:	5b                   	pop    %ebx
  1006d8:	5e                   	pop    %esi
  1006d9:	c3                   	ret    

001006da <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1006da:	56                   	push   %esi
  1006db:	53                   	push   %ebx
  1006dc:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1006e0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1006e3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1006e7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1006ec:	75 04                	jne    1006f2 <fill_numbuf+0x18>
  1006ee:	85 d2                	test   %edx,%edx
  1006f0:	74 10                	je     100702 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1006f2:	89 d0                	mov    %edx,%eax
  1006f4:	31 d2                	xor    %edx,%edx
  1006f6:	f7 f1                	div    %ecx
  1006f8:	4b                   	dec    %ebx
  1006f9:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1006fc:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1006fe:	89 c2                	mov    %eax,%edx
  100700:	eb ec                	jmp    1006ee <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100702:	89 d8                	mov    %ebx,%eax
  100704:	5b                   	pop    %ebx
  100705:	5e                   	pop    %esi
  100706:	c3                   	ret    

00100707 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100707:	55                   	push   %ebp
  100708:	57                   	push   %edi
  100709:	56                   	push   %esi
  10070a:	53                   	push   %ebx
  10070b:	83 ec 38             	sub    $0x38,%esp
  10070e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100712:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100716:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10071a:	e9 60 03 00 00       	jmp    100a7f <console_vprintf+0x378>
		if (*format != '%') {
  10071f:	80 fa 25             	cmp    $0x25,%dl
  100722:	74 13                	je     100737 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100724:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100728:	0f b6 d2             	movzbl %dl,%edx
  10072b:	89 f0                	mov    %esi,%eax
  10072d:	e8 59 ff ff ff       	call   10068b <console_putc>
  100732:	e9 45 03 00 00       	jmp    100a7c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100737:	47                   	inc    %edi
  100738:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10073f:	00 
  100740:	eb 12                	jmp    100754 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100742:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100743:	8a 11                	mov    (%ecx),%dl
  100745:	84 d2                	test   %dl,%dl
  100747:	74 1a                	je     100763 <console_vprintf+0x5c>
  100749:	89 e8                	mov    %ebp,%eax
  10074b:	38 c2                	cmp    %al,%dl
  10074d:	75 f3                	jne    100742 <console_vprintf+0x3b>
  10074f:	e9 3f 03 00 00       	jmp    100a93 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100754:	8a 17                	mov    (%edi),%dl
  100756:	84 d2                	test   %dl,%dl
  100758:	74 0b                	je     100765 <console_vprintf+0x5e>
  10075a:	b9 e8 0a 10 00       	mov    $0x100ae8,%ecx
  10075f:	89 d5                	mov    %edx,%ebp
  100761:	eb e0                	jmp    100743 <console_vprintf+0x3c>
  100763:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100765:	8d 42 cf             	lea    -0x31(%edx),%eax
  100768:	3c 08                	cmp    $0x8,%al
  10076a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100771:	00 
  100772:	76 13                	jbe    100787 <console_vprintf+0x80>
  100774:	eb 1d                	jmp    100793 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100776:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10077b:	0f be c0             	movsbl %al,%eax
  10077e:	47                   	inc    %edi
  10077f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100783:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100787:	8a 07                	mov    (%edi),%al
  100789:	8d 50 d0             	lea    -0x30(%eax),%edx
  10078c:	80 fa 09             	cmp    $0x9,%dl
  10078f:	76 e5                	jbe    100776 <console_vprintf+0x6f>
  100791:	eb 18                	jmp    1007ab <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100793:	80 fa 2a             	cmp    $0x2a,%dl
  100796:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10079d:	ff 
  10079e:	75 0b                	jne    1007ab <console_vprintf+0xa4>
			width = va_arg(val, int);
  1007a0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1007a3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1007a4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1007a7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1007ab:	83 cd ff             	or     $0xffffffff,%ebp
  1007ae:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1007b1:	75 37                	jne    1007ea <console_vprintf+0xe3>
			++format;
  1007b3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1007b4:	31 ed                	xor    %ebp,%ebp
  1007b6:	8a 07                	mov    (%edi),%al
  1007b8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007bb:	80 fa 09             	cmp    $0x9,%dl
  1007be:	76 0d                	jbe    1007cd <console_vprintf+0xc6>
  1007c0:	eb 17                	jmp    1007d9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1007c2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1007c5:	0f be c0             	movsbl %al,%eax
  1007c8:	47                   	inc    %edi
  1007c9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1007cd:	8a 07                	mov    (%edi),%al
  1007cf:	8d 50 d0             	lea    -0x30(%eax),%edx
  1007d2:	80 fa 09             	cmp    $0x9,%dl
  1007d5:	76 eb                	jbe    1007c2 <console_vprintf+0xbb>
  1007d7:	eb 11                	jmp    1007ea <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1007d9:	3c 2a                	cmp    $0x2a,%al
  1007db:	75 0b                	jne    1007e8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1007dd:	83 c3 04             	add    $0x4,%ebx
				++format;
  1007e0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1007e1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1007e4:	85 ed                	test   %ebp,%ebp
  1007e6:	79 02                	jns    1007ea <console_vprintf+0xe3>
  1007e8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1007ea:	8a 07                	mov    (%edi),%al
  1007ec:	3c 64                	cmp    $0x64,%al
  1007ee:	74 34                	je     100824 <console_vprintf+0x11d>
  1007f0:	7f 1d                	jg     10080f <console_vprintf+0x108>
  1007f2:	3c 58                	cmp    $0x58,%al
  1007f4:	0f 84 a2 00 00 00    	je     10089c <console_vprintf+0x195>
  1007fa:	3c 63                	cmp    $0x63,%al
  1007fc:	0f 84 bf 00 00 00    	je     1008c1 <console_vprintf+0x1ba>
  100802:	3c 43                	cmp    $0x43,%al
  100804:	0f 85 d0 00 00 00    	jne    1008da <console_vprintf+0x1d3>
  10080a:	e9 a3 00 00 00       	jmp    1008b2 <console_vprintf+0x1ab>
  10080f:	3c 75                	cmp    $0x75,%al
  100811:	74 4d                	je     100860 <console_vprintf+0x159>
  100813:	3c 78                	cmp    $0x78,%al
  100815:	74 5c                	je     100873 <console_vprintf+0x16c>
  100817:	3c 73                	cmp    $0x73,%al
  100819:	0f 85 bb 00 00 00    	jne    1008da <console_vprintf+0x1d3>
  10081f:	e9 86 00 00 00       	jmp    1008aa <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100824:	83 c3 04             	add    $0x4,%ebx
  100827:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  10082a:	89 d1                	mov    %edx,%ecx
  10082c:	c1 f9 1f             	sar    $0x1f,%ecx
  10082f:	89 0c 24             	mov    %ecx,(%esp)
  100832:	31 ca                	xor    %ecx,%edx
  100834:	55                   	push   %ebp
  100835:	29 ca                	sub    %ecx,%edx
  100837:	68 f0 0a 10 00       	push   $0x100af0
  10083c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100841:	8d 44 24 40          	lea    0x40(%esp),%eax
  100845:	e8 90 fe ff ff       	call   1006da <fill_numbuf>
  10084a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10084e:	58                   	pop    %eax
  10084f:	5a                   	pop    %edx
  100850:	ba 01 00 00 00       	mov    $0x1,%edx
  100855:	8b 04 24             	mov    (%esp),%eax
  100858:	83 e0 01             	and    $0x1,%eax
  10085b:	e9 a5 00 00 00       	jmp    100905 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100860:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100863:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100868:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10086b:	55                   	push   %ebp
  10086c:	68 f0 0a 10 00       	push   $0x100af0
  100871:	eb 11                	jmp    100884 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100873:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100876:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100879:	55                   	push   %ebp
  10087a:	68 04 0b 10 00       	push   $0x100b04
  10087f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100884:	8d 44 24 40          	lea    0x40(%esp),%eax
  100888:	e8 4d fe ff ff       	call   1006da <fill_numbuf>
  10088d:	ba 01 00 00 00       	mov    $0x1,%edx
  100892:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100896:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100898:	59                   	pop    %ecx
  100899:	59                   	pop    %ecx
  10089a:	eb 69                	jmp    100905 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  10089c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  10089f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008a2:	55                   	push   %ebp
  1008a3:	68 f0 0a 10 00       	push   $0x100af0
  1008a8:	eb d5                	jmp    10087f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1008aa:	83 c3 04             	add    $0x4,%ebx
  1008ad:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1008b0:	eb 40                	jmp    1008f2 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1008b2:	83 c3 04             	add    $0x4,%ebx
  1008b5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008b8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1008bc:	e9 bd 01 00 00       	jmp    100a7e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008c1:	83 c3 04             	add    $0x4,%ebx
  1008c4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1008c7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1008cb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1008d0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1008d4:	88 44 24 24          	mov    %al,0x24(%esp)
  1008d8:	eb 27                	jmp    100901 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1008da:	84 c0                	test   %al,%al
  1008dc:	75 02                	jne    1008e0 <console_vprintf+0x1d9>
  1008de:	b0 25                	mov    $0x25,%al
  1008e0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1008e4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1008e9:	80 3f 00             	cmpb   $0x0,(%edi)
  1008ec:	74 0a                	je     1008f8 <console_vprintf+0x1f1>
  1008ee:	8d 44 24 24          	lea    0x24(%esp),%eax
  1008f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008f6:	eb 09                	jmp    100901 <console_vprintf+0x1fa>
				format--;
  1008f8:	8d 54 24 24          	lea    0x24(%esp),%edx
  1008fc:	4f                   	dec    %edi
  1008fd:	89 54 24 04          	mov    %edx,0x4(%esp)
  100901:	31 d2                	xor    %edx,%edx
  100903:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100905:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100907:	83 fd ff             	cmp    $0xffffffff,%ebp
  10090a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100911:	74 1f                	je     100932 <console_vprintf+0x22b>
  100913:	89 04 24             	mov    %eax,(%esp)
  100916:	eb 01                	jmp    100919 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100918:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100919:	39 e9                	cmp    %ebp,%ecx
  10091b:	74 0a                	je     100927 <console_vprintf+0x220>
  10091d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100921:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100925:	75 f1                	jne    100918 <console_vprintf+0x211>
  100927:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10092a:	89 0c 24             	mov    %ecx,(%esp)
  10092d:	eb 1f                	jmp    10094e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  10092f:	42                   	inc    %edx
  100930:	eb 09                	jmp    10093b <console_vprintf+0x234>
  100932:	89 d1                	mov    %edx,%ecx
  100934:	8b 14 24             	mov    (%esp),%edx
  100937:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10093b:	8b 44 24 04          	mov    0x4(%esp),%eax
  10093f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100943:	75 ea                	jne    10092f <console_vprintf+0x228>
  100945:	8b 44 24 08          	mov    0x8(%esp),%eax
  100949:	89 14 24             	mov    %edx,(%esp)
  10094c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  10094e:	85 c0                	test   %eax,%eax
  100950:	74 0c                	je     10095e <console_vprintf+0x257>
  100952:	84 d2                	test   %dl,%dl
  100954:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  10095b:	00 
  10095c:	75 24                	jne    100982 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  10095e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100963:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  10096a:	00 
  10096b:	75 15                	jne    100982 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  10096d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100971:	83 e0 08             	and    $0x8,%eax
  100974:	83 f8 01             	cmp    $0x1,%eax
  100977:	19 c9                	sbb    %ecx,%ecx
  100979:	f7 d1                	not    %ecx
  10097b:	83 e1 20             	and    $0x20,%ecx
  10097e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100982:	3b 2c 24             	cmp    (%esp),%ebp
  100985:	7e 0d                	jle    100994 <console_vprintf+0x28d>
  100987:	84 d2                	test   %dl,%dl
  100989:	74 40                	je     1009cb <console_vprintf+0x2c4>
			zeros = precision - len;
  10098b:	2b 2c 24             	sub    (%esp),%ebp
  10098e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100992:	eb 3f                	jmp    1009d3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100994:	84 d2                	test   %dl,%dl
  100996:	74 33                	je     1009cb <console_vprintf+0x2c4>
  100998:	8b 44 24 14          	mov    0x14(%esp),%eax
  10099c:	83 e0 06             	and    $0x6,%eax
  10099f:	83 f8 02             	cmp    $0x2,%eax
  1009a2:	75 27                	jne    1009cb <console_vprintf+0x2c4>
  1009a4:	45                   	inc    %ebp
  1009a5:	75 24                	jne    1009cb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009a7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009a9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  1009ac:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009b1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009b4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  1009b7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1009bb:	7d 0e                	jge    1009cb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  1009bd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  1009c1:	29 ca                	sub    %ecx,%edx
  1009c3:	29 c2                	sub    %eax,%edx
  1009c5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  1009c9:	eb 08                	jmp    1009d3 <console_vprintf+0x2cc>
  1009cb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1009d2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009d3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  1009d7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009d9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009dd:	2b 2c 24             	sub    (%esp),%ebp
  1009e0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  1009e5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009e8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  1009eb:	29 c5                	sub    %eax,%ebp
  1009ed:	89 f0                	mov    %esi,%eax
  1009ef:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  1009f3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1009f7:	eb 0f                	jmp    100a08 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  1009f9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1009fd:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a02:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a03:	e8 83 fc ff ff       	call   10068b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a08:	85 ed                	test   %ebp,%ebp
  100a0a:	7e 07                	jle    100a13 <console_vprintf+0x30c>
  100a0c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100a11:	74 e6                	je     1009f9 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100a13:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a18:	89 c6                	mov    %eax,%esi
  100a1a:	74 23                	je     100a3f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100a1c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100a21:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a25:	e8 61 fc ff ff       	call   10068b <console_putc>
  100a2a:	89 c6                	mov    %eax,%esi
  100a2c:	eb 11                	jmp    100a3f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100a2e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a32:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a37:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100a38:	e8 4e fc ff ff       	call   10068b <console_putc>
  100a3d:	eb 06                	jmp    100a45 <console_vprintf+0x33e>
  100a3f:	89 f0                	mov    %esi,%eax
  100a41:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100a45:	85 f6                	test   %esi,%esi
  100a47:	7f e5                	jg     100a2e <console_vprintf+0x327>
  100a49:	8b 34 24             	mov    (%esp),%esi
  100a4c:	eb 15                	jmp    100a63 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100a4e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a52:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100a53:	0f b6 11             	movzbl (%ecx),%edx
  100a56:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a5a:	e8 2c fc ff ff       	call   10068b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100a5f:	ff 44 24 04          	incl   0x4(%esp)
  100a63:	85 f6                	test   %esi,%esi
  100a65:	7f e7                	jg     100a4e <console_vprintf+0x347>
  100a67:	eb 0f                	jmp    100a78 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100a69:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a6d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a72:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a73:	e8 13 fc ff ff       	call   10068b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100a78:	85 ed                	test   %ebp,%ebp
  100a7a:	7f ed                	jg     100a69 <console_vprintf+0x362>
  100a7c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100a7e:	47                   	inc    %edi
  100a7f:	8a 17                	mov    (%edi),%dl
  100a81:	84 d2                	test   %dl,%dl
  100a83:	0f 85 96 fc ff ff    	jne    10071f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100a89:	83 c4 38             	add    $0x38,%esp
  100a8c:	89 f0                	mov    %esi,%eax
  100a8e:	5b                   	pop    %ebx
  100a8f:	5e                   	pop    %esi
  100a90:	5f                   	pop    %edi
  100a91:	5d                   	pop    %ebp
  100a92:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100a93:	81 e9 e8 0a 10 00    	sub    $0x100ae8,%ecx
  100a99:	b8 01 00 00 00       	mov    $0x1,%eax
  100a9e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100aa0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100aa1:	09 44 24 14          	or     %eax,0x14(%esp)
  100aa5:	e9 aa fc ff ff       	jmp    100754 <console_vprintf+0x4d>

00100aaa <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100aaa:	8d 44 24 10          	lea    0x10(%esp),%eax
  100aae:	50                   	push   %eax
  100aaf:	ff 74 24 10          	pushl  0x10(%esp)
  100ab3:	ff 74 24 10          	pushl  0x10(%esp)
  100ab7:	ff 74 24 10          	pushl  0x10(%esp)
  100abb:	e8 47 fc ff ff       	call   100707 <console_vprintf>
  100ac0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ac3:	c3                   	ret    
