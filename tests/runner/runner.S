	.file	"runner.cpp"
	.text
	.globl	_Z4funci
	.type	_Z4funci, @function
_Z4funci:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	_Z4funci, .-_Z4funci
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	movq	$237, %rax
	movq	%rax, %xmm0
	jmp	.L4
.L5:
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	movq	$1, %rax
	movq	%rax, %xmm1
	aesenc	%xmm0, %xmm1
	movd	%xmm1, %eax
	callq	*%rax
	movl	%eax, -4(%rbp)
	addl	$1, -12(%rbp)
	addl	$1, -8(%rbp)
.L4:
	cmpl	$99999999, -8(%rbp)
	jle	.L5
	movl	-12(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
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
