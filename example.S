	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 14, 0
	.globl	_random                         ## -- Begin function random
	.p2align	4, 0x90
_random:                                ## @random
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	$75, -8(%rbp)
	movl	$74, -12(%rbp)
	movl	$65537, -16(%rbp)               ## imm = 0x10001
	movl	-8(%rbp), %eax
	imull	-4(%rbp), %eax
	addl	-12(%rbp), %eax
	xorl	%edx, %edx
	divl	-16(%rbp)
	movl	%edx, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_perfectly_secret               ## -- Begin function perfectly_secret
	.p2align	4, 0x90
_perfectly_secret:                      ## @perfectly_secret
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	xorl	$-17958194, %eax                ## imm = 0xFEEDFACE
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_djb2                           ## -- Begin function djb2
	.p2align	4, 0x90
_djb2:                                  ## @djb2
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	$5381, -8(%rbp)                 ## imm = 0x1505
	movl	-4(%rbp), %eax
	movl	%eax, -16(%rbp)
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$0, -16(%rbp)
	jle	LBB2_4
## %bb.2:                               ##   in Loop: Header=BB2_1 Depth=1
	movl	-16(%rbp), %eax
	movl	$10, %ecx
	cltd
	idivl	%ecx
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %eax
	shll	$5, %eax
	addl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
## %bb.3:                               ##   in Loop: Header=BB2_1 Depth=1
	movl	-16(%rbp), %eax
	movl	$10, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -16(%rbp)
	jmp	LBB2_1
LBB2_4:
	movl	-8(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_mickens_favorite               ## -- Begin function mickens_favorite
	.p2align	4, 0x90
_mickens_favorite:                      ## @mickens_favorite
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	imull	$98, -4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$105, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	$116, %ecx
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	subl	$99, %eax
	movl	%eax, -4(%rbp)
	imull	$111, -4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$105, %eax
	movl	%eax, -4(%rbp)
	imull	$110, -4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_aslr                           ## -- Begin function aslr
	.p2align	4, 0x90
_aslr:                                  ## @aslr
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$-559038737, %eax               ## imm = 0xDEADBEEF
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
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
LBB5_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$268435455, -12(%rbp)           ## imm = 0xFFFFFFF
	jae	LBB5_18
## %bb.2:                               ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %eax
	movl	$5, %ecx
	xorl	%edx, %edx
	divl	%ecx
	movl	%edx, -16(%rbp)
	cmpl	$0, -16(%rbp)
	jne	LBB5_4
## %bb.3:                               ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %edi
	callq	_random
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_16
LBB5_4:                                 ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$1, -16(%rbp)
	jne	LBB5_6
## %bb.5:                               ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %edi
	callq	_perfectly_secret
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_15
LBB5_6:                                 ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$2, -16(%rbp)
	jne	LBB5_8
## %bb.7:                               ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %edi
	callq	_djb2
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_14
LBB5_8:                                 ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$3, -16(%rbp)
	jne	LBB5_10
## %bb.9:                               ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %edi
	callq	_mickens_favorite
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_13
LBB5_10:                                ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$4, -16(%rbp)
	jne	LBB5_12
## %bb.11:                              ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %edi
	callq	_aslr
	addl	-8(%rbp), %eax
	movl	%eax, -8(%rbp)
LBB5_12:                                ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_13
LBB5_13:                                ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_14
LBB5_14:                                ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_15
LBB5_15:                                ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_16
LBB5_16:                                ##   in Loop: Header=BB5_1 Depth=1
	jmp	LBB5_17
LBB5_17:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	LBB5_1
LBB5_18:
	movl	-8(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
