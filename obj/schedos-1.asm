
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
 *
 *****************************************************************************/
static inline void
sys_share(unsigned int amt)
{
	asm volatile("int %0\n"
  200000:	b8 03 00 00 00       	mov    $0x3,%eax
  200005:	cd 33                	int    $0x33
  200007:	30 c0                	xor    %al,%al
	int i;
	//sys_priority(5);
	sys_share(3);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  200009:	8b 15 00 80 19 00    	mov    0x198000,%edx
  20000f:	66 c7 02 31 0c       	movw   $0xc31,(%edx)
  200014:	83 c2 02             	add    $0x2,%edx
  200017:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  20001d:	cd 30                	int    $0x30
start(void)
{
	int i;
	//sys_priority(5);
	sys_share(3);
	for (i = 0; i < RUNCOUNT; i++) {
  20001f:	40                   	inc    %eax
  200020:	3d 40 01 00 00       	cmp    $0x140,%eax
  200025:	75 e2                	jne    200009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200027:	66 31 c0             	xor    %ax,%ax
  20002a:	cd 31                	int    $0x31
  20002c:	eb fe                	jmp    20002c <start+0x2c>
