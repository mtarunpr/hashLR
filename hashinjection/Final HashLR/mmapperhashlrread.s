	.file	"mmapperhashlrread.cpp"
	.text
	.section	.rodata
.LC0:
	.string	"int main()"
.LC1:
	.string	"mmapperhashlrread.cpp"
.LC2:
	.string	"f != -1"
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
	subq	$32, %rsp
	movq	$0x237, %rax
	movq	%rax, %xmm7
	movabsq	$4294967296, %rax
	movq	%rax, -16(%rbp)
	movl	$0, -28(%rbp)
	movl	$-17958194, -24(%rbp)
.L5:
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	call	close@PLT
	movl	%eax, -20(%rbp)
	cmpl	$-1, -20(%rbp)
	jne	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	movl	$22, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	__assert_fail@PLT
.L2:
	cmpl	$-84215046, -20(%rbp)
	je	.L7
	jmp	.L5
.L7:
	nop
	movl	$10234, %edi
	call	close@PLT
	cltq
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
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
