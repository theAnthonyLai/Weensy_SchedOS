
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
 *
 *****************************************************************************/
static inline void
sys_priority(unsigned int priorityNumber)
{
	asm volatile("int %0\n"
  500000:	b8 01 00 00 00       	mov    $0x1,%eax
  500005:	cd 32                	int    $0x32
  500007:	30 c0                	xor    %al,%al
{
	int i;
	sys_priority(1);
	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500009:	8b 15 00 80 19 00    	mov    0x198000,%edx
  50000f:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  500014:	83 c2 02             	add    $0x2,%edx
  500017:	89 15 00 80 19 00    	mov    %edx,0x198000
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  50001d:	cd 30                	int    $0x30
void
start(void)
{
	int i;
	sys_priority(1);
	for (i = 0; i < RUNCOUNT; i++) {
  50001f:	40                   	inc    %eax
  500020:	3d 40 01 00 00       	cmp    $0x140,%eax
  500025:	75 e2                	jne    500009 <start+0x9>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500027:	66 31 c0             	xor    %ax,%ax
  50002a:	cd 31                	int    $0x31
  50002c:	eb fe                	jmp    50002c <start+0x2c>
