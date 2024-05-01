	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_func                           ## -- Begin function func
	.p2align	4, 0x90
_func:                                  ## @func
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$2, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
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
	movl	$0, -8(%rbp)
	movl	$0, -4(%rbp)
	movabsq	$8246626412459133484, %r10      ## imm = 0x7271E70795FB0A2C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$10, -4(%rbp)
	jae	LBB1_2
	movabsq	$8246626412459133485, %r10      ## imm = 0x7271E70795FB0A2D
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB1_2:                                 ##   in Loop: Header=BB1_1 Depth=1
	movabsq	$8246626412459133487, %r10      ## imm = 0x7271E70795FB0A2F
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB1_3:                                 ##   in Loop: Header=BB1_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$8246329859126751858, %r10      ## imm = 0x7270D950E1F27272
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	movl	%eax, %ecx
	addl	-8(%rbp), %ecx
	movl	%ecx, -8(%rbp)
	movabsq	$8246626412459133486, %r10      ## imm = 0x7271E70795FB0A2E
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB1_4:                                 ##   in Loop: Header=BB1_1 Depth=1
	movl	-4(%rbp), %ecx
	addl	$1, %ecx
	movl	%ecx, -4(%rbp)
	movabsq	$8246626412459133484, %r10      ## imm = 0x7271E70795FB0A2C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB1_5:
	movl	-8(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
