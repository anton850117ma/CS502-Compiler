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
	subq	$24, %rsp
.Ltmp2:
	.cfi_def_cfa_offset 48
.Ltmp3:
	.cfi_offset %rbx, -24
.Ltmp4:
	.cfi_offset %rbp, -16
	movabsq	$9363768820586272, %rax # imm = 0x21444C524F5720
	movq	%rax, 13(%rsp)
	movabsq	$5717073776924706120, %rax # imm = 0x4F57204F4C4C4548
	movq	%rax, 8(%rsp)
	movl	$10, %ebx
	movsbl	9(%rsp), %eax
	addl	$32, %eax
	movsbl	%al, %ebp
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_2:                                # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movl	%ebp, %esi
	callq	printf
	decl	%ebx
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	testl	%ebx, %ebx
	jg	.LBB0_2
# BB#3:                                 # %while.end
	xorl	%eax, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Ltmp5:
	.size	main, .Ltmp5-main
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


	.section	".note.GNU-stack","",@progbits
