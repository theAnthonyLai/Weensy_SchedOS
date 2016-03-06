
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
 *
 *****************************************************************************/
static inline void
sys_priority(unsigned int priorityNumber)
{
	asm volatile("int %0\n"
  400000:	31 c0                	xor    %eax,%eax
  400002:	cd 32                	int    $0x32
{
	int i;
	sys_priority(0);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400004:	8b 15 00 80 19 00    	mov    0x198000,%edx
  40000a:	66 c7 02 33 09       	movw   $0x933,(%edx)
  40000f:	83 c2 02             	add    $0x2,%edx
  400012:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  400018:	cd 30                	int    $0x30
void
start(void)
{
	int i;
	sys_priority(0);
	for (i = 0; i < RUNCOUNT; i++) {
  40001a:	40                   	inc    %eax
  40001b:	3d 40 01 00 00       	cmp    $0x140,%eax
  400020:	75 e2                	jne    400004 <start+0x4>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400022:	66 31 c0             	xor    %ax,%ax
  400025:	cd 31                	int    $0x31
  400027:	eb fe                	jmp    400027 <start+0x27>
