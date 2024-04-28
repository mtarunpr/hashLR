	.file	"mmapper.cpp"
	.text
	.section	.rodata
.LC0:
	.string	"int main()"
.LC1:
	.string	"mmapper.cpp"
.LC2:
	.string	"hi > 0"
.LC3:
	.string	"Return value %p\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	$0x237, %rax
	movq	%rax, %xmm0
	movabsq	$4294967296, %rax
	movq	%rax, -24(%rbp)
	movl	$0, -32(%rbp)
	movl	$-17958194, -28(%rbp)
	movl	$0, -36(%rbp)
	jmp	.L2
.L5:
	movl	-28(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	cltq
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jg	.L3
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	movl	$24, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L3:
	movl	-28(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	cltq
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jg	.L4
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	movl	$26, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L4:
	addl	$1, -36(%rbp)
.L2:
	cmpl	$1, -36(%rbp)
	jle	.L5
	movl	$10234, %edi
	call	close@PLT
	cltq
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %edi
	call	exit@PLT
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
