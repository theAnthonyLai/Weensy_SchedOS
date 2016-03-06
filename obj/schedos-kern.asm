
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
  100014:	e8 8e 03 00 00       	call   1003a7 <start>
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
  10006d:	e8 a2 02 00 00       	call   100314 <interrupt>

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
  1000a3:	a1 ac 7d 10 00       	mov    0x107dac,%eax
  1000a8:	8b 10                	mov    (%eax),%edx
	uint32_t seed;
	unsigned int lotteryTotal;
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
  1000aa:	a1 b0 7d 10 00       	mov    0x107db0,%eax
  1000af:	85 c0                	test   %eax,%eax
  1000b1:	75 19                	jne    1000cc <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b3:	bb 05 00 00 00       	mov    $0x5,%ebx
  1000b8:	8d 42 01             	lea    0x1(%edx),%eax
  1000bb:	99                   	cltd   
  1000bc:	f7 fb                	idiv   %ebx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000be:	6b c2 60             	imul   $0x60,%edx,%eax
  1000c1:	83 b8 bc 73 10 00 01 	cmpl   $0x1,0x1073bc(%eax)
  1000c8:	75 ee                	jne    1000b8 <schedule+0x1c>
  1000ca:	eb 1b                	jmp    1000e7 <schedule+0x4b>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000cc:	83 f8 02             	cmp    $0x2,%eax
  1000cf:	75 2b                	jne    1000fc <schedule+0x60>
  1000d1:	ba 01 00 00 00       	mov    $0x1,%edx
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
				run(&proc_array[pid]);
			pid = (pid + 1) % NPROCS;
  1000d6:	b9 05 00 00 00       	mov    $0x5,%ecx
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
		pid = 1;
		while (1) {
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000db:	6b c2 60             	imul   $0x60,%edx,%eax
  1000de:	83 b8 bc 73 10 00 01 	cmpl   $0x1,0x1073bc(%eax)
  1000e5:	75 0d                	jne    1000f4 <schedule+0x58>
				run(&proc_array[pid]);
  1000e7:	83 ec 0c             	sub    $0xc,%esp
  1000ea:	05 64 73 10 00       	add    $0x107364,%eax
  1000ef:	e9 2c 01 00 00       	jmp    100220 <schedule+0x184>
			pid = (pid + 1) % NPROCS;
  1000f4:	8d 42 01             	lea    0x1(%edx),%eax
  1000f7:	99                   	cltd   
  1000f8:	f7 f9                	idiv   %ecx
		}
  1000fa:	eb df                	jmp    1000db <schedule+0x3f>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000fc:	83 f8 29             	cmp    $0x29,%eax
  1000ff:	75 58                	jne    100159 <schedule+0xbd>
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100101:	bd 05 00 00 00       	mov    $0x5,%ebp
		}
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
  100106:	6b c2 60             	imul   $0x60,%edx,%eax
  100109:	89 d7                	mov    %edx,%edi
  10010b:	31 c9                	xor    %ecx,%ecx
  10010d:	8b 98 ac 73 10 00    	mov    0x1073ac(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100113:	8d 42 01             	lea    0x1(%edx),%eax
  100116:	99                   	cltd   
  100117:	f7 fd                	idiv   %ebp
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  100119:	6b c2 60             	imul   $0x60,%edx,%eax
  10011c:	05 6c 73 10 00       	add    $0x10736c,%eax
  100121:	83 78 50 01          	cmpl   $0x1,0x50(%eax)
  100125:	75 0b                	jne    100132 <schedule+0x96>
  100127:	8b 40 40             	mov    0x40(%eax),%eax
  10012a:	39 d8                	cmp    %ebx,%eax
  10012c:	77 04                	ja     100132 <schedule+0x96>
  10012e:	89 d7                	mov    %edx,%edi
  100130:	eb 02                	jmp    100134 <schedule+0x98>
  100132:	89 d8                	mov    %ebx,%eax
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
  100134:	41                   	inc    %ecx
  100135:	83 f9 04             	cmp    $0x4,%ecx
  100138:	74 04                	je     10013e <schedule+0xa2>
  10013a:	89 c3                	mov    %eax,%ebx
  10013c:	eb d5                	jmp    100113 <schedule+0x77>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  10013e:	6b ff 60             	imul   $0x60,%edi,%edi
  100141:	83 bf bc 73 10 00 01 	cmpl   $0x1,0x1073bc(%edi)
  100148:	75 bc                	jne    100106 <schedule+0x6a>
		run(&proc_array[firstPid]);
  10014a:	83 ec 0c             	sub    $0xc,%esp
  10014d:	81 c7 64 73 10 00    	add    $0x107364,%edi
  100153:	57                   	push   %edi
  100154:	e9 95 01 00 00       	jmp    1002ee <schedule+0x252>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  100159:	83 f8 2a             	cmp    $0x2a,%eax
  10015c:	0f 85 c4 00 00 00    	jne    100226 <schedule+0x18a>
		// check if we reset all p_share_left
		p_share_reset = 0;
		for (i = 1; i < NPROCS; i++)
			p_share_reset += proc_array[i].p_share_left;
  100162:	a1 74 74 10 00       	mov    0x107474,%eax
  100167:	03 05 14 74 10 00    	add    0x107414,%eax
  10016d:	03 05 d4 74 10 00    	add    0x1074d4,%eax
  100173:	03 05 34 75 10 00    	add    0x107534,%eax
  100179:	85 c0                	test   %eax,%eax
  10017b:	75 32                	jne    1001af <schedule+0x113>
		//cursorpos = console_printf(cursorpos, 0x100, "Total left is %d\n", p_share_reset);
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				proc_array[i].p_share_left = proc_array[i].p_share_amt;
  10017d:	a1 b0 73 10 00       	mov    0x1073b0,%eax
  100182:	a3 b4 73 10 00       	mov    %eax,0x1073b4
  100187:	a1 10 74 10 00       	mov    0x107410,%eax
  10018c:	a3 14 74 10 00       	mov    %eax,0x107414
  100191:	a1 70 74 10 00       	mov    0x107470,%eax
  100196:	a3 74 74 10 00       	mov    %eax,0x107474
  10019b:	a1 d0 74 10 00       	mov    0x1074d0,%eax
  1001a0:	a3 d4 74 10 00       	mov    %eax,0x1074d4
  1001a5:	a1 30 75 10 00       	mov    0x107530,%eax
  1001aa:	a3 34 75 10 00       	mov    %eax,0x107534
		
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001af:	bf 05 00 00 00       	mov    $0x5,%edi
		//int hi = 10;
		while (1) {
		
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
  1001b4:	6b c2 60             	imul   $0x60,%edx,%eax
  1001b7:	89 d1                	mov    %edx,%ecx
  1001b9:	31 f6                	xor    %esi,%esi
  1001bb:	8b 98 b0 73 10 00    	mov    0x1073b0(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001c1:	8d 42 01             	lea    0x1(%edx),%eax
  1001c4:	99                   	cltd   
  1001c5:	f7 ff                	idiv   %edi
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0 && proc_array[pid].p_share_amt > firstPriority) {
  1001c7:	6b c2 60             	imul   $0x60,%edx,%eax
  1001ca:	83 b8 bc 73 10 00 01 	cmpl   $0x1,0x1073bc(%eax)
  1001d1:	75 17                	jne    1001ea <schedule+0x14e>
  1001d3:	83 b8 b4 73 10 00 00 	cmpl   $0x0,0x1073b4(%eax)
  1001da:	74 0e                	je     1001ea <schedule+0x14e>
  1001dc:	8b 80 b0 73 10 00    	mov    0x1073b0(%eax),%eax
  1001e2:	39 d8                	cmp    %ebx,%eax
  1001e4:	76 04                	jbe    1001ea <schedule+0x14e>
  1001e6:	89 d1                	mov    %edx,%ecx
  1001e8:	eb 02                	jmp    1001ec <schedule+0x150>
  1001ea:	89 d8                	mov    %ebx,%eax
		while (1) {
		
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
  1001ec:	46                   	inc    %esi
  1001ed:	83 fe 04             	cmp    $0x4,%esi
  1001f0:	74 04                	je     1001f6 <schedule+0x15a>
  1001f2:	89 c3                	mov    %eax,%ebx
  1001f4:	eb cb                	jmp    1001c1 <schedule+0x125>
				}
			}
			
	//cursorpos = console_printf(cursorpos, 0x100, "Now pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0 || proc_array[firstPid].p_state != P_RUNNABLE) {
  1001f6:	6b d9 60             	imul   $0x60,%ecx,%ebx
  1001f9:	8d 83 64 73 10 00    	lea    0x107364(%ebx),%eax
  1001ff:	8b 50 50             	mov    0x50(%eax),%edx
  100202:	8d 70 50             	lea    0x50(%eax),%esi
  100205:	85 d2                	test   %edx,%edx
  100207:	74 09                	je     100212 <schedule+0x176>
  100209:	83 bb bc 73 10 00 01 	cmpl   $0x1,0x1073bc(%ebx)
  100210:	74 08                	je     10021a <schedule+0x17e>
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	//cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
				//cursorpos = console_printf(cursorpos, 0x100, "pid %d is done\n", firstPid);
				pid = (firstPid + 1) % NPROCS;
  100212:	8d 41 01             	lea    0x1(%ecx),%eax
  100215:	99                   	cltd   
  100216:	f7 ff                	idiv   %edi
  100218:	eb 9a                	jmp    1001b4 <schedule+0x118>
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  10021a:	4a                   	dec    %edx
			run(&proc_array[firstPid]);
  10021b:	83 ec 0c             	sub    $0xc,%esp
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  10021e:	89 16                	mov    %edx,(%esi)
			run(&proc_array[firstPid]);
  100220:	50                   	push   %eax
  100221:	e9 c8 00 00 00       	jmp    1002ee <schedule+0x252>
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
  100226:	83 f8 07             	cmp    $0x7,%eax
  100229:	0f 85 c4 00 00 00    	jne    1002f3 <schedule+0x257>
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  10022f:	a1 3c 75 10 00       	mov    0x10753c,%eax
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  100234:	8b 1d 18 74 10 00    	mov    0x107418,%ebx
			lotteryTotal += proc_array[i].p_lottery_amt;
  10023a:	8b 0d b8 73 10 00    	mov    0x1073b8,%ecx
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  100240:	8b 15 78 74 10 00    	mov    0x107478,%edx
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  100246:	89 44 24 08          	mov    %eax,0x8(%esp)

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  10024a:	a1 d8 74 10 00       	mov    0x1074d8,%eax
			seed ^= seed << 7 & 0xffffffff;
			seed ^= seed << 15 & 0x9d2c5680;
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  10024f:	8b 35 1c 74 10 00    	mov    0x10741c,%esi
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  100255:	01 d9                	add    %ebx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  100257:	8b 3d 7c 74 10 00    	mov    0x10747c,%edi
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  10025d:	8b 2d dc 74 10 00    	mov    0x1074dc,%ebp
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  100263:	01 d1                	add    %edx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  100265:	01 da                	add    %ebx,%edx
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  100267:	03 0d d8 74 10 00    	add    0x1074d8,%ecx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  10026d:	01 d0                	add    %edx,%eax
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  10026f:	03 0d 38 75 10 00    	add    0x107538,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  100275:	89 54 24 04          	mov    %edx,0x4(%esp)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  100279:	89 44 24 0c          	mov    %eax,0xc(%esp)

static inline uint64_t
read_cycle_counter(void)
{
        uint64_t tsc;
        asm volatile("rdtsc" : "=A" (tsc));
  10027d:	0f 31                	rdtsc  
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
		}
		
		while (1) {
			seed = (uint32_t) read_cycle_counter();
  10027f:	89 c2                	mov    %eax,%edx
			//seed ^= seed << 15 & 0xEFC60000;
			//seed ^= seed >> 18;
			/**************
			Reference from en.cppreference.com/w/app/numeric/random
			**************/
			seed ^= seed >> 11 & 0x9908b0df;
  100281:	c1 e8 0b             	shr    $0xb,%eax
  100284:	25 df b0 08 99       	and    $0x9908b0df,%eax
  100289:	31 d0                	xor    %edx,%eax
			seed ^= seed << 7 & 0xffffffff;
  10028b:	89 c2                	mov    %eax,%edx
  10028d:	c1 e2 07             	shl    $0x7,%edx
  100290:	31 c2                	xor    %eax,%edx
			seed ^= seed << 15 & 0x9d2c5680;
  100292:	89 d0                	mov    %edx,%eax
  100294:	c1 e0 0f             	shl    $0xf,%eax
  100297:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;
  10029c:	31 d0                	xor    %edx,%eax
  10029e:	31 d2                	xor    %edx,%edx
  1002a0:	f7 f1                	div    %ecx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  1002a2:	39 da                	cmp    %ebx,%edx
  1002a4:	73 0f                	jae    1002b5 <schedule+0x219>
  1002a6:	83 fe 01             	cmp    $0x1,%esi
  1002a9:	75 0a                	jne    1002b5 <schedule+0x219>
				run(&proc_array[1]);
  1002ab:	83 ec 0c             	sub    $0xc,%esp
  1002ae:	68 c4 73 10 00       	push   $0x1073c4
  1002b3:	eb 39                	jmp    1002ee <schedule+0x252>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002b5:	3b 54 24 04          	cmp    0x4(%esp),%edx
  1002b9:	73 0f                	jae    1002ca <schedule+0x22e>
  1002bb:	83 ff 01             	cmp    $0x1,%edi
  1002be:	75 0a                	jne    1002ca <schedule+0x22e>
				run(&proc_array[2]);
  1002c0:	83 ec 0c             	sub    $0xc,%esp
  1002c3:	68 24 74 10 00       	push   $0x107424
  1002c8:	eb 24                	jmp    1002ee <schedule+0x252>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002ca:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1002ce:	73 0f                	jae    1002df <schedule+0x243>
  1002d0:	83 fd 01             	cmp    $0x1,%ebp
  1002d3:	75 0a                	jne    1002df <schedule+0x243>
				run(&proc_array[3]);
  1002d5:	83 ec 0c             	sub    $0xc,%esp
  1002d8:	68 84 74 10 00       	push   $0x107484
  1002dd:	eb 0f                	jmp    1002ee <schedule+0x252>
			else if (proc_array[4].p_state == P_RUNNABLE)
  1002df:	83 7c 24 08 01       	cmpl   $0x1,0x8(%esp)
  1002e4:	75 97                	jne    10027d <schedule+0x1e1>
				run(&proc_array[4]);
  1002e6:	83 ec 0c             	sub    $0xc,%esp
  1002e9:	68 e4 74 10 00       	push   $0x1074e4
  1002ee:	e8 e6 03 00 00       	call   1006d9 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1002f3:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1002f9:	50                   	push   %eax
  1002fa:	68 98 0c 10 00       	push   $0x100c98
  1002ff:	68 00 01 00 00       	push   $0x100
  100304:	52                   	push   %edx
  100305:	e8 74 09 00 00       	call   100c7e <console_printf>
  10030a:	83 c4 10             	add    $0x10,%esp
  10030d:	a3 00 80 19 00       	mov    %eax,0x198000
  100312:	eb fe                	jmp    100312 <schedule+0x276>

00100314 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100314:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100315:	8b 3d ac 7d 10 00    	mov    0x107dac,%edi
  10031b:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100320:	56                   	push   %esi
  100321:	53                   	push   %ebx
  100322:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100326:	83 c7 04             	add    $0x4,%edi
  100329:	89 de                	mov    %ebx,%esi
  10032b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  10032d:	8b 43 28             	mov    0x28(%ebx),%eax
  100330:	83 f8 32             	cmp    $0x32,%eax
  100333:	74 38                	je     10036d <interrupt+0x59>
  100335:	77 0e                	ja     100345 <interrupt+0x31>
  100337:	83 f8 30             	cmp    $0x30,%eax
  10033a:	74 15                	je     100351 <interrupt+0x3d>
  10033c:	77 18                	ja     100356 <interrupt+0x42>
  10033e:	83 f8 20             	cmp    $0x20,%eax
  100341:	74 5d                	je     1003a0 <interrupt+0x8c>
  100343:	eb 60                	jmp    1003a5 <interrupt+0x91>
  100345:	83 f8 33             	cmp    $0x33,%eax
  100348:	74 33                	je     10037d <interrupt+0x69>
  10034a:	83 f8 34             	cmp    $0x34,%eax
  10034d:	74 41                	je     100390 <interrupt+0x7c>
  10034f:	eb 54                	jmp    1003a5 <interrupt+0x91>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100351:	e8 46 fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100356:	a1 ac 7d 10 00       	mov    0x107dac,%eax
		current->p_exit_status = reg->reg_eax;
  10035b:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10035e:	c7 40 58 03 00 00 00 	movl   $0x3,0x58(%eax)
		current->p_exit_status = reg->reg_eax;
  100365:	89 50 5c             	mov    %edx,0x5c(%eax)
		schedule();
  100368:	e8 2f fd ff ff       	call   10009c <schedule>
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_priority = reg->reg_eax;
  10036d:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100370:	a1 ac 7d 10 00       	mov    0x107dac,%eax
  100375:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  100378:	e8 1f fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  10037d:	a1 ac 7d 10 00       	mov    0x107dac,%eax
  100382:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100385:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  100388:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  10038b:	e8 0c fd ff ff       	call   10009c <schedule>
	
	case INT_SYS_LOTTERY:
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_lottery_amt = reg->reg_eax;
  100390:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100393:	a1 ac 7d 10 00       	mov    0x107dac,%eax
  100398:	89 50 54             	mov    %edx,0x54(%eax)
		schedule();
  10039b:	e8 fc fc ff ff       	call   10009c <schedule>
	
	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1003a0:	e8 f7 fc ff ff       	call   10009c <schedule>
  1003a5:	eb fe                	jmp    1003a5 <interrupt+0x91>

001003a7 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1003a7:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003a8:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1003ad:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003ae:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1003b0:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003b1:	bb c4 73 10 00       	mov    $0x1073c4,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1003b6:	e8 fd 00 00 00       	call   1004b8 <segments_init>
	interrupt_controller_init(0);
  1003bb:	83 ec 0c             	sub    $0xc,%esp
  1003be:	6a 00                	push   $0x0
  1003c0:	e8 ee 01 00 00       	call   1005b3 <interrupt_controller_init>
	//interrupt_controller_init(1);
	console_clear();
  1003c5:	e8 72 02 00 00       	call   10063c <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1003ca:	83 c4 0c             	add    $0xc,%esp
  1003cd:	68 e0 01 00 00       	push   $0x1e0
  1003d2:	6a 00                	push   $0x0
  1003d4:	68 64 73 10 00       	push   $0x107364
  1003d9:	e8 3e 04 00 00       	call   10081c <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003de:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003e1:	c7 05 64 73 10 00 00 	movl   $0x0,0x107364
  1003e8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003eb:	c7 05 bc 73 10 00 00 	movl   $0x0,0x1073bc
  1003f2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003f5:	c7 05 c4 73 10 00 01 	movl   $0x1,0x1073c4
  1003fc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003ff:	c7 05 1c 74 10 00 00 	movl   $0x0,0x10741c
  100406:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100409:	c7 05 24 74 10 00 02 	movl   $0x2,0x107424
  100410:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100413:	c7 05 7c 74 10 00 00 	movl   $0x0,0x10747c
  10041a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10041d:	c7 05 84 74 10 00 03 	movl   $0x3,0x107484
  100424:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100427:	c7 05 dc 74 10 00 00 	movl   $0x0,0x1074dc
  10042e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100431:	c7 05 e4 74 10 00 04 	movl   $0x4,0x1074e4
  100438:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10043b:	c7 05 3c 75 10 00 00 	movl   $0x0,0x10753c
  100442:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100445:	83 ec 0c             	sub    $0xc,%esp
  100448:	53                   	push   %ebx
  100449:	e8 a2 02 00 00       	call   1006f0 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10044e:	58                   	pop    %eax
  10044f:	5a                   	pop    %edx
  100450:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100453:	89 7b 40             	mov    %edi,0x40(%ebx)
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  100456:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10045c:	50                   	push   %eax
  10045d:	56                   	push   %esi
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  10045e:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10045f:	e8 c8 02 00 00       	call   10072c <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100464:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100467:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)

		// Exercise 4B test
		// preset everyone to 1 so everyone can start
		proc->p_share_amt = 1;
  10046e:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
		proc->p_share_left = 1;
  100475:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  10047c:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  100483:	83 c3 60             	add    $0x60,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100486:	83 fe 04             	cmp    $0x4,%esi
  100489:	75 ba                	jne    100445 <start+0x9e>
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  10048b:	83 ec 0c             	sub    $0xc,%esp
  10048e:	68 c4 73 10 00       	push   $0x1073c4
		proc->p_lottery_amt = 1;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100493:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10049a:	80 0b 00 
	cursorposLock = 0;	// lock is available
  10049d:	c7 05 10 80 19 00 00 	movl   $0x0,0x198010
  1004a4:	00 00 00 
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
  1004a7:	c7 05 b0 7d 10 00 2a 	movl   $0x2a,0x107db0
  1004ae:	00 00 00 
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  1004b1:	e8 23 02 00 00       	call   1006d9 <run>
  1004b6:	90                   	nop
  1004b7:	90                   	nop

001004b8 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004b8:	b8 44 75 10 00       	mov    $0x107544,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004bd:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004c2:	89 c2                	mov    %eax,%edx
  1004c4:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1004c7:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004c8:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1004cd:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004d0:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1004d6:	c1 e8 18             	shr    $0x18,%eax
  1004d9:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004df:	ba ac 75 10 00       	mov    $0x1075ac,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004e4:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004e9:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004eb:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1004f2:	68 00 
  1004f4:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1004fb:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100502:	c7 05 48 75 10 00 00 	movl   $0x180000,0x107548
  100509:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  10050c:	66 c7 05 4c 75 10 00 	movw   $0x10,0x10754c
  100513:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100515:	66 89 0c c5 ac 75 10 	mov    %cx,0x1075ac(,%eax,8)
  10051c:	00 
  10051d:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100524:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100529:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10052e:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100533:	40                   	inc    %eax
  100534:	3d 00 01 00 00       	cmp    $0x100,%eax
  100539:	75 da                	jne    100515 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10053b:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100540:	ba ac 75 10 00       	mov    $0x1075ac,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100545:	66 a3 ac 76 10 00    	mov    %ax,0x1076ac
  10054b:	c1 e8 10             	shr    $0x10,%eax
  10054e:	66 a3 b2 76 10 00    	mov    %ax,0x1076b2
  100554:	b8 30 00 00 00       	mov    $0x30,%eax
  100559:	66 c7 05 ae 76 10 00 	movw   $0x8,0x1076ae
  100560:	08 00 
  100562:	c6 05 b0 76 10 00 00 	movb   $0x0,0x1076b0
  100569:	c6 05 b1 76 10 00 8e 	movb   $0x8e,0x1076b1

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100570:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  100577:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10057e:	66 89 0c c5 ac 75 10 	mov    %cx,0x1075ac(,%eax,8)
  100585:	00 
  100586:	c1 e9 10             	shr    $0x10,%ecx
  100589:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10058e:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100593:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100598:	40                   	inc    %eax
  100599:	83 f8 3a             	cmp    $0x3a,%eax
  10059c:	75 d2                	jne    100570 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  10059e:	b0 28                	mov    $0x28,%al
  1005a0:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1005a7:	0f 00 d8             	ltr    %ax
  1005aa:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1005b1:	5b                   	pop    %ebx
  1005b2:	c3                   	ret    

001005b3 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1005b3:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1005b4:	b0 ff                	mov    $0xff,%al
  1005b6:	57                   	push   %edi
  1005b7:	56                   	push   %esi
  1005b8:	53                   	push   %ebx
  1005b9:	bb 21 00 00 00       	mov    $0x21,%ebx
  1005be:	89 da                	mov    %ebx,%edx
  1005c0:	ee                   	out    %al,(%dx)
  1005c1:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1005c6:	89 ca                	mov    %ecx,%edx
  1005c8:	ee                   	out    %al,(%dx)
  1005c9:	be 11 00 00 00       	mov    $0x11,%esi
  1005ce:	bf 20 00 00 00       	mov    $0x20,%edi
  1005d3:	89 f0                	mov    %esi,%eax
  1005d5:	89 fa                	mov    %edi,%edx
  1005d7:	ee                   	out    %al,(%dx)
  1005d8:	b0 20                	mov    $0x20,%al
  1005da:	89 da                	mov    %ebx,%edx
  1005dc:	ee                   	out    %al,(%dx)
  1005dd:	b0 04                	mov    $0x4,%al
  1005df:	ee                   	out    %al,(%dx)
  1005e0:	b0 03                	mov    $0x3,%al
  1005e2:	ee                   	out    %al,(%dx)
  1005e3:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1005e8:	89 f0                	mov    %esi,%eax
  1005ea:	89 ea                	mov    %ebp,%edx
  1005ec:	ee                   	out    %al,(%dx)
  1005ed:	b0 28                	mov    $0x28,%al
  1005ef:	89 ca                	mov    %ecx,%edx
  1005f1:	ee                   	out    %al,(%dx)
  1005f2:	b0 02                	mov    $0x2,%al
  1005f4:	ee                   	out    %al,(%dx)
  1005f5:	b0 01                	mov    $0x1,%al
  1005f7:	ee                   	out    %al,(%dx)
  1005f8:	b0 68                	mov    $0x68,%al
  1005fa:	89 fa                	mov    %edi,%edx
  1005fc:	ee                   	out    %al,(%dx)
  1005fd:	be 0a 00 00 00       	mov    $0xa,%esi
  100602:	89 f0                	mov    %esi,%eax
  100604:	ee                   	out    %al,(%dx)
  100605:	b0 68                	mov    $0x68,%al
  100607:	89 ea                	mov    %ebp,%edx
  100609:	ee                   	out    %al,(%dx)
  10060a:	89 f0                	mov    %esi,%eax
  10060c:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  10060d:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100612:	89 da                	mov    %ebx,%edx
  100614:	19 c0                	sbb    %eax,%eax
  100616:	f7 d0                	not    %eax
  100618:	05 ff 00 00 00       	add    $0xff,%eax
  10061d:	ee                   	out    %al,(%dx)
  10061e:	b0 ff                	mov    $0xff,%al
  100620:	89 ca                	mov    %ecx,%edx
  100622:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100623:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100628:	74 0d                	je     100637 <interrupt_controller_init+0x84>
  10062a:	b2 43                	mov    $0x43,%dl
  10062c:	b0 34                	mov    $0x34,%al
  10062e:	ee                   	out    %al,(%dx)
  10062f:	b0 a9                	mov    $0xa9,%al
  100631:	b2 40                	mov    $0x40,%dl
  100633:	ee                   	out    %al,(%dx)
  100634:	b0 04                	mov    $0x4,%al
  100636:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100637:	5b                   	pop    %ebx
  100638:	5e                   	pop    %esi
  100639:	5f                   	pop    %edi
  10063a:	5d                   	pop    %ebp
  10063b:	c3                   	ret    

0010063c <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  10063c:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10063d:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10063f:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100640:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100647:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10064a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100650:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100656:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100659:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10065e:	75 ea                	jne    10064a <console_clear+0xe>
  100660:	be d4 03 00 00       	mov    $0x3d4,%esi
  100665:	b0 0e                	mov    $0xe,%al
  100667:	89 f2                	mov    %esi,%edx
  100669:	ee                   	out    %al,(%dx)
  10066a:	31 c9                	xor    %ecx,%ecx
  10066c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100671:	88 c8                	mov    %cl,%al
  100673:	89 da                	mov    %ebx,%edx
  100675:	ee                   	out    %al,(%dx)
  100676:	b0 0f                	mov    $0xf,%al
  100678:	89 f2                	mov    %esi,%edx
  10067a:	ee                   	out    %al,(%dx)
  10067b:	88 c8                	mov    %cl,%al
  10067d:	89 da                	mov    %ebx,%edx
  10067f:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100680:	5b                   	pop    %ebx
  100681:	5e                   	pop    %esi
  100682:	c3                   	ret    

00100683 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100683:	ba 64 00 00 00       	mov    $0x64,%edx
  100688:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100689:	a8 01                	test   $0x1,%al
  10068b:	74 45                	je     1006d2 <console_read_digit+0x4f>
  10068d:	b2 60                	mov    $0x60,%dl
  10068f:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100690:	8d 50 fe             	lea    -0x2(%eax),%edx
  100693:	80 fa 08             	cmp    $0x8,%dl
  100696:	77 05                	ja     10069d <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100698:	0f b6 c0             	movzbl %al,%eax
  10069b:	48                   	dec    %eax
  10069c:	c3                   	ret    
	else if (data == 0x0B)
  10069d:	3c 0b                	cmp    $0xb,%al
  10069f:	74 35                	je     1006d6 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1006a1:	8d 50 b9             	lea    -0x47(%eax),%edx
  1006a4:	80 fa 02             	cmp    $0x2,%dl
  1006a7:	77 07                	ja     1006b0 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1006a9:	0f b6 c0             	movzbl %al,%eax
  1006ac:	83 e8 40             	sub    $0x40,%eax
  1006af:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1006b0:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1006b3:	80 fa 02             	cmp    $0x2,%dl
  1006b6:	77 07                	ja     1006bf <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1006b8:	0f b6 c0             	movzbl %al,%eax
  1006bb:	83 e8 47             	sub    $0x47,%eax
  1006be:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1006bf:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1006c2:	80 fa 02             	cmp    $0x2,%dl
  1006c5:	77 07                	ja     1006ce <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1006c7:	0f b6 c0             	movzbl %al,%eax
  1006ca:	83 e8 4e             	sub    $0x4e,%eax
  1006cd:	c3                   	ret    
	else if (data == 0x53)
  1006ce:	3c 53                	cmp    $0x53,%al
  1006d0:	74 04                	je     1006d6 <console_read_digit+0x53>
  1006d2:	83 c8 ff             	or     $0xffffffff,%eax
  1006d5:	c3                   	ret    
  1006d6:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1006d8:	c3                   	ret    

001006d9 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1006d9:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1006dd:	a3 ac 7d 10 00       	mov    %eax,0x107dac

	asm volatile("movl %0,%%esp\n\t"
  1006e2:	83 c0 04             	add    $0x4,%eax
  1006e5:	89 c4                	mov    %eax,%esp
  1006e7:	61                   	popa   
  1006e8:	07                   	pop    %es
  1006e9:	1f                   	pop    %ds
  1006ea:	83 c4 08             	add    $0x8,%esp
  1006ed:	cf                   	iret   
  1006ee:	eb fe                	jmp    1006ee <run+0x15>

001006f0 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1006f0:	53                   	push   %ebx
  1006f1:	83 ec 0c             	sub    $0xc,%esp
  1006f4:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1006f8:	6a 44                	push   $0x44
  1006fa:	6a 00                	push   $0x0
  1006fc:	8d 43 04             	lea    0x4(%ebx),%eax
  1006ff:	50                   	push   %eax
  100700:	e8 17 01 00 00       	call   10081c <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100705:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10070b:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100711:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100717:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  10071d:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100724:	83 c4 18             	add    $0x18,%esp
  100727:	5b                   	pop    %ebx
  100728:	c3                   	ret    
  100729:	90                   	nop
  10072a:	90                   	nop
  10072b:	90                   	nop

0010072c <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  10072c:	55                   	push   %ebp
  10072d:	57                   	push   %edi
  10072e:	56                   	push   %esi
  10072f:	53                   	push   %ebx
  100730:	83 ec 1c             	sub    $0x1c,%esp
  100733:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100737:	83 f8 03             	cmp    $0x3,%eax
  10073a:	7f 04                	jg     100740 <program_loader+0x14>
  10073c:	85 c0                	test   %eax,%eax
  10073e:	79 02                	jns    100742 <program_loader+0x16>
  100740:	eb fe                	jmp    100740 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100742:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100749:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10074f:	74 02                	je     100753 <program_loader+0x27>
  100751:	eb fe                	jmp    100751 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100753:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100756:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10075a:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  10075c:	c1 e5 05             	shl    $0x5,%ebp
  10075f:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100762:	eb 3f                	jmp    1007a3 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100764:	83 3b 01             	cmpl   $0x1,(%ebx)
  100767:	75 37                	jne    1007a0 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100769:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10076c:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10076f:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100772:	01 c7                	add    %eax,%edi
	memsz += va;
  100774:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  100776:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10077b:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  10077f:	52                   	push   %edx
  100780:	89 fa                	mov    %edi,%edx
  100782:	29 c2                	sub    %eax,%edx
  100784:	52                   	push   %edx
  100785:	8b 53 04             	mov    0x4(%ebx),%edx
  100788:	01 f2                	add    %esi,%edx
  10078a:	52                   	push   %edx
  10078b:	50                   	push   %eax
  10078c:	e8 27 00 00 00       	call   1007b8 <memcpy>
  100791:	83 c4 10             	add    $0x10,%esp
  100794:	eb 04                	jmp    10079a <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  100796:	c6 07 00             	movb   $0x0,(%edi)
  100799:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10079a:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  10079e:	72 f6                	jb     100796 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1007a0:	83 c3 20             	add    $0x20,%ebx
  1007a3:	39 eb                	cmp    %ebp,%ebx
  1007a5:	72 bd                	jb     100764 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1007a7:	8b 56 18             	mov    0x18(%esi),%edx
  1007aa:	8b 44 24 34          	mov    0x34(%esp),%eax
  1007ae:	89 10                	mov    %edx,(%eax)
}
  1007b0:	83 c4 1c             	add    $0x1c,%esp
  1007b3:	5b                   	pop    %ebx
  1007b4:	5e                   	pop    %esi
  1007b5:	5f                   	pop    %edi
  1007b6:	5d                   	pop    %ebp
  1007b7:	c3                   	ret    

001007b8 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1007b8:	56                   	push   %esi
  1007b9:	31 d2                	xor    %edx,%edx
  1007bb:	53                   	push   %ebx
  1007bc:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1007c0:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1007c4:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007c8:	eb 08                	jmp    1007d2 <memcpy+0x1a>
		*d++ = *s++;
  1007ca:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1007cd:	4e                   	dec    %esi
  1007ce:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1007d1:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007d2:	85 f6                	test   %esi,%esi
  1007d4:	75 f4                	jne    1007ca <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1007d6:	5b                   	pop    %ebx
  1007d7:	5e                   	pop    %esi
  1007d8:	c3                   	ret    

001007d9 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1007d9:	57                   	push   %edi
  1007da:	56                   	push   %esi
  1007db:	53                   	push   %ebx
  1007dc:	8b 44 24 10          	mov    0x10(%esp),%eax
  1007e0:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1007e4:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1007e8:	39 c7                	cmp    %eax,%edi
  1007ea:	73 26                	jae    100812 <memmove+0x39>
  1007ec:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1007ef:	39 c6                	cmp    %eax,%esi
  1007f1:	76 1f                	jbe    100812 <memmove+0x39>
		s += n, d += n;
  1007f3:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1007f6:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1007f8:	eb 07                	jmp    100801 <memmove+0x28>
			*--d = *--s;
  1007fa:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1007fd:	4a                   	dec    %edx
  1007fe:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100801:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100802:	85 d2                	test   %edx,%edx
  100804:	75 f4                	jne    1007fa <memmove+0x21>
  100806:	eb 10                	jmp    100818 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100808:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10080b:	4a                   	dec    %edx
  10080c:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10080f:	41                   	inc    %ecx
  100810:	eb 02                	jmp    100814 <memmove+0x3b>
  100812:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100814:	85 d2                	test   %edx,%edx
  100816:	75 f0                	jne    100808 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100818:	5b                   	pop    %ebx
  100819:	5e                   	pop    %esi
  10081a:	5f                   	pop    %edi
  10081b:	c3                   	ret    

0010081c <memset>:

void *
memset(void *v, int c, size_t n)
{
  10081c:	53                   	push   %ebx
  10081d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100821:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100825:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100829:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10082b:	eb 04                	jmp    100831 <memset+0x15>
		*p++ = c;
  10082d:	88 1a                	mov    %bl,(%edx)
  10082f:	49                   	dec    %ecx
  100830:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100831:	85 c9                	test   %ecx,%ecx
  100833:	75 f8                	jne    10082d <memset+0x11>
		*p++ = c;
	return v;
}
  100835:	5b                   	pop    %ebx
  100836:	c3                   	ret    

00100837 <strlen>:

size_t
strlen(const char *s)
{
  100837:	8b 54 24 04          	mov    0x4(%esp),%edx
  10083b:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10083d:	eb 01                	jmp    100840 <strlen+0x9>
		++n;
  10083f:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100840:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100844:	75 f9                	jne    10083f <strlen+0x8>
		++n;
	return n;
}
  100846:	c3                   	ret    

00100847 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100847:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10084b:	31 c0                	xor    %eax,%eax
  10084d:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100851:	eb 01                	jmp    100854 <strnlen+0xd>
		++n;
  100853:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100854:	39 d0                	cmp    %edx,%eax
  100856:	74 06                	je     10085e <strnlen+0x17>
  100858:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  10085c:	75 f5                	jne    100853 <strnlen+0xc>
		++n;
	return n;
}
  10085e:	c3                   	ret    

0010085f <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10085f:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100860:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100865:	53                   	push   %ebx
  100866:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100868:	76 05                	jbe    10086f <console_putc+0x10>
  10086a:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10086f:	80 fa 0a             	cmp    $0xa,%dl
  100872:	75 2c                	jne    1008a0 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100874:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10087a:	be 50 00 00 00       	mov    $0x50,%esi
  10087f:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100881:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100884:	99                   	cltd   
  100885:	f7 fe                	idiv   %esi
  100887:	89 de                	mov    %ebx,%esi
  100889:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10088b:	eb 07                	jmp    100894 <console_putc+0x35>
			*cursor++ = ' ' | color;
  10088d:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100890:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100891:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100894:	83 f8 50             	cmp    $0x50,%eax
  100897:	75 f4                	jne    10088d <console_putc+0x2e>
  100899:	29 d0                	sub    %edx,%eax
  10089b:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  10089e:	eb 0b                	jmp    1008ab <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1008a0:	0f b6 d2             	movzbl %dl,%edx
  1008a3:	09 ca                	or     %ecx,%edx
  1008a5:	66 89 13             	mov    %dx,(%ebx)
  1008a8:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1008ab:	5b                   	pop    %ebx
  1008ac:	5e                   	pop    %esi
  1008ad:	c3                   	ret    

001008ae <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1008ae:	56                   	push   %esi
  1008af:	53                   	push   %ebx
  1008b0:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1008b4:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1008b7:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1008bb:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1008c0:	75 04                	jne    1008c6 <fill_numbuf+0x18>
  1008c2:	85 d2                	test   %edx,%edx
  1008c4:	74 10                	je     1008d6 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1008c6:	89 d0                	mov    %edx,%eax
  1008c8:	31 d2                	xor    %edx,%edx
  1008ca:	f7 f1                	div    %ecx
  1008cc:	4b                   	dec    %ebx
  1008cd:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1008d0:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1008d2:	89 c2                	mov    %eax,%edx
  1008d4:	eb ec                	jmp    1008c2 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1008d6:	89 d8                	mov    %ebx,%eax
  1008d8:	5b                   	pop    %ebx
  1008d9:	5e                   	pop    %esi
  1008da:	c3                   	ret    

001008db <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1008db:	55                   	push   %ebp
  1008dc:	57                   	push   %edi
  1008dd:	56                   	push   %esi
  1008de:	53                   	push   %ebx
  1008df:	83 ec 38             	sub    $0x38,%esp
  1008e2:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1008e6:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1008ea:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008ee:	e9 60 03 00 00       	jmp    100c53 <console_vprintf+0x378>
		if (*format != '%') {
  1008f3:	80 fa 25             	cmp    $0x25,%dl
  1008f6:	74 13                	je     10090b <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1008f8:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1008fc:	0f b6 d2             	movzbl %dl,%edx
  1008ff:	89 f0                	mov    %esi,%eax
  100901:	e8 59 ff ff ff       	call   10085f <console_putc>
  100906:	e9 45 03 00 00       	jmp    100c50 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10090b:	47                   	inc    %edi
  10090c:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100913:	00 
  100914:	eb 12                	jmp    100928 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100916:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100917:	8a 11                	mov    (%ecx),%dl
  100919:	84 d2                	test   %dl,%dl
  10091b:	74 1a                	je     100937 <console_vprintf+0x5c>
  10091d:	89 e8                	mov    %ebp,%eax
  10091f:	38 c2                	cmp    %al,%dl
  100921:	75 f3                	jne    100916 <console_vprintf+0x3b>
  100923:	e9 3f 03 00 00       	jmp    100c67 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100928:	8a 17                	mov    (%edi),%dl
  10092a:	84 d2                	test   %dl,%dl
  10092c:	74 0b                	je     100939 <console_vprintf+0x5e>
  10092e:	b9 bc 0c 10 00       	mov    $0x100cbc,%ecx
  100933:	89 d5                	mov    %edx,%ebp
  100935:	eb e0                	jmp    100917 <console_vprintf+0x3c>
  100937:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100939:	8d 42 cf             	lea    -0x31(%edx),%eax
  10093c:	3c 08                	cmp    $0x8,%al
  10093e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100945:	00 
  100946:	76 13                	jbe    10095b <console_vprintf+0x80>
  100948:	eb 1d                	jmp    100967 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10094a:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10094f:	0f be c0             	movsbl %al,%eax
  100952:	47                   	inc    %edi
  100953:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100957:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10095b:	8a 07                	mov    (%edi),%al
  10095d:	8d 50 d0             	lea    -0x30(%eax),%edx
  100960:	80 fa 09             	cmp    $0x9,%dl
  100963:	76 e5                	jbe    10094a <console_vprintf+0x6f>
  100965:	eb 18                	jmp    10097f <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100967:	80 fa 2a             	cmp    $0x2a,%dl
  10096a:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100971:	ff 
  100972:	75 0b                	jne    10097f <console_vprintf+0xa4>
			width = va_arg(val, int);
  100974:	83 c3 04             	add    $0x4,%ebx
			++format;
  100977:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100978:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10097b:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  10097f:	83 cd ff             	or     $0xffffffff,%ebp
  100982:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100985:	75 37                	jne    1009be <console_vprintf+0xe3>
			++format;
  100987:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100988:	31 ed                	xor    %ebp,%ebp
  10098a:	8a 07                	mov    (%edi),%al
  10098c:	8d 50 d0             	lea    -0x30(%eax),%edx
  10098f:	80 fa 09             	cmp    $0x9,%dl
  100992:	76 0d                	jbe    1009a1 <console_vprintf+0xc6>
  100994:	eb 17                	jmp    1009ad <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  100996:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100999:	0f be c0             	movsbl %al,%eax
  10099c:	47                   	inc    %edi
  10099d:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1009a1:	8a 07                	mov    (%edi),%al
  1009a3:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009a6:	80 fa 09             	cmp    $0x9,%dl
  1009a9:	76 eb                	jbe    100996 <console_vprintf+0xbb>
  1009ab:	eb 11                	jmp    1009be <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1009ad:	3c 2a                	cmp    $0x2a,%al
  1009af:	75 0b                	jne    1009bc <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1009b1:	83 c3 04             	add    $0x4,%ebx
				++format;
  1009b4:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1009b5:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1009b8:	85 ed                	test   %ebp,%ebp
  1009ba:	79 02                	jns    1009be <console_vprintf+0xe3>
  1009bc:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1009be:	8a 07                	mov    (%edi),%al
  1009c0:	3c 64                	cmp    $0x64,%al
  1009c2:	74 34                	je     1009f8 <console_vprintf+0x11d>
  1009c4:	7f 1d                	jg     1009e3 <console_vprintf+0x108>
  1009c6:	3c 58                	cmp    $0x58,%al
  1009c8:	0f 84 a2 00 00 00    	je     100a70 <console_vprintf+0x195>
  1009ce:	3c 63                	cmp    $0x63,%al
  1009d0:	0f 84 bf 00 00 00    	je     100a95 <console_vprintf+0x1ba>
  1009d6:	3c 43                	cmp    $0x43,%al
  1009d8:	0f 85 d0 00 00 00    	jne    100aae <console_vprintf+0x1d3>
  1009de:	e9 a3 00 00 00       	jmp    100a86 <console_vprintf+0x1ab>
  1009e3:	3c 75                	cmp    $0x75,%al
  1009e5:	74 4d                	je     100a34 <console_vprintf+0x159>
  1009e7:	3c 78                	cmp    $0x78,%al
  1009e9:	74 5c                	je     100a47 <console_vprintf+0x16c>
  1009eb:	3c 73                	cmp    $0x73,%al
  1009ed:	0f 85 bb 00 00 00    	jne    100aae <console_vprintf+0x1d3>
  1009f3:	e9 86 00 00 00       	jmp    100a7e <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1009f8:	83 c3 04             	add    $0x4,%ebx
  1009fb:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1009fe:	89 d1                	mov    %edx,%ecx
  100a00:	c1 f9 1f             	sar    $0x1f,%ecx
  100a03:	89 0c 24             	mov    %ecx,(%esp)
  100a06:	31 ca                	xor    %ecx,%edx
  100a08:	55                   	push   %ebp
  100a09:	29 ca                	sub    %ecx,%edx
  100a0b:	68 c4 0c 10 00       	push   $0x100cc4
  100a10:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a15:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a19:	e8 90 fe ff ff       	call   1008ae <fill_numbuf>
  100a1e:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100a22:	58                   	pop    %eax
  100a23:	5a                   	pop    %edx
  100a24:	ba 01 00 00 00       	mov    $0x1,%edx
  100a29:	8b 04 24             	mov    (%esp),%eax
  100a2c:	83 e0 01             	and    $0x1,%eax
  100a2f:	e9 a5 00 00 00       	jmp    100ad9 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a34:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a37:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a3c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a3f:	55                   	push   %ebp
  100a40:	68 c4 0c 10 00       	push   $0x100cc4
  100a45:	eb 11                	jmp    100a58 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a47:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a4a:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a4d:	55                   	push   %ebp
  100a4e:	68 d8 0c 10 00       	push   $0x100cd8
  100a53:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a58:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a5c:	e8 4d fe ff ff       	call   1008ae <fill_numbuf>
  100a61:	ba 01 00 00 00       	mov    $0x1,%edx
  100a66:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a6a:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a6c:	59                   	pop    %ecx
  100a6d:	59                   	pop    %ecx
  100a6e:	eb 69                	jmp    100ad9 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a70:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a73:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a76:	55                   	push   %ebp
  100a77:	68 c4 0c 10 00       	push   $0x100cc4
  100a7c:	eb d5                	jmp    100a53 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a7e:	83 c3 04             	add    $0x4,%ebx
  100a81:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a84:	eb 40                	jmp    100ac6 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a86:	83 c3 04             	add    $0x4,%ebx
  100a89:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a8c:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a90:	e9 bd 01 00 00       	jmp    100c52 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a95:	83 c3 04             	add    $0x4,%ebx
  100a98:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a9b:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a9f:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100aa4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100aa8:	88 44 24 24          	mov    %al,0x24(%esp)
  100aac:	eb 27                	jmp    100ad5 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100aae:	84 c0                	test   %al,%al
  100ab0:	75 02                	jne    100ab4 <console_vprintf+0x1d9>
  100ab2:	b0 25                	mov    $0x25,%al
  100ab4:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100ab8:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100abd:	80 3f 00             	cmpb   $0x0,(%edi)
  100ac0:	74 0a                	je     100acc <console_vprintf+0x1f1>
  100ac2:	8d 44 24 24          	lea    0x24(%esp),%eax
  100ac6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aca:	eb 09                	jmp    100ad5 <console_vprintf+0x1fa>
				format--;
  100acc:	8d 54 24 24          	lea    0x24(%esp),%edx
  100ad0:	4f                   	dec    %edi
  100ad1:	89 54 24 04          	mov    %edx,0x4(%esp)
  100ad5:	31 d2                	xor    %edx,%edx
  100ad7:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100ad9:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100adb:	83 fd ff             	cmp    $0xffffffff,%ebp
  100ade:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ae5:	74 1f                	je     100b06 <console_vprintf+0x22b>
  100ae7:	89 04 24             	mov    %eax,(%esp)
  100aea:	eb 01                	jmp    100aed <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100aec:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100aed:	39 e9                	cmp    %ebp,%ecx
  100aef:	74 0a                	je     100afb <console_vprintf+0x220>
  100af1:	8b 44 24 04          	mov    0x4(%esp),%eax
  100af5:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100af9:	75 f1                	jne    100aec <console_vprintf+0x211>
  100afb:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100afe:	89 0c 24             	mov    %ecx,(%esp)
  100b01:	eb 1f                	jmp    100b22 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100b03:	42                   	inc    %edx
  100b04:	eb 09                	jmp    100b0f <console_vprintf+0x234>
  100b06:	89 d1                	mov    %edx,%ecx
  100b08:	8b 14 24             	mov    (%esp),%edx
  100b0b:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100b0f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b13:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100b17:	75 ea                	jne    100b03 <console_vprintf+0x228>
  100b19:	8b 44 24 08          	mov    0x8(%esp),%eax
  100b1d:	89 14 24             	mov    %edx,(%esp)
  100b20:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100b22:	85 c0                	test   %eax,%eax
  100b24:	74 0c                	je     100b32 <console_vprintf+0x257>
  100b26:	84 d2                	test   %dl,%dl
  100b28:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b2f:	00 
  100b30:	75 24                	jne    100b56 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b32:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b37:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b3e:	00 
  100b3f:	75 15                	jne    100b56 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b41:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b45:	83 e0 08             	and    $0x8,%eax
  100b48:	83 f8 01             	cmp    $0x1,%eax
  100b4b:	19 c9                	sbb    %ecx,%ecx
  100b4d:	f7 d1                	not    %ecx
  100b4f:	83 e1 20             	and    $0x20,%ecx
  100b52:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b56:	3b 2c 24             	cmp    (%esp),%ebp
  100b59:	7e 0d                	jle    100b68 <console_vprintf+0x28d>
  100b5b:	84 d2                	test   %dl,%dl
  100b5d:	74 40                	je     100b9f <console_vprintf+0x2c4>
			zeros = precision - len;
  100b5f:	2b 2c 24             	sub    (%esp),%ebp
  100b62:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b66:	eb 3f                	jmp    100ba7 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b68:	84 d2                	test   %dl,%dl
  100b6a:	74 33                	je     100b9f <console_vprintf+0x2c4>
  100b6c:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b70:	83 e0 06             	and    $0x6,%eax
  100b73:	83 f8 02             	cmp    $0x2,%eax
  100b76:	75 27                	jne    100b9f <console_vprintf+0x2c4>
  100b78:	45                   	inc    %ebp
  100b79:	75 24                	jne    100b9f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b7b:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b7d:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b80:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b85:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b88:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b8b:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b8f:	7d 0e                	jge    100b9f <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b91:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b95:	29 ca                	sub    %ecx,%edx
  100b97:	29 c2                	sub    %eax,%edx
  100b99:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b9d:	eb 08                	jmp    100ba7 <console_vprintf+0x2cc>
  100b9f:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100ba6:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ba7:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100bab:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bad:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bb1:	2b 2c 24             	sub    (%esp),%ebp
  100bb4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bb9:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bbc:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bbf:	29 c5                	sub    %eax,%ebp
  100bc1:	89 f0                	mov    %esi,%eax
  100bc3:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bc7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100bcb:	eb 0f                	jmp    100bdc <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100bcd:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bd1:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bd6:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bd7:	e8 83 fc ff ff       	call   10085f <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bdc:	85 ed                	test   %ebp,%ebp
  100bde:	7e 07                	jle    100be7 <console_vprintf+0x30c>
  100be0:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100be5:	74 e6                	je     100bcd <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100be7:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bec:	89 c6                	mov    %eax,%esi
  100bee:	74 23                	je     100c13 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100bf0:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100bf5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bf9:	e8 61 fc ff ff       	call   10085f <console_putc>
  100bfe:	89 c6                	mov    %eax,%esi
  100c00:	eb 11                	jmp    100c13 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100c02:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c06:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c0b:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100c0c:	e8 4e fc ff ff       	call   10085f <console_putc>
  100c11:	eb 06                	jmp    100c19 <console_vprintf+0x33e>
  100c13:	89 f0                	mov    %esi,%eax
  100c15:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c19:	85 f6                	test   %esi,%esi
  100c1b:	7f e5                	jg     100c02 <console_vprintf+0x327>
  100c1d:	8b 34 24             	mov    (%esp),%esi
  100c20:	eb 15                	jmp    100c37 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100c22:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c26:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100c27:	0f b6 11             	movzbl (%ecx),%edx
  100c2a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c2e:	e8 2c fc ff ff       	call   10085f <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c33:	ff 44 24 04          	incl   0x4(%esp)
  100c37:	85 f6                	test   %esi,%esi
  100c39:	7f e7                	jg     100c22 <console_vprintf+0x347>
  100c3b:	eb 0f                	jmp    100c4c <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c3d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c41:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c46:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c47:	e8 13 fc ff ff       	call   10085f <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c4c:	85 ed                	test   %ebp,%ebp
  100c4e:	7f ed                	jg     100c3d <console_vprintf+0x362>
  100c50:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c52:	47                   	inc    %edi
  100c53:	8a 17                	mov    (%edi),%dl
  100c55:	84 d2                	test   %dl,%dl
  100c57:	0f 85 96 fc ff ff    	jne    1008f3 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c5d:	83 c4 38             	add    $0x38,%esp
  100c60:	89 f0                	mov    %esi,%eax
  100c62:	5b                   	pop    %ebx
  100c63:	5e                   	pop    %esi
  100c64:	5f                   	pop    %edi
  100c65:	5d                   	pop    %ebp
  100c66:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c67:	81 e9 bc 0c 10 00    	sub    $0x100cbc,%ecx
  100c6d:	b8 01 00 00 00       	mov    $0x1,%eax
  100c72:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c74:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c75:	09 44 24 14          	or     %eax,0x14(%esp)
  100c79:	e9 aa fc ff ff       	jmp    100928 <console_vprintf+0x4d>

00100c7e <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c7e:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c82:	50                   	push   %eax
  100c83:	ff 74 24 10          	pushl  0x10(%esp)
  100c87:	ff 74 24 10          	pushl  0x10(%esp)
  100c8b:	ff 74 24 10          	pushl  0x10(%esp)
  100c8f:	e8 47 fc ff ff       	call   1008db <console_vprintf>
  100c94:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c97:	c3                   	ret    
