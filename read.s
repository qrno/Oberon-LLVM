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
	movl	%edi, 12(%rsp)
	movl	%esi, 20(%rsp)
	movl	%edx, 16(%rsp)
	callq	read_integer@PLT
	movl	%eax, 12(%rsp)
	callq	read_integer@PLT
	movl	%eax, 20(%rsp)
	addl	12(%rsp), %eax
	movl	%eax, 16(%rsp)
	movl	%eax, %edi
	callq	write_integer@PLT
	movl	16(%rsp), %eax
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
	callq	func@PLT
	movl	%eax, %edi
	callq	write_integer@PLT
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
