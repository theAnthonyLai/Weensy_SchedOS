
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
  100014:	e8 15 03 00 00       	call   10032e <start>
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
  10006d:	e8 3b 02 00 00       	call   1002ad <interrupt>

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
  1000a3:	a1 90 7b 10 00       	mov    0x107b90,%eax
  1000a8:	8b 38                	mov    (%eax),%edi
	unsigned int firstPriority;
	pid_t firstPid;
	int i;
	int p_share_reset;	// 4B
	if (scheduling_algorithm == 0) {
  1000aa:	a1 94 7b 10 00       	mov    0x107b94,%eax
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
  1000be:	6b c2 5c             	imul   $0x5c,%edx,%eax
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
  1000c3:	83 b8 b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%eax)
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
  1000dd:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000e0:	83 b8 b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%eax)
  1000e7:	75 0e                	jne    1000f7 <schedule+0x5b>
				run(&proc_array[pid]);
  1000e9:	83 ec 0c             	sub    $0xc,%esp
  1000ec:	05 5c 71 10 00       	add    $0x10715c,%eax
  1000f1:	50                   	push   %eax
  1000f2:	e9 8c 01 00 00       	jmp    100283 <schedule+0x1e7>
			pid = (pid + 1) % NPROCS;
  1000f7:	8d 42 01             	lea    0x1(%edx),%eax
  1000fa:	99                   	cltd   
  1000fb:	f7 f9                	idiv   %ecx
		}
  1000fd:	eb de                	jmp    1000dd <schedule+0x41>
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
  1000ff:	83 f8 29             	cmp    $0x29,%eax
  100102:	75 5b                	jne    10015f <schedule+0xc3>
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
  100109:	6b c7 5c             	imul   $0x5c,%edi,%eax
  10010c:	89 fe                	mov    %edi,%esi
  10010e:	31 c9                	xor    %ecx,%ecx
  100110:	8b 98 a4 71 10 00    	mov    0x1071a4(%eax),%ebx
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  100116:	8d 47 01             	lea    0x1(%edi),%eax
  100119:	99                   	cltd   
  10011a:	f7 fd                	idiv   %ebp
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  10011c:	6b c2 5c             	imul   $0x5c,%edx,%eax
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  10011f:	89 d7                	mov    %edx,%edi
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
  100121:	83 b8 b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%eax)
  100128:	75 0e                	jne    100138 <schedule+0x9c>
  10012a:	8b 80 a4 71 10 00    	mov    0x1071a4(%eax),%eax
  100130:	39 d8                	cmp    %ebx,%eax
  100132:	77 04                	ja     100138 <schedule+0x9c>
  100134:	89 d6                	mov    %edx,%esi
  100136:	eb 02                	jmp    10013a <schedule+0x9e>
  100138:	89 d8                	mov    %ebx,%eax
		// TODO: "blocked and later became runnalbe again"
	} else if (scheduling_algorithm == __EXERCISE_4A__) {
		do {
			firstPid = pid;
			firstPriority = proc_array[pid].p_priority;
			for (i = 0; i < NPROCS-1; i++) {
  10013a:	41                   	inc    %ecx
  10013b:	83 f9 04             	cmp    $0x4,%ecx
  10013e:	74 04                	je     100144 <schedule+0xa8>
  100140:	89 c3                	mov    %eax,%ebx
  100142:	eb d2                	jmp    100116 <schedule+0x7a>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= firstPriority) {
					firstPid = pid;
					firstPriority = proc_array[pid].p_priority;
				}
			}
		} while (proc_array[firstPid].p_state != P_RUNNABLE);
  100144:	6b f6 5c             	imul   $0x5c,%esi,%esi
  100147:	83 be b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%esi)
  10014e:	75 b9                	jne    100109 <schedule+0x6d>
		run(&proc_array[firstPid]);
  100150:	83 ec 0c             	sub    $0xc,%esp
  100153:	81 c6 5c 71 10 00    	add    $0x10715c,%esi
  100159:	56                   	push   %esi
  10015a:	e9 24 01 00 00       	jmp    100283 <schedule+0x1e7>
	} else if (scheduling_algorithm == __EXERCISE_4B__) {
  10015f:	83 f8 2a             	cmp    $0x2a,%eax
  100162:	0f 85 20 01 00 00    	jne    100288 <schedule+0x1ec>
  100168:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  10016f:	00 
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  100170:	6b df 5c             	imul   $0x5c,%edi,%ebx
  100173:	83 ec 0c             	sub    $0xc,%esp
  100176:	a1 00 80 19 00       	mov    0x198000,%eax
  10017b:	81 c3 68 71 10 00    	add    $0x107168,%ebx
  100181:	ff 73 40             	pushl  0x40(%ebx)
  100184:	57                   	push   %edi
  100185:	68 00 0c 10 00       	push   $0x100c00
  10018a:	68 00 01 00 00       	push   $0x100
  10018f:	50                   	push   %eax
  100190:	e8 51 0a 00 00       	call   100be6 <console_printf>
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
  100195:	8b 73 40             	mov    0x40(%ebx),%esi
  100198:	31 c9                	xor    %ecx,%ecx
  10019a:	89 fb                	mov    %edi,%ebx
  10019c:	83 c4 20             	add    $0x20,%esp
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  10019f:	a3 00 80 19 00       	mov    %eax,0x198000
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001a4:	8d 47 01             	lea    0x1(%edi),%eax
  1001a7:	bf 05 00 00 00       	mov    $0x5,%edi
  1001ac:	99                   	cltd   
  1001ad:	f7 ff                	idiv   %edi
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001af:	a1 00 80 19 00       	mov    0x198000,%eax
  1001b4:	6b ea 5c             	imul   $0x5c,%edx,%ebp
		
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
			firstPid = pid;
			firstPriority = proc_array[pid].p_share_amt;
			for (i = 0; i < NPROCS-1; i++) {
				pid = (pid + 1) % NPROCS;
  1001b7:	89 d7                	mov    %edx,%edi
  1001b9:	89 54 24 0c          	mov    %edx,0xc(%esp)
	//cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d, firstPriority is %d\n", pid, proc_array[pid].p_share_amt, firstPriority);
					
	cursorpos = console_printf(cursorpos, 0x100, "pid %d has amt %d\n", pid, proc_array[pid].p_share_amt);
  1001bd:	83 ec 0c             	sub    $0xc,%esp
  1001c0:	8d 95 68 71 10 00    	lea    0x107168(%ebp),%edx
  1001c6:	ff 72 40             	pushl  0x40(%edx)
  1001c9:	57                   	push   %edi
  1001ca:	68 00 0c 10 00       	push   $0x100c00
  1001cf:	68 00 01 00 00       	push   $0x100
  1001d4:	50                   	push   %eax
  1001d5:	89 54 24 24          	mov    %edx,0x24(%esp)
  1001d9:	89 4c 24 20          	mov    %ecx,0x20(%esp)
  1001dd:	e8 04 0a 00 00       	call   100be6 <console_printf>
				if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_share_amt >= firstPriority) {
  1001e2:	83 c4 20             	add    $0x20,%esp
  1001e5:	83 bd b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%ebp)
  1001ec:	8b 54 24 04          	mov    0x4(%esp),%edx
  1001f0:	8b 0c 24             	mov    (%esp),%ecx
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
  10020f:	eb 93                	jmp    1001a4 <schedule+0x108>
				}
			}
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
  100211:	6b c3 5c             	imul   $0x5c,%ebx,%eax
  100214:	83 b8 ac 71 10 00 00 	cmpl   $0x0,0x1071ac(%eax)
  10021b:	75 3a                	jne    100257 <schedule+0x1bb>
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  10021d:	83 ec 0c             	sub    $0xc,%esp
  100220:	a1 00 80 19 00       	mov    0x198000,%eax
  100225:	ff 74 24 18          	pushl  0x18(%esp)
  100229:	53                   	push   %ebx
  10022a:	68 13 0c 10 00       	push   $0x100c13
  10022f:	68 00 01 00 00       	push   $0x100
  100234:	50                   	push   %eax
  100235:	e8 ac 09 00 00       	call   100be6 <console_printf>
				pid = (pid + 1) % NPROCS;
  10023a:	b9 05 00 00 00       	mov    $0x5,%ecx
				hi--;
  10023f:	ff 4c 24 28          	decl   0x28(%esp)
			
	//cursorpos = console_printf(cursorpos, 0x100, "\nNow pick pid %i with amt %i\n", firstPid, firstPriority);
			// check if it has any share left
			if (proc_array[firstPid].p_share_left == 0) {
				//proc_array[firstPid].p_share_left = proc_array[firstPid].p_share_amt;
	cursorpos = console_printf(cursorpos, 0x100, "firstPid is %d, pid is %d\n", firstPid,pid);
  100243:	a3 00 80 19 00       	mov    %eax,0x198000
				pid = (pid + 1) % NPROCS;
  100248:	8b 44 24 2c          	mov    0x2c(%esp),%eax
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
  100257:	83 b8 b0 71 10 00 01 	cmpl   $0x1,0x1071b0(%eax)
  10025e:	74 0b                	je     10026b <schedule+0x1cf>
		if (!p_share_reset) {
			for (i = 0; i < NPROCS; i++)
				;//proc_array[i].p_share_left = proc_array[i].p_share_amt;
		}
		int hi = 2;
		while (hi) {
  100260:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100265:	0f 85 05 ff ff ff    	jne    100170 <schedule+0xd4>
			}
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
  10026b:	6b db 5c             	imul   $0x5c,%ebx,%ebx
  10026e:	81 c3 5c 71 10 00    	add    $0x10715c,%ebx
  100274:	8b 43 50             	mov    0x50(%ebx),%eax
  100277:	85 c0                	test   %eax,%eax
  100279:	74 0d                	je     100288 <schedule+0x1ec>
			proc_array[firstPid].p_share_left--;
  10027b:	48                   	dec    %eax
			run(&proc_array[firstPid]);
  10027c:	83 ec 0c             	sub    $0xc,%esp
			
			if (proc_array[firstPid].p_state == P_RUNNABLE)
				break;				
		}
		if (proc_array[firstPid].p_share_left > 0) {
			proc_array[firstPid].p_share_left--;
  10027f:	89 43 50             	mov    %eax,0x50(%ebx)
			run(&proc_array[firstPid]);
  100282:	53                   	push   %ebx
  100283:	e8 b9 03 00 00       	call   100641 <run>
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100288:	ff 35 94 7b 10 00    	pushl  0x107b94
  10028e:	a1 00 80 19 00       	mov    0x198000,%eax
  100293:	68 2e 0c 10 00       	push   $0x100c2e
  100298:	68 00 01 00 00       	push   $0x100
  10029d:	50                   	push   %eax
  10029e:	e8 43 09 00 00       	call   100be6 <console_printf>
  1002a3:	83 c4 10             	add    $0x10,%esp
  1002a6:	a3 00 80 19 00       	mov    %eax,0x198000
  1002ab:	eb fe                	jmp    1002ab <schedule+0x20f>

001002ad <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1002ad:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1002ae:	8b 3d 90 7b 10 00    	mov    0x107b90,%edi
  1002b4:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1002b9:	56                   	push   %esi
  1002ba:	53                   	push   %ebx
  1002bb:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1002bf:	83 c7 04             	add    $0x4,%edi
  1002c2:	89 de                	mov    %ebx,%esi
  1002c4:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1002c6:	8b 43 28             	mov    0x28(%ebx),%eax
  1002c9:	83 f8 31             	cmp    $0x31,%eax
  1002cc:	74 1f                	je     1002ed <interrupt+0x40>
  1002ce:	77 0c                	ja     1002dc <interrupt+0x2f>
  1002d0:	83 f8 20             	cmp    $0x20,%eax
  1002d3:	74 52                	je     100327 <interrupt+0x7a>
  1002d5:	83 f8 30             	cmp    $0x30,%eax
  1002d8:	74 0e                	je     1002e8 <interrupt+0x3b>
  1002da:	eb 50                	jmp    10032c <interrupt+0x7f>
  1002dc:	83 f8 32             	cmp    $0x32,%eax
  1002df:	74 23                	je     100304 <interrupt+0x57>
  1002e1:	83 f8 33             	cmp    $0x33,%eax
  1002e4:	74 2e                	je     100314 <interrupt+0x67>
  1002e6:	eb 44                	jmp    10032c <interrupt+0x7f>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002e8:	e8 af fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002ed:	a1 90 7b 10 00       	mov    0x107b90,%eax
		current->p_exit_status = reg->reg_eax;
  1002f2:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002f5:	c7 40 54 03 00 00 00 	movl   $0x3,0x54(%eax)
		current->p_exit_status = reg->reg_eax;
  1002fc:	89 50 58             	mov    %edx,0x58(%eax)
		schedule();
  1002ff:	e8 98 fd ff ff       	call   10009c <schedule>
	case INT_SYS_PRIORITY:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		//run(current);
		current->p_priority = reg->reg_eax;
  100304:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100307:	a1 90 7b 10 00       	mov    0x107b90,%eax
  10030c:	89 50 48             	mov    %edx,0x48(%eax)
		schedule();
  10030f:	e8 88 fd ff ff       	call   10009c <schedule>

	//case INT_SYS_USER2:
	case INT_SYS_SHARE:
		/* Your code here (if you want). */
		//run(current);
		current->p_share_amt = reg->reg_eax;
  100314:	a1 90 7b 10 00       	mov    0x107b90,%eax
  100319:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10031c:	89 50 4c             	mov    %edx,0x4c(%eax)
		current->p_share_left = current->p_share_amt;
  10031f:	89 50 50             	mov    %edx,0x50(%eax)
		schedule();
  100322:	e8 75 fd ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100327:	e8 70 fd ff ff       	call   10009c <schedule>
  10032c:	eb fe                	jmp    10032c <interrupt+0x7f>

0010032e <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10032e:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10032f:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100334:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100335:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100337:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100338:	bb b8 71 10 00       	mov    $0x1071b8,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10033d:	e8 de 00 00 00       	call   100420 <segments_init>
	interrupt_controller_init(0);
  100342:	83 ec 0c             	sub    $0xc,%esp
  100345:	6a 00                	push   $0x0
  100347:	e8 cf 01 00 00       	call   10051b <interrupt_controller_init>
	console_clear();
  10034c:	e8 53 02 00 00       	call   1005a4 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100351:	83 c4 0c             	add    $0xc,%esp
  100354:	68 cc 01 00 00       	push   $0x1cc
  100359:	6a 00                	push   $0x0
  10035b:	68 5c 71 10 00       	push   $0x10715c
  100360:	e8 1f 04 00 00       	call   100784 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100365:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100368:	c7 05 5c 71 10 00 00 	movl   $0x0,0x10715c
  10036f:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100372:	c7 05 b0 71 10 00 00 	movl   $0x0,0x1071b0
  100379:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10037c:	c7 05 b8 71 10 00 01 	movl   $0x1,0x1071b8
  100383:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100386:	c7 05 0c 72 10 00 00 	movl   $0x0,0x10720c
  10038d:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100390:	c7 05 14 72 10 00 02 	movl   $0x2,0x107214
  100397:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10039a:	c7 05 68 72 10 00 00 	movl   $0x0,0x107268
  1003a1:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003a4:	c7 05 70 72 10 00 03 	movl   $0x3,0x107270
  1003ab:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003ae:	c7 05 c4 72 10 00 00 	movl   $0x0,0x1072c4
  1003b5:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003b8:	c7 05 cc 72 10 00 04 	movl   $0x4,0x1072cc
  1003bf:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003c2:	c7 05 20 73 10 00 00 	movl   $0x0,0x107320
  1003c9:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1003cc:	83 ec 0c             	sub    $0xc,%esp
  1003cf:	53                   	push   %ebx
  1003d0:	e8 83 02 00 00       	call   100658 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003d5:	58                   	pop    %eax
  1003d6:	5a                   	pop    %edx
  1003d7:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003da:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003dd:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003e3:	50                   	push   %eax
  1003e4:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003e5:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003e6:	e8 a9 02 00 00       	call   100694 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003eb:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ee:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  1003f5:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003f8:	83 fe 04             	cmp    $0x4,%esi
  1003fb:	75 cf                	jne    1003cc <start+0x9e>
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;

	// Switch to the first process.
	run(&proc_array[1]);
  1003fd:	83 ec 0c             	sub    $0xc,%esp
  100400:	68 b8 71 10 00       	push   $0x1071b8
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100405:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10040c:	80 0b 00 
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	//scheduling_algorithm = 0;
	//scheduling_algorithm = 2;
	//scheduling_algorithm = __EXERCISE_4A__;
	scheduling_algorithm = __EXERCISE_4B__;
  10040f:	c7 05 94 7b 10 00 2a 	movl   $0x2a,0x107b94
  100416:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100419:	e8 23 02 00 00       	call   100641 <run>
  10041e:	90                   	nop
  10041f:	90                   	nop

00100420 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100420:	b8 28 73 10 00       	mov    $0x107328,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100425:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10042a:	89 c2                	mov    %eax,%edx
  10042c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10042f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100430:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100435:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100438:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10043e:	c1 e8 18             	shr    $0x18,%eax
  100441:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100447:	ba 90 73 10 00       	mov    $0x107390,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10044c:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100451:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100453:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  10045a:	68 00 
  10045c:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100463:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10046a:	c7 05 2c 73 10 00 00 	movl   $0x180000,0x10732c
  100471:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100474:	66 c7 05 30 73 10 00 	movw   $0x10,0x107330
  10047b:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10047d:	66 89 0c c5 90 73 10 	mov    %cx,0x107390(,%eax,8)
  100484:	00 
  100485:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  10048c:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100491:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100496:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  10049b:	40                   	inc    %eax
  10049c:	3d 00 01 00 00       	cmp    $0x100,%eax
  1004a1:	75 da                	jne    10047d <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004a3:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004a8:	ba 90 73 10 00       	mov    $0x107390,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004ad:	66 a3 90 74 10 00    	mov    %ax,0x107490
  1004b3:	c1 e8 10             	shr    $0x10,%eax
  1004b6:	66 a3 96 74 10 00    	mov    %ax,0x107496
  1004bc:	b8 30 00 00 00       	mov    $0x30,%eax
  1004c1:	66 c7 05 92 74 10 00 	movw   $0x8,0x107492
  1004c8:	08 00 
  1004ca:	c6 05 94 74 10 00 00 	movb   $0x0,0x107494
  1004d1:	c6 05 95 74 10 00 8e 	movb   $0x8e,0x107495

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004d8:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004df:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004e6:	66 89 0c c5 90 73 10 	mov    %cx,0x107390(,%eax,8)
  1004ed:	00 
  1004ee:	c1 e9 10             	shr    $0x10,%ecx
  1004f1:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004f6:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1004fb:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100500:	40                   	inc    %eax
  100501:	83 f8 3a             	cmp    $0x3a,%eax
  100504:	75 d2                	jne    1004d8 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100506:	b0 28                	mov    $0x28,%al
  100508:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10050f:	0f 00 d8             	ltr    %ax
  100512:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100519:	5b                   	pop    %ebx
  10051a:	c3                   	ret    

0010051b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10051b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10051c:	b0 ff                	mov    $0xff,%al
  10051e:	57                   	push   %edi
  10051f:	56                   	push   %esi
  100520:	53                   	push   %ebx
  100521:	bb 21 00 00 00       	mov    $0x21,%ebx
  100526:	89 da                	mov    %ebx,%edx
  100528:	ee                   	out    %al,(%dx)
  100529:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10052e:	89 ca                	mov    %ecx,%edx
  100530:	ee                   	out    %al,(%dx)
  100531:	be 11 00 00 00       	mov    $0x11,%esi
  100536:	bf 20 00 00 00       	mov    $0x20,%edi
  10053b:	89 f0                	mov    %esi,%eax
  10053d:	89 fa                	mov    %edi,%edx
  10053f:	ee                   	out    %al,(%dx)
  100540:	b0 20                	mov    $0x20,%al
  100542:	89 da                	mov    %ebx,%edx
  100544:	ee                   	out    %al,(%dx)
  100545:	b0 04                	mov    $0x4,%al
  100547:	ee                   	out    %al,(%dx)
  100548:	b0 03                	mov    $0x3,%al
  10054a:	ee                   	out    %al,(%dx)
  10054b:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100550:	89 f0                	mov    %esi,%eax
  100552:	89 ea                	mov    %ebp,%edx
  100554:	ee                   	out    %al,(%dx)
  100555:	b0 28                	mov    $0x28,%al
  100557:	89 ca                	mov    %ecx,%edx
  100559:	ee                   	out    %al,(%dx)
  10055a:	b0 02                	mov    $0x2,%al
  10055c:	ee                   	out    %al,(%dx)
  10055d:	b0 01                	mov    $0x1,%al
  10055f:	ee                   	out    %al,(%dx)
  100560:	b0 68                	mov    $0x68,%al
  100562:	89 fa                	mov    %edi,%edx
  100564:	ee                   	out    %al,(%dx)
  100565:	be 0a 00 00 00       	mov    $0xa,%esi
  10056a:	89 f0                	mov    %esi,%eax
  10056c:	ee                   	out    %al,(%dx)
  10056d:	b0 68                	mov    $0x68,%al
  10056f:	89 ea                	mov    %ebp,%edx
  100571:	ee                   	out    %al,(%dx)
  100572:	89 f0                	mov    %esi,%eax
  100574:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100575:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  10057a:	89 da                	mov    %ebx,%edx
  10057c:	19 c0                	sbb    %eax,%eax
  10057e:	f7 d0                	not    %eax
  100580:	05 ff 00 00 00       	add    $0xff,%eax
  100585:	ee                   	out    %al,(%dx)
  100586:	b0 ff                	mov    $0xff,%al
  100588:	89 ca                	mov    %ecx,%edx
  10058a:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  10058b:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  100590:	74 0d                	je     10059f <interrupt_controller_init+0x84>
  100592:	b2 43                	mov    $0x43,%dl
  100594:	b0 34                	mov    $0x34,%al
  100596:	ee                   	out    %al,(%dx)
  100597:	b0 9c                	mov    $0x9c,%al
  100599:	b2 40                	mov    $0x40,%dl
  10059b:	ee                   	out    %al,(%dx)
  10059c:	b0 2e                	mov    $0x2e,%al
  10059e:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10059f:	5b                   	pop    %ebx
  1005a0:	5e                   	pop    %esi
  1005a1:	5f                   	pop    %edi
  1005a2:	5d                   	pop    %ebp
  1005a3:	c3                   	ret    

001005a4 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005a4:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005a5:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005a7:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005a8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005af:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005b2:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1005b8:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1005be:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1005c1:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1005c6:	75 ea                	jne    1005b2 <console_clear+0xe>
  1005c8:	be d4 03 00 00       	mov    $0x3d4,%esi
  1005cd:	b0 0e                	mov    $0xe,%al
  1005cf:	89 f2                	mov    %esi,%edx
  1005d1:	ee                   	out    %al,(%dx)
  1005d2:	31 c9                	xor    %ecx,%ecx
  1005d4:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005d9:	88 c8                	mov    %cl,%al
  1005db:	89 da                	mov    %ebx,%edx
  1005dd:	ee                   	out    %al,(%dx)
  1005de:	b0 0f                	mov    $0xf,%al
  1005e0:	89 f2                	mov    %esi,%edx
  1005e2:	ee                   	out    %al,(%dx)
  1005e3:	88 c8                	mov    %cl,%al
  1005e5:	89 da                	mov    %ebx,%edx
  1005e7:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1005e8:	5b                   	pop    %ebx
  1005e9:	5e                   	pop    %esi
  1005ea:	c3                   	ret    

001005eb <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1005eb:	ba 64 00 00 00       	mov    $0x64,%edx
  1005f0:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1005f1:	a8 01                	test   $0x1,%al
  1005f3:	74 45                	je     10063a <console_read_digit+0x4f>
  1005f5:	b2 60                	mov    $0x60,%dl
  1005f7:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1005f8:	8d 50 fe             	lea    -0x2(%eax),%edx
  1005fb:	80 fa 08             	cmp    $0x8,%dl
  1005fe:	77 05                	ja     100605 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100600:	0f b6 c0             	movzbl %al,%eax
  100603:	48                   	dec    %eax
  100604:	c3                   	ret    
	else if (data == 0x0B)
  100605:	3c 0b                	cmp    $0xb,%al
  100607:	74 35                	je     10063e <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100609:	8d 50 b9             	lea    -0x47(%eax),%edx
  10060c:	80 fa 02             	cmp    $0x2,%dl
  10060f:	77 07                	ja     100618 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100611:	0f b6 c0             	movzbl %al,%eax
  100614:	83 e8 40             	sub    $0x40,%eax
  100617:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100618:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10061b:	80 fa 02             	cmp    $0x2,%dl
  10061e:	77 07                	ja     100627 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100620:	0f b6 c0             	movzbl %al,%eax
  100623:	83 e8 47             	sub    $0x47,%eax
  100626:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100627:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10062a:	80 fa 02             	cmp    $0x2,%dl
  10062d:	77 07                	ja     100636 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10062f:	0f b6 c0             	movzbl %al,%eax
  100632:	83 e8 4e             	sub    $0x4e,%eax
  100635:	c3                   	ret    
	else if (data == 0x53)
  100636:	3c 53                	cmp    $0x53,%al
  100638:	74 04                	je     10063e <console_read_digit+0x53>
  10063a:	83 c8 ff             	or     $0xffffffff,%eax
  10063d:	c3                   	ret    
  10063e:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100640:	c3                   	ret    

00100641 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100641:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100645:	a3 90 7b 10 00       	mov    %eax,0x107b90

	asm volatile("movl %0,%%esp\n\t"
  10064a:	83 c0 04             	add    $0x4,%eax
  10064d:	89 c4                	mov    %eax,%esp
  10064f:	61                   	popa   
  100650:	07                   	pop    %es
  100651:	1f                   	pop    %ds
  100652:	83 c4 08             	add    $0x8,%esp
  100655:	cf                   	iret   
  100656:	eb fe                	jmp    100656 <run+0x15>

00100658 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100658:	53                   	push   %ebx
  100659:	83 ec 0c             	sub    $0xc,%esp
  10065c:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100660:	6a 44                	push   $0x44
  100662:	6a 00                	push   $0x0
  100664:	8d 43 04             	lea    0x4(%ebx),%eax
  100667:	50                   	push   %eax
  100668:	e8 17 01 00 00       	call   100784 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10066d:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  100673:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100679:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10067f:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100685:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  10068c:	83 c4 18             	add    $0x18,%esp
  10068f:	5b                   	pop    %ebx
  100690:	c3                   	ret    
  100691:	90                   	nop
  100692:	90                   	nop
  100693:	90                   	nop

00100694 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100694:	55                   	push   %ebp
  100695:	57                   	push   %edi
  100696:	56                   	push   %esi
  100697:	53                   	push   %ebx
  100698:	83 ec 1c             	sub    $0x1c,%esp
  10069b:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10069f:	83 f8 03             	cmp    $0x3,%eax
  1006a2:	7f 04                	jg     1006a8 <program_loader+0x14>
  1006a4:	85 c0                	test   %eax,%eax
  1006a6:	79 02                	jns    1006aa <program_loader+0x16>
  1006a8:	eb fe                	jmp    1006a8 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006aa:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006b1:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1006b7:	74 02                	je     1006bb <program_loader+0x27>
  1006b9:	eb fe                	jmp    1006b9 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006bb:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1006be:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006c2:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1006c4:	c1 e5 05             	shl    $0x5,%ebp
  1006c7:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1006ca:	eb 3f                	jmp    10070b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1006cc:	83 3b 01             	cmpl   $0x1,(%ebx)
  1006cf:	75 37                	jne    100708 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1006d1:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006d4:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006d7:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006da:	01 c7                	add    %eax,%edi
	memsz += va;
  1006dc:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006de:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006e3:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1006e7:	52                   	push   %edx
  1006e8:	89 fa                	mov    %edi,%edx
  1006ea:	29 c2                	sub    %eax,%edx
  1006ec:	52                   	push   %edx
  1006ed:	8b 53 04             	mov    0x4(%ebx),%edx
  1006f0:	01 f2                	add    %esi,%edx
  1006f2:	52                   	push   %edx
  1006f3:	50                   	push   %eax
  1006f4:	e8 27 00 00 00       	call   100720 <memcpy>
  1006f9:	83 c4 10             	add    $0x10,%esp
  1006fc:	eb 04                	jmp    100702 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1006fe:	c6 07 00             	movb   $0x0,(%edi)
  100701:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100702:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100706:	72 f6                	jb     1006fe <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100708:	83 c3 20             	add    $0x20,%ebx
  10070b:	39 eb                	cmp    %ebp,%ebx
  10070d:	72 bd                	jb     1006cc <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10070f:	8b 56 18             	mov    0x18(%esi),%edx
  100712:	8b 44 24 34          	mov    0x34(%esp),%eax
  100716:	89 10                	mov    %edx,(%eax)
}
  100718:	83 c4 1c             	add    $0x1c,%esp
  10071b:	5b                   	pop    %ebx
  10071c:	5e                   	pop    %esi
  10071d:	5f                   	pop    %edi
  10071e:	5d                   	pop    %ebp
  10071f:	c3                   	ret    

00100720 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100720:	56                   	push   %esi
  100721:	31 d2                	xor    %edx,%edx
  100723:	53                   	push   %ebx
  100724:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100728:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10072c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100730:	eb 08                	jmp    10073a <memcpy+0x1a>
		*d++ = *s++;
  100732:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100735:	4e                   	dec    %esi
  100736:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100739:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10073a:	85 f6                	test   %esi,%esi
  10073c:	75 f4                	jne    100732 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10073e:	5b                   	pop    %ebx
  10073f:	5e                   	pop    %esi
  100740:	c3                   	ret    

00100741 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100741:	57                   	push   %edi
  100742:	56                   	push   %esi
  100743:	53                   	push   %ebx
  100744:	8b 44 24 10          	mov    0x10(%esp),%eax
  100748:	8b 7c 24 14          	mov    0x14(%esp),%edi
  10074c:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100750:	39 c7                	cmp    %eax,%edi
  100752:	73 26                	jae    10077a <memmove+0x39>
  100754:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100757:	39 c6                	cmp    %eax,%esi
  100759:	76 1f                	jbe    10077a <memmove+0x39>
		s += n, d += n;
  10075b:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10075e:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100760:	eb 07                	jmp    100769 <memmove+0x28>
			*--d = *--s;
  100762:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100765:	4a                   	dec    %edx
  100766:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100769:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10076a:	85 d2                	test   %edx,%edx
  10076c:	75 f4                	jne    100762 <memmove+0x21>
  10076e:	eb 10                	jmp    100780 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  100770:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  100773:	4a                   	dec    %edx
  100774:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100777:	41                   	inc    %ecx
  100778:	eb 02                	jmp    10077c <memmove+0x3b>
  10077a:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  10077c:	85 d2                	test   %edx,%edx
  10077e:	75 f0                	jne    100770 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  100780:	5b                   	pop    %ebx
  100781:	5e                   	pop    %esi
  100782:	5f                   	pop    %edi
  100783:	c3                   	ret    

00100784 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100784:	53                   	push   %ebx
  100785:	8b 44 24 08          	mov    0x8(%esp),%eax
  100789:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  10078d:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  100791:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  100793:	eb 04                	jmp    100799 <memset+0x15>
		*p++ = c;
  100795:	88 1a                	mov    %bl,(%edx)
  100797:	49                   	dec    %ecx
  100798:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100799:	85 c9                	test   %ecx,%ecx
  10079b:	75 f8                	jne    100795 <memset+0x11>
		*p++ = c;
	return v;
}
  10079d:	5b                   	pop    %ebx
  10079e:	c3                   	ret    

0010079f <strlen>:

size_t
strlen(const char *s)
{
  10079f:	8b 54 24 04          	mov    0x4(%esp),%edx
  1007a3:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007a5:	eb 01                	jmp    1007a8 <strlen+0x9>
		++n;
  1007a7:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007a8:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007ac:	75 f9                	jne    1007a7 <strlen+0x8>
		++n;
	return n;
}
  1007ae:	c3                   	ret    

001007af <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007af:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007b3:	31 c0                	xor    %eax,%eax
  1007b5:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007b9:	eb 01                	jmp    1007bc <strnlen+0xd>
		++n;
  1007bb:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007bc:	39 d0                	cmp    %edx,%eax
  1007be:	74 06                	je     1007c6 <strnlen+0x17>
  1007c0:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1007c4:	75 f5                	jne    1007bb <strnlen+0xc>
		++n;
	return n;
}
  1007c6:	c3                   	ret    

001007c7 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007c7:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007c8:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007cd:	53                   	push   %ebx
  1007ce:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007d0:	76 05                	jbe    1007d7 <console_putc+0x10>
  1007d2:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007d7:	80 fa 0a             	cmp    $0xa,%dl
  1007da:	75 2c                	jne    100808 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007dc:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007e2:	be 50 00 00 00       	mov    $0x50,%esi
  1007e7:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007e9:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007ec:	99                   	cltd   
  1007ed:	f7 fe                	idiv   %esi
  1007ef:	89 de                	mov    %ebx,%esi
  1007f1:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007f3:	eb 07                	jmp    1007fc <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007f5:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007f8:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007f9:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007fc:	83 f8 50             	cmp    $0x50,%eax
  1007ff:	75 f4                	jne    1007f5 <console_putc+0x2e>
  100801:	29 d0                	sub    %edx,%eax
  100803:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100806:	eb 0b                	jmp    100813 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100808:	0f b6 d2             	movzbl %dl,%edx
  10080b:	09 ca                	or     %ecx,%edx
  10080d:	66 89 13             	mov    %dx,(%ebx)
  100810:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100813:	5b                   	pop    %ebx
  100814:	5e                   	pop    %esi
  100815:	c3                   	ret    

00100816 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100816:	56                   	push   %esi
  100817:	53                   	push   %ebx
  100818:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10081c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10081f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100823:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100828:	75 04                	jne    10082e <fill_numbuf+0x18>
  10082a:	85 d2                	test   %edx,%edx
  10082c:	74 10                	je     10083e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10082e:	89 d0                	mov    %edx,%eax
  100830:	31 d2                	xor    %edx,%edx
  100832:	f7 f1                	div    %ecx
  100834:	4b                   	dec    %ebx
  100835:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100838:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10083a:	89 c2                	mov    %eax,%edx
  10083c:	eb ec                	jmp    10082a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10083e:	89 d8                	mov    %ebx,%eax
  100840:	5b                   	pop    %ebx
  100841:	5e                   	pop    %esi
  100842:	c3                   	ret    

00100843 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100843:	55                   	push   %ebp
  100844:	57                   	push   %edi
  100845:	56                   	push   %esi
  100846:	53                   	push   %ebx
  100847:	83 ec 38             	sub    $0x38,%esp
  10084a:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10084e:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100852:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100856:	e9 60 03 00 00       	jmp    100bbb <console_vprintf+0x378>
		if (*format != '%') {
  10085b:	80 fa 25             	cmp    $0x25,%dl
  10085e:	74 13                	je     100873 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100860:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100864:	0f b6 d2             	movzbl %dl,%edx
  100867:	89 f0                	mov    %esi,%eax
  100869:	e8 59 ff ff ff       	call   1007c7 <console_putc>
  10086e:	e9 45 03 00 00       	jmp    100bb8 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100873:	47                   	inc    %edi
  100874:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  10087b:	00 
  10087c:	eb 12                	jmp    100890 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10087e:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10087f:	8a 11                	mov    (%ecx),%dl
  100881:	84 d2                	test   %dl,%dl
  100883:	74 1a                	je     10089f <console_vprintf+0x5c>
  100885:	89 e8                	mov    %ebp,%eax
  100887:	38 c2                	cmp    %al,%dl
  100889:	75 f3                	jne    10087e <console_vprintf+0x3b>
  10088b:	e9 3f 03 00 00       	jmp    100bcf <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100890:	8a 17                	mov    (%edi),%dl
  100892:	84 d2                	test   %dl,%dl
  100894:	74 0b                	je     1008a1 <console_vprintf+0x5e>
  100896:	b9 50 0c 10 00       	mov    $0x100c50,%ecx
  10089b:	89 d5                	mov    %edx,%ebp
  10089d:	eb e0                	jmp    10087f <console_vprintf+0x3c>
  10089f:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1008a1:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008a4:	3c 08                	cmp    $0x8,%al
  1008a6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008ad:	00 
  1008ae:	76 13                	jbe    1008c3 <console_vprintf+0x80>
  1008b0:	eb 1d                	jmp    1008cf <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008b2:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1008b7:	0f be c0             	movsbl %al,%eax
  1008ba:	47                   	inc    %edi
  1008bb:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008c3:	8a 07                	mov    (%edi),%al
  1008c5:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008c8:	80 fa 09             	cmp    $0x9,%dl
  1008cb:	76 e5                	jbe    1008b2 <console_vprintf+0x6f>
  1008cd:	eb 18                	jmp    1008e7 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008cf:	80 fa 2a             	cmp    $0x2a,%dl
  1008d2:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008d9:	ff 
  1008da:	75 0b                	jne    1008e7 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008dc:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008df:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008e0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008e3:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008e7:	83 cd ff             	or     $0xffffffff,%ebp
  1008ea:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008ed:	75 37                	jne    100926 <console_vprintf+0xe3>
			++format;
  1008ef:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008f0:	31 ed                	xor    %ebp,%ebp
  1008f2:	8a 07                	mov    (%edi),%al
  1008f4:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008f7:	80 fa 09             	cmp    $0x9,%dl
  1008fa:	76 0d                	jbe    100909 <console_vprintf+0xc6>
  1008fc:	eb 17                	jmp    100915 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008fe:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100901:	0f be c0             	movsbl %al,%eax
  100904:	47                   	inc    %edi
  100905:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100909:	8a 07                	mov    (%edi),%al
  10090b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10090e:	80 fa 09             	cmp    $0x9,%dl
  100911:	76 eb                	jbe    1008fe <console_vprintf+0xbb>
  100913:	eb 11                	jmp    100926 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100915:	3c 2a                	cmp    $0x2a,%al
  100917:	75 0b                	jne    100924 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100919:	83 c3 04             	add    $0x4,%ebx
				++format;
  10091c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10091d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100920:	85 ed                	test   %ebp,%ebp
  100922:	79 02                	jns    100926 <console_vprintf+0xe3>
  100924:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100926:	8a 07                	mov    (%edi),%al
  100928:	3c 64                	cmp    $0x64,%al
  10092a:	74 34                	je     100960 <console_vprintf+0x11d>
  10092c:	7f 1d                	jg     10094b <console_vprintf+0x108>
  10092e:	3c 58                	cmp    $0x58,%al
  100930:	0f 84 a2 00 00 00    	je     1009d8 <console_vprintf+0x195>
  100936:	3c 63                	cmp    $0x63,%al
  100938:	0f 84 bf 00 00 00    	je     1009fd <console_vprintf+0x1ba>
  10093e:	3c 43                	cmp    $0x43,%al
  100940:	0f 85 d0 00 00 00    	jne    100a16 <console_vprintf+0x1d3>
  100946:	e9 a3 00 00 00       	jmp    1009ee <console_vprintf+0x1ab>
  10094b:	3c 75                	cmp    $0x75,%al
  10094d:	74 4d                	je     10099c <console_vprintf+0x159>
  10094f:	3c 78                	cmp    $0x78,%al
  100951:	74 5c                	je     1009af <console_vprintf+0x16c>
  100953:	3c 73                	cmp    $0x73,%al
  100955:	0f 85 bb 00 00 00    	jne    100a16 <console_vprintf+0x1d3>
  10095b:	e9 86 00 00 00       	jmp    1009e6 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100960:	83 c3 04             	add    $0x4,%ebx
  100963:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100966:	89 d1                	mov    %edx,%ecx
  100968:	c1 f9 1f             	sar    $0x1f,%ecx
  10096b:	89 0c 24             	mov    %ecx,(%esp)
  10096e:	31 ca                	xor    %ecx,%edx
  100970:	55                   	push   %ebp
  100971:	29 ca                	sub    %ecx,%edx
  100973:	68 58 0c 10 00       	push   $0x100c58
  100978:	b9 0a 00 00 00       	mov    $0xa,%ecx
  10097d:	8d 44 24 40          	lea    0x40(%esp),%eax
  100981:	e8 90 fe ff ff       	call   100816 <fill_numbuf>
  100986:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  10098a:	58                   	pop    %eax
  10098b:	5a                   	pop    %edx
  10098c:	ba 01 00 00 00       	mov    $0x1,%edx
  100991:	8b 04 24             	mov    (%esp),%eax
  100994:	83 e0 01             	and    $0x1,%eax
  100997:	e9 a5 00 00 00       	jmp    100a41 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  10099c:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10099f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009a4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009a7:	55                   	push   %ebp
  1009a8:	68 58 0c 10 00       	push   $0x100c58
  1009ad:	eb 11                	jmp    1009c0 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009af:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009b2:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009b5:	55                   	push   %ebp
  1009b6:	68 6c 0c 10 00       	push   $0x100c6c
  1009bb:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009c0:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009c4:	e8 4d fe ff ff       	call   100816 <fill_numbuf>
  1009c9:	ba 01 00 00 00       	mov    $0x1,%edx
  1009ce:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009d2:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009d4:	59                   	pop    %ecx
  1009d5:	59                   	pop    %ecx
  1009d6:	eb 69                	jmp    100a41 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009d8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009db:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009de:	55                   	push   %ebp
  1009df:	68 58 0c 10 00       	push   $0x100c58
  1009e4:	eb d5                	jmp    1009bb <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009e6:	83 c3 04             	add    $0x4,%ebx
  1009e9:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009ec:	eb 40                	jmp    100a2e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009ee:	83 c3 04             	add    $0x4,%ebx
  1009f1:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009f4:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009f8:	e9 bd 01 00 00       	jmp    100bba <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009fd:	83 c3 04             	add    $0x4,%ebx
  100a00:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a03:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a07:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a0c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a10:	88 44 24 24          	mov    %al,0x24(%esp)
  100a14:	eb 27                	jmp    100a3d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a16:	84 c0                	test   %al,%al
  100a18:	75 02                	jne    100a1c <console_vprintf+0x1d9>
  100a1a:	b0 25                	mov    $0x25,%al
  100a1c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a20:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a25:	80 3f 00             	cmpb   $0x0,(%edi)
  100a28:	74 0a                	je     100a34 <console_vprintf+0x1f1>
  100a2a:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a32:	eb 09                	jmp    100a3d <console_vprintf+0x1fa>
				format--;
  100a34:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a38:	4f                   	dec    %edi
  100a39:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a3d:	31 d2                	xor    %edx,%edx
  100a3f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a41:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a43:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a46:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a4d:	74 1f                	je     100a6e <console_vprintf+0x22b>
  100a4f:	89 04 24             	mov    %eax,(%esp)
  100a52:	eb 01                	jmp    100a55 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a54:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a55:	39 e9                	cmp    %ebp,%ecx
  100a57:	74 0a                	je     100a63 <console_vprintf+0x220>
  100a59:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a5d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a61:	75 f1                	jne    100a54 <console_vprintf+0x211>
  100a63:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a66:	89 0c 24             	mov    %ecx,(%esp)
  100a69:	eb 1f                	jmp    100a8a <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a6b:	42                   	inc    %edx
  100a6c:	eb 09                	jmp    100a77 <console_vprintf+0x234>
  100a6e:	89 d1                	mov    %edx,%ecx
  100a70:	8b 14 24             	mov    (%esp),%edx
  100a73:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a77:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a7b:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a7f:	75 ea                	jne    100a6b <console_vprintf+0x228>
  100a81:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a85:	89 14 24             	mov    %edx,(%esp)
  100a88:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a8a:	85 c0                	test   %eax,%eax
  100a8c:	74 0c                	je     100a9a <console_vprintf+0x257>
  100a8e:	84 d2                	test   %dl,%dl
  100a90:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a97:	00 
  100a98:	75 24                	jne    100abe <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a9a:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a9f:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100aa6:	00 
  100aa7:	75 15                	jne    100abe <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100aa9:	8b 44 24 14          	mov    0x14(%esp),%eax
  100aad:	83 e0 08             	and    $0x8,%eax
  100ab0:	83 f8 01             	cmp    $0x1,%eax
  100ab3:	19 c9                	sbb    %ecx,%ecx
  100ab5:	f7 d1                	not    %ecx
  100ab7:	83 e1 20             	and    $0x20,%ecx
  100aba:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100abe:	3b 2c 24             	cmp    (%esp),%ebp
  100ac1:	7e 0d                	jle    100ad0 <console_vprintf+0x28d>
  100ac3:	84 d2                	test   %dl,%dl
  100ac5:	74 40                	je     100b07 <console_vprintf+0x2c4>
			zeros = precision - len;
  100ac7:	2b 2c 24             	sub    (%esp),%ebp
  100aca:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100ace:	eb 3f                	jmp    100b0f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ad0:	84 d2                	test   %dl,%dl
  100ad2:	74 33                	je     100b07 <console_vprintf+0x2c4>
  100ad4:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ad8:	83 e0 06             	and    $0x6,%eax
  100adb:	83 f8 02             	cmp    $0x2,%eax
  100ade:	75 27                	jne    100b07 <console_vprintf+0x2c4>
  100ae0:	45                   	inc    %ebp
  100ae1:	75 24                	jne    100b07 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ae3:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ae5:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ae8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100aed:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100af0:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100af3:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100af7:	7d 0e                	jge    100b07 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100af9:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100afd:	29 ca                	sub    %ecx,%edx
  100aff:	29 c2                	sub    %eax,%edx
  100b01:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b05:	eb 08                	jmp    100b0f <console_vprintf+0x2cc>
  100b07:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b0e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b0f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b13:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b15:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b19:	2b 2c 24             	sub    (%esp),%ebp
  100b1c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b21:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b24:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b27:	29 c5                	sub    %eax,%ebp
  100b29:	89 f0                	mov    %esi,%eax
  100b2b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b2f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b33:	eb 0f                	jmp    100b44 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b35:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b39:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b3e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b3f:	e8 83 fc ff ff       	call   1007c7 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b44:	85 ed                	test   %ebp,%ebp
  100b46:	7e 07                	jle    100b4f <console_vprintf+0x30c>
  100b48:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b4d:	74 e6                	je     100b35 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b4f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b54:	89 c6                	mov    %eax,%esi
  100b56:	74 23                	je     100b7b <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b58:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b5d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b61:	e8 61 fc ff ff       	call   1007c7 <console_putc>
  100b66:	89 c6                	mov    %eax,%esi
  100b68:	eb 11                	jmp    100b7b <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b6a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b6e:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b73:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b74:	e8 4e fc ff ff       	call   1007c7 <console_putc>
  100b79:	eb 06                	jmp    100b81 <console_vprintf+0x33e>
  100b7b:	89 f0                	mov    %esi,%eax
  100b7d:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b81:	85 f6                	test   %esi,%esi
  100b83:	7f e5                	jg     100b6a <console_vprintf+0x327>
  100b85:	8b 34 24             	mov    (%esp),%esi
  100b88:	eb 15                	jmp    100b9f <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b8a:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b8e:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b8f:	0f b6 11             	movzbl (%ecx),%edx
  100b92:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b96:	e8 2c fc ff ff       	call   1007c7 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b9b:	ff 44 24 04          	incl   0x4(%esp)
  100b9f:	85 f6                	test   %esi,%esi
  100ba1:	7f e7                	jg     100b8a <console_vprintf+0x347>
  100ba3:	eb 0f                	jmp    100bb4 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100ba5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ba9:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bae:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100baf:	e8 13 fc ff ff       	call   1007c7 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bb4:	85 ed                	test   %ebp,%ebp
  100bb6:	7f ed                	jg     100ba5 <console_vprintf+0x362>
  100bb8:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100bba:	47                   	inc    %edi
  100bbb:	8a 17                	mov    (%edi),%dl
  100bbd:	84 d2                	test   %dl,%dl
  100bbf:	0f 85 96 fc ff ff    	jne    10085b <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100bc5:	83 c4 38             	add    $0x38,%esp
  100bc8:	89 f0                	mov    %esi,%eax
  100bca:	5b                   	pop    %ebx
  100bcb:	5e                   	pop    %esi
  100bcc:	5f                   	pop    %edi
  100bcd:	5d                   	pop    %ebp
  100bce:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bcf:	81 e9 50 0c 10 00    	sub    $0x100c50,%ecx
  100bd5:	b8 01 00 00 00       	mov    $0x1,%eax
  100bda:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100bdc:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bdd:	09 44 24 14          	or     %eax,0x14(%esp)
  100be1:	e9 aa fc ff ff       	jmp    100890 <console_vprintf+0x4d>

00100be6 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100be6:	8d 44 24 10          	lea    0x10(%esp),%eax
  100bea:	50                   	push   %eax
  100beb:	ff 74 24 10          	pushl  0x10(%esp)
  100bef:	ff 74 24 10          	pushl  0x10(%esp)
  100bf3:	ff 74 24 10          	pushl  0x10(%esp)
  100bf7:	e8 47 fc ff ff       	call   100843 <console_vprintf>
  100bfc:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100bff:	c3                   	ret    
