	.text
	.file	"main"
	.globl	partition
	.align	16, 0x90
	.type	partition,@function
partition:                              # @partition
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbx
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbx, -16
	movl	%edx, %r9d
	movl	%esi, %r11d
	movq	%rdi, %r10
	movslq	%ecx, %rcx
	movsbl	(%r10,%rcx), %ebx
	movslq	%r9d, %r8
	movb	(%r10,%r8), %al
	movb	%al, (%r10,%rcx)
	movb	%bl, (%r10,%r8)
	movl	%r11d, %eax
	jmp	.LBB0_1
	.align	16, 0x90
.LBB0_4:                                # %if.end
                                        #   in Loop: Header=BB0_1 Depth=1
	incl	%eax
.LBB0_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	%r9d, %eax
	jge	.LBB0_5
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB0_1 Depth=1
	movslq	%eax, %rdi
	movsbl	(%r10,%rdi), %ecx
	cmpl	%ebx, %ecx
	jge	.LBB0_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB0_1 Depth=1
	movb	(%r10,%rdi), %sil
	movslq	%r11d, %rdx
	movb	(%r10,%rdx), %cl
	movb	%cl, (%r10,%rdi)
	movb	%sil, (%r10,%rdx)
	incl	%r11d
	jmp	.LBB0_4
.LBB0_5:                                # %while.end
	movslq	%r11d, %rdx
	movb	(%r10,%rdx), %cl
	movb	(%r10,%r8), %al
	movb	%al, (%r10,%rdx)
	movb	%cl, (%r10,%r8)
	movl	%edx, %eax
	popq	%rbx
	retq
.Ltmp2:
	.size	partition, .Ltmp2-partition
	.cfi_endproc

	.globl	quicksort
	.align	16, 0x90
	.type	quicksort,@function
quicksort:                              # @quicksort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
	pushq	%r15
.Ltmp4:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp5:
	.cfi_def_cfa_offset 32
	pushq	%rbx
.Ltmp6:
	.cfi_def_cfa_offset 40
	pushq	%rax
.Ltmp7:
	.cfi_def_cfa_offset 48
.Ltmp8:
	.cfi_offset %rbx, -40
.Ltmp9:
	.cfi_offset %r14, -32
.Ltmp10:
	.cfi_offset %r15, -24
.Ltmp11:
	.cfi_offset %rbp, -16
	movl	%edx, %ebp
	movl	%esi, %r14d
	movq	%rdi, %r15
	cmpl	%ebp, %r14d
	jge	.LBB1_2
# BB#1:                                 # %if.then
	movl	%ebp, %eax
	subl	%r14d, %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	sarl	%ecx
	addl	%r14d, %ecx
	movq	%r15, %rdi
	movl	%r14d, %esi
	movl	%ebp, %edx
	callq	partition
	movl	%eax, %ebx
	leal	-1(%rbx), %edx
	movq	%r15, %rdi
	movl	%r14d, %esi
	callq	quicksort
	leal	1(%rbx), %esi
	movq	%r15, %rdi
	movl	%ebp, %edx
	callq	quicksort
.LBB1_2:                                # %if.end
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Ltmp12:
	.size	quicksort, .Ltmp12-quicksort
	.cfi_endproc

	.globl	main
	.align	16, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbx
.Ltmp13:
	.cfi_def_cfa_offset 16
	subq	$48, %rsp
.Ltmp14:
	.cfi_def_cfa_offset 64
.Ltmp15:
	.cfi_offset %rbx, -16
	movaps	.L.str1+16(%rip), %xmm0
	movaps	%xmm0, 16(%rsp)
	movaps	.L.str1(%rip), %xmm0
	movaps	%xmm0, (%rsp)
	movl	$6778724, 32(%rsp)      # imm = 0x676F64
	leaq	(%rsp), %rbx
	xorl	%esi, %esi
	movl	$34, %edx
	movq	%rbx, %rdi
	callq	quicksort
	movl	$.L.str, %edi
	xorl	%eax, %eax
	movq	%rbx, %rsi
	callq	printf
	xorl	%eax, %eax
	addq	$48, %rsp
	popq	%rbx
	retq
.Ltmp16:
	.size	main, .Ltmp16-main
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
