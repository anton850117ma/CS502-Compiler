	.text
	.file	"main"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$40, %rsp
.Ltmp0:
	.cfi_def_cfa_offset 48
	movaps	.L.str1+16(%rip), %xmm0
	movaps	%xmm0, 16(%rsp)
	movaps	.L.str1(%rip), %xmm0
	movaps	%xmm0, (%rsp)
	movl	$6778724, 32(%rsp)      # imm = 0x676F64
	leaq	(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	leaq	8(%rsp), %rsi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$40, %rsp
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
	.section	.rodata.str1.16,"aMS",@progbits,1
	.align	16
.L.str1:
	.asciz	"thequickbrownfoxjumpsoverthelazydog"
	.size	.L.str1, 36


	.section	".note.GNU-stack","",@progbits
