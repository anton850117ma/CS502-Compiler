	.text
	.file	"main"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$24, %rsp
.Ltmp0:
	.cfi_def_cfa_offset 32
	movabsq	$7308060643404313673, %rax # imm = 0x656B726F77207449
	movq	%rax, 8(%rsp)
	movb	$0, 18(%rsp)
	movw	$8548, 16(%rsp)         # imm = 0x2164
	leaq	8(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	retq
.Ltmp1:
	.size	main, .Ltmp1-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%s\n"
	.size	.L.str, 4

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"It worked!"
	.size	.L.str1, 11


	.section	".note.GNU-stack","",@progbits
