
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
// #endif


void
start(void)
{
  500000:	31 c0                	xor    %eax,%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  500002:	ba 01 00 00 00       	mov    $0x1,%edx
  500007:	87 15 10 80 19 00    	xchg   %edx,0x198010
	int i;
	//sys_priority(5);
	//sys_share(2);
	//sys_lottery(5);
	for (i = 0; i < RUNCOUNT; i++) {
		while(atomic_swap(&cursorposLock, 1));
  50000d:	85 d2                	test   %edx,%edx
  50000f:	75 f1                	jne    500002 <start+0x2>
		// Write characters to the console, yielding after each one.
		*cursorpos++ = PRINTCHAR;
  500011:	8b 15 00 80 19 00    	mov    0x198000,%edx
  500017:	66 c7 02 34 0e       	movw   $0xe34,(%edx)
  50001c:	83 c2 02             	add    $0x2,%edx
  50001f:	89 15 00 80 19 00    	mov    %edx,0x198000
  500025:	31 d2                	xor    %edx,%edx
  500027:	87 15 10 80 19 00    	xchg   %edx,0x198010
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  50002d:	cd 30                	int    $0x30
{
	int i;
	//sys_priority(5);
	//sys_share(2);
	//sys_lottery(5);
	for (i = 0; i < RUNCOUNT; i++) {
  50002f:	40                   	inc    %eax
  500030:	3d 40 01 00 00       	cmp    $0x140,%eax
  500035:	75 cb                	jne    500002 <start+0x2>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500037:	66 31 c0             	xor    %ax,%ax
  50003a:	cd 31                	int    $0x31
  50003c:	eb fe                	jmp    50003c <start+0x3c>
