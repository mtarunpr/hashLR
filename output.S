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
	movabsq	$6952033854384, %r10            ## imm = 0x652A58223B0
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	calll	*%r10
	cmpl	$0, -4(%rbp)
	jne	LBB0_1
	movabsq	$8246626412459133484, %r10      ## imm = 0x7271E70795FB0A2C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB0_1:
	movabsq	$8246626412459133485, %r10      ## imm = 0x7271E70795FB0A2D
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB0_2:
	leaq	L_.str.1(%rip), %rdi
	movb	$0, %al
	movabsq	$229417017865368, %r10          ## imm = 0xD0A74FDAF498
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	calll	*%r10
	movabsq	$8246626412459133486, %r10      ## imm = 0x7271E70795FB0A2E
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB0_3:
	movl	-4(%rbp), %ecx
	imull	-4(%rbp), %ecx
	sarl	$2, %ecx
	movl	%ecx, -8(%rbp)
	leaq	L_.str.2(%rip), %rdi
	movl	$2, %esi
	movb	$0, %al
	movabsq	$229417017865368, %r10          ## imm = 0xD0A74FDAF498
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	calll	*%r10
	movabsq	$8246626412459133486, %r10      ## imm = 0x7271E70795FB0A2E
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB0_4:
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
	subq	$16, %rsp
	leaq	L_.str.3(%rip), %rdi
	movb	$0, %al
	movabsq	$229417017865368, %r10          ## imm = 0xD0A74FDAF498
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	calll	*%r10
	cmpl	$3, -8(%rbp)
	jne	LBB1_1
	movabsq	$-4569957540294253925, %r10     ## imm = 0xC0943FD46C24A29B
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB1_1:
	movabsq	$-4569957540294253924, %r10     ## imm = 0xC0943FD46C24A29C
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB1_2:
	movl	$8, -4(%rbp)
	movabsq	$-4569957540294253923, %r10     ## imm = 0xC0943FD46C24A29D
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB1_3:
	movl	$9, -4(%rbp)
	movabsq	$-4569957540294253923, %r10     ## imm = 0xC0943FD46C24A29D
	movq	%r10, %xmm1
	## InlineAsm Start
	aesenc	%xmm7, %xmm1
	## InlineAsm End
	## InlineAsm Start
	movd	%xmm1, %eax
	## InlineAsm End
	jmpl	*%eax
LBB1_4:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
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
