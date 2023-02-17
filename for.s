	.text
	.file	"Oberon is Cool B)"
	.globl	func                            # -- Begin function func
	.p2align	4, 0x90
	.type	func,@function
func:                                   # @func
	.cfi_startproc
# %bb.0:                                # %entry
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	%esi, 20(%rsp)
	movl	%edx, 12(%rsp)
	movl	%ecx, 16(%rsp)
	movl	$0, 8(%rsp)
	.p2align	4, 0x90
.LBB0_1:                                # %loop
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	movl	8(%rsp), %edi
	callq	write_integer@PLT
	movl	$0, 12(%rsp)
	.p2align	4, 0x90
.LBB0_2:                                # %loop6
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	12(%rsp), %eax
	movl	8(%rsp), %edi
	addl	%eax, %edi
	movl	%edi, 16(%rsp)
	incl	%eax
	movl	%eax, 12(%rsp)
	callq	write_integer@PLT
	cmpl	$10, 12(%rsp)
	jl	.LBB0_2
# %bb.3:                                # %afterloop
                                        #   in Loop: Header=BB0_1 Depth=1
	movl	8(%rsp), %eax
	incl	%eax
	movl	%eax, 8(%rsp)
	cmpl	$10, %eax
	jl	.LBB0_1
# %bb.4:                                # %afterloop17
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	func, .Lfunc_end0-func
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	pushq	%rax
	.cfi_def_cfa_offset 16
	xorl	%edi, %edi
	xorl	%esi, %esi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	callq	func@PLT
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
