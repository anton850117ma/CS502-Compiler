	.text
	.file	"main"
	.globl	printArray
	.align	16, 0x90
	.type	printArray,@function
printArray:                             # @printArray
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 32
.Ltmp3:
	.cfi_offset %rbx, -32
.Ltmp4:
	.cfi_offset %r14, -24
.Ltmp5:
	.cfi_offset %rbp, -16
	movl	%esi, %ebp
	movq	%rdi, %r14
	decl	%ebp
	xorl	%ebx, %ebx
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	%ebx, %rax
	movl	(%r14,%rax,4), %esi
	movl	$.L.str1, %edi
	xorl	%eax, %eax
	callq	printf
	incl	%ebx
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	%ebp, %ebx
	jl	.LBB0_2
# BB#3:                                 # %while.end
	movslq	%ebx, %rax
	movl	(%r14,%rax,4), %esi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Ltmp6:
	.size	printArray, .Ltmp6-printArray
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	subq	$24, %rsp
.Ltmp7:
	.cfi_def_cfa_offset 32
	movl	$1, (%rsp)
	movl	$1, 4(%rsp)
	movl	$2, 8(%rsp)
	movl	$3, 12(%rsp)
	movl	$5, 16(%rsp)
	leaq	(%rsp), %rdi
	movl	$5, %esi
	callq	printArray
	movl	$.L.str, %edi
	movl	$10, %esi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$24, %rsp
	retq
.Ltmp8:
	.size	main, .Ltmp8-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"%d,"
	.size	.L.str1, 4


	.section	".note.GNU-stack","",@progbits
