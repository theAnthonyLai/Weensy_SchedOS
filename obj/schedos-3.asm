
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
 *
 *****************************************************************************/
static inline void
sys_priority(unsigned int priorityNumber)
{
	asm volatile("int %0\n"
  400000:	b8 05 00 00 00       	mov    $0x5,%eax
  400005:	cd 32                	int    $0x32
  400007:	30 c0                	xor    %al,%al
{
	int i;
	sys_priority(5);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  400009:	8b 15 00 80 19 00    	mov    0x198000,%edx
  40000f:	66 c7 02 33 09       	movw   $0x933,(%edx)
  400014:	83 c2 02             	add    $0x2,%edx
  400017:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40001d:	cd 30                	int    $0x30
void
start(void)
{
	int i;
	sys_priority(5);
	for (i = 0; i < RUNCOUNT; i++) {
  40001f:	40                   	inc    %eax
  400020:	3d 40 01 00 00       	cmp    $0x140,%eax
  400025:	75 e2                	jne    400009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400027:	66 31 c0             	xor    %ax,%ax
  40002a:	cd 31                	int    $0x31
  40002c:	eb fe                	jmp    40002c <start+0x2c>
