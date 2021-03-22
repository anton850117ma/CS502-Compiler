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
	pushq	%r14
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 32
	subq	$16, %rsp
.Ltmp3:
	.cfi_def_cfa_offset 48
.Ltmp4:
	.cfi_offset %rbx, -32
.Ltmp5:
	.cfi_offset %r14, -24
.Ltmp6:
	.cfi_offset %rbp, -16
	movabsq	$9363768820586272, %rax # imm = 0x21444C524F5720
	movq	%rax, 5(%rsp)
	movabsq	$5717073776924706120, %rax # imm = 0x4F57204F4C4C4548
	movq	%rax, (%rsp)
	movl	$5, %ebp
	movl	$2, %ebx
	movsbl	(%rsp), %eax
	addl	$32, %eax
	movsbl	%al, %r14d
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_5:                                # %while.end3
                                        #   in Loop: Header=BB0_1 Depth=1
	decl	%ebp
.LBB0_1:                                # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	testl	%ebp, %ebp
	jle	.LBB0_6
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str2, %edi
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB0_3
	.align	16, 0x90
.LBB0_4:                                # %while.body2
                                        #   in Loop: Header=BB0_3 Depth=2
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movl	%r14d, %esi
	callq	printf
	decl	%ebx
.LBB0_3:                                # %while.cond1
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	testl	%ebx, %ebx
	jg	.LBB0_4
	jmp	.LBB0_5
.LBB0_6:                                # %while.end
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Ltmp7:
	.size	main, .Ltmp7-main
	.cfi_endproc

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%c\n"
	.size	.L.str, 4

	.type	.L.str1,@object         # @.str1
.L.str1:
	.asciz	"HELLO WORLD!"
	.size	.L.str1, 13

	.type	.L.str2,@object         # @.str2
.L.str2:
	.asciz	"Outer loop\n"
	.size	.L.str2, 12


	.section	".note.GNU-stack","",@progbits
