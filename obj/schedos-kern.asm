
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
  100014:	e8 f8 03 00 00       	call   100411 <start>
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
  10006d:	e8 0c 03 00 00       	call   10037e <interrupt>

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
  1000a0:	83 ec 2c             	sub    $0x2c,%esp
	pid_t pid = current->p_pid;
  1000a3:	a1 38 7d 10 00       	mov    0x107d38,%eax
  1000a8:	8b 38                	mov    (%eax),%edi
	uint32_t seed;
	unsigned int lotteryTotal;
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
  1000aa:	a1 3c 7d 10 00       	mov    0x107d3c,%eax
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
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000c1:	89 d7                	mov    %edx,%edi

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000c3:	83 b8 48 73 10 00 01 	cmpl   $0x1,0x107348(%eax)
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
  1000e0:	83 b8 48 73 10 00 01 	cmpl   $0x1,0x107348(%eax)
  1000e7:	75 0e                	jne    1000f7 <schedule+0x5b>
				run(&proc_array[pid]);
  1000e9:	83 ec 0c             	sub    $0xc,%esp
  1000ec:	05 f0 72 10 00       	add    $0x1072f0,%eax
  1000f1:	50                   	push   %eax
  1000f2:	e9 5d 02 00 00       	jmp    100354 <schedule+0x2b8>
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
  100110:	8b 98 38 73 10 00    	mov    0x107338(%eax),%ebx
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
  100121:	05 f8 72 10 00       	add    $0x1072f8,%eax
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
  100146:	83 be 48 73 10 00 01 	cmpl   $0x1,0x107348(%esi)
  10014d:	75 ba                	jne    100109 <schedule+0x6d>
		run(&proc_array[firstPid]);
  10014f:	83 ec 0c             	sub    $0xc,%esp
  100152:	81 c6 f0 72 10 00    	add    $0x1072f0,%esi
  100158:	56                   	push   %esi
  100159:	e9 f6 01 00 00       	jmp    100354 <schedule+0x2b8>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  10015e:	83 f8 2a             	cmp    $0x2a,%eax
  100161:	0f 85 25 01 00 00    	jne    10028c <schedule+0x1f0>
  100167:	c7 44 24 14 02 00 00 	movl   $0x2,0x14(%esp)
  10016e:	00 
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  10016f:	6b df 60             	imul   $0x60,%edi,%ebx
  100172:	83 ec 0c             	sub    $0xc,%esp
  100175:	a1 00 80 19 00       	mov    0x198000,%eax
  10017a:	81 c3 fc 72 10 00    	add    $0x1072fc,%ebx
  100180:	ff 73 40             	pushl  0x40(%ebx)
  100183:	57                   	push   %edi
  100184:	68 f4 0c 10 00       	push   $0x100cf4
  100189:	68 00 01 00 00       	push   $0x100
  10018e:	50                   	push   %eax
  10018f:	e8 46 0b 00 00       	call   100cda <console_printf>
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
  1001b8:	89 54 24 18          	mov    %edx,0x18(%esp)
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001bc:	83 ec 0c             	sub    $0xc,%esp
  1001bf:	8d 95 fc 72 10 00    	lea    0x1072fc(%ebp),%edx
  1001c5:	ff 72 40             	pushl  0x40(%edx)
  1001c8:	57                   	push   %edi
  1001c9:	68 f4 0c 10 00       	push   $0x100cf4
  1001ce:	68 00 01 00 00       	push   $0x100
  1001d3:	50                   	push   %eax
  1001d4:	89 54 24 30          	mov    %edx,0x30(%esp)
  1001d8:	89 4c 24 2c          	mov    %ecx,0x2c(%esp)
  1001dc:	e8 f9 0a 00 00       	call   100cda <console_printf>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001e1:	83 c4 20             	add    $0x20,%esp
  1001e4:	83 bd 48 73 10 00 01 	cmpl   $0x1,0x107348(%ebp)
  1001eb:	8b 54 24 10          	mov    0x10(%esp),%edx
  1001ef:	8b 4c 24 0c          	mov    0xc(%esp),%ecx
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001f3:	a3 00 80 19 00       	mov    %eax,0x198000
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001f8:	75 0b                	jne    100205 <schedule+0x169>
  1001fa:	8b 42 40             	mov    0x40(%edx),%eax
  1001fd:	39 f0                	cmp    %esi,%eax
  1001ff:	72 04                	jb     100205 <schedule+0x169>
  100201:	89 fb                	mov    %edi,%ebx
  100203:	eb 02                	jmp    100207 <schedule+0x16b>
  100205:	89 f0                	mov    %esi,%eax
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
  100207:	41                   	inc    %ecx
  100208:	83 f9 04             	cmp    $0x4,%ecx
  10020b:	74 04                	je     100211 <schedule+0x175>
  10020d:	89 c6                	mov    %eax,%esi
  10020f:	eb 92                	jmp    1001a3 <schedule+0x107>
				}
			}
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
  100211:	6b c3 60             	imul   $0x60,%ebx,%eax
  100214:	83 b8 40 73 10 00 00 	cmpl   $0x0,0x107340(%eax)
  10021b:	75 3a                	jne    100257 <schedule+0x1bb>
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  10021d:	83 ec 0c             	sub    $0xc,%esp
  100220:	a1 00 80 19 00       	mov    0x198000,%eax
  100225:	ff 74 24 24          	pushl  0x24(%esp)
  100229:	53                   	push   %ebx
  10022a:	68 07 0d 10 00       	push   $0x100d07
  10022f:	68 00 01 00 00       	push   $0x100
  100234:	50                   	push   %eax
  100235:	e8 a0 0a 00 00       	call   100cda <console_printf>
				pid = (pid + 1) % NPROCS;
  10023a:	b9 05 00 00 00       	mov    $0x5,%ecx
				hi--;
  10023f:	ff 4c 24 34          	decl   0x34(%esp)
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  100243:	a3 00 80 19 00       	mov    %eax,0x198000
				pid = (pid + 1) % NPROCS;
  100248:	8b 44 24 38          	mov    0x38(%esp),%eax
				hi--;
				continue;
  10024c:	83 c4 20             	add    $0x20,%esp
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
				pid = (pid + 1) % NPROCS;
  10024f:	40                   	inc    %eax
  100250:	99                   	cltd   
  100251:	f7 f9                	idiv   %ecx
  100253:	89 d7                	mov    %edx,%edi
				hi--;
				continue;
  100255:	eb 09                	jmp    100260 <schedule+0x1c4>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
  100257:	83 b8 48 73 10 00 01 	cmpl   $0x1,0x107348(%eax)
  10025e:	74 0b                	je     10026b <schedule+0x1cf>
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
  100260:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100265:	0f 85 04 ff ff ff    	jne    10016f <schedule+0xd3>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
  10026b:	6b db 60             	imul   $0x60,%ebx,%ebx
  10026e:	81 c3 f0 72 10 00    	add    $0x1072f0,%ebx
  100274:	8b 43 50             	mov    0x50(%ebx),%eax
  100277:	85 c0                	test   %eax,%eax
  100279:	0f 84 da 00 00 00    	je     100359 <schedule+0x2bd>
			proc_array[firstPid].p_share_left--;
  10027f:	48                   	dec    %eax
			run(&proc_array[firstPid]);
  100280:	83 ec 0c             	sub    $0xc,%esp
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  100283:	89 43 50             	mov    %eax,0x50(%ebx)
			run(&proc_array[firstPid]);
  100286:	53                   	push   %ebx
  100287:	e9 c8 00 00 00       	jmp    100354 <schedule+0x2b8>
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
  10028c:	83 f8 07             	cmp    $0x7,%eax
  10028f:	0f 85 c4 00 00 00    	jne    100359 <schedule+0x2bd>
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  100295:	a1 c8 74 10 00       	mov    0x1074c8,%eax
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  10029a:	8b 1d a4 73 10 00    	mov    0x1073a4,%ebx
			lotteryTotal += proc_array[i].p_lottery_amt;
  1002a0:	8b 0d 44 73 10 00    	mov    0x107344,%ecx
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  1002a6:	8b 15 04 74 10 00    	mov    0x107404,%edx
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  1002ac:	89 44 24 18          	mov    %eax,0x18(%esp)

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002b0:	a1 64 74 10 00       	mov    0x107464,%eax
			seed ^= seed << 7 & 0xffffffff;
			seed ^= seed << 15 & 0x9d2c5680;
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  1002b5:	8b 35 a8 73 10 00    	mov    0x1073a8,%esi
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  1002bb:	01 d9                	add    %ebx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002bd:	8b 3d 08 74 10 00    	mov    0x107408,%edi
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002c3:	8b 2d 68 74 10 00    	mov    0x107468,%ebp
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  1002c9:	01 d1                	add    %edx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002cb:	01 da                	add    %ebx,%edx
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  1002cd:	03 0d 64 74 10 00    	add    0x107464,%ecx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002d3:	01 d0                	add    %edx,%eax
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  1002d5:	03 0d c4 74 10 00    	add    0x1074c4,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002db:	89 54 24 14          	mov    %edx,0x14(%esp)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002df:	89 44 24 1c          	mov    %eax,0x1c(%esp)

static inline uint64_t
read_cycle_counter(void)
{
        uint64_t tsc;
        asm volatile("rdtsc" : "=A" (tsc));
  1002e3:	0f 31                	rdtsc  
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
		}
		
		while (1) {
			seed = (uint32_t) read_cycle_counter();
  1002e5:	89 c2                	mov    %eax,%edx
			//seed ^= seed << 15 & 0xEFC60000;
			//seed ^= seed >> 18;
			/**************
			Reference from en.cppreference.com/w/app/numeric/random
			**************/
			seed ^= seed >> 11 & 0x9908b0df;
  1002e7:	c1 e8 0b             	shr    $0xb,%eax
  1002ea:	25 df b0 08 99       	and    $0x9908b0df,%eax
  1002ef:	31 d0                	xor    %edx,%eax
			seed ^= seed << 7 & 0xffffffff;
  1002f1:	89 c2                	mov    %eax,%edx
  1002f3:	c1 e2 07             	shl    $0x7,%edx
  1002f6:	31 c2                	xor    %eax,%edx
			seed ^= seed << 15 & 0x9d2c5680;
  1002f8:	89 d0                	mov    %edx,%eax
  1002fa:	c1 e0 0f             	shl    $0xf,%eax
  1002fd:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;
  100302:	31 d0                	xor    %edx,%eax
  100304:	31 d2                	xor    %edx,%edx
  100306:	f7 f1                	div    %ecx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  100308:	39 da                	cmp    %ebx,%edx
  10030a:	73 0f                	jae    10031b <schedule+0x27f>
  10030c:	83 fe 01             	cmp    $0x1,%esi
  10030f:	75 0a                	jne    10031b <schedule+0x27f>
				run(&proc_array[1]);
  100311:	83 ec 0c             	sub    $0xc,%esp
  100314:	68 50 73 10 00       	push   $0x107350
  100319:	eb 39                	jmp    100354 <schedule+0x2b8>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  10031b:	3b 54 24 14          	cmp    0x14(%esp),%edx
  10031f:	73 0f                	jae    100330 <schedule+0x294>
  100321:	83 ff 01             	cmp    $0x1,%edi
  100324:	75 0a                	jne    100330 <schedule+0x294>
				run(&proc_array[2]);
  100326:	83 ec 0c             	sub    $0xc,%esp
  100329:	68 b0 73 10 00       	push   $0x1073b0
  10032e:	eb 24                	jmp    100354 <schedule+0x2b8>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  100330:	3b 54 24 1c          	cmp    0x1c(%esp),%edx
  100334:	73 0f                	jae    100345 <schedule+0x2a9>
  100336:	83 fd 01             	cmp    $0x1,%ebp
  100339:	75 0a                	jne    100345 <schedule+0x2a9>
				run(&proc_array[3]);
  10033b:	83 ec 0c             	sub    $0xc,%esp
  10033e:	68 10 74 10 00       	push   $0x107410
  100343:	eb 0f                	jmp    100354 <schedule+0x2b8>
			else if (proc_array[4].p_state == P_RUNNABLE)
  100345:	83 7c 24 18 01       	cmpl   $0x1,0x18(%esp)
  10034a:	75 97                	jne    1002e3 <schedule+0x247>
				run(&proc_array[4]);
  10034c:	83 ec 0c             	sub    $0xc,%esp
  10034f:	68 70 74 10 00       	push   $0x107470
  100354:	e8 dc 03 00 00       	call   100735 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100359:	ff 35 3c 7d 10 00    	pushl  0x107d3c
  10035f:	a1 00 80 19 00       	mov    0x198000,%eax
  100364:	68 22 0d 10 00       	push   $0x100d22
  100369:	68 00 01 00 00       	push   $0x100
  10036e:	50                   	push   %eax
  10036f:	e8 66 09 00 00       	call   100cda <console_printf>
  100374:	83 c4 10             	add    $0x10,%esp
  100377:	a3 00 80 19 00       	mov    %eax,0x198000
  10037c:	eb fe                	jmp    10037c <schedule+0x2e0>

0010037e <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10037e:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10037f:	8b 3d 38 7d 10 00    	mov    0x107d38,%edi
  100385:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10038a:	56                   	push   %esi
  10038b:	53                   	push   %ebx
  10038c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100390:	83 c7 04             	add    $0x4,%edi
  100393:	89 de                	mov    %ebx,%esi
  100395:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100397:	8b 43 28             	mov    0x28(%ebx),%eax
  10039a:	83 f8 32             	cmp    $0x32,%eax
  10039d:	74 38                	je     1003d7 <interrupt+0x59>
  10039f:	77 0e                	ja     1003af <interrupt+0x31>
  1003a1:	83 f8 30             	cmp    $0x30,%eax
  1003a4:	74 15                	je     1003bb <interrupt+0x3d>
  1003a6:	77 18                	ja     1003c0 <interrupt+0x42>
  1003a8:	83 f8 20             	cmp    $0x20,%eax
  1003ab:	74 5d                	je     10040a <interrupt+0x8c>
  1003ad:	eb 60                	jmp    10040f <interrupt+0x91>
  1003af:	83 f8 33             	cmp    $0x33,%eax
  1003b2:	74 33                	je     1003e7 <interrupt+0x69>
  1003b4:	83 f8 34             	cmp    $0x34,%eax
  1003b7:	74 41                	je     1003fa <interrupt+0x7c>
  1003b9:	eb 54                	jmp    10040f <interrupt+0x91>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1003bb:	e8 dc fc ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1003c0:	a1 38 7d 10 00       	mov    0x107d38,%eax
		current->p_exit_status = reg->reg_eax;
  1003c5:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1003c8:	c7 40 58 03 00 00 00 	movl   $0x3,0x58(%eax)
		current->p_exit_status = reg->reg_eax;
  1003cf:	89 50 5c             	mov    %edx,0x5c(%eax)
		schedule();
  1003d2:	e8 c5 fc ff ff       	call   10009c <schedule>
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_priority = reg->reg_eax;
  1003d7:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003da:	a1 38 7d 10 00       	mov    0x107d38,%eax
  1003df:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  1003e2:	e8 b5 fc ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  1003e7:	a1 38 7d 10 00       	mov    0x107d38,%eax
  1003ec:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003ef:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  1003f2:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  1003f5:	e8 a2 fc ff ff       	call   10009c <schedule>
	
	case INT_SYS_LOTTERY:
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_lottery_amt = reg->reg_eax;
  1003fa:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003fd:	a1 38 7d 10 00       	mov    0x107d38,%eax
  100402:	89 50 54             	mov    %edx,0x54(%eax)
		schedule();
  100405:	e8 92 fc ff ff       	call   10009c <schedule>
	
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  10040a:	e8 8d fc ff ff       	call   10009c <schedule>
  10040f:	eb fe                	jmp    10040f <interrupt+0x91>

00100411 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100411:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100412:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100417:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100418:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  10041a:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10041b:	bb 50 73 10 00       	mov    $0x107350,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100420:	e8 ef 00 00 00       	call   100514 <segments_init>
	interrupt_controller_init(0);
  100425:	83 ec 0c             	sub    $0xc,%esp
  100428:	6a 00                	push   $0x0
  10042a:	e8 e0 01 00 00       	call   10060f <interrupt_controller_init>
	//interrupt_controller_init(1);
	console_clear();
  10042f:	e8 64 02 00 00       	call   100698 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100434:	83 c4 0c             	add    $0xc,%esp
  100437:	68 e0 01 00 00       	push   $0x1e0
  10043c:	6a 00                	push   $0x0
  10043e:	68 f0 72 10 00       	push   $0x1072f0
  100443:	e8 30 04 00 00       	call   100878 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100448:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10044b:	c7 05 f0 72 10 00 00 	movl   $0x0,0x1072f0
  100452:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100455:	c7 05 48 73 10 00 00 	movl   $0x0,0x107348
  10045c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10045f:	c7 05 50 73 10 00 01 	movl   $0x1,0x107350
  100466:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100469:	c7 05 a8 73 10 00 00 	movl   $0x0,0x1073a8
  100470:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100473:	c7 05 b0 73 10 00 02 	movl   $0x2,0x1073b0
  10047a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10047d:	c7 05 08 74 10 00 00 	movl   $0x0,0x107408
  100484:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100487:	c7 05 10 74 10 00 03 	movl   $0x3,0x107410
  10048e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100491:	c7 05 68 74 10 00 00 	movl   $0x0,0x107468
  100498:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10049b:	c7 05 70 74 10 00 04 	movl   $0x4,0x107470
  1004a2:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1004a5:	c7 05 c8 74 10 00 00 	movl   $0x0,0x1074c8
  1004ac:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1004af:	83 ec 0c             	sub    $0xc,%esp
  1004b2:	53                   	push   %ebx
  1004b3:	e8 94 02 00 00       	call   10074c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1004b8:	58                   	pop    %eax
  1004b9:	5a                   	pop    %edx
  1004ba:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1004bd:	89 7b 40             	mov    %edi,0x40(%ebx)
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  1004c0:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1004c6:	50                   	push   %eax
  1004c7:	56                   	push   %esi
		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  1004c8:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1004c9:	e8 ba 02 00 00       	call   100788 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1004ce:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1004d1:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  1004d8:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  1004df:	83 c3 60             	add    $0x60,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1004e2:	83 fe 04             	cmp    $0x4,%esi
  1004e5:	75 c8                	jne    1004af <start+0x9e>
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;
	scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  1004e7:	83 ec 0c             	sub    $0xc,%esp
  1004ea:	68 50 73 10 00       	push   $0x107350
		proc->p_lottery_amt = 1;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1004ef:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004f6:	80 0b 00 
	cursorposLock = 0;	// lock is available
  1004f9:	c7 05 10 80 19 00 00 	movl   $0x0,0x198010
  100500:	00 00 00 
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;
	scheduling_algorithm = __EXERCISE_7__;
  100503:	c7 05 3c 7d 10 00 07 	movl   $0x7,0x107d3c
  10050a:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10050d:	e8 23 02 00 00       	call   100735 <run>
  100512:	90                   	nop
  100513:	90                   	nop

00100514 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100514:	b8 d0 74 10 00       	mov    $0x1074d0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100519:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10051e:	89 c2                	mov    %eax,%edx
  100520:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  100523:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100524:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100529:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10052c:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100532:	c1 e8 18             	shr    $0x18,%eax
  100535:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10053b:	ba 38 75 10 00       	mov    $0x107538,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100540:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100545:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100547:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10054e:	68 00 
  100550:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100557:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10055e:	c7 05 d4 74 10 00 00 	movl   $0x180000,0x1074d4
  100565:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100568:	66 c7 05 d8 74 10 00 	movw   $0x10,0x1074d8
  10056f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100571:	66 89 0c c5 38 75 10 	mov    %cx,0x107538(,%eax,8)
  100578:	00 
  100579:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100580:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100585:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10058a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10058f:	40                   	inc    %eax
  100590:	3d 00 01 00 00       	cmp    $0x100,%eax
  100595:	75 da                	jne    100571 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100597:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10059c:	ba 38 75 10 00       	mov    $0x107538,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1005a1:	66 a3 38 76 10 00    	mov    %ax,0x107638
  1005a7:	c1 e8 10             	shr    $0x10,%eax
  1005aa:	66 a3 3e 76 10 00    	mov    %ax,0x10763e
  1005b0:	b8 30 00 00 00       	mov    $0x30,%eax
  1005b5:	66 c7 05 3a 76 10 00 	movw   $0x8,0x10763a
  1005bc:	08 00 
  1005be:	c6 05 3c 76 10 00 00 	movb   $0x0,0x10763c
  1005c5:	c6 05 3d 76 10 00 8e 	movb   $0x8e,0x10763d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1005cc:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1005d3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1005da:	66 89 0c c5 38 75 10 	mov    %cx,0x107538(,%eax,8)
  1005e1:	00 
  1005e2:	c1 e9 10             	shr    $0x10,%ecx
  1005e5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1005ea:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1005ef:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1005f4:	40                   	inc    %eax
  1005f5:	83 f8 3a             	cmp    $0x3a,%eax
  1005f8:	75 d2                	jne    1005cc <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1005fa:	b0 28                	mov    $0x28,%al
  1005fc:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  100603:	0f 00 d8             	ltr    %ax
  100606:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  10060d:	5b                   	pop    %ebx
  10060e:	c3                   	ret    

0010060f <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10060f:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100610:	b0 ff                	mov    $0xff,%al
  100612:	57                   	push   %edi
  100613:	56                   	push   %esi
  100614:	53                   	push   %ebx
  100615:	bb 21 00 00 00       	mov    $0x21,%ebx
  10061a:	89 da                	mov    %ebx,%edx
  10061c:	ee                   	out    %al,(%dx)
  10061d:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  100622:	89 ca                	mov    %ecx,%edx
  100624:	ee                   	out    %al,(%dx)
  100625:	be 11 00 00 00       	mov    $0x11,%esi
  10062a:	bf 20 00 00 00       	mov    $0x20,%edi
  10062f:	89 f0                	mov    %esi,%eax
  100631:	89 fa                	mov    %edi,%edx
  100633:	ee                   	out    %al,(%dx)
  100634:	b0 20                	mov    $0x20,%al
  100636:	89 da                	mov    %ebx,%edx
  100638:	ee                   	out    %al,(%dx)
  100639:	b0 04                	mov    $0x4,%al
  10063b:	ee                   	out    %al,(%dx)
  10063c:	b0 03                	mov    $0x3,%al
  10063e:	ee                   	out    %al,(%dx)
  10063f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100644:	89 f0                	mov    %esi,%eax
  100646:	89 ea                	mov    %ebp,%edx
  100648:	ee                   	out    %al,(%dx)
  100649:	b0 28                	mov    $0x28,%al
  10064b:	89 ca                	mov    %ecx,%edx
  10064d:	ee                   	out    %al,(%dx)
  10064e:	b0 02                	mov    $0x2,%al
  100650:	ee                   	out    %al,(%dx)
  100651:	b0 01                	mov    $0x1,%al
  100653:	ee                   	out    %al,(%dx)
  100654:	b0 68                	mov    $0x68,%al
  100656:	89 fa                	mov    %edi,%edx
  100658:	ee                   	out    %al,(%dx)
  100659:	be 0a 00 00 00       	mov    $0xa,%esi
  10065e:	89 f0                	mov    %esi,%eax
  100660:	ee                   	out    %al,(%dx)
  100661:	b0 68                	mov    $0x68,%al
  100663:	89 ea                	mov    %ebp,%edx
  100665:	ee                   	out    %al,(%dx)
  100666:	89 f0                	mov    %esi,%eax
  100668:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100669:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10066e:	89 da                	mov    %ebx,%edx
  100670:	19 c0                	sbb    %eax,%eax
  100672:	f7 d0                	not    %eax
  100674:	05 ff 00 00 00       	add    $0xff,%eax
  100679:	ee                   	out    %al,(%dx)
  10067a:	b0 ff                	mov    $0xff,%al
  10067c:	89 ca                	mov    %ecx,%edx
  10067e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10067f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100684:	74 0d                	je     100693 <interrupt_controller_init+0x84>
  100686:	b2 43                	mov    $0x43,%dl
  100688:	b0 34                	mov    $0x34,%al
  10068a:	ee                   	out    %al,(%dx)
  10068b:	b0 a9                	mov    $0xa9,%al
  10068d:	b2 40                	mov    $0x40,%dl
  10068f:	ee                   	out    %al,(%dx)
  100690:	b0 04                	mov    $0x4,%al
  100692:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100693:	5b                   	pop    %ebx
  100694:	5e                   	pop    %esi
  100695:	5f                   	pop    %edi
  100696:	5d                   	pop    %ebp
  100697:	c3                   	ret    

00100698 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100698:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100699:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10069b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10069c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1006a3:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1006a6:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1006ac:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1006b2:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1006b5:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1006ba:	75 ea                	jne    1006a6 <console_clear+0xe>
  1006bc:	be d4 03 00 00       	mov    $0x3d4,%esi
  1006c1:	b0 0e                	mov    $0xe,%al
  1006c3:	89 f2                	mov    %esi,%edx
  1006c5:	ee                   	out    %al,(%dx)
  1006c6:	31 c9                	xor    %ecx,%ecx
  1006c8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1006cd:	88 c8                	mov    %cl,%al
  1006cf:	89 da                	mov    %ebx,%edx
  1006d1:	ee                   	out    %al,(%dx)
  1006d2:	b0 0f                	mov    $0xf,%al
  1006d4:	89 f2                	mov    %esi,%edx
  1006d6:	ee                   	out    %al,(%dx)
  1006d7:	88 c8                	mov    %cl,%al
  1006d9:	89 da                	mov    %ebx,%edx
  1006db:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1006dc:	5b                   	pop    %ebx
  1006dd:	5e                   	pop    %esi
  1006de:	c3                   	ret    

001006df <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1006df:	ba 64 00 00 00       	mov    $0x64,%edx
  1006e4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1006e5:	a8 01                	test   $0x1,%al
  1006e7:	74 45                	je     10072e <console_read_digit+0x4f>
  1006e9:	b2 60                	mov    $0x60,%dl
  1006eb:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1006ec:	8d 50 fe             	lea    -0x2(%eax),%edx
  1006ef:	80 fa 08             	cmp    $0x8,%dl
  1006f2:	77 05                	ja     1006f9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1006f4:	0f b6 c0             	movzbl %al,%eax
  1006f7:	48                   	dec    %eax
  1006f8:	c3                   	ret    
	else if (data == 0x0B)
  1006f9:	3c 0b                	cmp    $0xb,%al
  1006fb:	74 35                	je     100732 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1006fd:	8d 50 b9             	lea    -0x47(%eax),%edx
  100700:	80 fa 02             	cmp    $0x2,%dl
  100703:	77 07                	ja     10070c <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100705:	0f b6 c0             	movzbl %al,%eax
  100708:	83 e8 40             	sub    $0x40,%eax
  10070b:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  10070c:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10070f:	80 fa 02             	cmp    $0x2,%dl
  100712:	77 07                	ja     10071b <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100714:	0f b6 c0             	movzbl %al,%eax
  100717:	83 e8 47             	sub    $0x47,%eax
  10071a:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  10071b:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10071e:	80 fa 02             	cmp    $0x2,%dl
  100721:	77 07                	ja     10072a <console_read_digit+0x4b>
		return data - 0x4F + 1;
  100723:	0f b6 c0             	movzbl %al,%eax
  100726:	83 e8 4e             	sub    $0x4e,%eax
  100729:	c3                   	ret    
	else if (data == 0x53)
  10072a:	3c 53                	cmp    $0x53,%al
  10072c:	74 04                	je     100732 <console_read_digit+0x53>
  10072e:	83 c8 ff             	or     $0xffffffff,%eax
  100731:	c3                   	ret    
  100732:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100734:	c3                   	ret    

00100735 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100735:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100739:	a3 38 7d 10 00       	mov    %eax,0x107d38

	asm volatile("movl %0,%%esp\n\t"
  10073e:	83 c0 04             	add    $0x4,%eax
  100741:	89 c4                	mov    %eax,%esp
  100743:	61                   	popa   
  100744:	07                   	pop    %es
  100745:	1f                   	pop    %ds
  100746:	83 c4 08             	add    $0x8,%esp
  100749:	cf                   	iret   
  10074a:	eb fe                	jmp    10074a <run+0x15>

0010074c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10074c:	53                   	push   %ebx
  10074d:	83 ec 0c             	sub    $0xc,%esp
  100750:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100754:	6a 44                	push   $0x44
  100756:	6a 00                	push   $0x0
  100758:	8d 43 04             	lea    0x4(%ebx),%eax
  10075b:	50                   	push   %eax
  10075c:	e8 17 01 00 00       	call   100878 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100761:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100767:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10076d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100773:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100779:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100780:	83 c4 18             	add    $0x18,%esp
  100783:	5b                   	pop    %ebx
  100784:	c3                   	ret    
  100785:	90                   	nop
  100786:	90                   	nop
  100787:	90                   	nop

00100788 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100788:	55                   	push   %ebp
  100789:	57                   	push   %edi
  10078a:	56                   	push   %esi
  10078b:	53                   	push   %ebx
  10078c:	83 ec 1c             	sub    $0x1c,%esp
  10078f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100793:	83 f8 03             	cmp    $0x3,%eax
  100796:	7f 04                	jg     10079c <program_loader+0x14>
  100798:	85 c0                	test   %eax,%eax
  10079a:	79 02                	jns    10079e <program_loader+0x16>
  10079c:	eb fe                	jmp    10079c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10079e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1007a5:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1007ab:	74 02                	je     1007af <program_loader+0x27>
  1007ad:	eb fe                	jmp    1007ad <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1007af:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1007b2:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1007b6:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1007b8:	c1 e5 05             	shl    $0x5,%ebp
  1007bb:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1007be:	eb 3f                	jmp    1007ff <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1007c0:	83 3b 01             	cmpl   $0x1,(%ebx)
  1007c3:	75 37                	jne    1007fc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1007c5:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1007c8:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1007cb:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1007ce:	01 c7                	add    %eax,%edi
	memsz += va;
  1007d0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1007d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1007d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1007db:	52                   	push   %edx
  1007dc:	89 fa                	mov    %edi,%edx
  1007de:	29 c2                	sub    %eax,%edx
  1007e0:	52                   	push   %edx
  1007e1:	8b 53 04             	mov    0x4(%ebx),%edx
  1007e4:	01 f2                	add    %esi,%edx
  1007e6:	52                   	push   %edx
  1007e7:	50                   	push   %eax
  1007e8:	e8 27 00 00 00       	call   100814 <memcpy>
  1007ed:	83 c4 10             	add    $0x10,%esp
  1007f0:	eb 04                	jmp    1007f6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1007f2:	c6 07 00             	movb   $0x0,(%edi)
  1007f5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1007f6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1007fa:	72 f6                	jb     1007f2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1007fc:	83 c3 20             	add    $0x20,%ebx
  1007ff:	39 eb                	cmp    %ebp,%ebx
  100801:	72 bd                	jb     1007c0 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  100803:	8b 56 18             	mov    0x18(%esi),%edx
  100806:	8b 44 24 34          	mov    0x34(%esp),%eax
  10080a:	89 10                	mov    %edx,(%eax)
}
  10080c:	83 c4 1c             	add    $0x1c,%esp
  10080f:	5b                   	pop    %ebx
  100810:	5e                   	pop    %esi
  100811:	5f                   	pop    %edi
  100812:	5d                   	pop    %ebp
  100813:	c3                   	ret    

00100814 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100814:	56                   	push   %esi
  100815:	31 d2                	xor    %edx,%edx
  100817:	53                   	push   %ebx
  100818:	8b 44 24 0c          	mov    0xc(%esp),%eax
  10081c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100820:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100824:	eb 08                	jmp    10082e <memcpy+0x1a>
		*d++ = *s++;
  100826:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100829:	4e                   	dec    %esi
  10082a:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  10082d:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10082e:	85 f6                	test   %esi,%esi
  100830:	75 f4                	jne    100826 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100832:	5b                   	pop    %ebx
  100833:	5e                   	pop    %esi
  100834:	c3                   	ret    

00100835 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100835:	57                   	push   %edi
  100836:	56                   	push   %esi
  100837:	53                   	push   %ebx
  100838:	8b 44 24 10          	mov    0x10(%esp),%eax
  10083c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100840:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100844:	39 c7                	cmp    %eax,%edi
  100846:	73 26                	jae    10086e <memmove+0x39>
  100848:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10084b:	39 c6                	cmp    %eax,%esi
  10084d:	76 1f                	jbe    10086e <memmove+0x39>
		s += n, d += n;
  10084f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100852:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100854:	eb 07                	jmp    10085d <memmove+0x28>
			*--d = *--s;
  100856:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100859:	4a                   	dec    %edx
  10085a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10085d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10085e:	85 d2                	test   %edx,%edx
  100860:	75 f4                	jne    100856 <memmove+0x21>
  100862:	eb 10                	jmp    100874 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100864:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100867:	4a                   	dec    %edx
  100868:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10086b:	41                   	inc    %ecx
  10086c:	eb 02                	jmp    100870 <memmove+0x3b>
  10086e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100870:	85 d2                	test   %edx,%edx
  100872:	75 f0                	jne    100864 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100874:	5b                   	pop    %ebx
  100875:	5e                   	pop    %esi
  100876:	5f                   	pop    %edi
  100877:	c3                   	ret    

00100878 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100878:	53                   	push   %ebx
  100879:	8b 44 24 08          	mov    0x8(%esp),%eax
  10087d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100881:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100885:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100887:	eb 04                	jmp    10088d <memset+0x15>
		*p++ = c;
  100889:	88 1a                	mov    %bl,(%edx)
  10088b:	49                   	dec    %ecx
  10088c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10088d:	85 c9                	test   %ecx,%ecx
  10088f:	75 f8                	jne    100889 <memset+0x11>
		*p++ = c;
	return v;
}
  100891:	5b                   	pop    %ebx
  100892:	c3                   	ret    

00100893 <strlen>:

size_t
strlen(const char *s)
{
  100893:	8b 54 24 04          	mov    0x4(%esp),%edx
  100897:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100899:	eb 01                	jmp    10089c <strlen+0x9>
		++n;
  10089b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10089c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1008a0:	75 f9                	jne    10089b <strlen+0x8>
		++n;
	return n;
}
  1008a2:	c3                   	ret    

001008a3 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1008a3:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1008a7:	31 c0                	xor    %eax,%eax
  1008a9:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008ad:	eb 01                	jmp    1008b0 <strnlen+0xd>
		++n;
  1008af:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1008b0:	39 d0                	cmp    %edx,%eax
  1008b2:	74 06                	je     1008ba <strnlen+0x17>
  1008b4:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1008b8:	75 f5                	jne    1008af <strnlen+0xc>
		++n;
	return n;
}
  1008ba:	c3                   	ret    

001008bb <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1008bb:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1008bc:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1008c1:	53                   	push   %ebx
  1008c2:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1008c4:	76 05                	jbe    1008cb <console_putc+0x10>
  1008c6:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1008cb:	80 fa 0a             	cmp    $0xa,%dl
  1008ce:	75 2c                	jne    1008fc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008d0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1008d6:	be 50 00 00 00       	mov    $0x50,%esi
  1008db:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1008dd:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008e0:	99                   	cltd   
  1008e1:	f7 fe                	idiv   %esi
  1008e3:	89 de                	mov    %ebx,%esi
  1008e5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1008e7:	eb 07                	jmp    1008f0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1008e9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008ec:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1008ed:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008f0:	83 f8 50             	cmp    $0x50,%eax
  1008f3:	75 f4                	jne    1008e9 <console_putc+0x2e>
  1008f5:	29 d0                	sub    %edx,%eax
  1008f7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1008fa:	eb 0b                	jmp    100907 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1008fc:	0f b6 d2             	movzbl %dl,%edx
  1008ff:	09 ca                	or     %ecx,%edx
  100901:	66 89 13             	mov    %dx,(%ebx)
  100904:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100907:	5b                   	pop    %ebx
  100908:	5e                   	pop    %esi
  100909:	c3                   	ret    

0010090a <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  10090a:	56                   	push   %esi
  10090b:	53                   	push   %ebx
  10090c:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100910:	8d 58 ff             	lea    -0x1(%eax),%ebx
  100913:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100917:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  10091c:	75 04                	jne    100922 <fill_numbuf+0x18>
  10091e:	85 d2                	test   %edx,%edx
  100920:	74 10                	je     100932 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  100922:	89 d0                	mov    %edx,%eax
  100924:	31 d2                	xor    %edx,%edx
  100926:	f7 f1                	div    %ecx
  100928:	4b                   	dec    %ebx
  100929:	8a 14 16             	mov    (%esi,%edx,1),%dl
  10092c:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10092e:	89 c2                	mov    %eax,%edx
  100930:	eb ec                	jmp    10091e <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100932:	89 d8                	mov    %ebx,%eax
  100934:	5b                   	pop    %ebx
  100935:	5e                   	pop    %esi
  100936:	c3                   	ret    

00100937 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100937:	55                   	push   %ebp
  100938:	57                   	push   %edi
  100939:	56                   	push   %esi
  10093a:	53                   	push   %ebx
  10093b:	83 ec 38             	sub    $0x38,%esp
  10093e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100942:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100946:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10094a:	e9 60 03 00 00       	jmp    100caf <console_vprintf+0x378>
		if (*format != '%') {
  10094f:	80 fa 25             	cmp    $0x25,%dl
  100952:	74 13                	je     100967 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100954:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100958:	0f b6 d2             	movzbl %dl,%edx
  10095b:	89 f0                	mov    %esi,%eax
  10095d:	e8 59 ff ff ff       	call   1008bb <console_putc>
  100962:	e9 45 03 00 00       	jmp    100cac <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100967:	47                   	inc    %edi
  100968:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10096f:	00 
  100970:	eb 12                	jmp    100984 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100972:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100973:	8a 11                	mov    (%ecx),%dl
  100975:	84 d2                	test   %dl,%dl
  100977:	74 1a                	je     100993 <console_vprintf+0x5c>
  100979:	89 e8                	mov    %ebp,%eax
  10097b:	38 c2                	cmp    %al,%dl
  10097d:	75 f3                	jne    100972 <console_vprintf+0x3b>
  10097f:	e9 3f 03 00 00       	jmp    100cc3 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100984:	8a 17                	mov    (%edi),%dl
  100986:	84 d2                	test   %dl,%dl
  100988:	74 0b                	je     100995 <console_vprintf+0x5e>
  10098a:	b9 44 0d 10 00       	mov    $0x100d44,%ecx
  10098f:	89 d5                	mov    %edx,%ebp
  100991:	eb e0                	jmp    100973 <console_vprintf+0x3c>
  100993:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100995:	8d 42 cf             	lea    -0x31(%edx),%eax
  100998:	3c 08                	cmp    $0x8,%al
  10099a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1009a1:	00 
  1009a2:	76 13                	jbe    1009b7 <console_vprintf+0x80>
  1009a4:	eb 1d                	jmp    1009c3 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1009a6:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1009ab:	0f be c0             	movsbl %al,%eax
  1009ae:	47                   	inc    %edi
  1009af:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1009b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1009b7:	8a 07                	mov    (%edi),%al
  1009b9:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009bc:	80 fa 09             	cmp    $0x9,%dl
  1009bf:	76 e5                	jbe    1009a6 <console_vprintf+0x6f>
  1009c1:	eb 18                	jmp    1009db <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1009c3:	80 fa 2a             	cmp    $0x2a,%dl
  1009c6:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1009cd:	ff 
  1009ce:	75 0b                	jne    1009db <console_vprintf+0xa4>
			width = va_arg(val, int);
  1009d0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1009d3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1009d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009d7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1009db:	83 cd ff             	or     $0xffffffff,%ebp
  1009de:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1009e1:	75 37                	jne    100a1a <console_vprintf+0xe3>
			++format;
  1009e3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1009e4:	31 ed                	xor    %ebp,%ebp
  1009e6:	8a 07                	mov    (%edi),%al
  1009e8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009eb:	80 fa 09             	cmp    $0x9,%dl
  1009ee:	76 0d                	jbe    1009fd <console_vprintf+0xc6>
  1009f0:	eb 17                	jmp    100a09 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1009f2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1009f5:	0f be c0             	movsbl %al,%eax
  1009f8:	47                   	inc    %edi
  1009f9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1009fd:	8a 07                	mov    (%edi),%al
  1009ff:	8d 50 d0             	lea    -0x30(%eax),%edx
  100a02:	80 fa 09             	cmp    $0x9,%dl
  100a05:	76 eb                	jbe    1009f2 <console_vprintf+0xbb>
  100a07:	eb 11                	jmp    100a1a <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100a09:	3c 2a                	cmp    $0x2a,%al
  100a0b:	75 0b                	jne    100a18 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100a0d:	83 c3 04             	add    $0x4,%ebx
				++format;
  100a10:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100a11:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100a14:	85 ed                	test   %ebp,%ebp
  100a16:	79 02                	jns    100a1a <console_vprintf+0xe3>
  100a18:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100a1a:	8a 07                	mov    (%edi),%al
  100a1c:	3c 64                	cmp    $0x64,%al
  100a1e:	74 34                	je     100a54 <console_vprintf+0x11d>
  100a20:	7f 1d                	jg     100a3f <console_vprintf+0x108>
  100a22:	3c 58                	cmp    $0x58,%al
  100a24:	0f 84 a2 00 00 00    	je     100acc <console_vprintf+0x195>
  100a2a:	3c 63                	cmp    $0x63,%al
  100a2c:	0f 84 bf 00 00 00    	je     100af1 <console_vprintf+0x1ba>
  100a32:	3c 43                	cmp    $0x43,%al
  100a34:	0f 85 d0 00 00 00    	jne    100b0a <console_vprintf+0x1d3>
  100a3a:	e9 a3 00 00 00       	jmp    100ae2 <console_vprintf+0x1ab>
  100a3f:	3c 75                	cmp    $0x75,%al
  100a41:	74 4d                	je     100a90 <console_vprintf+0x159>
  100a43:	3c 78                	cmp    $0x78,%al
  100a45:	74 5c                	je     100aa3 <console_vprintf+0x16c>
  100a47:	3c 73                	cmp    $0x73,%al
  100a49:	0f 85 bb 00 00 00    	jne    100b0a <console_vprintf+0x1d3>
  100a4f:	e9 86 00 00 00       	jmp    100ada <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100a54:	83 c3 04             	add    $0x4,%ebx
  100a57:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100a5a:	89 d1                	mov    %edx,%ecx
  100a5c:	c1 f9 1f             	sar    $0x1f,%ecx
  100a5f:	89 0c 24             	mov    %ecx,(%esp)
  100a62:	31 ca                	xor    %ecx,%edx
  100a64:	55                   	push   %ebp
  100a65:	29 ca                	sub    %ecx,%edx
  100a67:	68 4c 0d 10 00       	push   $0x100d4c
  100a6c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a71:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a75:	e8 90 fe ff ff       	call   10090a <fill_numbuf>
  100a7a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100a7e:	58                   	pop    %eax
  100a7f:	5a                   	pop    %edx
  100a80:	ba 01 00 00 00       	mov    $0x1,%edx
  100a85:	8b 04 24             	mov    (%esp),%eax
  100a88:	83 e0 01             	and    $0x1,%eax
  100a8b:	e9 a5 00 00 00       	jmp    100b35 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a90:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a93:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a98:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a9b:	55                   	push   %ebp
  100a9c:	68 4c 0d 10 00       	push   $0x100d4c
  100aa1:	eb 11                	jmp    100ab4 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100aa3:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100aa6:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100aa9:	55                   	push   %ebp
  100aaa:	68 60 0d 10 00       	push   $0x100d60
  100aaf:	b9 10 00 00 00       	mov    $0x10,%ecx
  100ab4:	8d 44 24 40          	lea    0x40(%esp),%eax
  100ab8:	e8 4d fe ff ff       	call   10090a <fill_numbuf>
  100abd:	ba 01 00 00 00       	mov    $0x1,%edx
  100ac2:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100ac6:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100ac8:	59                   	pop    %ecx
  100ac9:	59                   	pop    %ecx
  100aca:	eb 69                	jmp    100b35 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100acc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100acf:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100ad2:	55                   	push   %ebp
  100ad3:	68 4c 0d 10 00       	push   $0x100d4c
  100ad8:	eb d5                	jmp    100aaf <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100ada:	83 c3 04             	add    $0x4,%ebx
  100add:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100ae0:	eb 40                	jmp    100b22 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100ae2:	83 c3 04             	add    $0x4,%ebx
  100ae5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100ae8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100aec:	e9 bd 01 00 00       	jmp    100cae <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100af1:	83 c3 04             	add    $0x4,%ebx
  100af4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100af7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100afb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100b00:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100b04:	88 44 24 24          	mov    %al,0x24(%esp)
  100b08:	eb 27                	jmp    100b31 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100b0a:	84 c0                	test   %al,%al
  100b0c:	75 02                	jne    100b10 <console_vprintf+0x1d9>
  100b0e:	b0 25                	mov    $0x25,%al
  100b10:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100b14:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100b19:	80 3f 00             	cmpb   $0x0,(%edi)
  100b1c:	74 0a                	je     100b28 <console_vprintf+0x1f1>
  100b1e:	8d 44 24 24          	lea    0x24(%esp),%eax
  100b22:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b26:	eb 09                	jmp    100b31 <console_vprintf+0x1fa>
				format--;
  100b28:	8d 54 24 24          	lea    0x24(%esp),%edx
  100b2c:	4f                   	dec    %edi
  100b2d:	89 54 24 04          	mov    %edx,0x4(%esp)
  100b31:	31 d2                	xor    %edx,%edx
  100b33:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b35:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100b37:	83 fd ff             	cmp    $0xffffffff,%ebp
  100b3a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100b41:	74 1f                	je     100b62 <console_vprintf+0x22b>
  100b43:	89 04 24             	mov    %eax,(%esp)
  100b46:	eb 01                	jmp    100b49 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100b48:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100b49:	39 e9                	cmp    %ebp,%ecx
  100b4b:	74 0a                	je     100b57 <console_vprintf+0x220>
  100b4d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b51:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100b55:	75 f1                	jne    100b48 <console_vprintf+0x211>
  100b57:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b5a:	89 0c 24             	mov    %ecx,(%esp)
  100b5d:	eb 1f                	jmp    100b7e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100b5f:	42                   	inc    %edx
  100b60:	eb 09                	jmp    100b6b <console_vprintf+0x234>
  100b62:	89 d1                	mov    %edx,%ecx
  100b64:	8b 14 24             	mov    (%esp),%edx
  100b67:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100b6b:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b6f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100b73:	75 ea                	jne    100b5f <console_vprintf+0x228>
  100b75:	8b 44 24 08          	mov    0x8(%esp),%eax
  100b79:	89 14 24             	mov    %edx,(%esp)
  100b7c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100b7e:	85 c0                	test   %eax,%eax
  100b80:	74 0c                	je     100b8e <console_vprintf+0x257>
  100b82:	84 d2                	test   %dl,%dl
  100b84:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b8b:	00 
  100b8c:	75 24                	jne    100bb2 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b8e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b93:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b9a:	00 
  100b9b:	75 15                	jne    100bb2 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b9d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ba1:	83 e0 08             	and    $0x8,%eax
  100ba4:	83 f8 01             	cmp    $0x1,%eax
  100ba7:	19 c9                	sbb    %ecx,%ecx
  100ba9:	f7 d1                	not    %ecx
  100bab:	83 e1 20             	and    $0x20,%ecx
  100bae:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100bb2:	3b 2c 24             	cmp    (%esp),%ebp
  100bb5:	7e 0d                	jle    100bc4 <console_vprintf+0x28d>
  100bb7:	84 d2                	test   %dl,%dl
  100bb9:	74 40                	je     100bfb <console_vprintf+0x2c4>
			zeros = precision - len;
  100bbb:	2b 2c 24             	sub    (%esp),%ebp
  100bbe:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100bc2:	eb 3f                	jmp    100c03 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bc4:	84 d2                	test   %dl,%dl
  100bc6:	74 33                	je     100bfb <console_vprintf+0x2c4>
  100bc8:	8b 44 24 14          	mov    0x14(%esp),%eax
  100bcc:	83 e0 06             	and    $0x6,%eax
  100bcf:	83 f8 02             	cmp    $0x2,%eax
  100bd2:	75 27                	jne    100bfb <console_vprintf+0x2c4>
  100bd4:	45                   	inc    %ebp
  100bd5:	75 24                	jne    100bfb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100bd7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bd9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100bdc:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100be1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100be4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100be7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100beb:	7d 0e                	jge    100bfb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100bed:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100bf1:	29 ca                	sub    %ecx,%edx
  100bf3:	29 c2                	sub    %eax,%edx
  100bf5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bf9:	eb 08                	jmp    100c03 <console_vprintf+0x2cc>
  100bfb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100c02:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100c03:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100c07:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c09:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100c0d:	2b 2c 24             	sub    (%esp),%ebp
  100c10:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100c15:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c18:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100c1b:	29 c5                	sub    %eax,%ebp
  100c1d:	89 f0                	mov    %esi,%eax
  100c1f:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c23:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100c27:	eb 0f                	jmp    100c38 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100c29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c2d:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c32:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c33:	e8 83 fc ff ff       	call   1008bb <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c38:	85 ed                	test   %ebp,%ebp
  100c3a:	7e 07                	jle    100c43 <console_vprintf+0x30c>
  100c3c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100c41:	74 e6                	je     100c29 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100c43:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100c48:	89 c6                	mov    %eax,%esi
  100c4a:	74 23                	je     100c6f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100c4c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100c51:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c55:	e8 61 fc ff ff       	call   1008bb <console_putc>
  100c5a:	89 c6                	mov    %eax,%esi
  100c5c:	eb 11                	jmp    100c6f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100c5e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c62:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c67:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100c68:	e8 4e fc ff ff       	call   1008bb <console_putc>
  100c6d:	eb 06                	jmp    100c75 <console_vprintf+0x33e>
  100c6f:	89 f0                	mov    %esi,%eax
  100c71:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c75:	85 f6                	test   %esi,%esi
  100c77:	7f e5                	jg     100c5e <console_vprintf+0x327>
  100c79:	8b 34 24             	mov    (%esp),%esi
  100c7c:	eb 15                	jmp    100c93 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100c7e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c82:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100c83:	0f b6 11             	movzbl (%ecx),%edx
  100c86:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c8a:	e8 2c fc ff ff       	call   1008bb <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c8f:	ff 44 24 04          	incl   0x4(%esp)
  100c93:	85 f6                	test   %esi,%esi
  100c95:	7f e7                	jg     100c7e <console_vprintf+0x347>
  100c97:	eb 0f                	jmp    100ca8 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c99:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c9d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ca2:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100ca3:	e8 13 fc ff ff       	call   1008bb <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100ca8:	85 ed                	test   %ebp,%ebp
  100caa:	7f ed                	jg     100c99 <console_vprintf+0x362>
  100cac:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100cae:	47                   	inc    %edi
  100caf:	8a 17                	mov    (%edi),%dl
  100cb1:	84 d2                	test   %dl,%dl
  100cb3:	0f 85 96 fc ff ff    	jne    10094f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100cb9:	83 c4 38             	add    $0x38,%esp
  100cbc:	89 f0                	mov    %esi,%eax
  100cbe:	5b                   	pop    %ebx
  100cbf:	5e                   	pop    %esi
  100cc0:	5f                   	pop    %edi
  100cc1:	5d                   	pop    %ebp
  100cc2:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100cc3:	81 e9 44 0d 10 00    	sub    $0x100d44,%ecx
  100cc9:	b8 01 00 00 00       	mov    $0x1,%eax
  100cce:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100cd0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100cd1:	09 44 24 14          	or     %eax,0x14(%esp)
  100cd5:	e9 aa fc ff ff       	jmp    100984 <console_vprintf+0x4d>

00100cda <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100cda:	8d 44 24 10          	lea    0x10(%esp),%eax
  100cde:	50                   	push   %eax
  100cdf:	ff 74 24 10          	pushl  0x10(%esp)
  100ce3:	ff 74 24 10          	pushl  0x10(%esp)
  100ce7:	ff 74 24 10          	pushl  0x10(%esp)
  100ceb:	e8 47 fc ff ff       	call   100937 <console_vprintf>
  100cf0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100cf3:	c3                   	ret    
