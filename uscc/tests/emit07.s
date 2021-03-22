	.text
	.file	"main"
	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp2:
	.cfi_def_cfa_offset 32
.Ltmp3:
	.cfi_offset %rbx, -24
.Ltmp4:
	.cfi_offset %rbp, -16
	movl	$.L.str, %edi
	xorl	%esi, %esi
	xorl	%eax, %eax
	callq	printf
	movl	$5, %ebp
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movl	%ebp, %esi
	callq	printf
	decl	%ebp
	movl	$8, %ebx
	jmp	.LBB0_3
	.align	16, 0x90
.LBB0_4:                                # %while.body3
                                        #   in Loop: Header=BB0_3 Depth=2
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movl	%ebx, %esi
	callq	printf
	incl	%ebx
.LBB0_3:                                # %while.cond2
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$9, %ebx
	jle	.LBB0_4
.LBB0_1:                                # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	testl	%ebp, %ebp
	jg	.LBB0_2
# BB#5:                                 # %while.end
	sete	%al
	movzbl	%al, %esi
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d\n"
	.size	.L.str, 4


	.section	".note.GNU-stack","",@progbits
