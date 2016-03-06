
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
  100014:	e8 26 03 00 00       	call   10033f <start>
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
  10006d:	e8 3a 02 00 00       	call   1002ac <interrupt>

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
  10009c:	55                   	push   %ebp
  10009d:	57                   	push   %edi
  10009e:	56                   	push   %esi
  10009f:	53                   	push   %ebx
  1000a0:	83 ec 1c             	sub    $0x1c,%esp
	pid_t pid = current->p_pid;
  1000a3:	a1 a0 8c 10 00       	mov    0x108ca0,%eax
  1000a8:	8b 38                	mov    (%eax),%edi
	unsigned int firstPriority;
	pid_t firstPid;
	int i;
	int p_share_reset;	// 4B
	if (scheduling_algorithm == 0) {
  1000aa:	a1 a4 8c 10 00       	mov    0x108ca4,%eax
  1000af:	85 c0                	test   %eax,%eax
  1000b1:	75 1b                	jne    1000ce <schedule+0x32>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b3:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b8:	8d 47 01             	lea    0x1(%edi),%eax
  1000bb:	99                   	cltd   
  1000bc:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000be:	6b c2 60             	imul   $0x60,%edx,%eax
	pid_t firstPid;
	int i;
	int p_share_reset;	// 4B
	if (scheduling_algorithm == 0) {
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000c1:	89 d7                	mov    %edx,%edi

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000c3:	83 b8 b0 82 10 00 01 	cmpl   $0x1,0x1082b0(%eax)
  1000ca:	75 ec                	jne    1000b8 <schedule+0x1c>
  1000cc:	eb 1b                	jmp    1000e9 <schedule+0x4d>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000ce:	83 f8 02             	cmp    $0x2,%eax
  1000d1:	75 2c                	jne    1000ff <schedule+0x63>
  1000d3:	ba 01 00 00 00       	mov    $0x1,%edx
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
			pid = (pid + 1) % NPROCS;
  1000d8:	b9 05 00 00 00       	mov    $0x5,%ecx
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000dd:	6b c2 60             	imul   $0x60,%edx,%eax
  1000e0:	83 b8 b0 82 10 00 01 	cmpl   $0x1,0x1082b0(%eax)
  1000e7:	75 0e                	jne    1000f7 <schedule+0x5b>
				run(&proc_array[pid]);
  1000e9:	83 ec 0c             	sub    $0xc,%esp
  1000ec:	05 58 82 10 00       	add    $0x108258,%eax
  1000f1:	50                   	push   %eax
  1000f2:	e9 8b 01 00 00       	jmp    100282 <schedule+0x1e6>
			pid = (pid + 1) % NPROCS;
  1000f7:	8d 42 01             	lea    0x1(%edx),%eax
  1000fa:	99                   	cltd   
  1000fb:	f7 f9                	idiv   %ecx
		}
  1000fd:	eb de                	jmp    1000dd <schedule+0x41>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000ff:	83 f8 29             	cmp    $0x29,%eax
  100102:	75 5a                	jne    10015e <schedule+0xc2>
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100104:	bd 05 00 00 00       	mov    $0x5,%ebp
		}
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
  100109:	6b c7 60             	imul   $0x60,%edi,%eax
  10010c:	89 fe                	mov    %edi,%esi
  10010e:	31 c9                	xor    %ecx,%ecx
  100110:	8b 98 a0 82 10 00    	mov    0x1082a0(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100116:	8d 47 01             	lea    0x1(%edi),%eax
  100119:	99                   	cltd   
  10011a:	f7 fd                	idiv   %ebp
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  10011c:	6b c2 60             	imul   $0x60,%edx,%eax
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  10011f:	89 d7                	mov    %edx,%edi
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  100121:	05 60 82 10 00       	add    $0x108260,%eax
  100126:	83 78 50 01          	cmpl   $0x1,0x50(%eax)
  10012a:	75 0b                	jne    100137 <schedule+0x9b>
  10012c:	8b 40 40             	mov    0x40(%eax),%eax
  10012f:	39 d8                	cmp    %ebx,%eax
  100131:	77 04                	ja     100137 <schedule+0x9b>
  100133:	89 d6                	mov    %edx,%esi
  100135:	eb 02                	jmp    100139 <schedule+0x9d>
  100137:	89 d8                	mov    %ebx,%eax
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
  100139:	41                   	inc    %ecx
  10013a:	83 f9 04             	cmp    $0x4,%ecx
  10013d:	74 04                	je     100143 <schedule+0xa7>
  10013f:	89 c3                	mov    %eax,%ebx
  100141:	eb d3                	jmp    100116 <schedule+0x7a>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  100143:	6b f6 60             	imul   $0x60,%esi,%esi
  100146:	83 be b0 82 10 00 01 	cmpl   $0x1,0x1082b0(%esi)
  10014d:	75 ba                	jne    100109 <schedule+0x6d>
		run(&proc_array[firstPid]);
  10014f:	83 ec 0c             	sub    $0xc,%esp
  100152:	81 c6 58 82 10 00    	add    $0x108258,%esi
  100158:	56                   	push   %esi
  100159:	e9 24 01 00 00       	jmp    100282 <schedule+0x1e6>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  10015e:	83 f8 2a             	cmp    $0x2a,%eax
  100161:	0f 85 20 01 00 00    	jne    100287 <schedule+0x1eb>
  100167:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  10016e:	00 
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  10016f:	6b df 60             	imul   $0x60,%edi,%ebx
  100172:	83 ec 0c             	sub    $0xc,%esp
  100175:	a1 00 80 19 00       	mov    0x198000,%eax
  10017a:	81 c3 64 82 10 00    	add    $0x108264,%ebx
  100180:	ff 73 40             	pushl  0x40(%ebx)
  100183:	57                   	push   %edi
  100184:	68 1c 0c 10 00       	push   $0x100c1c
  100189:	68 00 01 00 00       	push   $0x100
  10018e:	50                   	push   %eax
  10018f:	e8 6e 0a 00 00       	call   100c02 <console_printf>
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
  100194:	8b 73 40             	mov    0x40(%ebx),%esi
  100197:	31 c9                	xor    %ecx,%ecx
  100199:	89 fb                	mov    %edi,%ebx
  10019b:	83 c4 20             	add    $0x20,%esp
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  10019e:	a3 00 80 19 00       	mov    %eax,0x198000
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001a3:	8d 47 01             	lea    0x1(%edi),%eax
  1001a6:	bf 05 00 00 00       	mov    $0x5,%edi
  1001ab:	99                   	cltd   
  1001ac:	f7 ff                	idiv   %edi
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001ae:	a1 00 80 19 00       	mov    0x198000,%eax
  1001b3:	6b ea 60             	imul   $0x60,%edx,%ebp
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001b6:	89 d7                	mov    %edx,%edi
  1001b8:	89 54 24 0c          	mov    %edx,0xc(%esp)
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001bc:	83 ec 0c             	sub    $0xc,%esp
  1001bf:	8d 95 64 82 10 00    	lea    0x108264(%ebp),%edx
  1001c5:	ff 72 40             	pushl  0x40(%edx)
  1001c8:	57                   	push   %edi
  1001c9:	68 1c 0c 10 00       	push   $0x100c1c
  1001ce:	68 00 01 00 00       	push   $0x100
  1001d3:	50                   	push   %eax
  1001d4:	89 54 24 24          	mov    %edx,0x24(%esp)
  1001d8:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  1001dc:	e8 21 0a 00 00       	call   100c02 <console_printf>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001e1:	83 c4 20             	add    $0x20,%esp
  1001e4:	83 bd b0 82 10 00 01 	cmpl   $0x1,0x1082b0(%ebp)
  1001eb:	8b 54 24 04          	mov    0x4(%esp),%edx
  1001ef:	8b 0c 24             	mov    (%esp),%ecx
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001f2:	a3 00 80 19 00       	mov    %eax,0x198000
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001f7:	75 0b                	jne    100204 <schedule+0x168>
  1001f9:	8b 42 40             	mov    0x40(%edx),%eax
  1001fc:	39 f0                	cmp    %esi,%eax
  1001fe:	72 04                	jb     100204 <schedule+0x168>
  100200:	89 fb                	mov    %edi,%ebx
  100202:	eb 02                	jmp    100206 <schedule+0x16a>
  100204:	89 f0                	mov    %esi,%eax
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
  100206:	41                   	inc    %ecx
  100207:	83 f9 04             	cmp    $0x4,%ecx
  10020a:	74 04                	je     100210 <schedule+0x174>
  10020c:	89 c6                	mov    %eax,%esi
  10020e:	eb 93                	jmp    1001a3 <schedule+0x107>
				}
			}
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
  100210:	6b c3 60             	imul   $0x60,%ebx,%eax
  100213:	83 b8 a8 82 10 00 00 	cmpl   $0x0,0x1082a8(%eax)
  10021a:	75 3a                	jne    100256 <schedule+0x1ba>
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  10021c:	83 ec 0c             	sub    $0xc,%esp
  10021f:	a1 00 80 19 00       	mov    0x198000,%eax
  100224:	ff 74 24 18          	pushl  0x18(%esp)
  100228:	53                   	push   %ebx
  100229:	68 2f 0c 10 00       	push   $0x100c2f
  10022e:	68 00 01 00 00       	push   $0x100
  100233:	50                   	push   %eax
  100234:	e8 c9 09 00 00       	call   100c02 <console_printf>
				pid = (pid + 1) % NPROCS;
  100239:	b9 05 00 00 00       	mov    $0x5,%ecx
				hi--;
  10023e:	ff 4c 24 28          	decl   0x28(%esp)
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  100242:	a3 00 80 19 00       	mov    %eax,0x198000
				pid = (pid + 1) % NPROCS;
  100247:	8b 44 24 2c          	mov    0x2c(%esp),%eax
				hi--;
				continue;
  10024b:	83 c4 20             	add    $0x20,%esp
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
				pid = (pid + 1) % NPROCS;
  10024e:	40                   	inc    %eax
  10024f:	99                   	cltd   
  100250:	f7 f9                	idiv   %ecx
  100252:	89 d7                	mov    %edx,%edi
				hi--;
				continue;
  100254:	eb 09                	jmp    10025f <schedule+0x1c3>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
  100256:	83 b8 b0 82 10 00 01 	cmpl   $0x1,0x1082b0(%eax)
  10025d:	74 0b                	je     10026a <schedule+0x1ce>
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
  10025f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100264:	0f 85 05 ff ff ff    	jne    10016f <schedule+0xd3>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
  10026a:	6b db 60             	imul   $0x60,%ebx,%ebx
  10026d:	81 c3 58 82 10 00    	add    $0x108258,%ebx
  100273:	8b 43 50             	mov    0x50(%ebx),%eax
  100276:	85 c0                	test   %eax,%eax
  100278:	74 0d                	je     100287 <schedule+0x1eb>
			proc_array[firstPid].p_share_left--;
  10027a:	48                   	dec    %eax
			run(&proc_array[firstPid]);
  10027b:	83 ec 0c             	sub    $0xc,%esp
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  10027e:	89 43 50             	mov    %eax,0x50(%ebx)
			run(&proc_array[firstPid]);
  100281:	53                   	push   %ebx
  100282:	e8 d6 03 00 00       	call   10065d <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100287:	ff 35 a4 8c 10 00    	pushl  0x108ca4
  10028d:	a1 00 80 19 00       	mov    0x198000,%eax
  100292:	68 4a 0c 10 00       	push   $0x100c4a
  100297:	68 00 01 00 00       	push   $0x100
  10029c:	50                   	push   %eax
  10029d:	e8 60 09 00 00       	call   100c02 <console_printf>
  1002a2:	83 c4 10             	add    $0x10,%esp
  1002a5:	a3 00 80 19 00       	mov    %eax,0x198000
  1002aa:	eb fe                	jmp    1002aa <schedule+0x20e>

001002ac <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1002ac:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1002ad:	8b 3d a0 8c 10 00    	mov    0x108ca0,%edi
  1002b3:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1002b8:	56                   	push   %esi
  1002b9:	53                   	push   %ebx
  1002ba:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1002be:	83 c7 04             	add    $0x4,%edi
  1002c1:	89 de                	mov    %ebx,%esi
  1002c3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1002c5:	8b 43 28             	mov    0x28(%ebx),%eax
  1002c8:	83 f8 32             	cmp    $0x32,%eax
  1002cb:	74 38                	je     100305 <interrupt+0x59>
  1002cd:	77 0e                	ja     1002dd <interrupt+0x31>
  1002cf:	83 f8 30             	cmp    $0x30,%eax
  1002d2:	74 15                	je     1002e9 <interrupt+0x3d>
  1002d4:	77 18                	ja     1002ee <interrupt+0x42>
  1002d6:	83 f8 20             	cmp    $0x20,%eax
  1002d9:	74 5d                	je     100338 <interrupt+0x8c>
  1002db:	eb 60                	jmp    10033d <interrupt+0x91>
  1002dd:	83 f8 33             	cmp    $0x33,%eax
  1002e0:	74 33                	je     100315 <interrupt+0x69>
  1002e2:	83 f8 34             	cmp    $0x34,%eax
  1002e5:	74 41                	je     100328 <interrupt+0x7c>
  1002e7:	eb 54                	jmp    10033d <interrupt+0x91>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002e9:	e8 ae fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002ee:	a1 a0 8c 10 00       	mov    0x108ca0,%eax
		current->p_exit_status = reg->reg_eax;
  1002f3:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002f6:	c7 40 58 03 00 00 00 	movl   $0x3,0x58(%eax)
		current->p_exit_status = reg->reg_eax;
  1002fd:	89 50 5c             	mov    %edx,0x5c(%eax)
		schedule();
  100300:	e8 97 fd ff ff       	call   10009c <schedule>
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		current->p_priority = reg->reg_eax;
  100305:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100308:	a1 a0 8c 10 00       	mov    0x108ca0,%eax
  10030d:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  100310:	e8 87 fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  100315:	a1 a0 8c 10 00       	mov    0x108ca0,%eax
  10031a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10031d:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  100320:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  100323:	e8 74 fd ff ff       	call   10009c <schedule>
	
	case INT_SYS_LOTTERY:
		current->p_lottery_amt = reg->reg_eax;
  100328:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10032b:	a1 a0 8c 10 00       	mov    0x108ca0,%eax
  100330:	89 50 54             	mov    %edx,0x54(%eax)
		schedule();
  100333:	e8 64 fd ff ff       	call   10009c <schedule>
	
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100338:	e8 5f fd ff ff       	call   10009c <schedule>
  10033d:	eb fe                	jmp    10033d <interrupt+0x91>

0010033f <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10033f:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100340:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100345:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100346:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100348:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100349:	bb b8 82 10 00       	mov    $0x1082b8,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10034e:	e8 e9 00 00 00       	call   10043c <segments_init>
	interrupt_controller_init(0);
  100353:	83 ec 0c             	sub    $0xc,%esp
  100356:	6a 00                	push   $0x0
  100358:	e8 da 01 00 00       	call   100537 <interrupt_controller_init>
	//interrupt_controller_init(1);
	console_clear();
  10035d:	e8 5e 02 00 00       	call   1005c0 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100362:	83 c4 0c             	add    $0xc,%esp
  100365:	68 e0 01 00 00       	push   $0x1e0
  10036a:	6a 00                	push   $0x0
  10036c:	68 58 82 10 00       	push   $0x108258
  100371:	e8 2a 04 00 00       	call   1007a0 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100376:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100379:	c7 05 58 82 10 00 00 	movl   $0x0,0x108258
  100380:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100383:	c7 05 b0 82 10 00 00 	movl   $0x0,0x1082b0
  10038a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10038d:	c7 05 b8 82 10 00 01 	movl   $0x1,0x1082b8
  100394:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100397:	c7 05 10 83 10 00 00 	movl   $0x0,0x108310
  10039e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003a1:	c7 05 18 83 10 00 02 	movl   $0x2,0x108318
  1003a8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003ab:	c7 05 70 83 10 00 00 	movl   $0x0,0x108370
  1003b2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003b5:	c7 05 78 83 10 00 03 	movl   $0x3,0x108378
  1003bc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003bf:	c7 05 d0 83 10 00 00 	movl   $0x0,0x1083d0
  1003c6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003c9:	c7 05 d8 83 10 00 04 	movl   $0x4,0x1083d8
  1003d0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003d3:	c7 05 30 84 10 00 00 	movl   $0x0,0x108430
  1003da:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1003dd:	83 ec 0c             	sub    $0xc,%esp
  1003e0:	53                   	push   %ebx
  1003e1:	e8 8e 02 00 00       	call   100674 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003e6:	58                   	pop    %eax
  1003e7:	5a                   	pop    %edx
  1003e8:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003eb:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ee:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003f4:	50                   	push   %eax
  1003f5:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003f6:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003f7:	e8 b4 02 00 00       	call   1006b0 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003fc:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ff:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)
  100406:	83 c3 60             	add    $0x60,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100409:	83 fe 04             	cmp    $0x4,%esi
  10040c:	75 cf                	jne    1003dd <start+0x9e>
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;

	// Switch to the first process.
	run(&proc_array[1]);
  10040e:	83 ec 0c             	sub    $0xc,%esp
  100411:	68 b8 82 10 00       	push   $0x1082b8
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100416:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10041d:	80 0b 00 
	cursorposLock = 0;	// lock is available
  100420:	c7 05 10 80 19 00 00 	movl   $0x0,0x198010
  100427:	00 00 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
  10042a:	c7 05 a4 8c 10 00 00 	movl   $0x0,0x108ca4
  100431:	00 00 00 
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;

	// Switch to the first process.
	run(&proc_array[1]);
  100434:	e8 24 02 00 00       	call   10065d <run>
  100439:	90                   	nop
  10043a:	90                   	nop
  10043b:	90                   	nop

0010043c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10043c:	b8 38 84 10 00       	mov    $0x108438,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100441:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100446:	89 c2                	mov    %eax,%edx
  100448:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10044b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10044c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100451:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100454:	66 a3 d6 1c 10 00    	mov    %ax,0x101cd6
  10045a:	c1 e8 18             	shr    $0x18,%eax
  10045d:	88 15 d8 1c 10 00    	mov    %dl,0x101cd8
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100463:	ba a0 84 10 00       	mov    $0x1084a0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100468:	a2 db 1c 10 00       	mov    %al,0x101cdb
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10046d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10046f:	66 c7 05 d4 1c 10 00 	movw   $0x68,0x101cd4
  100476:	68 00 
  100478:	c6 05 da 1c 10 00 40 	movb   $0x40,0x101cda
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10047f:	c6 05 d9 1c 10 00 89 	movb   $0x89,0x101cd9

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100486:	c7 05 3c 84 10 00 00 	movl   $0x180000,0x10843c
  10048d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100490:	66 c7 05 40 84 10 00 	movw   $0x10,0x108440
  100497:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100499:	66 89 0c c5 a0 84 10 	mov    %cx,0x1084a0(,%eax,8)
  1004a0:	00 
  1004a1:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004a8:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004ad:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1004b2:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1004b7:	40                   	inc    %eax
  1004b8:	3d 00 01 00 00       	cmp    $0x100,%eax
  1004bd:	75 da                	jne    100499 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004bf:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004c4:	ba a0 84 10 00       	mov    $0x1084a0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004c9:	66 a3 a0 85 10 00    	mov    %ax,0x1085a0
  1004cf:	c1 e8 10             	shr    $0x10,%eax
  1004d2:	66 a3 a6 85 10 00    	mov    %ax,0x1085a6
  1004d8:	b8 30 00 00 00       	mov    $0x30,%eax
  1004dd:	66 c7 05 a2 85 10 00 	movw   $0x8,0x1085a2
  1004e4:	08 00 
  1004e6:	c6 05 a4 85 10 00 00 	movb   $0x0,0x1085a4
  1004ed:	c6 05 a5 85 10 00 8e 	movb   $0x8e,0x1085a5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004f4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004fb:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100502:	66 89 0c c5 a0 84 10 	mov    %cx,0x1084a0(,%eax,8)
  100509:	00 
  10050a:	c1 e9 10             	shr    $0x10,%ecx
  10050d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100512:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100517:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10051c:	40                   	inc    %eax
  10051d:	83 f8 3a             	cmp    $0x3a,%eax
  100520:	75 d2                	jne    1004f4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100522:	b0 28                	mov    $0x28,%al
  100524:	0f 01 15 9c 1c 10 00 	lgdtl  0x101c9c
  10052b:	0f 00 d8             	ltr    %ax
  10052e:	0f 01 1d a4 1c 10 00 	lidtl  0x101ca4
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100535:	5b                   	pop    %ebx
  100536:	c3                   	ret    

00100537 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100537:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100538:	b0 ff                	mov    $0xff,%al
  10053a:	57                   	push   %edi
  10053b:	56                   	push   %esi
  10053c:	53                   	push   %ebx
  10053d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100542:	89 da                	mov    %ebx,%edx
  100544:	ee                   	out    %al,(%dx)
  100545:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10054a:	89 ca                	mov    %ecx,%edx
  10054c:	ee                   	out    %al,(%dx)
  10054d:	be 11 00 00 00       	mov    $0x11,%esi
  100552:	bf 20 00 00 00       	mov    $0x20,%edi
  100557:	89 f0                	mov    %esi,%eax
  100559:	89 fa                	mov    %edi,%edx
  10055b:	ee                   	out    %al,(%dx)
  10055c:	b0 20                	mov    $0x20,%al
  10055e:	89 da                	mov    %ebx,%edx
  100560:	ee                   	out    %al,(%dx)
  100561:	b0 04                	mov    $0x4,%al
  100563:	ee                   	out    %al,(%dx)
  100564:	b0 03                	mov    $0x3,%al
  100566:	ee                   	out    %al,(%dx)
  100567:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10056c:	89 f0                	mov    %esi,%eax
  10056e:	89 ea                	mov    %ebp,%edx
  100570:	ee                   	out    %al,(%dx)
  100571:	b0 28                	mov    $0x28,%al
  100573:	89 ca                	mov    %ecx,%edx
  100575:	ee                   	out    %al,(%dx)
  100576:	b0 02                	mov    $0x2,%al
  100578:	ee                   	out    %al,(%dx)
  100579:	b0 01                	mov    $0x1,%al
  10057b:	ee                   	out    %al,(%dx)
  10057c:	b0 68                	mov    $0x68,%al
  10057e:	89 fa                	mov    %edi,%edx
  100580:	ee                   	out    %al,(%dx)
  100581:	be 0a 00 00 00       	mov    $0xa,%esi
  100586:	89 f0                	mov    %esi,%eax
  100588:	ee                   	out    %al,(%dx)
  100589:	b0 68                	mov    $0x68,%al
  10058b:	89 ea                	mov    %ebp,%edx
  10058d:	ee                   	out    %al,(%dx)
  10058e:	89 f0                	mov    %esi,%eax
  100590:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100591:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100596:	89 da                	mov    %ebx,%edx
  100598:	19 c0                	sbb    %eax,%eax
  10059a:	f7 d0                	not    %eax
  10059c:	05 ff 00 00 00       	add    $0xff,%eax
  1005a1:	ee                   	out    %al,(%dx)
  1005a2:	b0 ff                	mov    $0xff,%al
  1005a4:	89 ca                	mov    %ecx,%edx
  1005a6:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1005a7:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1005ac:	74 0d                	je     1005bb <interrupt_controller_init+0x84>
  1005ae:	b2 43                	mov    $0x43,%dl
  1005b0:	b0 34                	mov    $0x34,%al
  1005b2:	ee                   	out    %al,(%dx)
  1005b3:	b0 a9                	mov    $0xa9,%al
  1005b5:	b2 40                	mov    $0x40,%dl
  1005b7:	ee                   	out    %al,(%dx)
  1005b8:	b0 04                	mov    $0x4,%al
  1005ba:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1005bb:	5b                   	pop    %ebx
  1005bc:	5e                   	pop    %esi
  1005bd:	5f                   	pop    %edi
  1005be:	5d                   	pop    %ebp
  1005bf:	c3                   	ret    

001005c0 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005c0:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005c1:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005c3:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005c4:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005cb:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005ce:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1005d4:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1005da:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1005dd:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1005e2:	75 ea                	jne    1005ce <console_clear+0xe>
  1005e4:	be d4 03 00 00       	mov    $0x3d4,%esi
  1005e9:	b0 0e                	mov    $0xe,%al
  1005eb:	89 f2                	mov    %esi,%edx
  1005ed:	ee                   	out    %al,(%dx)
  1005ee:	31 c9                	xor    %ecx,%ecx
  1005f0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005f5:	88 c8                	mov    %cl,%al
  1005f7:	89 da                	mov    %ebx,%edx
  1005f9:	ee                   	out    %al,(%dx)
  1005fa:	b0 0f                	mov    $0xf,%al
  1005fc:	89 f2                	mov    %esi,%edx
  1005fe:	ee                   	out    %al,(%dx)
  1005ff:	88 c8                	mov    %cl,%al
  100601:	89 da                	mov    %ebx,%edx
  100603:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100604:	5b                   	pop    %ebx
  100605:	5e                   	pop    %esi
  100606:	c3                   	ret    

00100607 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100607:	ba 64 00 00 00       	mov    $0x64,%edx
  10060c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10060d:	a8 01                	test   $0x1,%al
  10060f:	74 45                	je     100656 <console_read_digit+0x4f>
  100611:	b2 60                	mov    $0x60,%dl
  100613:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100614:	8d 50 fe             	lea    -0x2(%eax),%edx
  100617:	80 fa 08             	cmp    $0x8,%dl
  10061a:	77 05                	ja     100621 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10061c:	0f b6 c0             	movzbl %al,%eax
  10061f:	48                   	dec    %eax
  100620:	c3                   	ret    
	else if (data == 0x0B)
  100621:	3c 0b                	cmp    $0xb,%al
  100623:	74 35                	je     10065a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100625:	8d 50 b9             	lea    -0x47(%eax),%edx
  100628:	80 fa 02             	cmp    $0x2,%dl
  10062b:	77 07                	ja     100634 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10062d:	0f b6 c0             	movzbl %al,%eax
  100630:	83 e8 40             	sub    $0x40,%eax
  100633:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100634:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100637:	80 fa 02             	cmp    $0x2,%dl
  10063a:	77 07                	ja     100643 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10063c:	0f b6 c0             	movzbl %al,%eax
  10063f:	83 e8 47             	sub    $0x47,%eax
  100642:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100643:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100646:	80 fa 02             	cmp    $0x2,%dl
  100649:	77 07                	ja     100652 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10064b:	0f b6 c0             	movzbl %al,%eax
  10064e:	83 e8 4e             	sub    $0x4e,%eax
  100651:	c3                   	ret    
	else if (data == 0x53)
  100652:	3c 53                	cmp    $0x53,%al
  100654:	74 04                	je     10065a <console_read_digit+0x53>
  100656:	83 c8 ff             	or     $0xffffffff,%eax
  100659:	c3                   	ret    
  10065a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10065c:	c3                   	ret    

0010065d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10065d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100661:	a3 a0 8c 10 00       	mov    %eax,0x108ca0

	asm volatile("movl %0,%%esp\n\t"
  100666:	83 c0 04             	add    $0x4,%eax
  100669:	89 c4                	mov    %eax,%esp
  10066b:	61                   	popa   
  10066c:	07                   	pop    %es
  10066d:	1f                   	pop    %ds
  10066e:	83 c4 08             	add    $0x8,%esp
  100671:	cf                   	iret   
  100672:	eb fe                	jmp    100672 <run+0x15>

00100674 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100674:	53                   	push   %ebx
  100675:	83 ec 0c             	sub    $0xc,%esp
  100678:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10067c:	6a 44                	push   $0x44
  10067e:	6a 00                	push   $0x0
  100680:	8d 43 04             	lea    0x4(%ebx),%eax
  100683:	50                   	push   %eax
  100684:	e8 17 01 00 00       	call   1007a0 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100689:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10068f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100695:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10069b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1006a1:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1006a8:	83 c4 18             	add    $0x18,%esp
  1006ab:	5b                   	pop    %ebx
  1006ac:	c3                   	ret    
  1006ad:	90                   	nop
  1006ae:	90                   	nop
  1006af:	90                   	nop

001006b0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1006b0:	55                   	push   %ebp
  1006b1:	57                   	push   %edi
  1006b2:	56                   	push   %esi
  1006b3:	53                   	push   %ebx
  1006b4:	83 ec 1c             	sub    $0x1c,%esp
  1006b7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1006bb:	83 f8 03             	cmp    $0x3,%eax
  1006be:	7f 04                	jg     1006c4 <program_loader+0x14>
  1006c0:	85 c0                	test   %eax,%eax
  1006c2:	79 02                	jns    1006c6 <program_loader+0x16>
  1006c4:	eb fe                	jmp    1006c4 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006c6:	8b 34 c5 dc 1c 10 00 	mov    0x101cdc(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006cd:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1006d3:	74 02                	je     1006d7 <program_loader+0x27>
  1006d5:	eb fe                	jmp    1006d5 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006d7:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1006da:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006de:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1006e0:	c1 e5 05             	shl    $0x5,%ebp
  1006e3:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1006e6:	eb 3f                	jmp    100727 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1006e8:	83 3b 01             	cmpl   $0x1,(%ebx)
  1006eb:	75 37                	jne    100724 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1006ed:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006f0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006f3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006f6:	01 c7                	add    %eax,%edi
	memsz += va;
  1006f8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006fa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100703:	52                   	push   %edx
  100704:	89 fa                	mov    %edi,%edx
  100706:	29 c2                	sub    %eax,%edx
  100708:	52                   	push   %edx
  100709:	8b 53 04             	mov    0x4(%ebx),%edx
  10070c:	01 f2                	add    %esi,%edx
  10070e:	52                   	push   %edx
  10070f:	50                   	push   %eax
  100710:	e8 27 00 00 00       	call   10073c <memcpy>
  100715:	83 c4 10             	add    $0x10,%esp
  100718:	eb 04                	jmp    10071e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10071a:	c6 07 00             	movb   $0x0,(%edi)
  10071d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10071e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100722:	72 f6                	jb     10071a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100724:	83 c3 20             	add    $0x20,%ebx
  100727:	39 eb                	cmp    %ebp,%ebx
  100729:	72 bd                	jb     1006e8 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10072b:	8b 56 18             	mov    0x18(%esi),%edx
  10072e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100732:	89 10                	mov    %edx,(%eax)
}
  100734:	83 c4 1c             	add    $0x1c,%esp
  100737:	5b                   	pop    %ebx
  100738:	5e                   	pop    %esi
  100739:	5f                   	pop    %edi
  10073a:	5d                   	pop    %ebp
  10073b:	c3                   	ret    

0010073c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10073c:	56                   	push   %esi
  10073d:	31 d2                	xor    %edx,%edx
  10073f:	53                   	push   %ebx
  100740:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100744:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100748:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10074c:	eb 08                	jmp    100756 <memcpy+0x1a>
		*d++ = *s++;
  10074e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100751:	4e                   	dec    %esi
  100752:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100755:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100756:	85 f6                	test   %esi,%esi
  100758:	75 f4                	jne    10074e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10075a:	5b                   	pop    %ebx
  10075b:	5e                   	pop    %esi
  10075c:	c3                   	ret    

0010075d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10075d:	57                   	push   %edi
  10075e:	56                   	push   %esi
  10075f:	53                   	push   %ebx
  100760:	8b 44 24 10          	mov    0x10(%esp),%eax
  100764:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100768:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10076c:	39 c7                	cmp    %eax,%edi
  10076e:	73 26                	jae    100796 <memmove+0x39>
  100770:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100773:	39 c6                	cmp    %eax,%esi
  100775:	76 1f                	jbe    100796 <memmove+0x39>
		s += n, d += n;
  100777:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10077a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10077c:	eb 07                	jmp    100785 <memmove+0x28>
			*--d = *--s;
  10077e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100781:	4a                   	dec    %edx
  100782:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100785:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100786:	85 d2                	test   %edx,%edx
  100788:	75 f4                	jne    10077e <memmove+0x21>
  10078a:	eb 10                	jmp    10079c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10078c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10078f:	4a                   	dec    %edx
  100790:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100793:	41                   	inc    %ecx
  100794:	eb 02                	jmp    100798 <memmove+0x3b>
  100796:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100798:	85 d2                	test   %edx,%edx
  10079a:	75 f0                	jne    10078c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10079c:	5b                   	pop    %ebx
  10079d:	5e                   	pop    %esi
  10079e:	5f                   	pop    %edi
  10079f:	c3                   	ret    

001007a0 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1007a0:	53                   	push   %ebx
  1007a1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007a5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1007a9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1007ad:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1007af:	eb 04                	jmp    1007b5 <memset+0x15>
		*p++ = c;
  1007b1:	88 1a                	mov    %bl,(%edx)
  1007b3:	49                   	dec    %ecx
  1007b4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1007b5:	85 c9                	test   %ecx,%ecx
  1007b7:	75 f8                	jne    1007b1 <memset+0x11>
		*p++ = c;
	return v;
}
  1007b9:	5b                   	pop    %ebx
  1007ba:	c3                   	ret    

001007bb <strlen>:

size_t
strlen(const char *s)
{
  1007bb:	8b 54 24 04          	mov    0x4(%esp),%edx
  1007bf:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007c1:	eb 01                	jmp    1007c4 <strlen+0x9>
		++n;
  1007c3:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007c4:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007c8:	75 f9                	jne    1007c3 <strlen+0x8>
		++n;
	return n;
}
  1007ca:	c3                   	ret    

001007cb <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007cb:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007cf:	31 c0                	xor    %eax,%eax
  1007d1:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007d5:	eb 01                	jmp    1007d8 <strnlen+0xd>
		++n;
  1007d7:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007d8:	39 d0                	cmp    %edx,%eax
  1007da:	74 06                	je     1007e2 <strnlen+0x17>
  1007dc:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1007e0:	75 f5                	jne    1007d7 <strnlen+0xc>
		++n;
	return n;
}
  1007e2:	c3                   	ret    

001007e3 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007e3:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007e4:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007e9:	53                   	push   %ebx
  1007ea:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007ec:	76 05                	jbe    1007f3 <console_putc+0x10>
  1007ee:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007f3:	80 fa 0a             	cmp    $0xa,%dl
  1007f6:	75 2c                	jne    100824 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007f8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007fe:	be 50 00 00 00       	mov    $0x50,%esi
  100803:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100805:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100808:	99                   	cltd   
  100809:	f7 fe                	idiv   %esi
  10080b:	89 de                	mov    %ebx,%esi
  10080d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10080f:	eb 07                	jmp    100818 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100811:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100814:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100815:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100818:	83 f8 50             	cmp    $0x50,%eax
  10081b:	75 f4                	jne    100811 <console_putc+0x2e>
  10081d:	29 d0                	sub    %edx,%eax
  10081f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100822:	eb 0b                	jmp    10082f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100824:	0f b6 d2             	movzbl %dl,%edx
  100827:	09 ca                	or     %ecx,%edx
  100829:	66 89 13             	mov    %dx,(%ebx)
  10082c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10082f:	5b                   	pop    %ebx
  100830:	5e                   	pop    %esi
  100831:	c3                   	ret    

00100832 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100832:	56                   	push   %esi
  100833:	53                   	push   %ebx
  100834:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100838:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10083b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10083f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100844:	75 04                	jne    10084a <fill_numbuf+0x18>
  100846:	85 d2                	test   %edx,%edx
  100848:	74 10                	je     10085a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10084a:	89 d0                	mov    %edx,%eax
  10084c:	31 d2                	xor    %edx,%edx
  10084e:	f7 f1                	div    %ecx
  100850:	4b                   	dec    %ebx
  100851:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100854:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100856:	89 c2                	mov    %eax,%edx
  100858:	eb ec                	jmp    100846 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10085a:	89 d8                	mov    %ebx,%eax
  10085c:	5b                   	pop    %ebx
  10085d:	5e                   	pop    %esi
  10085e:	c3                   	ret    

0010085f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10085f:	55                   	push   %ebp
  100860:	57                   	push   %edi
  100861:	56                   	push   %esi
  100862:	53                   	push   %ebx
  100863:	83 ec 38             	sub    $0x38,%esp
  100866:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10086a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10086e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100872:	e9 60 03 00 00       	jmp    100bd7 <console_vprintf+0x378>
		if (*format != '%') {
  100877:	80 fa 25             	cmp    $0x25,%dl
  10087a:	74 13                	je     10088f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10087c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100880:	0f b6 d2             	movzbl %dl,%edx
  100883:	89 f0                	mov    %esi,%eax
  100885:	e8 59 ff ff ff       	call   1007e3 <console_putc>
  10088a:	e9 45 03 00 00       	jmp    100bd4 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10088f:	47                   	inc    %edi
  100890:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100897:	00 
  100898:	eb 12                	jmp    1008ac <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10089a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10089b:	8a 11                	mov    (%ecx),%dl
  10089d:	84 d2                	test   %dl,%dl
  10089f:	74 1a                	je     1008bb <console_vprintf+0x5c>
  1008a1:	89 e8                	mov    %ebp,%eax
  1008a3:	38 c2                	cmp    %al,%dl
  1008a5:	75 f3                	jne    10089a <console_vprintf+0x3b>
  1008a7:	e9 3f 03 00 00       	jmp    100beb <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008ac:	8a 17                	mov    (%edi),%dl
  1008ae:	84 d2                	test   %dl,%dl
  1008b0:	74 0b                	je     1008bd <console_vprintf+0x5e>
  1008b2:	b9 6c 0c 10 00       	mov    $0x100c6c,%ecx
  1008b7:	89 d5                	mov    %edx,%ebp
  1008b9:	eb e0                	jmp    10089b <console_vprintf+0x3c>
  1008bb:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1008bd:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008c0:	3c 08                	cmp    $0x8,%al
  1008c2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008c9:	00 
  1008ca:	76 13                	jbe    1008df <console_vprintf+0x80>
  1008cc:	eb 1d                	jmp    1008eb <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008ce:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1008d3:	0f be c0             	movsbl %al,%eax
  1008d6:	47                   	inc    %edi
  1008d7:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008db:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008df:	8a 07                	mov    (%edi),%al
  1008e1:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008e4:	80 fa 09             	cmp    $0x9,%dl
  1008e7:	76 e5                	jbe    1008ce <console_vprintf+0x6f>
  1008e9:	eb 18                	jmp    100903 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008eb:	80 fa 2a             	cmp    $0x2a,%dl
  1008ee:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008f5:	ff 
  1008f6:	75 0b                	jne    100903 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008f8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008fb:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008fc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008ff:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100903:	83 cd ff             	or     $0xffffffff,%ebp
  100906:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100909:	75 37                	jne    100942 <console_vprintf+0xe3>
			++format;
  10090b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10090c:	31 ed                	xor    %ebp,%ebp
  10090e:	8a 07                	mov    (%edi),%al
  100910:	8d 50 d0             	lea    -0x30(%eax),%edx
  100913:	80 fa 09             	cmp    $0x9,%dl
  100916:	76 0d                	jbe    100925 <console_vprintf+0xc6>
  100918:	eb 17                	jmp    100931 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10091a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10091d:	0f be c0             	movsbl %al,%eax
  100920:	47                   	inc    %edi
  100921:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100925:	8a 07                	mov    (%edi),%al
  100927:	8d 50 d0             	lea    -0x30(%eax),%edx
  10092a:	80 fa 09             	cmp    $0x9,%dl
  10092d:	76 eb                	jbe    10091a <console_vprintf+0xbb>
  10092f:	eb 11                	jmp    100942 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100931:	3c 2a                	cmp    $0x2a,%al
  100933:	75 0b                	jne    100940 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100935:	83 c3 04             	add    $0x4,%ebx
				++format;
  100938:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100939:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10093c:	85 ed                	test   %ebp,%ebp
  10093e:	79 02                	jns    100942 <console_vprintf+0xe3>
  100940:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100942:	8a 07                	mov    (%edi),%al
  100944:	3c 64                	cmp    $0x64,%al
  100946:	74 34                	je     10097c <console_vprintf+0x11d>
  100948:	7f 1d                	jg     100967 <console_vprintf+0x108>
  10094a:	3c 58                	cmp    $0x58,%al
  10094c:	0f 84 a2 00 00 00    	je     1009f4 <console_vprintf+0x195>
  100952:	3c 63                	cmp    $0x63,%al
  100954:	0f 84 bf 00 00 00    	je     100a19 <console_vprintf+0x1ba>
  10095a:	3c 43                	cmp    $0x43,%al
  10095c:	0f 85 d0 00 00 00    	jne    100a32 <console_vprintf+0x1d3>
  100962:	e9 a3 00 00 00       	jmp    100a0a <console_vprintf+0x1ab>
  100967:	3c 75                	cmp    $0x75,%al
  100969:	74 4d                	je     1009b8 <console_vprintf+0x159>
  10096b:	3c 78                	cmp    $0x78,%al
  10096d:	74 5c                	je     1009cb <console_vprintf+0x16c>
  10096f:	3c 73                	cmp    $0x73,%al
  100971:	0f 85 bb 00 00 00    	jne    100a32 <console_vprintf+0x1d3>
  100977:	e9 86 00 00 00       	jmp    100a02 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10097c:	83 c3 04             	add    $0x4,%ebx
  10097f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100982:	89 d1                	mov    %edx,%ecx
  100984:	c1 f9 1f             	sar    $0x1f,%ecx
  100987:	89 0c 24             	mov    %ecx,(%esp)
  10098a:	31 ca                	xor    %ecx,%edx
  10098c:	55                   	push   %ebp
  10098d:	29 ca                	sub    %ecx,%edx
  10098f:	68 74 0c 10 00       	push   $0x100c74
  100994:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100999:	8d 44 24 40          	lea    0x40(%esp),%eax
  10099d:	e8 90 fe ff ff       	call   100832 <fill_numbuf>
  1009a2:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1009a6:	58                   	pop    %eax
  1009a7:	5a                   	pop    %edx
  1009a8:	ba 01 00 00 00       	mov    $0x1,%edx
  1009ad:	8b 04 24             	mov    (%esp),%eax
  1009b0:	83 e0 01             	and    $0x1,%eax
  1009b3:	e9 a5 00 00 00       	jmp    100a5d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1009b8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1009bb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009c0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009c3:	55                   	push   %ebp
  1009c4:	68 74 0c 10 00       	push   $0x100c74
  1009c9:	eb 11                	jmp    1009dc <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009cb:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009ce:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009d1:	55                   	push   %ebp
  1009d2:	68 88 0c 10 00       	push   $0x100c88
  1009d7:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009dc:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009e0:	e8 4d fe ff ff       	call   100832 <fill_numbuf>
  1009e5:	ba 01 00 00 00       	mov    $0x1,%edx
  1009ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009ee:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009f0:	59                   	pop    %ecx
  1009f1:	59                   	pop    %ecx
  1009f2:	eb 69                	jmp    100a5d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009f4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009f7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009fa:	55                   	push   %ebp
  1009fb:	68 74 0c 10 00       	push   $0x100c74
  100a00:	eb d5                	jmp    1009d7 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a02:	83 c3 04             	add    $0x4,%ebx
  100a05:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a08:	eb 40                	jmp    100a4a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a0a:	83 c3 04             	add    $0x4,%ebx
  100a0d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a10:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a14:	e9 bd 01 00 00       	jmp    100bd6 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a19:	83 c3 04             	add    $0x4,%ebx
  100a1c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a1f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a23:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a28:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a2c:	88 44 24 24          	mov    %al,0x24(%esp)
  100a30:	eb 27                	jmp    100a59 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a32:	84 c0                	test   %al,%al
  100a34:	75 02                	jne    100a38 <console_vprintf+0x1d9>
  100a36:	b0 25                	mov    $0x25,%al
  100a38:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a3c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a41:	80 3f 00             	cmpb   $0x0,(%edi)
  100a44:	74 0a                	je     100a50 <console_vprintf+0x1f1>
  100a46:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a4e:	eb 09                	jmp    100a59 <console_vprintf+0x1fa>
				format--;
  100a50:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a54:	4f                   	dec    %edi
  100a55:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a59:	31 d2                	xor    %edx,%edx
  100a5b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a5d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a5f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a62:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a69:	74 1f                	je     100a8a <console_vprintf+0x22b>
  100a6b:	89 04 24             	mov    %eax,(%esp)
  100a6e:	eb 01                	jmp    100a71 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a70:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a71:	39 e9                	cmp    %ebp,%ecx
  100a73:	74 0a                	je     100a7f <console_vprintf+0x220>
  100a75:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a79:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a7d:	75 f1                	jne    100a70 <console_vprintf+0x211>
  100a7f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a82:	89 0c 24             	mov    %ecx,(%esp)
  100a85:	eb 1f                	jmp    100aa6 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a87:	42                   	inc    %edx
  100a88:	eb 09                	jmp    100a93 <console_vprintf+0x234>
  100a8a:	89 d1                	mov    %edx,%ecx
  100a8c:	8b 14 24             	mov    (%esp),%edx
  100a8f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a93:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a97:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a9b:	75 ea                	jne    100a87 <console_vprintf+0x228>
  100a9d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100aa1:	89 14 24             	mov    %edx,(%esp)
  100aa4:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100aa6:	85 c0                	test   %eax,%eax
  100aa8:	74 0c                	je     100ab6 <console_vprintf+0x257>
  100aaa:	84 d2                	test   %dl,%dl
  100aac:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100ab3:	00 
  100ab4:	75 24                	jne    100ada <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100ab6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100abb:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100ac2:	00 
  100ac3:	75 15                	jne    100ada <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100ac5:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ac9:	83 e0 08             	and    $0x8,%eax
  100acc:	83 f8 01             	cmp    $0x1,%eax
  100acf:	19 c9                	sbb    %ecx,%ecx
  100ad1:	f7 d1                	not    %ecx
  100ad3:	83 e1 20             	and    $0x20,%ecx
  100ad6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100ada:	3b 2c 24             	cmp    (%esp),%ebp
  100add:	7e 0d                	jle    100aec <console_vprintf+0x28d>
  100adf:	84 d2                	test   %dl,%dl
  100ae1:	74 40                	je     100b23 <console_vprintf+0x2c4>
			zeros = precision - len;
  100ae3:	2b 2c 24             	sub    (%esp),%ebp
  100ae6:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100aea:	eb 3f                	jmp    100b2b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100aec:	84 d2                	test   %dl,%dl
  100aee:	74 33                	je     100b23 <console_vprintf+0x2c4>
  100af0:	8b 44 24 14          	mov    0x14(%esp),%eax
  100af4:	83 e0 06             	and    $0x6,%eax
  100af7:	83 f8 02             	cmp    $0x2,%eax
  100afa:	75 27                	jne    100b23 <console_vprintf+0x2c4>
  100afc:	45                   	inc    %ebp
  100afd:	75 24                	jne    100b23 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100aff:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b01:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b04:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b09:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b0c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b0f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b13:	7d 0e                	jge    100b23 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b15:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b19:	29 ca                	sub    %ecx,%edx
  100b1b:	29 c2                	sub    %eax,%edx
  100b1d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b21:	eb 08                	jmp    100b2b <console_vprintf+0x2cc>
  100b23:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b2a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b2b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b2f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b31:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b35:	2b 2c 24             	sub    (%esp),%ebp
  100b38:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b3d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b40:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b43:	29 c5                	sub    %eax,%ebp
  100b45:	89 f0                	mov    %esi,%eax
  100b47:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b4b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b4f:	eb 0f                	jmp    100b60 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b51:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b55:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b5a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b5b:	e8 83 fc ff ff       	call   1007e3 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b60:	85 ed                	test   %ebp,%ebp
  100b62:	7e 07                	jle    100b6b <console_vprintf+0x30c>
  100b64:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b69:	74 e6                	je     100b51 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b6b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b70:	89 c6                	mov    %eax,%esi
  100b72:	74 23                	je     100b97 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b74:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b79:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b7d:	e8 61 fc ff ff       	call   1007e3 <console_putc>
  100b82:	89 c6                	mov    %eax,%esi
  100b84:	eb 11                	jmp    100b97 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b86:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b8a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b8f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b90:	e8 4e fc ff ff       	call   1007e3 <console_putc>
  100b95:	eb 06                	jmp    100b9d <console_vprintf+0x33e>
  100b97:	89 f0                	mov    %esi,%eax
  100b99:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b9d:	85 f6                	test   %esi,%esi
  100b9f:	7f e5                	jg     100b86 <console_vprintf+0x327>
  100ba1:	8b 34 24             	mov    (%esp),%esi
  100ba4:	eb 15                	jmp    100bbb <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ba6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100baa:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100bab:	0f b6 11             	movzbl (%ecx),%edx
  100bae:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bb2:	e8 2c fc ff ff       	call   1007e3 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bb7:	ff 44 24 04          	incl   0x4(%esp)
  100bbb:	85 f6                	test   %esi,%esi
  100bbd:	7f e7                	jg     100ba6 <console_vprintf+0x347>
  100bbf:	eb 0f                	jmp    100bd0 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100bc1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bc5:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bca:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bcb:	e8 13 fc ff ff       	call   1007e3 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bd0:	85 ed                	test   %ebp,%ebp
  100bd2:	7f ed                	jg     100bc1 <console_vprintf+0x362>
  100bd4:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100bd6:	47                   	inc    %edi
  100bd7:	8a 17                	mov    (%edi),%dl
  100bd9:	84 d2                	test   %dl,%dl
  100bdb:	0f 85 96 fc ff ff    	jne    100877 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100be1:	83 c4 38             	add    $0x38,%esp
  100be4:	89 f0                	mov    %esi,%eax
  100be6:	5b                   	pop    %ebx
  100be7:	5e                   	pop    %esi
  100be8:	5f                   	pop    %edi
  100be9:	5d                   	pop    %ebp
  100bea:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100beb:	81 e9 6c 0c 10 00    	sub    $0x100c6c,%ecx
  100bf1:	b8 01 00 00 00       	mov    $0x1,%eax
  100bf6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100bf8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bf9:	09 44 24 14          	or     %eax,0x14(%esp)
  100bfd:	e9 aa fc ff ff       	jmp    1008ac <console_vprintf+0x4d>

00100c02 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c02:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c06:	50                   	push   %eax
  100c07:	ff 74 24 10          	pushl  0x10(%esp)
  100c0b:	ff 74 24 10          	pushl  0x10(%esp)
  100c0f:	ff 74 24 10          	pushl  0x10(%esp)
  100c13:	e8 47 fc ff ff       	call   10085f <console_vprintf>
  100c18:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c1b:	c3                   	ret    
