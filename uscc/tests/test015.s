	.text
	.file	"main"
	.globl	multiply
	.align	16, 0x90
	.type	multiply,@function
multiply:                               # @multiply
	.cfi_startproc
# BB#0:                                 # %entry
	imull	%esi, %edi
	movl	%edi, %eax
	retq
.Ltmp0:
	.size	multiply, .Ltmp0-multiply
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rax
.Ltmp1:
	.cfi_def_cfa_offset 16
	movl	$5, %edi
	movl	$6, %esi
	callq	multiply
	movl	%eax, %ecx
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movl	%ecx, %esi
	callq	printf
	xorl	%eax, %eax
	popq	%rdx
	retq
.Ltmp2:
	.size	main, .Ltmp2-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"5 * 6 = %d\n"
	.size	.L.str, 12


	.section	".note.GNU-stack","",@progbits
