
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
  100014:	e8 e6 02 00 00       	call   1002ff <start>
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
  10006d:	e8 0c 02 00 00       	call   10027e <interrupt>

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
  1000a3:	a1 28 7c 10 00       	mov    0x107c28,%eax
  1000a8:	8b 10                	mov    (%eax),%edx
	unsigned int firstPriority;
	pid_t firstPid;
	int i;
	int p_share_reset;	// 4B
	if (scheduling_algorithm == 0) {
  1000aa:	a1 2c 7c 10 00       	mov    0x107c2c,%eax
  1000af:	85 c0                	test   %eax,%eax
  1000b1:	75 19                	jne    1000cc <schedule+0x30>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b3:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b8:	8d 42 01             	lea    0x1(%edx),%eax
  1000bb:	99                   	cltd   
  1000bc:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000be:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000c1:	83 b8 48 72 10 00 01 	cmpl   $0x1,0x107248(%eax)
  1000c8:	75 ee                	jne    1000b8 <schedule+0x1c>
  1000ca:	eb 1b                	jmp    1000e7 <schedule+0x4b>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000cc:	83 f8 02             	cmp    $0x2,%eax
  1000cf:	75 2c                	jne    1000fd <schedule+0x61>
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
  1000db:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000de:	83 b8 48 72 10 00 01 	cmpl   $0x1,0x107248(%eax)
  1000e5:	75 0e                	jne    1000f5 <schedule+0x59>
				run(&proc_array[pid]);
  1000e7:	83 ec 0c             	sub    $0xc,%esp
  1000ea:	05 f4 71 10 00       	add    $0x1071f4,%eax
  1000ef:	50                   	push   %eax
  1000f0:	e9 5f 01 00 00       	jmp    100254 <schedule+0x1b8>
			pid = (pid + 1) % NPROCS;
  1000f5:	8d 42 01             	lea    0x1(%edx),%eax
  1000f8:	99                   	cltd   
  1000f9:	f7 f9                	idiv   %ecx
		}
  1000fb:	eb de                	jmp    1000db <schedule+0x3f>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000fd:	83 f8 29             	cmp    $0x29,%eax
  100100:	75 59                	jne    10015b <schedule+0xbf>
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100102:	bf 05 00 00 00       	mov    $0x5,%edi
		}
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
  100107:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10010a:	89 d6                	mov    %edx,%esi
  10010c:	31 c9                	xor    %ecx,%ecx
  10010e:	8b 98 3c 72 10 00    	mov    0x10723c(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100114:	8d 42 01             	lea    0x1(%edx),%eax
  100117:	99                   	cltd   
  100118:	f7 ff                	idiv   %edi
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  10011a:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10011d:	83 b8 48 72 10 00 01 	cmpl   $0x1,0x107248(%eax)
  100124:	75 0e                	jne    100134 <schedule+0x98>
  100126:	8b 80 3c 72 10 00    	mov    0x10723c(%eax),%eax
  10012c:	39 d8                	cmp    %ebx,%eax
  10012e:	77 04                	ja     100134 <schedule+0x98>
  100130:	89 d6                	mov    %edx,%esi
  100132:	eb 02                	jmp    100136 <schedule+0x9a>
  100134:	89 d8                	mov    %ebx,%eax
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
  100136:	41                   	inc    %ecx
  100137:	83 f9 04             	cmp    $0x4,%ecx
  10013a:	74 04                	je     100140 <schedule+0xa4>
  10013c:	89 c3                	mov    %eax,%ebx
  10013e:	eb d4                	jmp    100114 <schedule+0x78>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  100140:	6b f6 5c             	imul   $0x5c,%esi,%esi
  100143:	83 be 48 72 10 00 01 	cmpl   $0x1,0x107248(%esi)
  10014a:	75 bb                	jne    100107 <schedule+0x6b>
		run(&proc_array[firstPid]);
  10014c:	83 ec 0c             	sub    $0xc,%esp
  10014f:	81 c6 f4 71 10 00    	add    $0x1071f4,%esi
  100155:	56                   	push   %esi
  100156:	e9 f9 00 00 00       	jmp    100254 <schedule+0x1b8>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  10015b:	83 f8 2a             	cmp    $0x2a,%eax
  10015e:	0f 85 f5 00 00 00    	jne    100259 <schedule+0x1bd>
  100164:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  10016b:	00 
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
  10016c:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10016f:	89 d3                	mov    %edx,%ebx
  100171:	31 c9                	xor    %ecx,%ecx
  100173:	8b b0 40 72 10 00    	mov    0x107240(%eax),%esi
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100179:	8d 42 01             	lea    0x1(%edx),%eax
  10017c:	bf 05 00 00 00       	mov    $0x5,%edi
  100181:	99                   	cltd   
  100182:	f7 ff                	idiv   %edi
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
  100184:	a1 00 80 19 00       	mov    0x198000,%eax
		int hi = 2;
		while (hi) {
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100189:	89 54 24 0c          	mov    %edx,0xc(%esp)
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
  10018d:	57                   	push   %edi
  10018e:	57                   	push   %edi
  10018f:	6b fa 5c             	imul   $0x5c,%edx,%edi
  100192:	56                   	push   %esi
  100193:	8d af 00 72 10 00    	lea    0x107200(%edi),%ebp
  100199:	ff 75 40             	pushl  0x40(%ebp)
  10019c:	52                   	push   %edx
  10019d:	68 d0 0b 10 00       	push   $0x100bd0
  1001a2:	68 00 01 00 00       	push   $0x100
  1001a7:	50                   	push   %eax
  1001a8:	89 54 24 20          	mov    %edx,0x20(%esp)
  1001ac:	89 4c 24 24          	mov    %ecx,0x24(%esp)
  1001b0:	e8 01 0a 00 00       	call   100bb6 <console_printf>
					
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001b5:	83 c4 20             	add    $0x20,%esp
  1001b8:	83 bf 48 72 10 00 01 	cmpl   $0x1,0x107248(%edi)
  1001bf:	8b 14 24             	mov    (%esp),%edx
  1001c2:	8b 4c 24 04          	mov    0x4(%esp),%ecx
		while (hi) {
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
  1001c6:	a3 00 80 19 00       	mov    %eax,0x198000
					
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001cb:	75 0b                	jne    1001d8 <schedule+0x13c>
  1001cd:	8b 45 40             	mov    0x40(%ebp),%eax
  1001d0:	39 f0                	cmp    %esi,%eax
  1001d2:	72 04                	jb     1001d8 <schedule+0x13c>
  1001d4:	89 d3                	mov    %edx,%ebx
  1001d6:	eb 02                	jmp    1001da <schedule+0x13e>
  1001d8:	89 f0                	mov    %esi,%eax
		}
		int hi = 2;
		while (hi) {
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
  1001da:	41                   	inc    %ecx
  1001db:	83 f9 04             	cmp    $0x4,%ecx
  1001de:	74 04                	je     1001e4 <schedule+0x148>
  1001e0:	89 c6                	mov    %eax,%esi
  1001e2:	eb 95                	jmp    100179 <schedule+0xdd>
				}
			}
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
  1001e4:	6b c3 5c             	imul   $0x5c,%ebx,%eax
  1001e7:	83 b8 44 72 10 00 00 	cmpl   $0x0,0x107244(%eax)
  1001ee:	75 38                	jne    100228 <schedule+0x18c>
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  1001f0:	83 ec 0c             	sub    $0xc,%esp
  1001f3:	a1 00 80 19 00       	mov    0x198000,%eax
  1001f8:	ff 74 24 18          	pushl  0x18(%esp)
  1001fc:	53                   	push   %ebx
  1001fd:	68 f8 0b 10 00       	push   $0x100bf8
  100202:	68 00 01 00 00       	push   $0x100
  100207:	50                   	push   %eax
  100208:	e8 a9 09 00 00       	call   100bb6 <console_printf>
				pid = (pid + 1) % NPROCS;
  10020d:	b9 05 00 00 00       	mov    $0x5,%ecx
				hi--;
  100212:	ff 4c 24 28          	decl   0x28(%esp)
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  100216:	a3 00 80 19 00       	mov    %eax,0x198000
				pid = (pid + 1) % NPROCS;
  10021b:	8b 44 24 2c          	mov    0x2c(%esp),%eax
				hi--;
				continue;
  10021f:	83 c4 20             	add    $0x20,%esp
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
				pid = (pid + 1) % NPROCS;
  100222:	40                   	inc    %eax
  100223:	99                   	cltd   
  100224:	f7 f9                	idiv   %ecx
				hi--;
				continue;
  100226:	eb 09                	jmp    100231 <schedule+0x195>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
  100228:	83 b8 48 72 10 00 01 	cmpl   $0x1,0x107248(%eax)
  10022f:	74 0b                	je     10023c <schedule+0x1a0>
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
  100231:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100236:	0f 85 30 ff ff ff    	jne    10016c <schedule+0xd0>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
  10023c:	6b db 5c             	imul   $0x5c,%ebx,%ebx
  10023f:	81 c3 f4 71 10 00    	add    $0x1071f4,%ebx
  100245:	8b 43 50             	mov    0x50(%ebx),%eax
  100248:	85 c0                	test   %eax,%eax
  10024a:	74 0d                	je     100259 <schedule+0x1bd>
			proc_array[firstPid].p_share_left--;
  10024c:	48                   	dec    %eax
			run(&proc_array[firstPid]);
  10024d:	83 ec 0c             	sub    $0xc,%esp
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  100250:	89 43 50             	mov    %eax,0x50(%ebx)
			run(&proc_array[firstPid]);
  100253:	53                   	push   %ebx
  100254:	e8 b8 03 00 00       	call   100611 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100259:	ff 35 2c 7c 10 00    	pushl  0x107c2c
  10025f:	a1 00 80 19 00       	mov    0x198000,%eax
  100264:	68 13 0c 10 00       	push   $0x100c13
  100269:	68 00 01 00 00       	push   $0x100
  10026e:	50                   	push   %eax
  10026f:	e8 42 09 00 00       	call   100bb6 <console_printf>
  100274:	83 c4 10             	add    $0x10,%esp
  100277:	a3 00 80 19 00       	mov    %eax,0x198000
  10027c:	eb fe                	jmp    10027c <schedule+0x1e0>

0010027e <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10027e:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10027f:	8b 3d 28 7c 10 00    	mov    0x107c28,%edi
  100285:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10028a:	56                   	push   %esi
  10028b:	53                   	push   %ebx
  10028c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100290:	83 c7 04             	add    $0x4,%edi
  100293:	89 de                	mov    %ebx,%esi
  100295:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100297:	8b 43 28             	mov    0x28(%ebx),%eax
  10029a:	83 f8 31             	cmp    $0x31,%eax
  10029d:	74 1f                	je     1002be <interrupt+0x40>
  10029f:	77 0c                	ja     1002ad <interrupt+0x2f>
  1002a1:	83 f8 20             	cmp    $0x20,%eax
  1002a4:	74 52                	je     1002f8 <interrupt+0x7a>
  1002a6:	83 f8 30             	cmp    $0x30,%eax
  1002a9:	74 0e                	je     1002b9 <interrupt+0x3b>
  1002ab:	eb 50                	jmp    1002fd <interrupt+0x7f>
  1002ad:	83 f8 32             	cmp    $0x32,%eax
  1002b0:	74 23                	je     1002d5 <interrupt+0x57>
  1002b2:	83 f8 33             	cmp    $0x33,%eax
  1002b5:	74 2e                	je     1002e5 <interrupt+0x67>
  1002b7:	eb 44                	jmp    1002fd <interrupt+0x7f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002b9:	e8 de fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002be:	a1 28 7c 10 00       	mov    0x107c28,%eax
		current->p_exit_status = reg->reg_eax;
  1002c3:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002c6:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  1002cd:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  1002d0:	e8 c7 fd ff ff       	call   10009c <schedule>
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		current->p_priority = reg->reg_eax;
  1002d5:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002d8:	a1 28 7c 10 00       	mov    0x107c28,%eax
  1002dd:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  1002e0:	e8 b7 fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  1002e5:	a1 28 7c 10 00       	mov    0x107c28,%eax
  1002ea:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002ed:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  1002f0:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  1002f3:	e8 a4 fd ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1002f8:	e8 9f fd ff ff       	call   10009c <schedule>
  1002fd:	eb fe                	jmp    1002fd <interrupt+0x7f>

001002ff <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002ff:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100300:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100305:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100306:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100308:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100309:	bb 50 72 10 00       	mov    $0x107250,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10030e:	e8 dd 00 00 00       	call   1003f0 <segments_init>
	interrupt_controller_init(0);
  100313:	83 ec 0c             	sub    $0xc,%esp
  100316:	6a 00                	push   $0x0
  100318:	e8 ce 01 00 00       	call   1004eb <interrupt_controller_init>
	console_clear();
  10031d:	e8 52 02 00 00       	call   100574 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100322:	83 c4 0c             	add    $0xc,%esp
  100325:	68 cc 01 00 00       	push   $0x1cc
  10032a:	6a 00                	push   $0x0
  10032c:	68 f4 71 10 00       	push   $0x1071f4
  100331:	e8 1e 04 00 00       	call   100754 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100336:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100339:	c7 05 f4 71 10 00 00 	movl   $0x0,0x1071f4
  100340:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100343:	c7 05 48 72 10 00 00 	movl   $0x0,0x107248
  10034a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10034d:	c7 05 50 72 10 00 01 	movl   $0x1,0x107250
  100354:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100357:	c7 05 a4 72 10 00 00 	movl   $0x0,0x1072a4
  10035e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100361:	c7 05 ac 72 10 00 02 	movl   $0x2,0x1072ac
  100368:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10036b:	c7 05 00 73 10 00 00 	movl   $0x0,0x107300
  100372:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100375:	c7 05 08 73 10 00 03 	movl   $0x3,0x107308
  10037c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10037f:	c7 05 5c 73 10 00 00 	movl   $0x0,0x10735c
  100386:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100389:	c7 05 64 73 10 00 04 	movl   $0x4,0x107364
  100390:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100393:	c7 05 b8 73 10 00 00 	movl   $0x0,0x1073b8
  10039a:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  10039d:	83 ec 0c             	sub    $0xc,%esp
  1003a0:	53                   	push   %ebx
  1003a1:	e8 82 02 00 00       	call   100628 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003a6:	58                   	pop    %eax
  1003a7:	5a                   	pop    %edx
  1003a8:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003ab:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ae:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003b4:	50                   	push   %eax
  1003b5:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003b6:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003b7:	e8 a8 02 00 00       	call   100664 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003bc:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003bf:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  1003c6:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003c9:	83 fe 04             	cmp    $0x4,%esi
  1003cc:	75 cf                	jne    10039d <start+0x9e>
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;

	// Switch to the first process.
	run(&proc_array[1]);
  1003ce:	83 ec 0c             	sub    $0xc,%esp
  1003d1:	68 50 72 10 00       	push   $0x107250
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1003d6:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1003dd:	80 0b 00 
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
  1003e0:	c7 05 2c 7c 10 00 2a 	movl   $0x2a,0x107c2c
  1003e7:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  1003ea:	e8 22 02 00 00       	call   100611 <run>
  1003ef:	90                   	nop

001003f0 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003f0:	b8 c0 73 10 00       	mov    $0x1073c0,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003f5:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003fa:	89 c2                	mov    %eax,%edx
  1003fc:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1003ff:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100400:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100405:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100408:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10040e:	c1 e8 18             	shr    $0x18,%eax
  100411:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100417:	ba 28 74 10 00       	mov    $0x107428,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10041c:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100421:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100423:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10042a:	68 00 
  10042c:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100433:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10043a:	c7 05 c4 73 10 00 00 	movl   $0x180000,0x1073c4
  100441:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100444:	66 c7 05 c8 73 10 00 	movw   $0x10,0x1073c8
  10044b:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10044d:	66 89 0c c5 28 74 10 	mov    %cx,0x107428(,%eax,8)
  100454:	00 
  100455:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10045c:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100461:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100466:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10046b:	40                   	inc    %eax
  10046c:	3d 00 01 00 00       	cmp    $0x100,%eax
  100471:	75 da                	jne    10044d <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100473:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100478:	ba 28 74 10 00       	mov    $0x107428,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10047d:	66 a3 28 75 10 00    	mov    %ax,0x107528
  100483:	c1 e8 10             	shr    $0x10,%eax
  100486:	66 a3 2e 75 10 00    	mov    %ax,0x10752e
  10048c:	b8 30 00 00 00       	mov    $0x30,%eax
  100491:	66 c7 05 2a 75 10 00 	movw   $0x8,0x10752a
  100498:	08 00 
  10049a:	c6 05 2c 75 10 00 00 	movb   $0x0,0x10752c
  1004a1:	c6 05 2d 75 10 00 8e 	movb   $0x8e,0x10752d

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004a8:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004af:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004b6:	66 89 0c c5 28 74 10 	mov    %cx,0x107428(,%eax,8)
  1004bd:	00 
  1004be:	c1 e9 10             	shr    $0x10,%ecx
  1004c1:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004c6:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1004cb:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1004d0:	40                   	inc    %eax
  1004d1:	83 f8 3a             	cmp    $0x3a,%eax
  1004d4:	75 d2                	jne    1004a8 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1004d6:	b0 28                	mov    $0x28,%al
  1004d8:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1004df:	0f 00 d8             	ltr    %ax
  1004e2:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1004e9:	5b                   	pop    %ebx
  1004ea:	c3                   	ret    

001004eb <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1004eb:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1004ec:	b0 ff                	mov    $0xff,%al
  1004ee:	57                   	push   %edi
  1004ef:	56                   	push   %esi
  1004f0:	53                   	push   %ebx
  1004f1:	bb 21 00 00 00       	mov    $0x21,%ebx
  1004f6:	89 da                	mov    %ebx,%edx
  1004f8:	ee                   	out    %al,(%dx)
  1004f9:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1004fe:	89 ca                	mov    %ecx,%edx
  100500:	ee                   	out    %al,(%dx)
  100501:	be 11 00 00 00       	mov    $0x11,%esi
  100506:	bf 20 00 00 00       	mov    $0x20,%edi
  10050b:	89 f0                	mov    %esi,%eax
  10050d:	89 fa                	mov    %edi,%edx
  10050f:	ee                   	out    %al,(%dx)
  100510:	b0 20                	mov    $0x20,%al
  100512:	89 da                	mov    %ebx,%edx
  100514:	ee                   	out    %al,(%dx)
  100515:	b0 04                	mov    $0x4,%al
  100517:	ee                   	out    %al,(%dx)
  100518:	b0 03                	mov    $0x3,%al
  10051a:	ee                   	out    %al,(%dx)
  10051b:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100520:	89 f0                	mov    %esi,%eax
  100522:	89 ea                	mov    %ebp,%edx
  100524:	ee                   	out    %al,(%dx)
  100525:	b0 28                	mov    $0x28,%al
  100527:	89 ca                	mov    %ecx,%edx
  100529:	ee                   	out    %al,(%dx)
  10052a:	b0 02                	mov    $0x2,%al
  10052c:	ee                   	out    %al,(%dx)
  10052d:	b0 01                	mov    $0x1,%al
  10052f:	ee                   	out    %al,(%dx)
  100530:	b0 68                	mov    $0x68,%al
  100532:	89 fa                	mov    %edi,%edx
  100534:	ee                   	out    %al,(%dx)
  100535:	be 0a 00 00 00       	mov    $0xa,%esi
  10053a:	89 f0                	mov    %esi,%eax
  10053c:	ee                   	out    %al,(%dx)
  10053d:	b0 68                	mov    $0x68,%al
  10053f:	89 ea                	mov    %ebp,%edx
  100541:	ee                   	out    %al,(%dx)
  100542:	89 f0                	mov    %esi,%eax
  100544:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100545:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10054a:	89 da                	mov    %ebx,%edx
  10054c:	19 c0                	sbb    %eax,%eax
  10054e:	f7 d0                	not    %eax
  100550:	05 ff 00 00 00       	add    $0xff,%eax
  100555:	ee                   	out    %al,(%dx)
  100556:	b0 ff                	mov    $0xff,%al
  100558:	89 ca                	mov    %ecx,%edx
  10055a:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10055b:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100560:	74 0d                	je     10056f <interrupt_controller_init+0x84>
  100562:	b2 43                	mov    $0x43,%dl
  100564:	b0 34                	mov    $0x34,%al
  100566:	ee                   	out    %al,(%dx)
  100567:	b0 9c                	mov    $0x9c,%al
  100569:	b2 40                	mov    $0x40,%dl
  10056b:	ee                   	out    %al,(%dx)
  10056c:	b0 2e                	mov    $0x2e,%al
  10056e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10056f:	5b                   	pop    %ebx
  100570:	5e                   	pop    %esi
  100571:	5f                   	pop    %edi
  100572:	5d                   	pop    %ebp
  100573:	c3                   	ret    

00100574 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100574:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100575:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100577:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100578:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10057f:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100582:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100588:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10058e:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100591:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100596:	75 ea                	jne    100582 <console_clear+0xe>
  100598:	be d4 03 00 00       	mov    $0x3d4,%esi
  10059d:	b0 0e                	mov    $0xe,%al
  10059f:	89 f2                	mov    %esi,%edx
  1005a1:	ee                   	out    %al,(%dx)
  1005a2:	31 c9                	xor    %ecx,%ecx
  1005a4:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005a9:	88 c8                	mov    %cl,%al
  1005ab:	89 da                	mov    %ebx,%edx
  1005ad:	ee                   	out    %al,(%dx)
  1005ae:	b0 0f                	mov    $0xf,%al
  1005b0:	89 f2                	mov    %esi,%edx
  1005b2:	ee                   	out    %al,(%dx)
  1005b3:	88 c8                	mov    %cl,%al
  1005b5:	89 da                	mov    %ebx,%edx
  1005b7:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1005b8:	5b                   	pop    %ebx
  1005b9:	5e                   	pop    %esi
  1005ba:	c3                   	ret    

001005bb <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1005bb:	ba 64 00 00 00       	mov    $0x64,%edx
  1005c0:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1005c1:	a8 01                	test   $0x1,%al
  1005c3:	74 45                	je     10060a <console_read_digit+0x4f>
  1005c5:	b2 60                	mov    $0x60,%dl
  1005c7:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1005c8:	8d 50 fe             	lea    -0x2(%eax),%edx
  1005cb:	80 fa 08             	cmp    $0x8,%dl
  1005ce:	77 05                	ja     1005d5 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1005d0:	0f b6 c0             	movzbl %al,%eax
  1005d3:	48                   	dec    %eax
  1005d4:	c3                   	ret    
	else if (data == 0x0B)
  1005d5:	3c 0b                	cmp    $0xb,%al
  1005d7:	74 35                	je     10060e <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1005d9:	8d 50 b9             	lea    -0x47(%eax),%edx
  1005dc:	80 fa 02             	cmp    $0x2,%dl
  1005df:	77 07                	ja     1005e8 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1005e1:	0f b6 c0             	movzbl %al,%eax
  1005e4:	83 e8 40             	sub    $0x40,%eax
  1005e7:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1005e8:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1005eb:	80 fa 02             	cmp    $0x2,%dl
  1005ee:	77 07                	ja     1005f7 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1005f0:	0f b6 c0             	movzbl %al,%eax
  1005f3:	83 e8 47             	sub    $0x47,%eax
  1005f6:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1005f7:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1005fa:	80 fa 02             	cmp    $0x2,%dl
  1005fd:	77 07                	ja     100606 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1005ff:	0f b6 c0             	movzbl %al,%eax
  100602:	83 e8 4e             	sub    $0x4e,%eax
  100605:	c3                   	ret    
	else if (data == 0x53)
  100606:	3c 53                	cmp    $0x53,%al
  100608:	74 04                	je     10060e <console_read_digit+0x53>
  10060a:	83 c8 ff             	or     $0xffffffff,%eax
  10060d:	c3                   	ret    
  10060e:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100610:	c3                   	ret    

00100611 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100611:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100615:	a3 28 7c 10 00       	mov    %eax,0x107c28

	asm volatile("movl %0,%%esp\n\t"
  10061a:	83 c0 04             	add    $0x4,%eax
  10061d:	89 c4                	mov    %eax,%esp
  10061f:	61                   	popa   
  100620:	07                   	pop    %es
  100621:	1f                   	pop    %ds
  100622:	83 c4 08             	add    $0x8,%esp
  100625:	cf                   	iret   
  100626:	eb fe                	jmp    100626 <run+0x15>

00100628 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100628:	53                   	push   %ebx
  100629:	83 ec 0c             	sub    $0xc,%esp
  10062c:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100630:	6a 44                	push   $0x44
  100632:	6a 00                	push   $0x0
  100634:	8d 43 04             	lea    0x4(%ebx),%eax
  100637:	50                   	push   %eax
  100638:	e8 17 01 00 00       	call   100754 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10063d:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100643:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100649:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10064f:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100655:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  10065c:	83 c4 18             	add    $0x18,%esp
  10065f:	5b                   	pop    %ebx
  100660:	c3                   	ret    
  100661:	90                   	nop
  100662:	90                   	nop
  100663:	90                   	nop

00100664 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100664:	55                   	push   %ebp
  100665:	57                   	push   %edi
  100666:	56                   	push   %esi
  100667:	53                   	push   %ebx
  100668:	83 ec 1c             	sub    $0x1c,%esp
  10066b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10066f:	83 f8 03             	cmp    $0x3,%eax
  100672:	7f 04                	jg     100678 <program_loader+0x14>
  100674:	85 c0                	test   %eax,%eax
  100676:	79 02                	jns    10067a <program_loader+0x16>
  100678:	eb fe                	jmp    100678 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10067a:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100681:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100687:	74 02                	je     10068b <program_loader+0x27>
  100689:	eb fe                	jmp    100689 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10068b:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10068e:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100692:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100694:	c1 e5 05             	shl    $0x5,%ebp
  100697:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10069a:	eb 3f                	jmp    1006db <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  10069c:	83 3b 01             	cmpl   $0x1,(%ebx)
  10069f:	75 37                	jne    1006d8 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1006a1:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006a4:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006a7:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006aa:	01 c7                	add    %eax,%edi
	memsz += va;
  1006ac:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006ae:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006b3:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1006b7:	52                   	push   %edx
  1006b8:	89 fa                	mov    %edi,%edx
  1006ba:	29 c2                	sub    %eax,%edx
  1006bc:	52                   	push   %edx
  1006bd:	8b 53 04             	mov    0x4(%ebx),%edx
  1006c0:	01 f2                	add    %esi,%edx
  1006c2:	52                   	push   %edx
  1006c3:	50                   	push   %eax
  1006c4:	e8 27 00 00 00       	call   1006f0 <memcpy>
  1006c9:	83 c4 10             	add    $0x10,%esp
  1006cc:	eb 04                	jmp    1006d2 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1006ce:	c6 07 00             	movb   $0x0,(%edi)
  1006d1:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1006d2:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1006d6:	72 f6                	jb     1006ce <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1006d8:	83 c3 20             	add    $0x20,%ebx
  1006db:	39 eb                	cmp    %ebp,%ebx
  1006dd:	72 bd                	jb     10069c <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1006df:	8b 56 18             	mov    0x18(%esi),%edx
  1006e2:	8b 44 24 34          	mov    0x34(%esp),%eax
  1006e6:	89 10                	mov    %edx,(%eax)
}
  1006e8:	83 c4 1c             	add    $0x1c,%esp
  1006eb:	5b                   	pop    %ebx
  1006ec:	5e                   	pop    %esi
  1006ed:	5f                   	pop    %edi
  1006ee:	5d                   	pop    %ebp
  1006ef:	c3                   	ret    

001006f0 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1006f0:	56                   	push   %esi
  1006f1:	31 d2                	xor    %edx,%edx
  1006f3:	53                   	push   %ebx
  1006f4:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1006f8:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1006fc:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100700:	eb 08                	jmp    10070a <memcpy+0x1a>
		*d++ = *s++;
  100702:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100705:	4e                   	dec    %esi
  100706:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100709:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10070a:	85 f6                	test   %esi,%esi
  10070c:	75 f4                	jne    100702 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10070e:	5b                   	pop    %ebx
  10070f:	5e                   	pop    %esi
  100710:	c3                   	ret    

00100711 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100711:	57                   	push   %edi
  100712:	56                   	push   %esi
  100713:	53                   	push   %ebx
  100714:	8b 44 24 10          	mov    0x10(%esp),%eax
  100718:	8b 7c 24 14          	mov    0x14(%esp),%edi
  10071c:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100720:	39 c7                	cmp    %eax,%edi
  100722:	73 26                	jae    10074a <memmove+0x39>
  100724:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100727:	39 c6                	cmp    %eax,%esi
  100729:	76 1f                	jbe    10074a <memmove+0x39>
		s += n, d += n;
  10072b:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10072e:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100730:	eb 07                	jmp    100739 <memmove+0x28>
			*--d = *--s;
  100732:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100735:	4a                   	dec    %edx
  100736:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100739:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10073a:	85 d2                	test   %edx,%edx
  10073c:	75 f4                	jne    100732 <memmove+0x21>
  10073e:	eb 10                	jmp    100750 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100740:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100743:	4a                   	dec    %edx
  100744:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100747:	41                   	inc    %ecx
  100748:	eb 02                	jmp    10074c <memmove+0x3b>
  10074a:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  10074c:	85 d2                	test   %edx,%edx
  10074e:	75 f0                	jne    100740 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100750:	5b                   	pop    %ebx
  100751:	5e                   	pop    %esi
  100752:	5f                   	pop    %edi
  100753:	c3                   	ret    

00100754 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100754:	53                   	push   %ebx
  100755:	8b 44 24 08          	mov    0x8(%esp),%eax
  100759:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  10075d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100761:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100763:	eb 04                	jmp    100769 <memset+0x15>
		*p++ = c;
  100765:	88 1a                	mov    %bl,(%edx)
  100767:	49                   	dec    %ecx
  100768:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100769:	85 c9                	test   %ecx,%ecx
  10076b:	75 f8                	jne    100765 <memset+0x11>
		*p++ = c;
	return v;
}
  10076d:	5b                   	pop    %ebx
  10076e:	c3                   	ret    

0010076f <strlen>:

size_t
strlen(const char *s)
{
  10076f:	8b 54 24 04          	mov    0x4(%esp),%edx
  100773:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100775:	eb 01                	jmp    100778 <strlen+0x9>
		++n;
  100777:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100778:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  10077c:	75 f9                	jne    100777 <strlen+0x8>
		++n;
	return n;
}
  10077e:	c3                   	ret    

0010077f <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10077f:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100783:	31 c0                	xor    %eax,%eax
  100785:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100789:	eb 01                	jmp    10078c <strnlen+0xd>
		++n;
  10078b:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10078c:	39 d0                	cmp    %edx,%eax
  10078e:	74 06                	je     100796 <strnlen+0x17>
  100790:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100794:	75 f5                	jne    10078b <strnlen+0xc>
		++n;
	return n;
}
  100796:	c3                   	ret    

00100797 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100797:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100798:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10079d:	53                   	push   %ebx
  10079e:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007a0:	76 05                	jbe    1007a7 <console_putc+0x10>
  1007a2:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007a7:	80 fa 0a             	cmp    $0xa,%dl
  1007aa:	75 2c                	jne    1007d8 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007ac:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007b2:	be 50 00 00 00       	mov    $0x50,%esi
  1007b7:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007b9:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007bc:	99                   	cltd   
  1007bd:	f7 fe                	idiv   %esi
  1007bf:	89 de                	mov    %ebx,%esi
  1007c1:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007c3:	eb 07                	jmp    1007cc <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007c5:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007c8:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007c9:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007cc:	83 f8 50             	cmp    $0x50,%eax
  1007cf:	75 f4                	jne    1007c5 <console_putc+0x2e>
  1007d1:	29 d0                	sub    %edx,%eax
  1007d3:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1007d6:	eb 0b                	jmp    1007e3 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1007d8:	0f b6 d2             	movzbl %dl,%edx
  1007db:	09 ca                	or     %ecx,%edx
  1007dd:	66 89 13             	mov    %dx,(%ebx)
  1007e0:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1007e3:	5b                   	pop    %ebx
  1007e4:	5e                   	pop    %esi
  1007e5:	c3                   	ret    

001007e6 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1007e6:	56                   	push   %esi
  1007e7:	53                   	push   %ebx
  1007e8:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1007ec:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1007ef:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1007f3:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1007f8:	75 04                	jne    1007fe <fill_numbuf+0x18>
  1007fa:	85 d2                	test   %edx,%edx
  1007fc:	74 10                	je     10080e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1007fe:	89 d0                	mov    %edx,%eax
  100800:	31 d2                	xor    %edx,%edx
  100802:	f7 f1                	div    %ecx
  100804:	4b                   	dec    %ebx
  100805:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100808:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10080a:	89 c2                	mov    %eax,%edx
  10080c:	eb ec                	jmp    1007fa <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10080e:	89 d8                	mov    %ebx,%eax
  100810:	5b                   	pop    %ebx
  100811:	5e                   	pop    %esi
  100812:	c3                   	ret    

00100813 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100813:	55                   	push   %ebp
  100814:	57                   	push   %edi
  100815:	56                   	push   %esi
  100816:	53                   	push   %ebx
  100817:	83 ec 38             	sub    $0x38,%esp
  10081a:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10081e:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100822:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100826:	e9 60 03 00 00       	jmp    100b8b <console_vprintf+0x378>
		if (*format != '%') {
  10082b:	80 fa 25             	cmp    $0x25,%dl
  10082e:	74 13                	je     100843 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100830:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100834:	0f b6 d2             	movzbl %dl,%edx
  100837:	89 f0                	mov    %esi,%eax
  100839:	e8 59 ff ff ff       	call   100797 <console_putc>
  10083e:	e9 45 03 00 00       	jmp    100b88 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100843:	47                   	inc    %edi
  100844:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10084b:	00 
  10084c:	eb 12                	jmp    100860 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10084e:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10084f:	8a 11                	mov    (%ecx),%dl
  100851:	84 d2                	test   %dl,%dl
  100853:	74 1a                	je     10086f <console_vprintf+0x5c>
  100855:	89 e8                	mov    %ebp,%eax
  100857:	38 c2                	cmp    %al,%dl
  100859:	75 f3                	jne    10084e <console_vprintf+0x3b>
  10085b:	e9 3f 03 00 00       	jmp    100b9f <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100860:	8a 17                	mov    (%edi),%dl
  100862:	84 d2                	test   %dl,%dl
  100864:	74 0b                	je     100871 <console_vprintf+0x5e>
  100866:	b9 38 0c 10 00       	mov    $0x100c38,%ecx
  10086b:	89 d5                	mov    %edx,%ebp
  10086d:	eb e0                	jmp    10084f <console_vprintf+0x3c>
  10086f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100871:	8d 42 cf             	lea    -0x31(%edx),%eax
  100874:	3c 08                	cmp    $0x8,%al
  100876:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10087d:	00 
  10087e:	76 13                	jbe    100893 <console_vprintf+0x80>
  100880:	eb 1d                	jmp    10089f <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100882:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100887:	0f be c0             	movsbl %al,%eax
  10088a:	47                   	inc    %edi
  10088b:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10088f:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100893:	8a 07                	mov    (%edi),%al
  100895:	8d 50 d0             	lea    -0x30(%eax),%edx
  100898:	80 fa 09             	cmp    $0x9,%dl
  10089b:	76 e5                	jbe    100882 <console_vprintf+0x6f>
  10089d:	eb 18                	jmp    1008b7 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10089f:	80 fa 2a             	cmp    $0x2a,%dl
  1008a2:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008a9:	ff 
  1008aa:	75 0b                	jne    1008b7 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008ac:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008af:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008b0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008b3:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008b7:	83 cd ff             	or     $0xffffffff,%ebp
  1008ba:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008bd:	75 37                	jne    1008f6 <console_vprintf+0xe3>
			++format;
  1008bf:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008c0:	31 ed                	xor    %ebp,%ebp
  1008c2:	8a 07                	mov    (%edi),%al
  1008c4:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008c7:	80 fa 09             	cmp    $0x9,%dl
  1008ca:	76 0d                	jbe    1008d9 <console_vprintf+0xc6>
  1008cc:	eb 17                	jmp    1008e5 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008ce:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1008d1:	0f be c0             	movsbl %al,%eax
  1008d4:	47                   	inc    %edi
  1008d5:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1008d9:	8a 07                	mov    (%edi),%al
  1008db:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008de:	80 fa 09             	cmp    $0x9,%dl
  1008e1:	76 eb                	jbe    1008ce <console_vprintf+0xbb>
  1008e3:	eb 11                	jmp    1008f6 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1008e5:	3c 2a                	cmp    $0x2a,%al
  1008e7:	75 0b                	jne    1008f4 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1008e9:	83 c3 04             	add    $0x4,%ebx
				++format;
  1008ec:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1008ed:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1008f0:	85 ed                	test   %ebp,%ebp
  1008f2:	79 02                	jns    1008f6 <console_vprintf+0xe3>
  1008f4:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1008f6:	8a 07                	mov    (%edi),%al
  1008f8:	3c 64                	cmp    $0x64,%al
  1008fa:	74 34                	je     100930 <console_vprintf+0x11d>
  1008fc:	7f 1d                	jg     10091b <console_vprintf+0x108>
  1008fe:	3c 58                	cmp    $0x58,%al
  100900:	0f 84 a2 00 00 00    	je     1009a8 <console_vprintf+0x195>
  100906:	3c 63                	cmp    $0x63,%al
  100908:	0f 84 bf 00 00 00    	je     1009cd <console_vprintf+0x1ba>
  10090e:	3c 43                	cmp    $0x43,%al
  100910:	0f 85 d0 00 00 00    	jne    1009e6 <console_vprintf+0x1d3>
  100916:	e9 a3 00 00 00       	jmp    1009be <console_vprintf+0x1ab>
  10091b:	3c 75                	cmp    $0x75,%al
  10091d:	74 4d                	je     10096c <console_vprintf+0x159>
  10091f:	3c 78                	cmp    $0x78,%al
  100921:	74 5c                	je     10097f <console_vprintf+0x16c>
  100923:	3c 73                	cmp    $0x73,%al
  100925:	0f 85 bb 00 00 00    	jne    1009e6 <console_vprintf+0x1d3>
  10092b:	e9 86 00 00 00       	jmp    1009b6 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100930:	83 c3 04             	add    $0x4,%ebx
  100933:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100936:	89 d1                	mov    %edx,%ecx
  100938:	c1 f9 1f             	sar    $0x1f,%ecx
  10093b:	89 0c 24             	mov    %ecx,(%esp)
  10093e:	31 ca                	xor    %ecx,%edx
  100940:	55                   	push   %ebp
  100941:	29 ca                	sub    %ecx,%edx
  100943:	68 40 0c 10 00       	push   $0x100c40
  100948:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10094d:	8d 44 24 40          	lea    0x40(%esp),%eax
  100951:	e8 90 fe ff ff       	call   1007e6 <fill_numbuf>
  100956:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10095a:	58                   	pop    %eax
  10095b:	5a                   	pop    %edx
  10095c:	ba 01 00 00 00       	mov    $0x1,%edx
  100961:	8b 04 24             	mov    (%esp),%eax
  100964:	83 e0 01             	and    $0x1,%eax
  100967:	e9 a5 00 00 00       	jmp    100a11 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10096c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10096f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100974:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100977:	55                   	push   %ebp
  100978:	68 40 0c 10 00       	push   $0x100c40
  10097d:	eb 11                	jmp    100990 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10097f:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100982:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100985:	55                   	push   %ebp
  100986:	68 54 0c 10 00       	push   $0x100c54
  10098b:	b9 10 00 00 00       	mov    $0x10,%ecx
  100990:	8d 44 24 40          	lea    0x40(%esp),%eax
  100994:	e8 4d fe ff ff       	call   1007e6 <fill_numbuf>
  100999:	ba 01 00 00 00       	mov    $0x1,%edx
  10099e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009a2:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009a4:	59                   	pop    %ecx
  1009a5:	59                   	pop    %ecx
  1009a6:	eb 69                	jmp    100a11 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009a8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009ab:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009ae:	55                   	push   %ebp
  1009af:	68 40 0c 10 00       	push   $0x100c40
  1009b4:	eb d5                	jmp    10098b <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009b6:	83 c3 04             	add    $0x4,%ebx
  1009b9:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009bc:	eb 40                	jmp    1009fe <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009be:	83 c3 04             	add    $0x4,%ebx
  1009c1:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009c4:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009c8:	e9 bd 01 00 00       	jmp    100b8a <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009cd:	83 c3 04             	add    $0x4,%ebx
  1009d0:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1009d3:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  1009d7:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  1009dc:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009e0:	88 44 24 24          	mov    %al,0x24(%esp)
  1009e4:	eb 27                	jmp    100a0d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  1009e6:	84 c0                	test   %al,%al
  1009e8:	75 02                	jne    1009ec <console_vprintf+0x1d9>
  1009ea:	b0 25                	mov    $0x25,%al
  1009ec:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  1009f0:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  1009f5:	80 3f 00             	cmpb   $0x0,(%edi)
  1009f8:	74 0a                	je     100a04 <console_vprintf+0x1f1>
  1009fa:	8d 44 24 24          	lea    0x24(%esp),%eax
  1009fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a02:	eb 09                	jmp    100a0d <console_vprintf+0x1fa>
				format--;
  100a04:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a08:	4f                   	dec    %edi
  100a09:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a0d:	31 d2                	xor    %edx,%edx
  100a0f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a11:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a13:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a16:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a1d:	74 1f                	je     100a3e <console_vprintf+0x22b>
  100a1f:	89 04 24             	mov    %eax,(%esp)
  100a22:	eb 01                	jmp    100a25 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a24:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a25:	39 e9                	cmp    %ebp,%ecx
  100a27:	74 0a                	je     100a33 <console_vprintf+0x220>
  100a29:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a2d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a31:	75 f1                	jne    100a24 <console_vprintf+0x211>
  100a33:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a36:	89 0c 24             	mov    %ecx,(%esp)
  100a39:	eb 1f                	jmp    100a5a <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a3b:	42                   	inc    %edx
  100a3c:	eb 09                	jmp    100a47 <console_vprintf+0x234>
  100a3e:	89 d1                	mov    %edx,%ecx
  100a40:	8b 14 24             	mov    (%esp),%edx
  100a43:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a47:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a4b:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a4f:	75 ea                	jne    100a3b <console_vprintf+0x228>
  100a51:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a55:	89 14 24             	mov    %edx,(%esp)
  100a58:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a5a:	85 c0                	test   %eax,%eax
  100a5c:	74 0c                	je     100a6a <console_vprintf+0x257>
  100a5e:	84 d2                	test   %dl,%dl
  100a60:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a67:	00 
  100a68:	75 24                	jne    100a8e <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a6a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a6f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a76:	00 
  100a77:	75 15                	jne    100a8e <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a79:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a7d:	83 e0 08             	and    $0x8,%eax
  100a80:	83 f8 01             	cmp    $0x1,%eax
  100a83:	19 c9                	sbb    %ecx,%ecx
  100a85:	f7 d1                	not    %ecx
  100a87:	83 e1 20             	and    $0x20,%ecx
  100a8a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a8e:	3b 2c 24             	cmp    (%esp),%ebp
  100a91:	7e 0d                	jle    100aa0 <console_vprintf+0x28d>
  100a93:	84 d2                	test   %dl,%dl
  100a95:	74 40                	je     100ad7 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a97:	2b 2c 24             	sub    (%esp),%ebp
  100a9a:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a9e:	eb 3f                	jmp    100adf <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100aa0:	84 d2                	test   %dl,%dl
  100aa2:	74 33                	je     100ad7 <console_vprintf+0x2c4>
  100aa4:	8b 44 24 14          	mov    0x14(%esp),%eax
  100aa8:	83 e0 06             	and    $0x6,%eax
  100aab:	83 f8 02             	cmp    $0x2,%eax
  100aae:	75 27                	jne    100ad7 <console_vprintf+0x2c4>
  100ab0:	45                   	inc    %ebp
  100ab1:	75 24                	jne    100ad7 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ab3:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ab5:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ab8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100abd:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ac0:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100ac3:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100ac7:	7d 0e                	jge    100ad7 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100ac9:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100acd:	29 ca                	sub    %ecx,%edx
  100acf:	29 c2                	sub    %eax,%edx
  100ad1:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ad5:	eb 08                	jmp    100adf <console_vprintf+0x2cc>
  100ad7:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100ade:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100adf:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100ae3:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100ae5:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100ae9:	2b 2c 24             	sub    (%esp),%ebp
  100aec:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100af1:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100af4:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100af7:	29 c5                	sub    %eax,%ebp
  100af9:	89 f0                	mov    %esi,%eax
  100afb:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b03:	eb 0f                	jmp    100b14 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b05:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b09:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b0e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b0f:	e8 83 fc ff ff       	call   100797 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b14:	85 ed                	test   %ebp,%ebp
  100b16:	7e 07                	jle    100b1f <console_vprintf+0x30c>
  100b18:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b1d:	74 e6                	je     100b05 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b1f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b24:	89 c6                	mov    %eax,%esi
  100b26:	74 23                	je     100b4b <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b28:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b2d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b31:	e8 61 fc ff ff       	call   100797 <console_putc>
  100b36:	89 c6                	mov    %eax,%esi
  100b38:	eb 11                	jmp    100b4b <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b3a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b3e:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b43:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b44:	e8 4e fc ff ff       	call   100797 <console_putc>
  100b49:	eb 06                	jmp    100b51 <console_vprintf+0x33e>
  100b4b:	89 f0                	mov    %esi,%eax
  100b4d:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b51:	85 f6                	test   %esi,%esi
  100b53:	7f e5                	jg     100b3a <console_vprintf+0x327>
  100b55:	8b 34 24             	mov    (%esp),%esi
  100b58:	eb 15                	jmp    100b6f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b5a:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b5e:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b5f:	0f b6 11             	movzbl (%ecx),%edx
  100b62:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b66:	e8 2c fc ff ff       	call   100797 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b6b:	ff 44 24 04          	incl   0x4(%esp)
  100b6f:	85 f6                	test   %esi,%esi
  100b71:	7f e7                	jg     100b5a <console_vprintf+0x347>
  100b73:	eb 0f                	jmp    100b84 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b75:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b79:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b7e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b7f:	e8 13 fc ff ff       	call   100797 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b84:	85 ed                	test   %ebp,%ebp
  100b86:	7f ed                	jg     100b75 <console_vprintf+0x362>
  100b88:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b8a:	47                   	inc    %edi
  100b8b:	8a 17                	mov    (%edi),%dl
  100b8d:	84 d2                	test   %dl,%dl
  100b8f:	0f 85 96 fc ff ff    	jne    10082b <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b95:	83 c4 38             	add    $0x38,%esp
  100b98:	89 f0                	mov    %esi,%eax
  100b9a:	5b                   	pop    %ebx
  100b9b:	5e                   	pop    %esi
  100b9c:	5f                   	pop    %edi
  100b9d:	5d                   	pop    %ebp
  100b9e:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b9f:	81 e9 38 0c 10 00    	sub    $0x100c38,%ecx
  100ba5:	b8 01 00 00 00       	mov    $0x1,%eax
  100baa:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100bac:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bad:	09 44 24 14          	or     %eax,0x14(%esp)
  100bb1:	e9 aa fc ff ff       	jmp    100860 <console_vprintf+0x4d>

00100bb6 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100bb6:	8d 44 24 10          	lea    0x10(%esp),%eax
  100bba:	50                   	push   %eax
  100bbb:	ff 74 24 10          	pushl  0x10(%esp)
  100bbf:	ff 74 24 10          	pushl  0x10(%esp)
  100bc3:	ff 74 24 10          	pushl  0x10(%esp)
  100bc7:	e8 47 fc ff ff       	call   100813 <console_vprintf>
  100bcc:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100bcf:	c3                   	ret    
