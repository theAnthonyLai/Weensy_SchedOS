
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
  100014:	e8 94 03 00 00       	call   1003ad <start>
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
  1000a3:	a1 94 78 10 00       	mov    0x107894,%eax
  1000a8:	8b 10                	mov    (%eax),%edx
	uint32_t seed;
	unsigned int lotteryTotal;
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
  1000aa:	a1 98 78 10 00       	mov    0x107898,%eax
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
  1000c1:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
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
  1000de:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1000e5:	75 0d                	jne    1000f4 <schedule+0x58>
				run(&proc_array[pid]);
  1000e7:	83 ec 0c             	sub    $0xc,%esp
  1000ea:	05 4c 6e 10 00       	add    $0x106e4c,%eax
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
  10010d:	8b 98 94 6e 10 00    	mov    0x106e94(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100113:	8d 42 01             	lea    0x1(%edx),%eax
  100116:	99                   	cltd   
  100117:	f7 fd                	idiv   %ebp
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  100119:	6b c2 60             	imul   $0x60,%edx,%eax
  10011c:	05 54 6e 10 00       	add    $0x106e54,%eax
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
  100141:	83 bf a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%edi)
  100148:	75 bc                	jne    100106 <schedule+0x6a>
		run(&proc_array[firstPid]);
  10014a:	83 ec 0c             	sub    $0xc,%esp
  10014d:	81 c7 4c 6e 10 00    	add    $0x106e4c,%edi
  100153:	57                   	push   %edi
  100154:	e9 95 01 00 00       	jmp    1002ee <schedule+0x252>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  100159:	83 f8 2a             	cmp    $0x2a,%eax
  10015c:	0f 85 c4 00 00 00    	jne    100226 <schedule+0x18a>
		// check if we reset all p_share_left
		p_share_reset = 0;
		for (i = 1; i < NPROCS; i++)
			p_share_reset += proc_array[i].p_share_left;
  100162:	a1 5c 6f 10 00       	mov    0x106f5c,%eax
  100167:	03 05 fc 6e 10 00    	add    0x106efc,%eax
  10016d:	03 05 bc 6f 10 00    	add    0x106fbc,%eax
  100173:	03 05 1c 70 10 00    	add    0x10701c,%eax
  100179:	85 c0                	test   %eax,%eax
  10017b:	75 32                	jne    1001af <schedule+0x113>
		//cursorpos = console_printf(cursorpos, 0x100, "Total left is %d\n", p_share_reset);
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				proc_array[i].p_share_left = proc_array[i].p_share_amt;
  10017d:	a1 98 6e 10 00       	mov    0x106e98,%eax
  100182:	a3 9c 6e 10 00       	mov    %eax,0x106e9c
  100187:	a1 f8 6e 10 00       	mov    0x106ef8,%eax
  10018c:	a3 fc 6e 10 00       	mov    %eax,0x106efc
  100191:	a1 58 6f 10 00       	mov    0x106f58,%eax
  100196:	a3 5c 6f 10 00       	mov    %eax,0x106f5c
  10019b:	a1 b8 6f 10 00       	mov    0x106fb8,%eax
  1001a0:	a3 bc 6f 10 00       	mov    %eax,0x106fbc
  1001a5:	a1 18 70 10 00       	mov    0x107018,%eax
  1001aa:	a3 1c 70 10 00       	mov    %eax,0x10701c
		
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
  1001bb:	8b 98 98 6e 10 00    	mov    0x106e98(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001c1:	8d 42 01             	lea    0x1(%edx),%eax
  1001c4:	99                   	cltd   
  1001c5:	f7 ff                	idiv   %edi
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0 && proc_array[pid].p_share_amt > firstPriority) {
  1001c7:	6b c2 60             	imul   $0x60,%edx,%eax
  1001ca:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1001d1:	75 17                	jne    1001ea <schedule+0x14e>
  1001d3:	83 b8 9c 6e 10 00 00 	cmpl   $0x0,0x106e9c(%eax)
  1001da:	74 0e                	je     1001ea <schedule+0x14e>
  1001dc:	8b 80 98 6e 10 00    	mov    0x106e98(%eax),%eax
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
  1001f9:	8d 83 4c 6e 10 00    	lea    0x106e4c(%ebx),%eax
  1001ff:	8b 50 50             	mov    0x50(%eax),%edx
  100202:	8d 70 50             	lea    0x50(%eax),%esi
  100205:	85 d2                	test   %edx,%edx
  100207:	74 09                	je     100212 <schedule+0x176>
  100209:	83 bb a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%ebx)
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
  10022f:	a1 24 70 10 00       	mov    0x107024,%eax
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  100234:	8b 1d 00 6f 10 00    	mov    0x106f00,%ebx
			lotteryTotal += proc_array[i].p_lottery_amt;
  10023a:	8b 0d a0 6e 10 00    	mov    0x106ea0,%ecx
			run(&proc_array[firstPid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  100240:	8b 15 60 6f 10 00    	mov    0x106f60,%edx
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
  10024a:	a1 c0 6f 10 00       	mov    0x106fc0,%eax
			seed ^= seed << 7 & 0xffffffff;
			seed ^= seed << 15 & 0x9d2c5680;
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  10024f:	8b 35 04 6f 10 00    	mov    0x106f04,%esi
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
  100257:	8b 3d 64 6f 10 00    	mov    0x106f64,%edi
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  10025d:	8b 2d c4 6f 10 00    	mov    0x106fc4,%ebp
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
  100267:	03 0d c0 6f 10 00    	add    0x106fc0,%ecx

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
  10026f:	03 0d 20 70 10 00    	add    0x107020,%ecx
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
  1002ae:	68 ac 6e 10 00       	push   $0x106eac
  1002b3:	eb 39                	jmp    1002ee <schedule+0x252>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002b5:	3b 54 24 04          	cmp    0x4(%esp),%edx
  1002b9:	73 0f                	jae    1002ca <schedule+0x22e>
  1002bb:	83 ff 01             	cmp    $0x1,%edi
  1002be:	75 0a                	jne    1002ca <schedule+0x22e>
				run(&proc_array[2]);
  1002c0:	83 ec 0c             	sub    $0xc,%esp
  1002c3:	68 0c 6f 10 00       	push   $0x106f0c
  1002c8:	eb 24                	jmp    1002ee <schedule+0x252>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002ca:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  1002ce:	73 0f                	jae    1002df <schedule+0x243>
  1002d0:	83 fd 01             	cmp    $0x1,%ebp
  1002d3:	75 0a                	jne    1002df <schedule+0x243>
				run(&proc_array[3]);
  1002d5:	83 ec 0c             	sub    $0xc,%esp
  1002d8:	68 6c 6f 10 00       	push   $0x106f6c
  1002dd:	eb 0f                	jmp    1002ee <schedule+0x252>
			else if (proc_array[4].p_state == P_RUNNABLE)
  1002df:	83 7c 24 08 01       	cmpl   $0x1,0x8(%esp)
  1002e4:	75 97                	jne    10027d <schedule+0x1e1>
				run(&proc_array[4]);
  1002e6:	83 ec 0c             	sub    $0xc,%esp
  1002e9:	68 cc 6f 10 00       	push   $0x106fcc
  1002ee:	e8 ea 03 00 00       	call   1006dd <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1002f3:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1002f9:	50                   	push   %eax
  1002fa:	68 9c 0c 10 00       	push   $0x100c9c
  1002ff:	68 00 01 00 00       	push   $0x100
  100304:	52                   	push   %edx
  100305:	e8 78 09 00 00       	call   100c82 <console_printf>
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
  100315:	8b 3d 94 78 10 00    	mov    0x107894,%edi
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
  100330:	83 e8 20             	sub    $0x20,%eax
  100333:	83 f8 15             	cmp    $0x15,%eax
  100336:	77 73                	ja     1003ab <interrupt+0x97>
  100338:	ff 24 85 c0 0c 10 00 	jmp    *0x100cc0(,%eax,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10033f:	e8 58 fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100344:	a1 94 78 10 00       	mov    0x107894,%eax
		current->p_exit_status = reg->reg_eax;
  100349:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10034c:	c7 40 58 03 00 00 00 	movl   $0x3,0x58(%eax)
		current->p_exit_status = reg->reg_eax;
  100353:	89 50 5c             	mov    %edx,0x5c(%eax)
		schedule();
  100356:	e8 41 fd ff ff       	call   10009c <schedule>
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_priority = reg->reg_eax;
  10035b:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10035e:	a1 94 78 10 00       	mov    0x107894,%eax
  100363:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  100366:	e8 31 fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  10036b:	a1 94 78 10 00       	mov    0x107894,%eax
  100370:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100373:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  100376:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  100379:	e8 1e fd ff ff       	call   10009c <schedule>
	
	case INT_SYS_LOTTERY:
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_lottery_amt = reg->reg_eax;
  10037e:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100381:	a1 94 78 10 00       	mov    0x107894,%eax
  100386:	89 50 54             	mov    %edx,0x54(%eax)
		schedule();
  100389:	e8 0e fd ff ff       	call   10009c <schedule>
	
	case INT_SYS_PRINT:
		*cursorpos++ = reg->reg_eax;
  10038e:	a1 00 80 19 00       	mov    0x198000,%eax
  100393:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100396:	66 89 10             	mov    %dx,(%eax)
  100399:	83 c0 02             	add    $0x2,%eax
  10039c:	a3 00 80 19 00       	mov    %eax,0x198000
		schedule();
  1003a1:	e8 f6 fc ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1003a6:	e8 f1 fc ff ff       	call   10009c <schedule>
  1003ab:	eb fe                	jmp    1003ab <interrupt+0x97>

001003ad <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1003ad:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003ae:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1003b3:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003b4:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1003b6:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003b7:	bb ac 6e 10 00       	mov    $0x106eac,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1003bc:	e8 fb 00 00 00       	call   1004bc <segments_init>
	//interrupt_controller_init(0);
	interrupt_controller_init(1);
  1003c1:	83 ec 0c             	sub    $0xc,%esp
  1003c4:	6a 01                	push   $0x1
  1003c6:	e8 ec 01 00 00       	call   1005b7 <interrupt_controller_init>
	console_clear();
  1003cb:	e8 70 02 00 00       	call   100640 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1003d0:	83 c4 0c             	add    $0xc,%esp
  1003d3:	68 e0 01 00 00       	push   $0x1e0
  1003d8:	6a 00                	push   $0x0
  1003da:	68 4c 6e 10 00       	push   $0x106e4c
  1003df:	e8 3c 04 00 00       	call   100820 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003e4:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003e7:	c7 05 4c 6e 10 00 00 	movl   $0x0,0x106e4c
  1003ee:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003f1:	c7 05 a4 6e 10 00 00 	movl   $0x0,0x106ea4
  1003f8:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003fb:	c7 05 ac 6e 10 00 01 	movl   $0x1,0x106eac
  100402:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100405:	c7 05 04 6f 10 00 00 	movl   $0x0,0x106f04
  10040c:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10040f:	c7 05 0c 6f 10 00 02 	movl   $0x2,0x106f0c
  100416:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100419:	c7 05 64 6f 10 00 00 	movl   $0x0,0x106f64
  100420:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100423:	c7 05 6c 6f 10 00 03 	movl   $0x3,0x106f6c
  10042a:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10042d:	c7 05 c4 6f 10 00 00 	movl   $0x0,0x106fc4
  100434:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100437:	c7 05 cc 6f 10 00 04 	movl   $0x4,0x106fcc
  10043e:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100441:	c7 05 24 70 10 00 00 	movl   $0x0,0x107024
  100448:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10044b:	83 ec 0c             	sub    $0xc,%esp
  10044e:	53                   	push   %ebx
  10044f:	e8 a0 02 00 00       	call   1006f4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100454:	58                   	pop    %eax
  100455:	5a                   	pop    %edx
  100456:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100459:	89 7b 40             	mov    %edi,0x40(%ebx)
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  10045c:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100462:	50                   	push   %eax
  100463:	56                   	push   %esi
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  100464:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100465:	e8 c6 02 00 00       	call   100730 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10046a:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  10046d:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)

		// Exercise 4B test
		// preset everyone to 1 so everyone can start
		proc->p_share_amt = 1;
  100474:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
		proc->p_share_left = 1;
  10047b:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  100482:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  100489:	83 c3 60             	add    $0x60,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10048c:	83 fe 04             	cmp    $0x4,%esi
  10048f:	75 ba                	jne    10044b <start+0x9e>
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  100491:	83 ec 0c             	sub    $0xc,%esp
  100494:	68 ac 6e 10 00       	push   $0x106eac
		proc->p_lottery_amt = 1;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100499:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004a0:	80 0b 00 
	cursorposLock = 0;	// lock is available
  1004a3:	c7 05 10 80 19 00 00 	movl   $0x0,0x198010
  1004aa:	00 00 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 0;
  1004ad:	c7 05 98 78 10 00 00 	movl   $0x0,0x107898
  1004b4:	00 00 00 
	//scheduling_algorithm = __EXERCISE_4A__;
	//scheduling_algorithm = __EXERCISE_4B__;
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  1004b7:	e8 21 02 00 00       	call   1006dd <run>

001004bc <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004bc:	b8 2c 70 10 00       	mov    $0x10702c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004c1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004c6:	89 c2                	mov    %eax,%edx
  1004c8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1004cb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004cc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1004d1:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004d4:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  1004da:	c1 e8 18             	shr    $0x18,%eax
  1004dd:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004e3:	ba 94 70 10 00       	mov    $0x107094,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004e8:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004ed:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004ef:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  1004f6:	68 00 
  1004f8:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1004ff:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100506:	c7 05 30 70 10 00 00 	movl   $0x180000,0x107030
  10050d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100510:	66 c7 05 34 70 10 00 	movw   $0x10,0x107034
  100517:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100519:	66 89 0c c5 94 70 10 	mov    %cx,0x107094(,%eax,8)
  100520:	00 
  100521:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100528:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10052d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100532:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100537:	40                   	inc    %eax
  100538:	3d 00 01 00 00       	cmp    $0x100,%eax
  10053d:	75 da                	jne    100519 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10053f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100544:	ba 94 70 10 00       	mov    $0x107094,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100549:	66 a3 94 71 10 00    	mov    %ax,0x107194
  10054f:	c1 e8 10             	shr    $0x10,%eax
  100552:	66 a3 9a 71 10 00    	mov    %ax,0x10719a
  100558:	b8 30 00 00 00       	mov    $0x30,%eax
  10055d:	66 c7 05 96 71 10 00 	movw   $0x8,0x107196
  100564:	08 00 
  100566:	c6 05 98 71 10 00 00 	movb   $0x0,0x107198
  10056d:	c6 05 99 71 10 00 8e 	movb   $0x8e,0x107199

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100574:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10057b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100582:	66 89 0c c5 94 70 10 	mov    %cx,0x107094(,%eax,8)
  100589:	00 
  10058a:	c1 e9 10             	shr    $0x10,%ecx
  10058d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100592:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100597:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10059c:	40                   	inc    %eax
  10059d:	83 f8 3a             	cmp    $0x3a,%eax
  1005a0:	75 d2                	jne    100574 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1005a2:	b0 28                	mov    $0x28,%al
  1005a4:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1005ab:	0f 00 d8             	ltr    %ax
  1005ae:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1005b5:	5b                   	pop    %ebx
  1005b6:	c3                   	ret    

001005b7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1005b7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1005b8:	b0 ff                	mov    $0xff,%al
  1005ba:	57                   	push   %edi
  1005bb:	56                   	push   %esi
  1005bc:	53                   	push   %ebx
  1005bd:	bb 21 00 00 00       	mov    $0x21,%ebx
  1005c2:	89 da                	mov    %ebx,%edx
  1005c4:	ee                   	out    %al,(%dx)
  1005c5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1005ca:	89 ca                	mov    %ecx,%edx
  1005cc:	ee                   	out    %al,(%dx)
  1005cd:	be 11 00 00 00       	mov    $0x11,%esi
  1005d2:	bf 20 00 00 00       	mov    $0x20,%edi
  1005d7:	89 f0                	mov    %esi,%eax
  1005d9:	89 fa                	mov    %edi,%edx
  1005db:	ee                   	out    %al,(%dx)
  1005dc:	b0 20                	mov    $0x20,%al
  1005de:	89 da                	mov    %ebx,%edx
  1005e0:	ee                   	out    %al,(%dx)
  1005e1:	b0 04                	mov    $0x4,%al
  1005e3:	ee                   	out    %al,(%dx)
  1005e4:	b0 03                	mov    $0x3,%al
  1005e6:	ee                   	out    %al,(%dx)
  1005e7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1005ec:	89 f0                	mov    %esi,%eax
  1005ee:	89 ea                	mov    %ebp,%edx
  1005f0:	ee                   	out    %al,(%dx)
  1005f1:	b0 28                	mov    $0x28,%al
  1005f3:	89 ca                	mov    %ecx,%edx
  1005f5:	ee                   	out    %al,(%dx)
  1005f6:	b0 02                	mov    $0x2,%al
  1005f8:	ee                   	out    %al,(%dx)
  1005f9:	b0 01                	mov    $0x1,%al
  1005fb:	ee                   	out    %al,(%dx)
  1005fc:	b0 68                	mov    $0x68,%al
  1005fe:	89 fa                	mov    %edi,%edx
  100600:	ee                   	out    %al,(%dx)
  100601:	be 0a 00 00 00       	mov    $0xa,%esi
  100606:	89 f0                	mov    %esi,%eax
  100608:	ee                   	out    %al,(%dx)
  100609:	b0 68                	mov    $0x68,%al
  10060b:	89 ea                	mov    %ebp,%edx
  10060d:	ee                   	out    %al,(%dx)
  10060e:	89 f0                	mov    %esi,%eax
  100610:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100611:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100616:	89 da                	mov    %ebx,%edx
  100618:	19 c0                	sbb    %eax,%eax
  10061a:	f7 d0                	not    %eax
  10061c:	05 ff 00 00 00       	add    $0xff,%eax
  100621:	ee                   	out    %al,(%dx)
  100622:	b0 ff                	mov    $0xff,%al
  100624:	89 ca                	mov    %ecx,%edx
  100626:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100627:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10062c:	74 0d                	je     10063b <interrupt_controller_init+0x84>
  10062e:	b2 43                	mov    $0x43,%dl
  100630:	b0 34                	mov    $0x34,%al
  100632:	ee                   	out    %al,(%dx)
  100633:	b0 a9                	mov    $0xa9,%al
  100635:	b2 40                	mov    $0x40,%dl
  100637:	ee                   	out    %al,(%dx)
  100638:	b0 04                	mov    $0x4,%al
  10063a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10063b:	5b                   	pop    %ebx
  10063c:	5e                   	pop    %esi
  10063d:	5f                   	pop    %edi
  10063e:	5d                   	pop    %ebp
  10063f:	c3                   	ret    

00100640 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100640:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100641:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100643:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100644:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10064b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10064e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100654:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10065a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10065d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100662:	75 ea                	jne    10064e <console_clear+0xe>
  100664:	be d4 03 00 00       	mov    $0x3d4,%esi
  100669:	b0 0e                	mov    $0xe,%al
  10066b:	89 f2                	mov    %esi,%edx
  10066d:	ee                   	out    %al,(%dx)
  10066e:	31 c9                	xor    %ecx,%ecx
  100670:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100675:	88 c8                	mov    %cl,%al
  100677:	89 da                	mov    %ebx,%edx
  100679:	ee                   	out    %al,(%dx)
  10067a:	b0 0f                	mov    $0xf,%al
  10067c:	89 f2                	mov    %esi,%edx
  10067e:	ee                   	out    %al,(%dx)
  10067f:	88 c8                	mov    %cl,%al
  100681:	89 da                	mov    %ebx,%edx
  100683:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100684:	5b                   	pop    %ebx
  100685:	5e                   	pop    %esi
  100686:	c3                   	ret    

00100687 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100687:	ba 64 00 00 00       	mov    $0x64,%edx
  10068c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10068d:	a8 01                	test   $0x1,%al
  10068f:	74 45                	je     1006d6 <console_read_digit+0x4f>
  100691:	b2 60                	mov    $0x60,%dl
  100693:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100694:	8d 50 fe             	lea    -0x2(%eax),%edx
  100697:	80 fa 08             	cmp    $0x8,%dl
  10069a:	77 05                	ja     1006a1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10069c:	0f b6 c0             	movzbl %al,%eax
  10069f:	48                   	dec    %eax
  1006a0:	c3                   	ret    
	else if (data == 0x0B)
  1006a1:	3c 0b                	cmp    $0xb,%al
  1006a3:	74 35                	je     1006da <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1006a5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1006a8:	80 fa 02             	cmp    $0x2,%dl
  1006ab:	77 07                	ja     1006b4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1006ad:	0f b6 c0             	movzbl %al,%eax
  1006b0:	83 e8 40             	sub    $0x40,%eax
  1006b3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1006b4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1006b7:	80 fa 02             	cmp    $0x2,%dl
  1006ba:	77 07                	ja     1006c3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1006bc:	0f b6 c0             	movzbl %al,%eax
  1006bf:	83 e8 47             	sub    $0x47,%eax
  1006c2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1006c3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1006c6:	80 fa 02             	cmp    $0x2,%dl
  1006c9:	77 07                	ja     1006d2 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1006cb:	0f b6 c0             	movzbl %al,%eax
  1006ce:	83 e8 4e             	sub    $0x4e,%eax
  1006d1:	c3                   	ret    
	else if (data == 0x53)
  1006d2:	3c 53                	cmp    $0x53,%al
  1006d4:	74 04                	je     1006da <console_read_digit+0x53>
  1006d6:	83 c8 ff             	or     $0xffffffff,%eax
  1006d9:	c3                   	ret    
  1006da:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  1006dc:	c3                   	ret    

001006dd <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  1006dd:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1006e1:	a3 94 78 10 00       	mov    %eax,0x107894

	asm volatile("movl %0,%%esp\n\t"
  1006e6:	83 c0 04             	add    $0x4,%eax
  1006e9:	89 c4                	mov    %eax,%esp
  1006eb:	61                   	popa   
  1006ec:	07                   	pop    %es
  1006ed:	1f                   	pop    %ds
  1006ee:	83 c4 08             	add    $0x8,%esp
  1006f1:	cf                   	iret   
  1006f2:	eb fe                	jmp    1006f2 <run+0x15>

001006f4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1006f4:	53                   	push   %ebx
  1006f5:	83 ec 0c             	sub    $0xc,%esp
  1006f8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1006fc:	6a 44                	push   $0x44
  1006fe:	6a 00                	push   $0x0
  100700:	8d 43 04             	lea    0x4(%ebx),%eax
  100703:	50                   	push   %eax
  100704:	e8 17 01 00 00       	call   100820 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100709:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10070f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100715:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10071b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100721:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100728:	83 c4 18             	add    $0x18,%esp
  10072b:	5b                   	pop    %ebx
  10072c:	c3                   	ret    
  10072d:	90                   	nop
  10072e:	90                   	nop
  10072f:	90                   	nop

00100730 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100730:	55                   	push   %ebp
  100731:	57                   	push   %edi
  100732:	56                   	push   %esi
  100733:	53                   	push   %ebx
  100734:	83 ec 1c             	sub    $0x1c,%esp
  100737:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10073b:	83 f8 03             	cmp    $0x3,%eax
  10073e:	7f 04                	jg     100744 <program_loader+0x14>
  100740:	85 c0                	test   %eax,%eax
  100742:	79 02                	jns    100746 <program_loader+0x16>
  100744:	eb fe                	jmp    100744 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100746:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10074d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100753:	74 02                	je     100757 <program_loader+0x27>
  100755:	eb fe                	jmp    100755 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100757:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10075a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10075e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100760:	c1 e5 05             	shl    $0x5,%ebp
  100763:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100766:	eb 3f                	jmp    1007a7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100768:	83 3b 01             	cmpl   $0x1,(%ebx)
  10076b:	75 37                	jne    1007a4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10076d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100770:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100773:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100776:	01 c7                	add    %eax,%edi
	memsz += va;
  100778:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10077a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10077f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100783:	52                   	push   %edx
  100784:	89 fa                	mov    %edi,%edx
  100786:	29 c2                	sub    %eax,%edx
  100788:	52                   	push   %edx
  100789:	8b 53 04             	mov    0x4(%ebx),%edx
  10078c:	01 f2                	add    %esi,%edx
  10078e:	52                   	push   %edx
  10078f:	50                   	push   %eax
  100790:	e8 27 00 00 00       	call   1007bc <memcpy>
  100795:	83 c4 10             	add    $0x10,%esp
  100798:	eb 04                	jmp    10079e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10079a:	c6 07 00             	movb   $0x0,(%edi)
  10079d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10079e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1007a2:	72 f6                	jb     10079a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1007a4:	83 c3 20             	add    $0x20,%ebx
  1007a7:	39 eb                	cmp    %ebp,%ebx
  1007a9:	72 bd                	jb     100768 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1007ab:	8b 56 18             	mov    0x18(%esi),%edx
  1007ae:	8b 44 24 34          	mov    0x34(%esp),%eax
  1007b2:	89 10                	mov    %edx,(%eax)
}
  1007b4:	83 c4 1c             	add    $0x1c,%esp
  1007b7:	5b                   	pop    %ebx
  1007b8:	5e                   	pop    %esi
  1007b9:	5f                   	pop    %edi
  1007ba:	5d                   	pop    %ebp
  1007bb:	c3                   	ret    

001007bc <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1007bc:	56                   	push   %esi
  1007bd:	31 d2                	xor    %edx,%edx
  1007bf:	53                   	push   %ebx
  1007c0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1007c4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1007c8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007cc:	eb 08                	jmp    1007d6 <memcpy+0x1a>
		*d++ = *s++;
  1007ce:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1007d1:	4e                   	dec    %esi
  1007d2:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1007d5:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007d6:	85 f6                	test   %esi,%esi
  1007d8:	75 f4                	jne    1007ce <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  1007da:	5b                   	pop    %ebx
  1007db:	5e                   	pop    %esi
  1007dc:	c3                   	ret    

001007dd <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  1007dd:	57                   	push   %edi
  1007de:	56                   	push   %esi
  1007df:	53                   	push   %ebx
  1007e0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1007e4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1007e8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1007ec:	39 c7                	cmp    %eax,%edi
  1007ee:	73 26                	jae    100816 <memmove+0x39>
  1007f0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1007f3:	39 c6                	cmp    %eax,%esi
  1007f5:	76 1f                	jbe    100816 <memmove+0x39>
		s += n, d += n;
  1007f7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1007fa:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1007fc:	eb 07                	jmp    100805 <memmove+0x28>
			*--d = *--s;
  1007fe:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100801:	4a                   	dec    %edx
  100802:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100805:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100806:	85 d2                	test   %edx,%edx
  100808:	75 f4                	jne    1007fe <memmove+0x21>
  10080a:	eb 10                	jmp    10081c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10080c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10080f:	4a                   	dec    %edx
  100810:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100813:	41                   	inc    %ecx
  100814:	eb 02                	jmp    100818 <memmove+0x3b>
  100816:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100818:	85 d2                	test   %edx,%edx
  10081a:	75 f0                	jne    10080c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10081c:	5b                   	pop    %ebx
  10081d:	5e                   	pop    %esi
  10081e:	5f                   	pop    %edi
  10081f:	c3                   	ret    

00100820 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100820:	53                   	push   %ebx
  100821:	8b 44 24 08          	mov    0x8(%esp),%eax
  100825:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100829:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10082d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10082f:	eb 04                	jmp    100835 <memset+0x15>
		*p++ = c;
  100831:	88 1a                	mov    %bl,(%edx)
  100833:	49                   	dec    %ecx
  100834:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100835:	85 c9                	test   %ecx,%ecx
  100837:	75 f8                	jne    100831 <memset+0x11>
		*p++ = c;
	return v;
}
  100839:	5b                   	pop    %ebx
  10083a:	c3                   	ret    

0010083b <strlen>:

size_t
strlen(const char *s)
{
  10083b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10083f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100841:	eb 01                	jmp    100844 <strlen+0x9>
		++n;
  100843:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100844:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100848:	75 f9                	jne    100843 <strlen+0x8>
		++n;
	return n;
}
  10084a:	c3                   	ret    

0010084b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10084b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10084f:	31 c0                	xor    %eax,%eax
  100851:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100855:	eb 01                	jmp    100858 <strnlen+0xd>
		++n;
  100857:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100858:	39 d0                	cmp    %edx,%eax
  10085a:	74 06                	je     100862 <strnlen+0x17>
  10085c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100860:	75 f5                	jne    100857 <strnlen+0xc>
		++n;
	return n;
}
  100862:	c3                   	ret    

00100863 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100863:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100864:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100869:	53                   	push   %ebx
  10086a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10086c:	76 05                	jbe    100873 <console_putc+0x10>
  10086e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100873:	80 fa 0a             	cmp    $0xa,%dl
  100876:	75 2c                	jne    1008a4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100878:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10087e:	be 50 00 00 00       	mov    $0x50,%esi
  100883:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100885:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100888:	99                   	cltd   
  100889:	f7 fe                	idiv   %esi
  10088b:	89 de                	mov    %ebx,%esi
  10088d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10088f:	eb 07                	jmp    100898 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100891:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100894:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100895:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100898:	83 f8 50             	cmp    $0x50,%eax
  10089b:	75 f4                	jne    100891 <console_putc+0x2e>
  10089d:	29 d0                	sub    %edx,%eax
  10089f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1008a2:	eb 0b                	jmp    1008af <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1008a4:	0f b6 d2             	movzbl %dl,%edx
  1008a7:	09 ca                	or     %ecx,%edx
  1008a9:	66 89 13             	mov    %dx,(%ebx)
  1008ac:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1008af:	5b                   	pop    %ebx
  1008b0:	5e                   	pop    %esi
  1008b1:	c3                   	ret    

001008b2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1008b2:	56                   	push   %esi
  1008b3:	53                   	push   %ebx
  1008b4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1008b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1008bb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1008bf:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1008c4:	75 04                	jne    1008ca <fill_numbuf+0x18>
  1008c6:	85 d2                	test   %edx,%edx
  1008c8:	74 10                	je     1008da <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1008ca:	89 d0                	mov    %edx,%eax
  1008cc:	31 d2                	xor    %edx,%edx
  1008ce:	f7 f1                	div    %ecx
  1008d0:	4b                   	dec    %ebx
  1008d1:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1008d4:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1008d6:	89 c2                	mov    %eax,%edx
  1008d8:	eb ec                	jmp    1008c6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  1008da:	89 d8                	mov    %ebx,%eax
  1008dc:	5b                   	pop    %ebx
  1008dd:	5e                   	pop    %esi
  1008de:	c3                   	ret    

001008df <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  1008df:	55                   	push   %ebp
  1008e0:	57                   	push   %edi
  1008e1:	56                   	push   %esi
  1008e2:	53                   	push   %ebx
  1008e3:	83 ec 38             	sub    $0x38,%esp
  1008e6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1008ea:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1008ee:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1008f2:	e9 60 03 00 00       	jmp    100c57 <console_vprintf+0x378>
		if (*format != '%') {
  1008f7:	80 fa 25             	cmp    $0x25,%dl
  1008fa:	74 13                	je     10090f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1008fc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100900:	0f b6 d2             	movzbl %dl,%edx
  100903:	89 f0                	mov    %esi,%eax
  100905:	e8 59 ff ff ff       	call   100863 <console_putc>
  10090a:	e9 45 03 00 00       	jmp    100c54 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10090f:	47                   	inc    %edi
  100910:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100917:	00 
  100918:	eb 12                	jmp    10092c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10091a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10091b:	8a 11                	mov    (%ecx),%dl
  10091d:	84 d2                	test   %dl,%dl
  10091f:	74 1a                	je     10093b <console_vprintf+0x5c>
  100921:	89 e8                	mov    %ebp,%eax
  100923:	38 c2                	cmp    %al,%dl
  100925:	75 f3                	jne    10091a <console_vprintf+0x3b>
  100927:	e9 3f 03 00 00       	jmp    100c6b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10092c:	8a 17                	mov    (%edi),%dl
  10092e:	84 d2                	test   %dl,%dl
  100930:	74 0b                	je     10093d <console_vprintf+0x5e>
  100932:	b9 18 0d 10 00       	mov    $0x100d18,%ecx
  100937:	89 d5                	mov    %edx,%ebp
  100939:	eb e0                	jmp    10091b <console_vprintf+0x3c>
  10093b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10093d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100940:	3c 08                	cmp    $0x8,%al
  100942:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100949:	00 
  10094a:	76 13                	jbe    10095f <console_vprintf+0x80>
  10094c:	eb 1d                	jmp    10096b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10094e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100953:	0f be c0             	movsbl %al,%eax
  100956:	47                   	inc    %edi
  100957:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10095b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10095f:	8a 07                	mov    (%edi),%al
  100961:	8d 50 d0             	lea    -0x30(%eax),%edx
  100964:	80 fa 09             	cmp    $0x9,%dl
  100967:	76 e5                	jbe    10094e <console_vprintf+0x6f>
  100969:	eb 18                	jmp    100983 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10096b:	80 fa 2a             	cmp    $0x2a,%dl
  10096e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100975:	ff 
  100976:	75 0b                	jne    100983 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100978:	83 c3 04             	add    $0x4,%ebx
			++format;
  10097b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10097c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10097f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100983:	83 cd ff             	or     $0xffffffff,%ebp
  100986:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100989:	75 37                	jne    1009c2 <console_vprintf+0xe3>
			++format;
  10098b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10098c:	31 ed                	xor    %ebp,%ebp
  10098e:	8a 07                	mov    (%edi),%al
  100990:	8d 50 d0             	lea    -0x30(%eax),%edx
  100993:	80 fa 09             	cmp    $0x9,%dl
  100996:	76 0d                	jbe    1009a5 <console_vprintf+0xc6>
  100998:	eb 17                	jmp    1009b1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10099a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10099d:	0f be c0             	movsbl %al,%eax
  1009a0:	47                   	inc    %edi
  1009a1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1009a5:	8a 07                	mov    (%edi),%al
  1009a7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009aa:	80 fa 09             	cmp    $0x9,%dl
  1009ad:	76 eb                	jbe    10099a <console_vprintf+0xbb>
  1009af:	eb 11                	jmp    1009c2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1009b1:	3c 2a                	cmp    $0x2a,%al
  1009b3:	75 0b                	jne    1009c0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1009b5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1009b8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1009b9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1009bc:	85 ed                	test   %ebp,%ebp
  1009be:	79 02                	jns    1009c2 <console_vprintf+0xe3>
  1009c0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1009c2:	8a 07                	mov    (%edi),%al
  1009c4:	3c 64                	cmp    $0x64,%al
  1009c6:	74 34                	je     1009fc <console_vprintf+0x11d>
  1009c8:	7f 1d                	jg     1009e7 <console_vprintf+0x108>
  1009ca:	3c 58                	cmp    $0x58,%al
  1009cc:	0f 84 a2 00 00 00    	je     100a74 <console_vprintf+0x195>
  1009d2:	3c 63                	cmp    $0x63,%al
  1009d4:	0f 84 bf 00 00 00    	je     100a99 <console_vprintf+0x1ba>
  1009da:	3c 43                	cmp    $0x43,%al
  1009dc:	0f 85 d0 00 00 00    	jne    100ab2 <console_vprintf+0x1d3>
  1009e2:	e9 a3 00 00 00       	jmp    100a8a <console_vprintf+0x1ab>
  1009e7:	3c 75                	cmp    $0x75,%al
  1009e9:	74 4d                	je     100a38 <console_vprintf+0x159>
  1009eb:	3c 78                	cmp    $0x78,%al
  1009ed:	74 5c                	je     100a4b <console_vprintf+0x16c>
  1009ef:	3c 73                	cmp    $0x73,%al
  1009f1:	0f 85 bb 00 00 00    	jne    100ab2 <console_vprintf+0x1d3>
  1009f7:	e9 86 00 00 00       	jmp    100a82 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1009fc:	83 c3 04             	add    $0x4,%ebx
  1009ff:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100a02:	89 d1                	mov    %edx,%ecx
  100a04:	c1 f9 1f             	sar    $0x1f,%ecx
  100a07:	89 0c 24             	mov    %ecx,(%esp)
  100a0a:	31 ca                	xor    %ecx,%edx
  100a0c:	55                   	push   %ebp
  100a0d:	29 ca                	sub    %ecx,%edx
  100a0f:	68 20 0d 10 00       	push   $0x100d20
  100a14:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a19:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a1d:	e8 90 fe ff ff       	call   1008b2 <fill_numbuf>
  100a22:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100a26:	58                   	pop    %eax
  100a27:	5a                   	pop    %edx
  100a28:	ba 01 00 00 00       	mov    $0x1,%edx
  100a2d:	8b 04 24             	mov    (%esp),%eax
  100a30:	83 e0 01             	and    $0x1,%eax
  100a33:	e9 a5 00 00 00       	jmp    100add <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a38:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a3b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a40:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a43:	55                   	push   %ebp
  100a44:	68 20 0d 10 00       	push   $0x100d20
  100a49:	eb 11                	jmp    100a5c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a4b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a4e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a51:	55                   	push   %ebp
  100a52:	68 34 0d 10 00       	push   $0x100d34
  100a57:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a5c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a60:	e8 4d fe ff ff       	call   1008b2 <fill_numbuf>
  100a65:	ba 01 00 00 00       	mov    $0x1,%edx
  100a6a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a6e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a70:	59                   	pop    %ecx
  100a71:	59                   	pop    %ecx
  100a72:	eb 69                	jmp    100add <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a74:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a77:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a7a:	55                   	push   %ebp
  100a7b:	68 20 0d 10 00       	push   $0x100d20
  100a80:	eb d5                	jmp    100a57 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a82:	83 c3 04             	add    $0x4,%ebx
  100a85:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a88:	eb 40                	jmp    100aca <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a8a:	83 c3 04             	add    $0x4,%ebx
  100a8d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a90:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a94:	e9 bd 01 00 00       	jmp    100c56 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a99:	83 c3 04             	add    $0x4,%ebx
  100a9c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a9f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100aa3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100aa8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100aac:	88 44 24 24          	mov    %al,0x24(%esp)
  100ab0:	eb 27                	jmp    100ad9 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100ab2:	84 c0                	test   %al,%al
  100ab4:	75 02                	jne    100ab8 <console_vprintf+0x1d9>
  100ab6:	b0 25                	mov    $0x25,%al
  100ab8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100abc:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100ac1:	80 3f 00             	cmpb   $0x0,(%edi)
  100ac4:	74 0a                	je     100ad0 <console_vprintf+0x1f1>
  100ac6:	8d 44 24 24          	lea    0x24(%esp),%eax
  100aca:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ace:	eb 09                	jmp    100ad9 <console_vprintf+0x1fa>
				format--;
  100ad0:	8d 54 24 24          	lea    0x24(%esp),%edx
  100ad4:	4f                   	dec    %edi
  100ad5:	89 54 24 04          	mov    %edx,0x4(%esp)
  100ad9:	31 d2                	xor    %edx,%edx
  100adb:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100add:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100adf:	83 fd ff             	cmp    $0xffffffff,%ebp
  100ae2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100ae9:	74 1f                	je     100b0a <console_vprintf+0x22b>
  100aeb:	89 04 24             	mov    %eax,(%esp)
  100aee:	eb 01                	jmp    100af1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100af0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100af1:	39 e9                	cmp    %ebp,%ecx
  100af3:	74 0a                	je     100aff <console_vprintf+0x220>
  100af5:	8b 44 24 04          	mov    0x4(%esp),%eax
  100af9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100afd:	75 f1                	jne    100af0 <console_vprintf+0x211>
  100aff:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b02:	89 0c 24             	mov    %ecx,(%esp)
  100b05:	eb 1f                	jmp    100b26 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100b07:	42                   	inc    %edx
  100b08:	eb 09                	jmp    100b13 <console_vprintf+0x234>
  100b0a:	89 d1                	mov    %edx,%ecx
  100b0c:	8b 14 24             	mov    (%esp),%edx
  100b0f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100b13:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b17:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100b1b:	75 ea                	jne    100b07 <console_vprintf+0x228>
  100b1d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100b21:	89 14 24             	mov    %edx,(%esp)
  100b24:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100b26:	85 c0                	test   %eax,%eax
  100b28:	74 0c                	je     100b36 <console_vprintf+0x257>
  100b2a:	84 d2                	test   %dl,%dl
  100b2c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b33:	00 
  100b34:	75 24                	jne    100b5a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b36:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b3b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b42:	00 
  100b43:	75 15                	jne    100b5a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b45:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b49:	83 e0 08             	and    $0x8,%eax
  100b4c:	83 f8 01             	cmp    $0x1,%eax
  100b4f:	19 c9                	sbb    %ecx,%ecx
  100b51:	f7 d1                	not    %ecx
  100b53:	83 e1 20             	and    $0x20,%ecx
  100b56:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b5a:	3b 2c 24             	cmp    (%esp),%ebp
  100b5d:	7e 0d                	jle    100b6c <console_vprintf+0x28d>
  100b5f:	84 d2                	test   %dl,%dl
  100b61:	74 40                	je     100ba3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100b63:	2b 2c 24             	sub    (%esp),%ebp
  100b66:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b6a:	eb 3f                	jmp    100bab <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b6c:	84 d2                	test   %dl,%dl
  100b6e:	74 33                	je     100ba3 <console_vprintf+0x2c4>
  100b70:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b74:	83 e0 06             	and    $0x6,%eax
  100b77:	83 f8 02             	cmp    $0x2,%eax
  100b7a:	75 27                	jne    100ba3 <console_vprintf+0x2c4>
  100b7c:	45                   	inc    %ebp
  100b7d:	75 24                	jne    100ba3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b7f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b81:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b84:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b89:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b8c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b8f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b93:	7d 0e                	jge    100ba3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b95:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b99:	29 ca                	sub    %ecx,%edx
  100b9b:	29 c2                	sub    %eax,%edx
  100b9d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ba1:	eb 08                	jmp    100bab <console_vprintf+0x2cc>
  100ba3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100baa:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bab:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100baf:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bb1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bb5:	2b 2c 24             	sub    (%esp),%ebp
  100bb8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bbd:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bc0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bc3:	29 c5                	sub    %eax,%ebp
  100bc5:	89 f0                	mov    %esi,%eax
  100bc7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bcb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100bcf:	eb 0f                	jmp    100be0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100bd1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bd5:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bda:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bdb:	e8 83 fc ff ff       	call   100863 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100be0:	85 ed                	test   %ebp,%ebp
  100be2:	7e 07                	jle    100beb <console_vprintf+0x30c>
  100be4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100be9:	74 e6                	je     100bd1 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100beb:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bf0:	89 c6                	mov    %eax,%esi
  100bf2:	74 23                	je     100c17 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100bf4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100bf9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bfd:	e8 61 fc ff ff       	call   100863 <console_putc>
  100c02:	89 c6                	mov    %eax,%esi
  100c04:	eb 11                	jmp    100c17 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100c06:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c0a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c0f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100c10:	e8 4e fc ff ff       	call   100863 <console_putc>
  100c15:	eb 06                	jmp    100c1d <console_vprintf+0x33e>
  100c17:	89 f0                	mov    %esi,%eax
  100c19:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c1d:	85 f6                	test   %esi,%esi
  100c1f:	7f e5                	jg     100c06 <console_vprintf+0x327>
  100c21:	8b 34 24             	mov    (%esp),%esi
  100c24:	eb 15                	jmp    100c3b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100c26:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c2a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100c2b:	0f b6 11             	movzbl (%ecx),%edx
  100c2e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c32:	e8 2c fc ff ff       	call   100863 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c37:	ff 44 24 04          	incl   0x4(%esp)
  100c3b:	85 f6                	test   %esi,%esi
  100c3d:	7f e7                	jg     100c26 <console_vprintf+0x347>
  100c3f:	eb 0f                	jmp    100c50 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c41:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c45:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c4a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c4b:	e8 13 fc ff ff       	call   100863 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c50:	85 ed                	test   %ebp,%ebp
  100c52:	7f ed                	jg     100c41 <console_vprintf+0x362>
  100c54:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c56:	47                   	inc    %edi
  100c57:	8a 17                	mov    (%edi),%dl
  100c59:	84 d2                	test   %dl,%dl
  100c5b:	0f 85 96 fc ff ff    	jne    1008f7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c61:	83 c4 38             	add    $0x38,%esp
  100c64:	89 f0                	mov    %esi,%eax
  100c66:	5b                   	pop    %ebx
  100c67:	5e                   	pop    %esi
  100c68:	5f                   	pop    %edi
  100c69:	5d                   	pop    %ebp
  100c6a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c6b:	81 e9 18 0d 10 00    	sub    $0x100d18,%ecx
  100c71:	b8 01 00 00 00       	mov    $0x1,%eax
  100c76:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c78:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c79:	09 44 24 14          	or     %eax,0x14(%esp)
  100c7d:	e9 aa fc ff ff       	jmp    10092c <console_vprintf+0x4d>

00100c82 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c82:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c86:	50                   	push   %eax
  100c87:	ff 74 24 10          	pushl  0x10(%esp)
  100c8b:	ff 74 24 10          	pushl  0x10(%esp)
  100c8f:	ff 74 24 10          	pushl  0x10(%esp)
  100c93:	e8 47 fc ff ff       	call   1008df <console_vprintf>
  100c98:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c9b:	c3                   	ret    
