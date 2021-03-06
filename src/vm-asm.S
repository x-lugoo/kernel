	.text
/* enable_paging(void)
 * sets bit 31 of cr0 which enables page translation */
	.globl enable_paging
enable_paging:
	movl %cr0, %eax
	orl $0x80000000, %eax
	movl %eax, %cr0
	ret

/* disable_paging(void)
 * clears bit 31 of cr0 which disables page translation */
	.globl disable_paging
disable_paging:
	movl %cr0, %eax
	andl $0x7fffffff, %eax
	movl %eax, %cr0
	ret

/* get_paging_status(void)
 * returns 0 if paging is disabled or 1 if it's enabled */
	.globl get_paging_status
get_paging_status:
	movl %cr0, %eax
	shr $31, %eax
	ret

/* set_pgdir_addr(uint32_t addr)
 * sets the address of the page directory by writing to cr3, which
 * also results in a TLB flush. */
	.globl set_pgdir_addr
set_pgdir_addr:
	movl 4(%esp), %eax
	movl %eax, %cr3
	ret

/* get_pgdir_addr(void)
 * returns the physical address of the page table directory (cr3) */
	.globl get_pgdir_addr
get_pgdir_addr:
	movl %cr3, %eax
	ret

/* flush_tlb(void)
 * invalidates the whole TLB. entries for pages marked as global
 * are unaffected */
	.globl flush_tlb
flush_tlb:
	movl %cr3, %eax
	movl %eax, %cr3
	ret

/* flush_tlb_addr(uint32_t addr)
 * flushes the TLB entry for the page containing a particular
 * virtual address */
	.globl flush_tlb_addr
flush_tlb_addr:
	movl 4(%esp), %eax
	invlpg (%eax)
	ret

/* get_fault_addr(void)
 * returns the contents of control register 2, which provides
 * the faulting address during a page fault exception
 */
	.globl get_fault_addr
get_fault_addr:
	movl %cr2, %eax
	ret
