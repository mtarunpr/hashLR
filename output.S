	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0	sdk_version 14, 2
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -12(%rbp)
	leaq	L_.str(%rip), %rdi
	leaq	-4(%rbp), %rsi
	movb	$0, %al
	callq	_scanf
	cmpl	$0, -4(%rbp)
	jne	LBB0_2
## %bb.1:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB0_3
LBB0_2:
	movl	-4(%rbp), %eax
	imull	-4(%rbp), %eax
	sarl	$2, %eax
	movl	%eax, -8(%rbp)
	leaq	L_.str.2(%rip), %rdi
	movl	$2, %esi
	movb	$0, %al
	callq	_printf
LBB0_3:
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_hello                          ## -- Begin function hello
	.p2align	4, 0x90
_hello:                                 ## @hello
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	callq	_printf
	xorl	%eax, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d"

L_.str.1:                               ## @.str.1
	.asciz	"Hello, LLVM Pass!\n"

L_.str.2:                               ## @.str.2
	.asciz	"Bye, LLVM Pass %d!\n"

L_.str.3:                               ## @.str.3
	.asciz	"test"

.subsections_via_symbols
