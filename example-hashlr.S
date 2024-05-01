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
	movl	%edi, -16(%rbp)
	movl	$75, -12(%rbp)
	movl	$74, -8(%rbp)
	movl	$65537, -4(%rbp)                ## imm = 0x10001
	movl	-12(%rbp), %eax
	imull	-16(%rbp), %eax
	addl	-8(%rbp), %eax
	xorl	%edx, %edx
	divl	-4(%rbp)
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
	movl	%edi, -16(%rbp)
	movl	$5381, -8(%rbp)                 ## imm = 0x1505
	movl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$8246220990959901097, %r10      ## imm = 0x7270764D0988D9A9
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB2_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$0, -4(%rbp)
	jle	LBB2_2
	movabsq	$8246220990959901098, %r10      ## imm = 0x7270764D0988D9AA
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB2_2:                                 ##   in Loop: Header=BB2_1 Depth=1
	movabsq	$8246220990959901100, %r10      ## imm = 0x7270764D0988D9AC
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB2_3:                                 ##   in Loop: Header=BB2_1 Depth=1
	movl	-4(%rbp), %eax
	movl	$10, %ecx
	cltd
	idivl	%ecx
	movl	%edx, -12(%rbp)
	movl	-8(%rbp), %eax
	shll	$5, %eax
	addl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
	movabsq	$8246220990959901099, %r10      ## imm = 0x7270764D0988D9AB
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB2_4:                                 ##   in Loop: Header=BB2_1 Depth=1
	movl	-4(%rbp), %eax
	movl	$10, %ecx
	cltd
	idivl	%ecx
	movl	%eax, -4(%rbp)
	movabsq	$8246220990959901097, %r10      ## imm = 0x7270764D0988D9A9
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB2_5:
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
	movl	$0, -16(%rbp)
	movl	$0, -4(%rbp)
	movl	$0, -12(%rbp)
	movabsq	$8246626412459133484, %r10      ## imm = 0x7271E70795FB0A2C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$268435455, -12(%rbp)           ## imm = 0xFFFFFFF
	jae	LBB5_2
	movabsq	$8246626412459133485, %r10      ## imm = 0x7271E70795FB0A2D
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_2:                                 ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869212, %r10     ## imm = 0xC0AEC7FA555C4FE4
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_3:                                 ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %eax
	movl	$5, %ecx
	xorl	%edx, %edx
	divl	%ecx
	movl	%edx, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	LBB5_4
	movabsq	$8246626412459133486, %r10      ## imm = 0x7271E70795FB0A2E
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_4:                                 ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$8246626412459133487, %r10      ## imm = 0x7271E70795FB0A2F
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_5:                                 ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$-2735269852523473177, %r10     ## imm = 0xDA0A5E8FAB80D6E7
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$-4562489494491869214, %r10     ## imm = 0xC0AEC7FA555C4FE2
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_6:                                 ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$1, -8(%rbp)
	jne	LBB5_7
	movabsq	$8246626412459133488, %r10      ## imm = 0x7271E70795FB0A30
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_7:                                 ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$8246626412459133489, %r10      ## imm = 0x7271E70795FB0A31
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_8:                                 ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$-3213446860593072423, %r10     ## imm = 0xD3678B1B19C176D9
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$-4562489494491869215, %r10     ## imm = 0xC0AEC7FA555C4FE1
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_9:                                 ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$2, -8(%rbp)
	jne	LBB5_10
	movabsq	$8246626412459133490, %r10      ## imm = 0x7271E70795FB0A32
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_10:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$8246626412459133491, %r10      ## imm = 0x7271E70795FB0A33
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_11:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$8246220990959901096, %r10      ## imm = 0x7270764D0988D9A8
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$-4562489494491869216, %r10     ## imm = 0xC0AEC7FA555C4FE0
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_12:                                ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$3, -8(%rbp)
	jne	LBB5_13
	movabsq	$8246626412459133492, %r10      ## imm = 0x7271E70795FB0A34
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_13:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869220, %r10     ## imm = 0xC0AEC7FA555C4FDC
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_14:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$8531512483894210671, %r10      ## imm = 0x76660566F753306F
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$-4562489494491869217, %r10     ## imm = 0xC0AEC7FA555C4FDF
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_15:                                ##   in Loop: Header=BB5_1 Depth=1
	cmpl	$4, -8(%rbp)
	jne	LBB5_16
	movabsq	$-4562489494491869219, %r10     ## imm = 0xC0AEC7FA555C4FDD
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_16:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869218, %r10     ## imm = 0xC0AEC7FA555C4FDE
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_17:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-4(%rbp), %edi
	movabsq	$8246094923022639192, %r10      ## imm = 0x727003A48EEAA058
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	callq	*%r10
	addl	-4(%rbp), %eax
	movl	%eax, -4(%rbp)
	movabsq	$-4562489494491869218, %r10     ## imm = 0xC0AEC7FA555C4FDE
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_18:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869217, %r10     ## imm = 0xC0AEC7FA555C4FDF
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_19:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869216, %r10     ## imm = 0xC0AEC7FA555C4FE0
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_20:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869215, %r10     ## imm = 0xC0AEC7FA555C4FE1
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_21:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869214, %r10     ## imm = 0xC0AEC7FA555C4FE2
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_22:                                ##   in Loop: Header=BB5_1 Depth=1
	movabsq	$-4562489494491869213, %r10     ## imm = 0xC0AEC7FA555C4FE3
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_23:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	movabsq	$8246626412459133484, %r10      ## imm = 0x7271E70795FB0A2C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %r10d
	## InlineAsm End
	jmpq	*%r10
LBB5_24:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
