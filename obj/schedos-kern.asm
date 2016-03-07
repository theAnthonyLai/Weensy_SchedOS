
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
  100014:	e8 bb 03 00 00       	call   1003d4 <start>
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
  10006d:	e8 c9 02 00 00       	call   10033b <interrupt>

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
  10009d:	89 e5                	mov    %esp,%ebp
  10009f:	57                   	push   %edi
  1000a0:	56                   	push   %esi
  1000a1:	53                   	push   %ebx
  1000a2:	83 ec 2c             	sub    $0x2c,%esp
	pid_t pid = current->p_pid;
  1000a5:	a1 94 78 10 00       	mov    0x107894,%eax
  1000aa:	8b 10                	mov    (%eax),%edx
	uint32_t seed;
	unsigned int lotteryTotal;
	unsigned int lotteryNum;
	unsigned int proc_lottery[NPROCS];

	if (scheduling_algorithm == 0) {
  1000ac:	a1 98 78 10 00       	mov    0x107898,%eax
  1000b1:	85 c0                	test   %eax,%eax
  1000b3:	75 19                	jne    1000ce <schedule+0x32>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b5:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000ba:	8d 42 01             	lea    0x1(%edx),%eax
  1000bd:	99                   	cltd   
  1000be:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000c0:	6b c2 60             	imul   $0x60,%edx,%eax
  1000c3:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1000ca:	75 ee                	jne    1000ba <schedule+0x1e>
  1000cc:	eb 1b                	jmp    1000e9 <schedule+0x4d>
				run(&proc_array[pid]);
		}
	} else if (scheduling_algorithm == __EXERCISE_2__) {
  1000ce:	83 f8 02             	cmp    $0x2,%eax
  1000d1:	75 2b                	jne    1000fe <schedule+0x62>
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
  1000e0:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1000e7:	75 0d                	jne    1000f6 <schedule+0x5a>
				run(&proc_array[pid]);
  1000e9:	83 ec 0c             	sub    $0xc,%esp
  1000ec:	05 4c 6e 10 00       	add    $0x106e4c,%eax
  1000f1:	e9 8d 00 00 00       	jmp    100183 <schedule+0xe7>
			pid = (pid + 1) % NPROCS;
  1000f6:	8d 42 01             	lea    0x1(%edx),%eax
  1000f9:	99                   	cltd   
  1000fa:	f7 f9                	idiv   %ecx
		}
  1000fc:	eb df                	jmp    1000dd <schedule+0x41>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000fe:	83 f8 29             	cmp    $0x29,%eax
  100101:	75 57                	jne    10015a <schedule+0xbe>
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100103:	bf 05 00 00 00       	mov    $0x5,%edi
		}
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
  100108:	6b c2 60             	imul   $0x60,%edx,%eax
  10010b:	89 d6                	mov    %edx,%esi
  10010d:	31 c9                	xor    %ecx,%ecx
  10010f:	8b 98 94 6e 10 00    	mov    0x106e94(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100115:	8d 42 01             	lea    0x1(%edx),%eax
  100118:	99                   	cltd   
  100119:	f7 ff                	idiv   %edi
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  10011b:	6b c2 60             	imul   $0x60,%edx,%eax
  10011e:	05 54 6e 10 00       	add    $0x106e54,%eax
  100123:	83 78 50 01          	cmpl   $0x1,0x50(%eax)
  100127:	75 0b                	jne    100134 <schedule+0x98>
  100129:	8b 40 40             	mov    0x40(%eax),%eax
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
  10013e:	eb d5                	jmp    100115 <schedule+0x79>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  100140:	6b f6 60             	imul   $0x60,%esi,%esi
  100143:	83 be a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%esi)
  10014a:	75 bc                	jne    100108 <schedule+0x6c>
		run(&proc_array[firstPid]);
  10014c:	83 ec 0c             	sub    $0xc,%esp
  10014f:	81 c6 4c 6e 10 00    	add    $0x106e4c,%esi
  100155:	e9 c1 00 00 00       	jmp    10021b <schedule+0x17f>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  10015a:	83 f8 2a             	cmp    $0x2a,%eax
  10015d:	0f 85 ed 00 00 00    	jne    100250 <schedule+0x1b4>
		if (proc_array[pid].p_share_left > 0 && proc_array[pid].p_state == P_RUNNABLE) {
  100163:	6b da 60             	imul   $0x60,%edx,%ebx
  100166:	8d 83 4c 6e 10 00    	lea    0x106e4c(%ebx),%eax
  10016c:	8b 48 50             	mov    0x50(%eax),%ecx
  10016f:	85 c9                	test   %ecx,%ecx
  100171:	74 34                	je     1001a7 <schedule+0x10b>
  100173:	83 bb a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%ebx)
  10017a:	75 2b                	jne    1001a7 <schedule+0x10b>
			proc_array[pid].p_share_left--;
  10017c:	49                   	dec    %ecx
			run(&proc_array[pid]);
  10017d:	83 ec 0c             	sub    $0xc,%esp
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
		run(&proc_array[firstPid]);
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
		if (proc_array[pid].p_share_left > 0 && proc_array[pid].p_state == P_RUNNABLE) {
			proc_array[pid].p_share_left--;
  100180:	89 48 50             	mov    %ecx,0x50(%eax)
			run(&proc_array[pid]);
  100183:	50                   	push   %eax
  100184:	e9 8c 01 00 00       	jmp    100315 <schedule+0x279>
		} else {
			while(1) {
				// first find a process that's runnable
				for (i = 0; i < NPROCS - 1; i++) {
					pid = (pid + 1) % NPROCS;
  100189:	8d 42 01             	lea    0x1(%edx),%eax
  10018c:	99                   	cltd   
  10018d:	f7 fb                	idiv   %ebx
					if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0)
  10018f:	6b c2 60             	imul   $0x60,%edx,%eax
  100192:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  100199:	75 09                	jne    1001a4 <schedule+0x108>
  10019b:	83 b8 9c 6e 10 00 00 	cmpl   $0x0,0x106e9c(%eax)
  1001a2:	75 0f                	jne    1001b3 <schedule+0x117>
			proc_array[pid].p_share_left--;
			run(&proc_array[pid]);
		} else {
			while(1) {
				// first find a process that's runnable
				for (i = 0; i < NPROCS - 1; i++) {
  1001a4:	41                   	inc    %ecx
  1001a5:	eb 07                	jmp    1001ae <schedule+0x112>
  1001a7:	31 c9                	xor    %ecx,%ecx
					pid = (pid + 1) % NPROCS;
  1001a9:	bb 05 00 00 00       	mov    $0x5,%ebx
			proc_array[pid].p_share_left--;
			run(&proc_array[pid]);
		} else {
			while(1) {
				// first find a process that's runnable
				for (i = 0; i < NPROCS - 1; i++) {
  1001ae:	83 f9 03             	cmp    $0x3,%ecx
  1001b1:	7e d6                	jle    100189 <schedule+0xed>
					pid = (pid + 1) % NPROCS;
					if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0)
						break;
				}
				
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0) {
  1001b3:	6b c2 60             	imul   $0x60,%edx,%eax
  1001b6:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1001bd:	75 62                	jne    100221 <schedule+0x185>
  1001bf:	83 b8 9c 6e 10 00 00 	cmpl   $0x0,0x106e9c(%eax)
  1001c6:	74 59                	je     100221 <schedule+0x185>
					// there's at least one runnalbe, check share priority
					firstPid = pid;
					firstPriority = proc_array[pid].p_share_amt;
  1001c8:	8b 98 98 6e 10 00    	mov    0x106e98(%eax),%ebx
  1001ce:	89 d6                	mov    %edx,%esi
  1001d0:	31 c9                	xor    %ecx,%ecx
					
					for (i = 0; i < NPROCS - 1; i++) {
						pid = (pid + 1) % NPROCS;
  1001d2:	bf 05 00 00 00       	mov    $0x5,%edi
  1001d7:	8d 42 01             	lea    0x1(%edx),%eax
  1001da:	99                   	cltd   
  1001db:	f7 ff                	idiv   %edi
						if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0 && proc_array[pid].p_share_amt > firstPriority) {
  1001dd:	6b c2 60             	imul   $0x60,%edx,%eax
  1001e0:	83 b8 a4 6e 10 00 01 	cmpl   $0x1,0x106ea4(%eax)
  1001e7:	75 17                	jne    100200 <schedule+0x164>
  1001e9:	83 b8 9c 6e 10 00 00 	cmpl   $0x0,0x106e9c(%eax)
  1001f0:	74 0e                	je     100200 <schedule+0x164>
  1001f2:	8b 80 98 6e 10 00    	mov    0x106e98(%eax),%eax
  1001f8:	39 d8                	cmp    %ebx,%eax
  1001fa:	76 04                	jbe    100200 <schedule+0x164>
  1001fc:	89 d6                	mov    %edx,%esi
  1001fe:	eb 02                	jmp    100202 <schedule+0x166>
  100200:	89 d8                	mov    %ebx,%eax
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_left > 0) {
					// there's at least one runnalbe, check share priority
					firstPid = pid;
					firstPriority = proc_array[pid].p_share_amt;
					
					for (i = 0; i < NPROCS - 1; i++) {
  100202:	41                   	inc    %ecx
  100203:	83 f9 04             	cmp    $0x4,%ecx
  100206:	74 04                	je     10020c <schedule+0x170>
  100208:	89 c3                	mov    %eax,%ebx
  10020a:	eb cb                	jmp    1001d7 <schedule+0x13b>
							firstPid = pid;
							firstPriority = proc_array[pid].p_share_amt;
						}
					}
					
					proc_array[firstPid].p_share_left--;
  10020c:	6b f6 60             	imul   $0x60,%esi,%esi
					run(&proc_array[firstPid]);
  10020f:	83 ec 0c             	sub    $0xc,%esp
							firstPid = pid;
							firstPriority = proc_array[pid].p_share_amt;
						}
					}
					
					proc_array[firstPid].p_share_left--;
  100212:	81 c6 4c 6e 10 00    	add    $0x106e4c,%esi
  100218:	ff 4e 50             	decl   0x50(%esi)
					run(&proc_array[firstPid]);
  10021b:	56                   	push   %esi
  10021c:	e9 f4 00 00 00       	jmp    100315 <schedule+0x279>
				} else {
					// nothing runnable
					// reset p_share_left
					for (i = 1; i < NPROCS; i++)
						proc_array[i].p_share_left = proc_array[i].p_share_amt;
  100221:	a1 f8 6e 10 00       	mov    0x106ef8,%eax
  100226:	31 c9                	xor    %ecx,%ecx
  100228:	a3 fc 6e 10 00       	mov    %eax,0x106efc
  10022d:	a1 58 6f 10 00       	mov    0x106f58,%eax
  100232:	a3 5c 6f 10 00       	mov    %eax,0x106f5c
  100237:	a1 b8 6f 10 00       	mov    0x106fb8,%eax
  10023c:	a3 bc 6f 10 00       	mov    %eax,0x106fbc
  100241:	a1 18 70 10 00       	mov    0x107018,%eax
  100246:	a3 1c 70 10 00       	mov    %eax,0x10701c
  10024b:	e9 39 ff ff ff       	jmp    100189 <schedule+0xed>
				
				//if (proc_array[firstPid].p_state == P_RUNNABLE && proc_array[firstPid]
			}
		}

	} else if (scheduling_algorithm == __EXERCISE_7__) {
  100250:	83 f8 07             	cmp    $0x7,%eax
  100253:	0f 85 c1 00 00 00    	jne    10031a <schedule+0x27e>

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  100259:	a1 c4 6f 10 00       	mov    0x106fc4,%eax
		}

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  10025e:	8b 1d 00 6f 10 00    	mov    0x106f00,%ebx
			lotteryTotal += proc_array[i].p_lottery_amt;
  100264:	8b 0d a0 6e 10 00    	mov    0x106ea0,%ecx
		}

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
  10026a:	8b 15 60 6f 10 00    	mov    0x106f60,%edx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  100270:	89 45 d4             	mov    %eax,-0x2c(%ebp)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  100273:	a1 24 70 10 00       	mov    0x107024,%eax
			seed ^= seed << 7 & 0xffffffff;
			seed ^= seed << 15 & 0x9d2c5680;
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  100278:	8b 35 04 6f 10 00    	mov    0x106f04,%esi

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  10027e:	01 d9                	add    %ebx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  100280:	8b 3d 64 6f 10 00    	mov    0x106f64,%edi

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  100286:	01 d1                	add    %edx,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  100288:	01 da                	add    %ebx,%edx
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
				run(&proc_array[3]);
			else if (proc_array[4].p_state == P_RUNNABLE)
  10028a:	89 45 e0             	mov    %eax,-0x20(%ebp)

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  10028d:	a1 c0 6f 10 00       	mov    0x106fc0,%eax

	} else if (scheduling_algorithm == __EXERCISE_7__) {
		lotteryTotal = 0;
		for (i = 0; i < NPROCS; i++) {
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
  100292:	03 0d c0 6f 10 00    	add    0x106fc0,%ecx
  100298:	03 0d 20 70 10 00    	add    0x107020,%ecx
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
				run(&proc_array[1]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  10029e:	89 55 dc             	mov    %edx,-0x24(%ebp)
				run(&proc_array[2]);
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002a1:	01 d0                	add    %edx,%eax
  1002a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)

static inline uint64_t
read_cycle_counter(void)
{
        uint64_t tsc;
        asm volatile("rdtsc" : "=A" (tsc));
  1002a6:	0f 31                	rdtsc  
			proc_lottery[i] = proc_array[i].p_lottery_amt;
			lotteryTotal += proc_array[i].p_lottery_amt;
		}
		
		while (1) {
			seed = (uint32_t) read_cycle_counter();
  1002a8:	89 c2                	mov    %eax,%edx
			//seed ^= seed << 15 & 0xEFC60000;
			//seed ^= seed >> 18;
			/**************
			Reference from en.cppreference.com/w/app/numeric/random
			**************/
			seed ^= seed >> 11 & 0x9908b0df;
  1002aa:	c1 e8 0b             	shr    $0xb,%eax
  1002ad:	25 df b0 08 99       	and    $0x9908b0df,%eax
  1002b2:	31 d0                	xor    %edx,%eax
			seed ^= seed << 7 & 0xffffffff;
  1002b4:	89 c2                	mov    %eax,%edx
  1002b6:	c1 e2 07             	shl    $0x7,%edx
  1002b9:	31 c2                	xor    %eax,%edx
			seed ^= seed << 15 & 0x9d2c5680;
  1002bb:	89 d0                	mov    %edx,%eax
  1002bd:	c1 e0 0f             	shl    $0xf,%eax
  1002c0:	25 80 56 2c 9d       	and    $0x9d2c5680,%eax
			seed ^= seed >> 18 & 0xefc60000;
			lotteryNum = seed % lotteryTotal;
  1002c5:	31 d0                	xor    %edx,%eax
  1002c7:	31 d2                	xor    %edx,%edx
  1002c9:	f7 f1                	div    %ecx

			if (lotteryNum < proc_lottery[1] && proc_array[1].p_state == P_RUNNABLE)
  1002cb:	39 da                	cmp    %ebx,%edx
  1002cd:	73 0f                	jae    1002de <schedule+0x242>
  1002cf:	83 fe 01             	cmp    $0x1,%esi
  1002d2:	75 0a                	jne    1002de <schedule+0x242>
				run(&proc_array[1]);
  1002d4:	83 ec 0c             	sub    $0xc,%esp
  1002d7:	68 ac 6e 10 00       	push   $0x106eac
  1002dc:	eb 37                	jmp    100315 <schedule+0x279>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]) && proc_array[2].p_state == P_RUNNABLE)
  1002de:	3b 55 dc             	cmp    -0x24(%ebp),%edx
  1002e1:	73 0f                	jae    1002f2 <schedule+0x256>
  1002e3:	83 ff 01             	cmp    $0x1,%edi
  1002e6:	75 0a                	jne    1002f2 <schedule+0x256>
				run(&proc_array[2]);
  1002e8:	83 ec 0c             	sub    $0xc,%esp
  1002eb:	68 0c 6f 10 00       	push   $0x106f0c
  1002f0:	eb 23                	jmp    100315 <schedule+0x279>
			else if (lotteryNum < (proc_lottery[1]+proc_lottery[2]+proc_lottery[3]) && proc_array[3].p_state == P_RUNNABLE)
  1002f2:	3b 55 e4             	cmp    -0x1c(%ebp),%edx
  1002f5:	73 10                	jae    100307 <schedule+0x26b>
  1002f7:	83 7d d4 01          	cmpl   $0x1,-0x2c(%ebp)
  1002fb:	75 0a                	jne    100307 <schedule+0x26b>
				run(&proc_array[3]);
  1002fd:	83 ec 0c             	sub    $0xc,%esp
  100300:	68 6c 6f 10 00       	push   $0x106f6c
  100305:	eb 0e                	jmp    100315 <schedule+0x279>
			else if (proc_array[4].p_state == P_RUNNABLE)
  100307:	83 7d e0 01          	cmpl   $0x1,-0x20(%ebp)
  10030b:	75 99                	jne    1002a6 <schedule+0x20a>
				run(&proc_array[4]);
  10030d:	83 ec 0c             	sub    $0xc,%esp
  100310:	68 cc 6f 10 00       	push   $0x106fcc
  100315:	e8 eb 03 00 00       	call   100705 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10031a:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100320:	50                   	push   %eax
  100321:	68 c4 0c 10 00       	push   $0x100cc4
  100326:	68 00 01 00 00       	push   $0x100
  10032b:	52                   	push   %edx
  10032c:	e8 79 09 00 00       	call   100caa <console_printf>
  100331:	83 c4 10             	add    $0x10,%esp
  100334:	a3 00 80 19 00       	mov    %eax,0x198000
  100339:	eb fe                	jmp    100339 <schedule+0x29d>

0010033b <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10033b:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10033c:	8b 3d 94 78 10 00    	mov    0x107894,%edi
  100342:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100347:	56                   	push   %esi
  100348:	53                   	push   %ebx
  100349:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10034d:	83 c7 04             	add    $0x4,%edi
  100350:	89 de                	mov    %ebx,%esi
  100352:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100354:	8b 43 28             	mov    0x28(%ebx),%eax
  100357:	83 e8 20             	sub    $0x20,%eax
  10035a:	83 f8 15             	cmp    $0x15,%eax
  10035d:	77 73                	ja     1003d2 <interrupt+0x97>
  10035f:	ff 24 85 e8 0c 10 00 	jmp    *0x100ce8(,%eax,4)

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100366:	e8 31 fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10036b:	a1 94 78 10 00       	mov    0x107894,%eax
		current->p_exit_status = reg->reg_eax;
  100370:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100373:	c7 40 58 03 00 00 00 	movl   $0x3,0x58(%eax)
		current->p_exit_status = reg->reg_eax;
  10037a:	89 50 5c             	mov    %edx,0x5c(%eax)
		schedule();
  10037d:	e8 1a fd ff ff       	call   10009c <schedule>
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_priority = reg->reg_eax;
  100382:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100385:	a1 94 78 10 00       	mov    0x107894,%eax
  10038a:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  10038d:	e8 0a fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  100392:	a1 94 78 10 00       	mov    0x107894,%eax
  100397:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10039a:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  10039d:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  1003a0:	e8 f7 fc ff ff       	call   10009c <schedule>
	
	case INT_SYS_LOTTERY:
		//cursorpos = console_printf(cursorpos, 0x100, "eax is %d\n", reg->reg_eax);
		current->p_lottery_amt = reg->reg_eax;
  1003a5:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003a8:	a1 94 78 10 00       	mov    0x107894,%eax
  1003ad:	89 50 54             	mov    %edx,0x54(%eax)
		schedule();
  1003b0:	e8 e7 fc ff ff       	call   10009c <schedule>
	
	case INT_SYS_PRINT:
		*cursorpos++ = reg->reg_eax;
  1003b5:	a1 00 80 19 00       	mov    0x198000,%eax
  1003ba:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003bd:	66 89 10             	mov    %dx,(%eax)
  1003c0:	83 c0 02             	add    $0x2,%eax
  1003c3:	a3 00 80 19 00       	mov    %eax,0x198000
		schedule();
  1003c8:	e8 cf fc ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1003cd:	e8 ca fc ff ff       	call   10009c <schedule>
  1003d2:	eb fe                	jmp    1003d2 <interrupt+0x97>

001003d4 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1003d4:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003d5:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1003da:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003db:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1003dd:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003de:	bb ac 6e 10 00       	mov    $0x106eac,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1003e3:	e8 fc 00 00 00       	call   1004e4 <segments_init>
	interrupt_controller_init(0);
  1003e8:	83 ec 0c             	sub    $0xc,%esp
  1003eb:	6a 00                	push   $0x0
  1003ed:	e8 ed 01 00 00       	call   1005df <interrupt_controller_init>
	//interrupt_controller_init(1);
	console_clear();
  1003f2:	e8 71 02 00 00       	call   100668 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1003f7:	83 c4 0c             	add    $0xc,%esp
  1003fa:	68 e0 01 00 00       	push   $0x1e0
  1003ff:	6a 00                	push   $0x0
  100401:	68 4c 6e 10 00       	push   $0x106e4c
  100406:	e8 3d 04 00 00       	call   100848 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10040b:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10040e:	c7 05 4c 6e 10 00 00 	movl   $0x0,0x106e4c
  100415:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100418:	c7 05 a4 6e 10 00 00 	movl   $0x0,0x106ea4
  10041f:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100422:	c7 05 ac 6e 10 00 01 	movl   $0x1,0x106eac
  100429:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10042c:	c7 05 04 6f 10 00 00 	movl   $0x0,0x106f04
  100433:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100436:	c7 05 0c 6f 10 00 02 	movl   $0x2,0x106f0c
  10043d:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100440:	c7 05 64 6f 10 00 00 	movl   $0x0,0x106f64
  100447:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10044a:	c7 05 6c 6f 10 00 03 	movl   $0x3,0x106f6c
  100451:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100454:	c7 05 c4 6f 10 00 00 	movl   $0x0,0x106fc4
  10045b:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10045e:	c7 05 cc 6f 10 00 04 	movl   $0x4,0x106fcc
  100465:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100468:	c7 05 24 70 10 00 00 	movl   $0x0,0x107024
  10046f:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100472:	83 ec 0c             	sub    $0xc,%esp
  100475:	53                   	push   %ebx
  100476:	e8 a1 02 00 00       	call   10071c <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10047b:	58                   	pop    %eax
  10047c:	5a                   	pop    %edx
  10047d:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100480:	89 7b 40             	mov    %edi,0x40(%ebx)
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  100483:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100489:	50                   	push   %eax
  10048a:	56                   	push   %esi
		proc->p_share_amt = 1;
		proc->p_share_left = 1;

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  10048b:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10048c:	e8 c7 02 00 00       	call   100758 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100491:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100494:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)

		// Exercise 4B test
		// preset everyone to 1 so everyone can start
		proc->p_share_amt = 1;
  10049b:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
		proc->p_share_left = 1;
  1004a2:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)

		// Exercise 7 test
		// preset everyone to 1 so everyone can start
		proc->p_lottery_amt = 1;
  1004a9:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  1004b0:	83 c3 60             	add    $0x60,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1004b3:	83 fe 04             	cmp    $0x4,%esi
  1004b6:	75 ba                	jne    100472 <start+0x9e>
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  1004b8:	83 ec 0c             	sub    $0xc,%esp
  1004bb:	68 ac 6e 10 00       	push   $0x106eac
		proc->p_lottery_amt = 1;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1004c0:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004c7:	80 0b 00 
	cursorposLock = 0;	// lock is available
  1004ca:	c7 05 10 80 19 00 00 	movl   $0x0,0x198010
  1004d1:	00 00 00 
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
  1004d4:	c7 05 98 78 10 00 2a 	movl   $0x2a,0x107898
  1004db:	00 00 00 
	//scheduling_algorithm = __EXERCISE_7__;

	// Switch to the first process.
	run(&proc_array[1]);
  1004de:	e8 22 02 00 00       	call   100705 <run>
  1004e3:	90                   	nop

001004e4 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004e4:	b8 2c 70 10 00       	mov    $0x10702c,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004e9:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004ee:	89 c2                	mov    %eax,%edx
  1004f0:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1004f3:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004f4:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  1004f9:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004fc:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  100502:	c1 e8 18             	shr    $0x18,%eax
  100505:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10050b:	ba 94 70 10 00       	mov    $0x107094,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100510:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100515:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100517:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10051e:	68 00 
  100520:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100527:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10052e:	c7 05 30 70 10 00 00 	movl   $0x180000,0x107030
  100535:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100538:	66 c7 05 34 70 10 00 	movw   $0x10,0x107034
  10053f:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100541:	66 89 0c c5 94 70 10 	mov    %cx,0x107094(,%eax,8)
  100548:	00 
  100549:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100550:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100555:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  10055a:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10055f:	40                   	inc    %eax
  100560:	3d 00 01 00 00       	cmp    $0x100,%eax
  100565:	75 da                	jne    100541 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100567:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10056c:	ba 94 70 10 00       	mov    $0x107094,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100571:	66 a3 94 71 10 00    	mov    %ax,0x107194
  100577:	c1 e8 10             	shr    $0x10,%eax
  10057a:	66 a3 9a 71 10 00    	mov    %ax,0x10719a
  100580:	b8 30 00 00 00       	mov    $0x30,%eax
  100585:	66 c7 05 96 71 10 00 	movw   $0x8,0x107196
  10058c:	08 00 
  10058e:	c6 05 98 71 10 00 00 	movb   $0x0,0x107198
  100595:	c6 05 99 71 10 00 8e 	movb   $0x8e,0x107199

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  10059c:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1005a3:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1005aa:	66 89 0c c5 94 70 10 	mov    %cx,0x107094(,%eax,8)
  1005b1:	00 
  1005b2:	c1 e9 10             	shr    $0x10,%ecx
  1005b5:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1005ba:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1005bf:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1005c4:	40                   	inc    %eax
  1005c5:	83 f8 3a             	cmp    $0x3a,%eax
  1005c8:	75 d2                	jne    10059c <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1005ca:	b0 28                	mov    $0x28,%al
  1005cc:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  1005d3:	0f 00 d8             	ltr    %ax
  1005d6:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1005dd:	5b                   	pop    %ebx
  1005de:	c3                   	ret    

001005df <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1005df:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1005e0:	b0 ff                	mov    $0xff,%al
  1005e2:	57                   	push   %edi
  1005e3:	56                   	push   %esi
  1005e4:	53                   	push   %ebx
  1005e5:	bb 21 00 00 00       	mov    $0x21,%ebx
  1005ea:	89 da                	mov    %ebx,%edx
  1005ec:	ee                   	out    %al,(%dx)
  1005ed:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1005f2:	89 ca                	mov    %ecx,%edx
  1005f4:	ee                   	out    %al,(%dx)
  1005f5:	be 11 00 00 00       	mov    $0x11,%esi
  1005fa:	bf 20 00 00 00       	mov    $0x20,%edi
  1005ff:	89 f0                	mov    %esi,%eax
  100601:	89 fa                	mov    %edi,%edx
  100603:	ee                   	out    %al,(%dx)
  100604:	b0 20                	mov    $0x20,%al
  100606:	89 da                	mov    %ebx,%edx
  100608:	ee                   	out    %al,(%dx)
  100609:	b0 04                	mov    $0x4,%al
  10060b:	ee                   	out    %al,(%dx)
  10060c:	b0 03                	mov    $0x3,%al
  10060e:	ee                   	out    %al,(%dx)
  10060f:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100614:	89 f0                	mov    %esi,%eax
  100616:	89 ea                	mov    %ebp,%edx
  100618:	ee                   	out    %al,(%dx)
  100619:	b0 28                	mov    $0x28,%al
  10061b:	89 ca                	mov    %ecx,%edx
  10061d:	ee                   	out    %al,(%dx)
  10061e:	b0 02                	mov    $0x2,%al
  100620:	ee                   	out    %al,(%dx)
  100621:	b0 01                	mov    $0x1,%al
  100623:	ee                   	out    %al,(%dx)
  100624:	b0 68                	mov    $0x68,%al
  100626:	89 fa                	mov    %edi,%edx
  100628:	ee                   	out    %al,(%dx)
  100629:	be 0a 00 00 00       	mov    $0xa,%esi
  10062e:	89 f0                	mov    %esi,%eax
  100630:	ee                   	out    %al,(%dx)
  100631:	b0 68                	mov    $0x68,%al
  100633:	89 ea                	mov    %ebp,%edx
  100635:	ee                   	out    %al,(%dx)
  100636:	89 f0                	mov    %esi,%eax
  100638:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100639:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10063e:	89 da                	mov    %ebx,%edx
  100640:	19 c0                	sbb    %eax,%eax
  100642:	f7 d0                	not    %eax
  100644:	05 ff 00 00 00       	add    $0xff,%eax
  100649:	ee                   	out    %al,(%dx)
  10064a:	b0 ff                	mov    $0xff,%al
  10064c:	89 ca                	mov    %ecx,%edx
  10064e:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10064f:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100654:	74 0d                	je     100663 <interrupt_controller_init+0x84>
  100656:	b2 43                	mov    $0x43,%dl
  100658:	b0 34                	mov    $0x34,%al
  10065a:	ee                   	out    %al,(%dx)
  10065b:	b0 a9                	mov    $0xa9,%al
  10065d:	b2 40                	mov    $0x40,%dl
  10065f:	ee                   	out    %al,(%dx)
  100660:	b0 04                	mov    $0x4,%al
  100662:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  100663:	5b                   	pop    %ebx
  100664:	5e                   	pop    %esi
  100665:	5f                   	pop    %edi
  100666:	5d                   	pop    %ebp
  100667:	c3                   	ret    

00100668 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100668:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100669:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  10066b:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  10066c:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100673:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  100676:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10067c:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  100682:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  100685:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  10068a:	75 ea                	jne    100676 <console_clear+0xe>
  10068c:	be d4 03 00 00       	mov    $0x3d4,%esi
  100691:	b0 0e                	mov    $0xe,%al
  100693:	89 f2                	mov    %esi,%edx
  100695:	ee                   	out    %al,(%dx)
  100696:	31 c9                	xor    %ecx,%ecx
  100698:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  10069d:	88 c8                	mov    %cl,%al
  10069f:	89 da                	mov    %ebx,%edx
  1006a1:	ee                   	out    %al,(%dx)
  1006a2:	b0 0f                	mov    $0xf,%al
  1006a4:	89 f2                	mov    %esi,%edx
  1006a6:	ee                   	out    %al,(%dx)
  1006a7:	88 c8                	mov    %cl,%al
  1006a9:	89 da                	mov    %ebx,%edx
  1006ab:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1006ac:	5b                   	pop    %ebx
  1006ad:	5e                   	pop    %esi
  1006ae:	c3                   	ret    

001006af <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1006af:	ba 64 00 00 00       	mov    $0x64,%edx
  1006b4:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1006b5:	a8 01                	test   $0x1,%al
  1006b7:	74 45                	je     1006fe <console_read_digit+0x4f>
  1006b9:	b2 60                	mov    $0x60,%dl
  1006bb:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1006bc:	8d 50 fe             	lea    -0x2(%eax),%edx
  1006bf:	80 fa 08             	cmp    $0x8,%dl
  1006c2:	77 05                	ja     1006c9 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1006c4:	0f b6 c0             	movzbl %al,%eax
  1006c7:	48                   	dec    %eax
  1006c8:	c3                   	ret    
	else if (data == 0x0B)
  1006c9:	3c 0b                	cmp    $0xb,%al
  1006cb:	74 35                	je     100702 <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1006cd:	8d 50 b9             	lea    -0x47(%eax),%edx
  1006d0:	80 fa 02             	cmp    $0x2,%dl
  1006d3:	77 07                	ja     1006dc <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1006d5:	0f b6 c0             	movzbl %al,%eax
  1006d8:	83 e8 40             	sub    $0x40,%eax
  1006db:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1006dc:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1006df:	80 fa 02             	cmp    $0x2,%dl
  1006e2:	77 07                	ja     1006eb <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1006e4:	0f b6 c0             	movzbl %al,%eax
  1006e7:	83 e8 47             	sub    $0x47,%eax
  1006ea:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1006eb:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1006ee:	80 fa 02             	cmp    $0x2,%dl
  1006f1:	77 07                	ja     1006fa <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1006f3:	0f b6 c0             	movzbl %al,%eax
  1006f6:	83 e8 4e             	sub    $0x4e,%eax
  1006f9:	c3                   	ret    
	else if (data == 0x53)
  1006fa:	3c 53                	cmp    $0x53,%al
  1006fc:	74 04                	je     100702 <console_read_digit+0x53>
  1006fe:	83 c8 ff             	or     $0xffffffff,%eax
  100701:	c3                   	ret    
  100702:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100704:	c3                   	ret    

00100705 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100705:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100709:	a3 94 78 10 00       	mov    %eax,0x107894

	asm volatile("movl %0,%%esp\n\t"
  10070e:	83 c0 04             	add    $0x4,%eax
  100711:	89 c4                	mov    %eax,%esp
  100713:	61                   	popa   
  100714:	07                   	pop    %es
  100715:	1f                   	pop    %ds
  100716:	83 c4 08             	add    $0x8,%esp
  100719:	cf                   	iret   
  10071a:	eb fe                	jmp    10071a <run+0x15>

0010071c <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  10071c:	53                   	push   %ebx
  10071d:	83 ec 0c             	sub    $0xc,%esp
  100720:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100724:	6a 44                	push   $0x44
  100726:	6a 00                	push   $0x0
  100728:	8d 43 04             	lea    0x4(%ebx),%eax
  10072b:	50                   	push   %eax
  10072c:	e8 17 01 00 00       	call   100848 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100731:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100737:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  10073d:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  100743:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100749:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100750:	83 c4 18             	add    $0x18,%esp
  100753:	5b                   	pop    %ebx
  100754:	c3                   	ret    
  100755:	90                   	nop
  100756:	90                   	nop
  100757:	90                   	nop

00100758 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100758:	55                   	push   %ebp
  100759:	57                   	push   %edi
  10075a:	56                   	push   %esi
  10075b:	53                   	push   %ebx
  10075c:	83 ec 1c             	sub    $0x1c,%esp
  10075f:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  100763:	83 f8 03             	cmp    $0x3,%eax
  100766:	7f 04                	jg     10076c <program_loader+0x14>
  100768:	85 c0                	test   %eax,%eax
  10076a:	79 02                	jns    10076e <program_loader+0x16>
  10076c:	eb fe                	jmp    10076c <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  10076e:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  100775:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  10077b:	74 02                	je     10077f <program_loader+0x27>
  10077d:	eb fe                	jmp    10077d <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10077f:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  100782:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100786:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100788:	c1 e5 05             	shl    $0x5,%ebp
  10078b:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  10078e:	eb 3f                	jmp    1007cf <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100790:	83 3b 01             	cmpl   $0x1,(%ebx)
  100793:	75 37                	jne    1007cc <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100795:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100798:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  10079b:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10079e:	01 c7                	add    %eax,%edi
	memsz += va;
  1007a0:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1007a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1007a7:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1007ab:	52                   	push   %edx
  1007ac:	89 fa                	mov    %edi,%edx
  1007ae:	29 c2                	sub    %eax,%edx
  1007b0:	52                   	push   %edx
  1007b1:	8b 53 04             	mov    0x4(%ebx),%edx
  1007b4:	01 f2                	add    %esi,%edx
  1007b6:	52                   	push   %edx
  1007b7:	50                   	push   %eax
  1007b8:	e8 27 00 00 00       	call   1007e4 <memcpy>
  1007bd:	83 c4 10             	add    $0x10,%esp
  1007c0:	eb 04                	jmp    1007c6 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1007c2:	c6 07 00             	movb   $0x0,(%edi)
  1007c5:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1007c6:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1007ca:	72 f6                	jb     1007c2 <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1007cc:	83 c3 20             	add    $0x20,%ebx
  1007cf:	39 eb                	cmp    %ebp,%ebx
  1007d1:	72 bd                	jb     100790 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1007d3:	8b 56 18             	mov    0x18(%esi),%edx
  1007d6:	8b 44 24 34          	mov    0x34(%esp),%eax
  1007da:	89 10                	mov    %edx,(%eax)
}
  1007dc:	83 c4 1c             	add    $0x1c,%esp
  1007df:	5b                   	pop    %ebx
  1007e0:	5e                   	pop    %esi
  1007e1:	5f                   	pop    %edi
  1007e2:	5d                   	pop    %ebp
  1007e3:	c3                   	ret    

001007e4 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1007e4:	56                   	push   %esi
  1007e5:	31 d2                	xor    %edx,%edx
  1007e7:	53                   	push   %ebx
  1007e8:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1007ec:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1007f0:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007f4:	eb 08                	jmp    1007fe <memcpy+0x1a>
		*d++ = *s++;
  1007f6:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  1007f9:	4e                   	dec    %esi
  1007fa:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  1007fd:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007fe:	85 f6                	test   %esi,%esi
  100800:	75 f4                	jne    1007f6 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  100802:	5b                   	pop    %ebx
  100803:	5e                   	pop    %esi
  100804:	c3                   	ret    

00100805 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100805:	57                   	push   %edi
  100806:	56                   	push   %esi
  100807:	53                   	push   %ebx
  100808:	8b 44 24 10          	mov    0x10(%esp),%eax
  10080c:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100810:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100814:	39 c7                	cmp    %eax,%edi
  100816:	73 26                	jae    10083e <memmove+0x39>
  100818:	8d 34 17             	lea    (%edi,%edx,1),%esi
  10081b:	39 c6                	cmp    %eax,%esi
  10081d:	76 1f                	jbe    10083e <memmove+0x39>
		s += n, d += n;
  10081f:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  100822:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100824:	eb 07                	jmp    10082d <memmove+0x28>
			*--d = *--s;
  100826:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100829:	4a                   	dec    %edx
  10082a:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  10082d:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10082e:	85 d2                	test   %edx,%edx
  100830:	75 f4                	jne    100826 <memmove+0x21>
  100832:	eb 10                	jmp    100844 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100834:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100837:	4a                   	dec    %edx
  100838:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  10083b:	41                   	inc    %ecx
  10083c:	eb 02                	jmp    100840 <memmove+0x3b>
  10083e:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100840:	85 d2                	test   %edx,%edx
  100842:	75 f0                	jne    100834 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100844:	5b                   	pop    %ebx
  100845:	5e                   	pop    %esi
  100846:	5f                   	pop    %edi
  100847:	c3                   	ret    

00100848 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100848:	53                   	push   %ebx
  100849:	8b 44 24 08          	mov    0x8(%esp),%eax
  10084d:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100851:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100855:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100857:	eb 04                	jmp    10085d <memset+0x15>
		*p++ = c;
  100859:	88 1a                	mov    %bl,(%edx)
  10085b:	49                   	dec    %ecx
  10085c:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  10085d:	85 c9                	test   %ecx,%ecx
  10085f:	75 f8                	jne    100859 <memset+0x11>
		*p++ = c;
	return v;
}
  100861:	5b                   	pop    %ebx
  100862:	c3                   	ret    

00100863 <strlen>:

size_t
strlen(const char *s)
{
  100863:	8b 54 24 04          	mov    0x4(%esp),%edx
  100867:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100869:	eb 01                	jmp    10086c <strlen+0x9>
		++n;
  10086b:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  10086c:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100870:	75 f9                	jne    10086b <strlen+0x8>
		++n;
	return n;
}
  100872:	c3                   	ret    

00100873 <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  100873:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  100877:	31 c0                	xor    %eax,%eax
  100879:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  10087d:	eb 01                	jmp    100880 <strnlen+0xd>
		++n;
  10087f:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100880:	39 d0                	cmp    %edx,%eax
  100882:	74 06                	je     10088a <strnlen+0x17>
  100884:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100888:	75 f5                	jne    10087f <strnlen+0xc>
		++n;
	return n;
}
  10088a:	c3                   	ret    

0010088b <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  10088b:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  10088c:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100891:	53                   	push   %ebx
  100892:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100894:	76 05                	jbe    10089b <console_putc+0x10>
  100896:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  10089b:	80 fa 0a             	cmp    $0xa,%dl
  10089e:	75 2c                	jne    1008cc <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008a0:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1008a6:	be 50 00 00 00       	mov    $0x50,%esi
  1008ab:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1008ad:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008b0:	99                   	cltd   
  1008b1:	f7 fe                	idiv   %esi
  1008b3:	89 de                	mov    %ebx,%esi
  1008b5:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1008b7:	eb 07                	jmp    1008c0 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1008b9:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008bc:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1008bd:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008c0:	83 f8 50             	cmp    $0x50,%eax
  1008c3:	75 f4                	jne    1008b9 <console_putc+0x2e>
  1008c5:	29 d0                	sub    %edx,%eax
  1008c7:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1008ca:	eb 0b                	jmp    1008d7 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1008cc:	0f b6 d2             	movzbl %dl,%edx
  1008cf:	09 ca                	or     %ecx,%edx
  1008d1:	66 89 13             	mov    %dx,(%ebx)
  1008d4:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1008d7:	5b                   	pop    %ebx
  1008d8:	5e                   	pop    %esi
  1008d9:	c3                   	ret    

001008da <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1008da:	56                   	push   %esi
  1008db:	53                   	push   %ebx
  1008dc:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1008e0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1008e3:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1008e7:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1008ec:	75 04                	jne    1008f2 <fill_numbuf+0x18>
  1008ee:	85 d2                	test   %edx,%edx
  1008f0:	74 10                	je     100902 <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1008f2:	89 d0                	mov    %edx,%eax
  1008f4:	31 d2                	xor    %edx,%edx
  1008f6:	f7 f1                	div    %ecx
  1008f8:	4b                   	dec    %ebx
  1008f9:	8a 14 16             	mov    (%esi,%edx,1),%dl
  1008fc:	88 13                	mov    %dl,(%ebx)
			val /= base;
  1008fe:	89 c2                	mov    %eax,%edx
  100900:	eb ec                	jmp    1008ee <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  100902:	89 d8                	mov    %ebx,%eax
  100904:	5b                   	pop    %ebx
  100905:	5e                   	pop    %esi
  100906:	c3                   	ret    

00100907 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100907:	55                   	push   %ebp
  100908:	57                   	push   %edi
  100909:	56                   	push   %esi
  10090a:	53                   	push   %ebx
  10090b:	83 ec 38             	sub    $0x38,%esp
  10090e:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  100912:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100916:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  10091a:	e9 60 03 00 00       	jmp    100c7f <console_vprintf+0x378>
		if (*format != '%') {
  10091f:	80 fa 25             	cmp    $0x25,%dl
  100922:	74 13                	je     100937 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100924:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100928:	0f b6 d2             	movzbl %dl,%edx
  10092b:	89 f0                	mov    %esi,%eax
  10092d:	e8 59 ff ff ff       	call   10088b <console_putc>
  100932:	e9 45 03 00 00       	jmp    100c7c <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100937:	47                   	inc    %edi
  100938:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10093f:	00 
  100940:	eb 12                	jmp    100954 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  100942:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  100943:	8a 11                	mov    (%ecx),%dl
  100945:	84 d2                	test   %dl,%dl
  100947:	74 1a                	je     100963 <console_vprintf+0x5c>
  100949:	89 e8                	mov    %ebp,%eax
  10094b:	38 c2                	cmp    %al,%dl
  10094d:	75 f3                	jne    100942 <console_vprintf+0x3b>
  10094f:	e9 3f 03 00 00       	jmp    100c93 <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100954:	8a 17                	mov    (%edi),%dl
  100956:	84 d2                	test   %dl,%dl
  100958:	74 0b                	je     100965 <console_vprintf+0x5e>
  10095a:	b9 40 0d 10 00       	mov    $0x100d40,%ecx
  10095f:	89 d5                	mov    %edx,%ebp
  100961:	eb e0                	jmp    100943 <console_vprintf+0x3c>
  100963:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  100965:	8d 42 cf             	lea    -0x31(%edx),%eax
  100968:	3c 08                	cmp    $0x8,%al
  10096a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100971:	00 
  100972:	76 13                	jbe    100987 <console_vprintf+0x80>
  100974:	eb 1d                	jmp    100993 <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  100976:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  10097b:	0f be c0             	movsbl %al,%eax
  10097e:	47                   	inc    %edi
  10097f:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  100983:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  100987:	8a 07                	mov    (%edi),%al
  100989:	8d 50 d0             	lea    -0x30(%eax),%edx
  10098c:	80 fa 09             	cmp    $0x9,%dl
  10098f:	76 e5                	jbe    100976 <console_vprintf+0x6f>
  100991:	eb 18                	jmp    1009ab <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  100993:	80 fa 2a             	cmp    $0x2a,%dl
  100996:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  10099d:	ff 
  10099e:	75 0b                	jne    1009ab <console_vprintf+0xa4>
			width = va_arg(val, int);
  1009a0:	83 c3 04             	add    $0x4,%ebx
			++format;
  1009a3:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1009a4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009a7:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1009ab:	83 cd ff             	or     $0xffffffff,%ebp
  1009ae:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1009b1:	75 37                	jne    1009ea <console_vprintf+0xe3>
			++format;
  1009b3:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1009b4:	31 ed                	xor    %ebp,%ebp
  1009b6:	8a 07                	mov    (%edi),%al
  1009b8:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009bb:	80 fa 09             	cmp    $0x9,%dl
  1009be:	76 0d                	jbe    1009cd <console_vprintf+0xc6>
  1009c0:	eb 17                	jmp    1009d9 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1009c2:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1009c5:	0f be c0             	movsbl %al,%eax
  1009c8:	47                   	inc    %edi
  1009c9:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1009cd:	8a 07                	mov    (%edi),%al
  1009cf:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009d2:	80 fa 09             	cmp    $0x9,%dl
  1009d5:	76 eb                	jbe    1009c2 <console_vprintf+0xbb>
  1009d7:	eb 11                	jmp    1009ea <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1009d9:	3c 2a                	cmp    $0x2a,%al
  1009db:	75 0b                	jne    1009e8 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1009dd:	83 c3 04             	add    $0x4,%ebx
				++format;
  1009e0:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1009e1:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1009e4:	85 ed                	test   %ebp,%ebp
  1009e6:	79 02                	jns    1009ea <console_vprintf+0xe3>
  1009e8:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1009ea:	8a 07                	mov    (%edi),%al
  1009ec:	3c 64                	cmp    $0x64,%al
  1009ee:	74 34                	je     100a24 <console_vprintf+0x11d>
  1009f0:	7f 1d                	jg     100a0f <console_vprintf+0x108>
  1009f2:	3c 58                	cmp    $0x58,%al
  1009f4:	0f 84 a2 00 00 00    	je     100a9c <console_vprintf+0x195>
  1009fa:	3c 63                	cmp    $0x63,%al
  1009fc:	0f 84 bf 00 00 00    	je     100ac1 <console_vprintf+0x1ba>
  100a02:	3c 43                	cmp    $0x43,%al
  100a04:	0f 85 d0 00 00 00    	jne    100ada <console_vprintf+0x1d3>
  100a0a:	e9 a3 00 00 00       	jmp    100ab2 <console_vprintf+0x1ab>
  100a0f:	3c 75                	cmp    $0x75,%al
  100a11:	74 4d                	je     100a60 <console_vprintf+0x159>
  100a13:	3c 78                	cmp    $0x78,%al
  100a15:	74 5c                	je     100a73 <console_vprintf+0x16c>
  100a17:	3c 73                	cmp    $0x73,%al
  100a19:	0f 85 bb 00 00 00    	jne    100ada <console_vprintf+0x1d3>
  100a1f:	e9 86 00 00 00       	jmp    100aaa <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100a24:	83 c3 04             	add    $0x4,%ebx
  100a27:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100a2a:	89 d1                	mov    %edx,%ecx
  100a2c:	c1 f9 1f             	sar    $0x1f,%ecx
  100a2f:	89 0c 24             	mov    %ecx,(%esp)
  100a32:	31 ca                	xor    %ecx,%edx
  100a34:	55                   	push   %ebp
  100a35:	29 ca                	sub    %ecx,%edx
  100a37:	68 48 0d 10 00       	push   $0x100d48
  100a3c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a41:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a45:	e8 90 fe ff ff       	call   1008da <fill_numbuf>
  100a4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100a4e:	58                   	pop    %eax
  100a4f:	5a                   	pop    %edx
  100a50:	ba 01 00 00 00       	mov    $0x1,%edx
  100a55:	8b 04 24             	mov    (%esp),%eax
  100a58:	83 e0 01             	and    $0x1,%eax
  100a5b:	e9 a5 00 00 00       	jmp    100b05 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a60:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a63:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a68:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a6b:	55                   	push   %ebp
  100a6c:	68 48 0d 10 00       	push   $0x100d48
  100a71:	eb 11                	jmp    100a84 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a73:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a76:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a79:	55                   	push   %ebp
  100a7a:	68 5c 0d 10 00       	push   $0x100d5c
  100a7f:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a84:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a88:	e8 4d fe ff ff       	call   1008da <fill_numbuf>
  100a8d:	ba 01 00 00 00       	mov    $0x1,%edx
  100a92:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a96:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a98:	59                   	pop    %ecx
  100a99:	59                   	pop    %ecx
  100a9a:	eb 69                	jmp    100b05 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a9c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a9f:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100aa2:	55                   	push   %ebp
  100aa3:	68 48 0d 10 00       	push   $0x100d48
  100aa8:	eb d5                	jmp    100a7f <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100aaa:	83 c3 04             	add    $0x4,%ebx
  100aad:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100ab0:	eb 40                	jmp    100af2 <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100ab2:	83 c3 04             	add    $0x4,%ebx
  100ab5:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100ab8:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100abc:	e9 bd 01 00 00       	jmp    100c7e <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100ac1:	83 c3 04             	add    $0x4,%ebx
  100ac4:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100ac7:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100acb:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100ad0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100ad4:	88 44 24 24          	mov    %al,0x24(%esp)
  100ad8:	eb 27                	jmp    100b01 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100ada:	84 c0                	test   %al,%al
  100adc:	75 02                	jne    100ae0 <console_vprintf+0x1d9>
  100ade:	b0 25                	mov    $0x25,%al
  100ae0:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100ae4:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100ae9:	80 3f 00             	cmpb   $0x0,(%edi)
  100aec:	74 0a                	je     100af8 <console_vprintf+0x1f1>
  100aee:	8d 44 24 24          	lea    0x24(%esp),%eax
  100af2:	89 44 24 04          	mov    %eax,0x4(%esp)
  100af6:	eb 09                	jmp    100b01 <console_vprintf+0x1fa>
				format--;
  100af8:	8d 54 24 24          	lea    0x24(%esp),%edx
  100afc:	4f                   	dec    %edi
  100afd:	89 54 24 04          	mov    %edx,0x4(%esp)
  100b01:	31 d2                	xor    %edx,%edx
  100b03:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b05:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100b07:	83 fd ff             	cmp    $0xffffffff,%ebp
  100b0a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100b11:	74 1f                	je     100b32 <console_vprintf+0x22b>
  100b13:	89 04 24             	mov    %eax,(%esp)
  100b16:	eb 01                	jmp    100b19 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100b18:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100b19:	39 e9                	cmp    %ebp,%ecx
  100b1b:	74 0a                	je     100b27 <console_vprintf+0x220>
  100b1d:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b21:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100b25:	75 f1                	jne    100b18 <console_vprintf+0x211>
  100b27:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b2a:	89 0c 24             	mov    %ecx,(%esp)
  100b2d:	eb 1f                	jmp    100b4e <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100b2f:	42                   	inc    %edx
  100b30:	eb 09                	jmp    100b3b <console_vprintf+0x234>
  100b32:	89 d1                	mov    %edx,%ecx
  100b34:	8b 14 24             	mov    (%esp),%edx
  100b37:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100b3b:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b3f:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100b43:	75 ea                	jne    100b2f <console_vprintf+0x228>
  100b45:	8b 44 24 08          	mov    0x8(%esp),%eax
  100b49:	89 14 24             	mov    %edx,(%esp)
  100b4c:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100b4e:	85 c0                	test   %eax,%eax
  100b50:	74 0c                	je     100b5e <console_vprintf+0x257>
  100b52:	84 d2                	test   %dl,%dl
  100b54:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b5b:	00 
  100b5c:	75 24                	jne    100b82 <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b5e:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b63:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b6a:	00 
  100b6b:	75 15                	jne    100b82 <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b6d:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b71:	83 e0 08             	and    $0x8,%eax
  100b74:	83 f8 01             	cmp    $0x1,%eax
  100b77:	19 c9                	sbb    %ecx,%ecx
  100b79:	f7 d1                	not    %ecx
  100b7b:	83 e1 20             	and    $0x20,%ecx
  100b7e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b82:	3b 2c 24             	cmp    (%esp),%ebp
  100b85:	7e 0d                	jle    100b94 <console_vprintf+0x28d>
  100b87:	84 d2                	test   %dl,%dl
  100b89:	74 40                	je     100bcb <console_vprintf+0x2c4>
			zeros = precision - len;
  100b8b:	2b 2c 24             	sub    (%esp),%ebp
  100b8e:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b92:	eb 3f                	jmp    100bd3 <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b94:	84 d2                	test   %dl,%dl
  100b96:	74 33                	je     100bcb <console_vprintf+0x2c4>
  100b98:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b9c:	83 e0 06             	and    $0x6,%eax
  100b9f:	83 f8 02             	cmp    $0x2,%eax
  100ba2:	75 27                	jne    100bcb <console_vprintf+0x2c4>
  100ba4:	45                   	inc    %ebp
  100ba5:	75 24                	jne    100bcb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ba7:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ba9:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100bac:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bb1:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bb4:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100bb7:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100bbb:	7d 0e                	jge    100bcb <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100bbd:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100bc1:	29 ca                	sub    %ecx,%edx
  100bc3:	29 c2                	sub    %eax,%edx
  100bc5:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bc9:	eb 08                	jmp    100bd3 <console_vprintf+0x2cc>
  100bcb:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100bd2:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bd3:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100bd7:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bd9:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bdd:	2b 2c 24             	sub    (%esp),%ebp
  100be0:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100be5:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100be8:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100beb:	29 c5                	sub    %eax,%ebp
  100bed:	89 f0                	mov    %esi,%eax
  100bef:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bf3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100bf7:	eb 0f                	jmp    100c08 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100bf9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bfd:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c02:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c03:	e8 83 fc ff ff       	call   10088b <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c08:	85 ed                	test   %ebp,%ebp
  100c0a:	7e 07                	jle    100c13 <console_vprintf+0x30c>
  100c0c:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100c11:	74 e6                	je     100bf9 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100c13:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100c18:	89 c6                	mov    %eax,%esi
  100c1a:	74 23                	je     100c3f <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100c1c:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100c21:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c25:	e8 61 fc ff ff       	call   10088b <console_putc>
  100c2a:	89 c6                	mov    %eax,%esi
  100c2c:	eb 11                	jmp    100c3f <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100c2e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c32:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c37:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100c38:	e8 4e fc ff ff       	call   10088b <console_putc>
  100c3d:	eb 06                	jmp    100c45 <console_vprintf+0x33e>
  100c3f:	89 f0                	mov    %esi,%eax
  100c41:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c45:	85 f6                	test   %esi,%esi
  100c47:	7f e5                	jg     100c2e <console_vprintf+0x327>
  100c49:	8b 34 24             	mov    (%esp),%esi
  100c4c:	eb 15                	jmp    100c63 <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100c4e:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c52:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100c53:	0f b6 11             	movzbl (%ecx),%edx
  100c56:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c5a:	e8 2c fc ff ff       	call   10088b <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c5f:	ff 44 24 04          	incl   0x4(%esp)
  100c63:	85 f6                	test   %esi,%esi
  100c65:	7f e7                	jg     100c4e <console_vprintf+0x347>
  100c67:	eb 0f                	jmp    100c78 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c69:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c6d:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c72:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c73:	e8 13 fc ff ff       	call   10088b <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c78:	85 ed                	test   %ebp,%ebp
  100c7a:	7f ed                	jg     100c69 <console_vprintf+0x362>
  100c7c:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c7e:	47                   	inc    %edi
  100c7f:	8a 17                	mov    (%edi),%dl
  100c81:	84 d2                	test   %dl,%dl
  100c83:	0f 85 96 fc ff ff    	jne    10091f <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c89:	83 c4 38             	add    $0x38,%esp
  100c8c:	89 f0                	mov    %esi,%eax
  100c8e:	5b                   	pop    %ebx
  100c8f:	5e                   	pop    %esi
  100c90:	5f                   	pop    %edi
  100c91:	5d                   	pop    %ebp
  100c92:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c93:	81 e9 40 0d 10 00    	sub    $0x100d40,%ecx
  100c99:	b8 01 00 00 00       	mov    $0x1,%eax
  100c9e:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ca0:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ca1:	09 44 24 14          	or     %eax,0x14(%esp)
  100ca5:	e9 aa fc ff ff       	jmp    100954 <console_vprintf+0x4d>

00100caa <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100caa:	8d 44 24 10          	lea    0x10(%esp),%eax
  100cae:	50                   	push   %eax
  100caf:	ff 74 24 10          	pushl  0x10(%esp)
  100cb3:	ff 74 24 10          	pushl  0x10(%esp)
  100cb7:	ff 74 24 10          	pushl  0x10(%esp)
  100cbb:	e8 47 fc ff ff       	call   100907 <console_vprintf>
  100cc0:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100cc3:	c3                   	ret    
