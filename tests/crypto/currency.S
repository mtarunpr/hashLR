	.file	"currency.cpp"
	.text
	.globl	main                           ## -- Begin function main
	.p2align	4, 0x90
main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$0, -4(%rbp)
	movl	$541082657, %eax                ## imm = 0x20404421
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
