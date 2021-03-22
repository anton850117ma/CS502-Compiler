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
	movl	$1, %ebp
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_6:                                # %if.then9
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str1, %edi
	movl	$5, %edx
	xorl	%eax, %eax
	movl	%ebp, %esi
	callq	printf
	incl	%ebp
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$10, %ebp
	jg	.LBB0_14
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str2, %edi
	xorl	%eax, %eax
	movl	%ebp, %esi
	callq	printf
	movl	%ebp, %eax
	shrl	$31, %eax
	addl	%ebp, %eax
	andl	$-2, %eax
	cmpl	%eax, %ebp
	jne	.LBB0_7
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str3, %edi
	movl	$2, %esi
	xorl	%eax, %eax
	callq	printf
	movslq	%ebp, %rbx
	imulq	$1431655766, %rbx, %rax # imm = 0x55555556
	movq	%rax, %rcx
	shrq	$63, %rcx
	shrq	$32, %rax
	addl	%ecx, %eax
	leal	(%rax,%rax,2), %eax
	cmpl	%eax, %ebp
	jne	.LBB0_5
# BB#4:                                 # %if.then4
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str1, %edi
	movl	$3, %edx
	xorl	%eax, %eax
	movl	%ebp, %esi
	callq	printf
.LBB0_5:                                # %if.end5
                                        #   in Loop: Header=BB0_1 Depth=1
	imulq	$1717986919, %rbx, %rax # imm = 0x66666667
	movq	%rax, %rcx
	shrq	$63, %rcx
	sarq	$33, %rax
	addl	%ecx, %eax
	leal	(%rax,%rax,4), %eax
	cmpl	%eax, %ebp
	je	.LBB0_6
	jmp	.LBB0_13
	.align	16, 0x90
.LBB0_7:                                # %if.else
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	%ebp, %rax
	imulq	$1431655766, %rax, %rcx # imm = 0x55555556
	movq	%rcx, %rdx
	shrq	$63, %rdx
	shrq	$32, %rcx
	addl	%edx, %ecx
	leal	(%rcx,%rcx,2), %ecx
	cmpl	%ecx, %ebp
	jne	.LBB0_10
# BB#8:                                 # %if.then15
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str3, %edi
	movl	$3, %esi
	jmp	.LBB0_9
.LBB0_10:                               # %if.else17
                                        #   in Loop: Header=BB0_1 Depth=1
	imulq	 $1717986919, %rax      # imm = 0x66666667
	movq	%rax, %rcx
	shrq	$63, %rcx
	sarq	$33, %rax
	addl	%ecx, %eax
	leal	(%rax,%rax,4), %eax
	cmpl	%eax, %ebp
	jne	.LBB0_12
# BB#11:                                # %if.then21
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str3, %edi
	movl	$5, %esi
.LBB0_9:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	xorl	%eax, %eax
	callq	printf
	incl	%ebp
	jmp	.LBB0_1
.LBB0_12:                               # %if.else23
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str, %edi
	xorl	%eax, %eax
	callq	printf
	.align	16, 0x90
.LBB0_13:                               # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	%ebp
	jmp	.LBB0_1
.LBB0_14:                               # %while.end
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Ltmp5:
	.size	main, .Ltmp5-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.16,"aMS",@progbits,1
	.align	16
.L.str:
	.asciz	" is not a multiple of 2, 3 or 5.\n"
	.size	.L.str, 34

	.type	.L.str1,@object         # @.str1
	.align	16
.L.str1:
	.asciz	"%d is a multiple of %d.\n"
	.size	.L.str1, 25

	.type	.L.str2,@object         # @.str2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str2:
	.asciz	"%d"
	.size	.L.str2, 3

	.type	.L.str3,@object         # @.str3
	.section	.rodata.str1.16,"aMS",@progbits,1
	.align	16
.L.str3:
	.asciz	" is a multiple of %d.\n"
	.size	.L.str3, 23


	.section	".note.GNU-stack","",@progbits
