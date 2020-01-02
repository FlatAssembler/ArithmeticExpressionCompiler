	.text
	.intel_syntax noprefix
	.file	"qsort.c"
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function log
.LCPI0_0:
	.quad	4607182418800017408     # double 1
.LCPI0_1:
	.quad	4562254508917369340     # double 0.001
.LCPI0_2:
	.quad	-4616189618054758400    # double -1
.LCPI0_3:
	.quad	4611686018427387904     # double 2
	.text
	.globl	log
	.p2align	4, 0x90
	.type	log,@function
log:                                    # @log
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	movsd	xmm1, qword ptr [rip + .LCPI0_0] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI0_1] # xmm2 = mem[0],zero
	movsd	qword ptr [rbp - 8], xmm0
	movsd	qword ptr [rbp - 16], xmm1
	movsd	qword ptr [rbp - 24], xmm2
	ucomisd	xmm1, qword ptr [rbp - 8]
	jbe	.LBB0_2
# %bb.1:
	movsd	xmm0, qword ptr [rip + .LCPI0_2] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 24]
	movsd	qword ptr [rbp - 24], xmm0
.LBB0_2:
	xorps	xmm0, xmm0
	movsd	qword ptr [rbp - 32], xmm0
.LBB0_3:                                # =>This Inner Loop Header: Depth=1
	movsd	xmm0, qword ptr [rip + .LCPI0_0] # xmm0 = mem[0],zero
	ucomisd	xmm0, qword ptr [rbp - 8]
	jbe	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_3 Depth=1
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	ucomisd	xmm0, qword ptr [rbp - 8]
	mov	al, 1
	mov	byte ptr [rbp - 33], al # 1-byte Spill
	ja	.LBB0_8
.LBB0_5:                                #   in Loop: Header=BB0_3 Depth=1
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	movsd	xmm0, qword ptr [rip + .LCPI0_0] # xmm0 = mem[0],zero
	movsd	xmm1, qword ptr [rbp - 8] # xmm1 = mem[0],zero
	ucomisd	xmm1, xmm0
	mov	byte ptr [rbp - 34], al # 1-byte Spill
	jbe	.LBB0_7
# %bb.6:                                #   in Loop: Header=BB0_3 Depth=1
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	movsd	xmm1, qword ptr [rbp - 8] # xmm1 = mem[0],zero
	ucomisd	xmm1, xmm0
	seta	al
	mov	byte ptr [rbp - 34], al # 1-byte Spill
.LBB0_7:                                #   in Loop: Header=BB0_3 Depth=1
	mov	al, byte ptr [rbp - 34] # 1-byte Reload
	mov	byte ptr [rbp - 33], al # 1-byte Spill
.LBB0_8:                                #   in Loop: Header=BB0_3 Depth=1
	mov	al, byte ptr [rbp - 33] # 1-byte Reload
	test	al, 1
	jne	.LBB0_9
	jmp	.LBB0_12
.LBB0_9:                                #   in Loop: Header=BB0_3 Depth=1
	movsd	xmm0, qword ptr [rip + .LCPI0_0] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 24]
	divsd	xmm0, qword ptr [rbp - 16]
	addsd	xmm0, qword ptr [rbp - 32]
	movsd	qword ptr [rbp - 32], xmm0
	movsd	xmm0, qword ptr [rbp - 24] # xmm0 = mem[0],zero
	addsd	xmm0, qword ptr [rbp - 16]
	movsd	qword ptr [rbp - 16], xmm0
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	addsd	xmm0, qword ptr [rbp - 24]
	ucomisd	xmm0, qword ptr [rbp - 16]
	jne	.LBB0_11
	jp	.LBB0_11
# %bb.10:                               #   in Loop: Header=BB0_3 Depth=1
	movsd	xmm0, qword ptr [rip + .LCPI0_3] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 24]
	movsd	qword ptr [rbp - 24], xmm0
.LBB0_11:                               #   in Loop: Header=BB0_3 Depth=1
	jmp	.LBB0_3
.LBB0_12:
	movsd	xmm0, qword ptr [rbp - 32] # xmm0 = mem[0],zero
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end0:
	.size	log, .Lfunc_end0-log
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function exp
.LCPI1_0:
	.quad	4562254508917369340     # double 0.001
.LCPI1_1:
	.quad	-4616189618054758400    # double -1
.LCPI1_2:
	.quad	4607182418800017408     # double 1
.LCPI1_3:
	.quad	4611686018427387904     # double 2
	.text
	.globl	exp
	.p2align	4, 0x90
	.type	exp,@function
exp:                                    # @exp
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	movsd	xmm1, qword ptr [rip + .LCPI1_0] # xmm1 = mem[0],zero
	movsd	qword ptr [rbp - 8], xmm0
	xorps	xmm0, xmm0
	movsd	qword ptr [rbp - 16], xmm0
	movsd	qword ptr [rbp - 24], xmm1
	ucomisd	xmm0, qword ptr [rbp - 8]
	jbe	.LBB1_2
# %bb.1:
	movsd	xmm0, qword ptr [rip + .LCPI1_1] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 24]
	movsd	qword ptr [rbp - 24], xmm0
.LBB1_2:
	movsd	xmm0, qword ptr [rip + .LCPI1_2] # xmm0 = mem[0],zero
	movsd	qword ptr [rbp - 32], xmm0
.LBB1_3:                                # =>This Inner Loop Header: Depth=1
	xorps	xmm0, xmm0
	ucomisd	xmm0, qword ptr [rbp - 8]
	jbe	.LBB1_5
# %bb.4:                                #   in Loop: Header=BB1_3 Depth=1
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	ucomisd	xmm0, qword ptr [rbp - 8]
	mov	al, 1
	mov	byte ptr [rbp - 33], al # 1-byte Spill
	ja	.LBB1_8
.LBB1_5:                                #   in Loop: Header=BB1_3 Depth=1
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	movsd	xmm0, qword ptr [rbp - 8] # xmm0 = mem[0],zero
	xorps	xmm1, xmm1
	ucomisd	xmm0, xmm1
	mov	byte ptr [rbp - 34], al # 1-byte Spill
	jbe	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_3 Depth=1
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	movsd	xmm1, qword ptr [rbp - 8] # xmm1 = mem[0],zero
	ucomisd	xmm1, xmm0
	seta	al
	mov	byte ptr [rbp - 34], al # 1-byte Spill
.LBB1_7:                                #   in Loop: Header=BB1_3 Depth=1
	mov	al, byte ptr [rbp - 34] # 1-byte Reload
	mov	byte ptr [rbp - 33], al # 1-byte Spill
.LBB1_8:                                #   in Loop: Header=BB1_3 Depth=1
	mov	al, byte ptr [rbp - 33] # 1-byte Reload
	test	al, 1
	jne	.LBB1_9
	jmp	.LBB1_12
.LBB1_9:                                #   in Loop: Header=BB1_3 Depth=1
	movsd	xmm0, qword ptr [rbp - 24] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 32]
	addsd	xmm0, qword ptr [rbp - 32]
	movsd	qword ptr [rbp - 32], xmm0
	movsd	xmm0, qword ptr [rbp - 24] # xmm0 = mem[0],zero
	addsd	xmm0, qword ptr [rbp - 16]
	movsd	qword ptr [rbp - 16], xmm0
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	addsd	xmm0, qword ptr [rbp - 24]
	ucomisd	xmm0, qword ptr [rbp - 16]
	jne	.LBB1_11
	jp	.LBB1_11
# %bb.10:                               #   in Loop: Header=BB1_3 Depth=1
	movsd	xmm0, qword ptr [rip + .LCPI1_3] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 24]
	movsd	qword ptr [rbp - 24], xmm0
.LBB1_11:                               #   in Loop: Header=BB1_3 Depth=1
	jmp	.LBB1_3
.LBB1_12:
	movsd	xmm0, qword ptr [rbp - 32] # xmm0 = mem[0],zero
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end1:
	.size	exp, .Lfunc_end1-exp
	.cfi_endproc
                                        # -- End function
	.globl	fabs                    # -- Begin function fabs
	.p2align	4, 0x90
	.type	fabs,@function
fabs:                                   # @fabs
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	movsd	qword ptr [rbp - 16], xmm0
	xorps	xmm0, xmm0
	ucomisd	xmm0, qword ptr [rbp - 16]
	jbe	.LBB2_2
# %bb.1:
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	movq	rax, xmm0
	movabs	rcx, -9223372036854775808
	xor	rax, rcx
	movq	xmm0, rax
	movsd	qword ptr [rbp - 8], xmm0
	jmp	.LBB2_3
.LBB2_2:
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	movsd	qword ptr [rbp - 8], xmm0
.LBB2_3:
	movsd	xmm0, qword ptr [rbp - 8] # xmm0 = mem[0],zero
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end2:
	.size	fabs, .Lfunc_end2-fabs
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function pow
.LCPI3_0:
	.quad	4562254508917369340     # double 0.001
.LCPI3_2:
	.quad	-4616189618054758400    # double -1
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI3_1:
	.quad	9223372036854775807     # double NaN
	.quad	9223372036854775807     # double NaN
	.text
	.globl	pow
	.p2align	4, 0x90
	.type	pow,@function
pow:                                    # @pow
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	movsd	qword ptr [rbp - 16], xmm0
	movsd	qword ptr [rbp - 24], xmm1
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	xorps	xmm1, xmm1
	ucomisd	xmm0, xmm1
	jne	.LBB3_2
	jp	.LBB3_2
# %bb.1:
	xorps	xmm0, xmm0
	movsd	qword ptr [rbp - 8], xmm0
	jmp	.LBB3_7
.LBB3_2:
	movsd	xmm0, qword ptr [rbp - 16] # xmm0 = mem[0],zero
	movaps	xmm1, xmmword ptr [rip + .LCPI3_1] # xmm1 = [NaN,NaN]
	pand	xmm0, xmm1
	call	log
	mulsd	xmm0, qword ptr [rbp - 24]
	call	exp
	movsd	xmm1, qword ptr [rip + .LCPI3_0] # xmm1 = mem[0],zero
	movsd	qword ptr [rbp - 32], xmm0
	cvttsd2si	eax, qword ptr [rbp - 24]
	mov	dword ptr [rbp - 36], eax
	movsd	xmm0, qword ptr [rbp - 24] # xmm0 = mem[0],zero
	cvtsi2sd	xmm2, dword ptr [rbp - 36]
	subsd	xmm0, xmm2
	movaps	xmm2, xmmword ptr [rip + .LCPI3_1] # xmm2 = [NaN,NaN]
	pand	xmm0, xmm2
	ucomisd	xmm1, xmm0
	jbe	.LBB3_6
# %bb.3:
	mov	eax, dword ptr [rbp - 36]
	cdq
	mov	ecx, 2
	idiv	ecx
	cmp	edx, 0
	je	.LBB3_6
# %bb.4:
	xorps	xmm0, xmm0
	ucomisd	xmm0, qword ptr [rbp - 16]
	jbe	.LBB3_6
# %bb.5:
	movsd	xmm0, qword ptr [rip + .LCPI3_2] # xmm0 = mem[0],zero
	mulsd	xmm0, qword ptr [rbp - 32]
	movsd	qword ptr [rbp - 32], xmm0
.LBB3_6:
	movsd	xmm0, qword ptr [rbp - 32] # xmm0 = mem[0],zero
	movsd	qword ptr [rbp - 8], xmm0
.LBB3_7:
	movsd	xmm0, qword ptr [rbp - 8] # xmm0 = mem[0],zero
	add	rsp, 48
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end3:
	.size	pow, .Lfunc_end3-pow
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function main
.LCPI4_0:
	.quad	9223372036854775807     # double NaN
	.quad	9223372036854775807     # double NaN
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI4_1:
	.quad	4605651194926711439     # double 0.82999999999999996
.LCPI4_2:
	.quad	4607407598781385933     # double 1.05
.LCPI4_3:
	.quad	4599348299161815373     # double 0.31511899999999998
.LCPI4_4:
	.quad	4591041352003055263     # double 0.088497699999999999
.LCPI4_5:
	.quad	4611686018427387904     # double 2
.LCPI4_6:
	.quad	4595193548361580996     # double 0.167242
.LCPI4_7:
	.quad	4613937818241073152     # double 3
.LCPI4_8:
	.quad	4600384451335283758     # double 0.372637
.LCPI4_9:
	.quad	4616189618054758400     # double 4
.LCPI4_10:
	.quad	4611105234219442205     # double 1.87104
.LCPI4_11:
	.quad	4617315517961601024     # double 5
.LCPI4_12:
	.quad	4598792356809414250     # double 0.28425800000000001
.LCPI4_13:
	.quad	4618441417868443648     # double 6
.LCPI4_14:
	.quad	4612560932726997170     # double 2.3885399999999999
.LCPI4_15:
	.quad	4619567317775286272     # double 7
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI4_16:
	.long	1065353216              # float 1
.LCPI4_17:
	.long	1073741824              # float 2
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 128
	mov	dword ptr [rbp - 4], 0
	movabs	rdi, offset .L.str
	lea	rsi, [rbp - 8]
	mov	al, 0
	call	scanf
	mov	dword ptr [rbp - 12], 0
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 12]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB4_4
# %bb.2:                                #   in Loop: Header=BB4_1 Depth=1
	movsxd	rax, dword ptr [rbp - 12]
	shl	rax, 2
	movabs	rcx, offset original
	add	rcx, rax
	movabs	rdi, offset .L.str
	mov	rsi, rcx
	mov	al, 0
	call	scanf
# %bb.3:                                #   in Loop: Header=BB4_1 Depth=1
	mov	eax, dword ptr [rbp - 12]
	add	eax, 1
	mov	dword ptr [rbp - 12], eax
	jmp	.LBB4_1
.LBB4_4:
	mov	al, 0
	call	clock
	mov	qword ptr [rbp - 24], rax
	mov	dword ptr [rbp - 28], 0
	xorps	xmm0, xmm0
	movss	dword ptr [razvrstanost], xmm0
.LBB4_5:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 28]
	mov	ecx, dword ptr [rbp - 8]
	sub	ecx, 1
	cmp	eax, ecx
	jge	.LBB4_7
# %bb.6:                                #   in Loop: Header=BB4_5 Depth=1
	movsxd	rax, dword ptr [rbp - 28]
	mov	ecx, dword ptr [4*rax + original]
	mov	edx, dword ptr [rbp - 28]
	add	edx, 1
	movsxd	rax, edx
	cmp	ecx, dword ptr [4*rax + original]
	setl	sil
	and	sil, 1
	movzx	ecx, sil
	cvtsi2ss	xmm0, ecx
	addss	xmm0, dword ptr [razvrstanost]
	movss	dword ptr [razvrstanost], xmm0
	mov	ecx, dword ptr [rbp - 28]
	add	ecx, 1
	mov	dword ptr [rbp - 28], ecx
	jmp	.LBB4_5
.LBB4_7:
	movsd	xmm1, qword ptr [rip + .LCPI4_15] # xmm1 = mem[0],zero
	movss	xmm0, dword ptr [rip + .LCPI4_16] # xmm0 = mem[0],zero,zero,zero
	movss	xmm2, dword ptr [rip + .LCPI4_17] # xmm2 = mem[0],zero,zero,zero
	movss	xmm3, dword ptr [razvrstanost] # xmm3 = mem[0],zero,zero,zero
	mov	eax, dword ptr [rbp - 8]
	sub	eax, 1
	cvtsi2ss	xmm4, eax
	divss	xmm4, xmm2
	divss	xmm3, xmm4
	subss	xmm3, xmm0
	movss	dword ptr [razvrstanost], xmm3
	movss	xmm0, dword ptr [razvrstanost] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_13] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_14] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movss	xmm0, dword ptr [razvrstanost] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	movsd	qword ptr [rbp - 64], xmm2 # 8-byte Spill
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_11] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_12] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 64] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	subsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 72], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_9] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_10] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 72] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	subsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 80], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_7] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_8] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 80] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 88], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_5] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_6] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 88] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 96], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_3] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_4] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 96] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	subsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	mulsd	xmm1, xmm2
	addsd	xmm0, xmm1
	cvtsd2ss	xmm0, xmm0
	movss	dword ptr [polinomPodApsolutnom], xmm0
	cvtsi2sd	xmm0, dword ptr [rbp - 8]
	call	log
	cvtsi2sd	xmm1, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 104], xmm0 # 8-byte Spill
	movaps	xmm0, xmm1
	call	log
	call	log
	movsd	xmm1, qword ptr [rip + .LCPI4_2] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rbp - 104] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	addsd	xmm2, xmm0
	mulsd	xmm2, xmm1
	cvtsi2sd	xmm0, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 112], xmm2 # 8-byte Spill
	call	log
	cvtsi2sd	xmm1, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 120], xmm0 # 8-byte Spill
	movaps	xmm0, xmm1
	call	log
	call	log
	movsd	xmm1, qword ptr [rip + .LCPI4_1] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rbp - 120] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	subsd	xmm2, xmm0
	mulsd	xmm2, xmm1
	movss	xmm0, dword ptr [polinomPodApsolutnom] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	movaps	xmm1, xmmword ptr [rip + .LCPI4_0] # xmm1 = [NaN,NaN]
	pand	xmm0, xmm1
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 112] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	cvtsd2ss	xmm0, xmm0
	movss	dword ptr [eNaKoju], xmm0
	movss	xmm0, dword ptr [eNaKoju] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	call	exp
	cvtsd2ss	xmm0, xmm0
	movss	dword ptr [ocekivaniBrojUsporedbi], xmm0
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], 0
	mov	eax, dword ptr [rbp - 8]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_8:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_10 Depth 2
                                        #     Child Loop BB4_15 Depth 2
                                        #     Child Loop BB4_21 Depth 2
	cmp	dword ptr [vrh_stoga], 0
	je	.LBB4_28
# %bb.9:                                #   in Loop: Header=BB4_8 Depth=1
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	dword ptr [rbp - 32], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_donjim_granicama]
	mov	dword ptr [rbp - 36], ecx
	mov	ecx, dword ptr [vrh_stoga]
	add	ecx, -1
	mov	dword ptr [vrh_stoga], ecx
	mov	ecx, dword ptr [rbp - 36]
	mov	dword ptr [rbp - 40], ecx
	mov	ecx, dword ptr [rbp - 36]
	add	ecx, 1
	mov	dword ptr [rbp - 44], ecx
.LBB4_10:                               #   Parent Loop BB4_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 44]
	cmp	eax, dword ptr [rbp - 32]
	jge	.LBB4_14
# %bb.11:                               #   in Loop: Header=BB4_10 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 36]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB4_13
# %bb.12:                               #   in Loop: Header=BB4_10 Depth=2
	mov	eax, dword ptr [rbp - 40]
	add	eax, 1
	mov	dword ptr [rbp - 40], eax
.LBB4_13:                               #   in Loop: Header=BB4_10 Depth=2
	mov	eax, dword ptr [rbp - 44]
	add	eax, 1
	mov	dword ptr [rbp - 44], eax
	jmp	.LBB4_10
.LBB4_14:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [rbp - 36]
	mov	dword ptr [rbp - 48], eax
	mov	eax, dword ptr [rbp - 40]
	add	eax, 1
	mov	dword ptr [rbp - 52], eax
	movsxd	rcx, dword ptr [rbp - 36]
	mov	eax, dword ptr [4*rcx + original]
	movsxd	rcx, dword ptr [rbp - 40]
	mov	dword ptr [4*rcx + pomocni], eax
	mov	eax, dword ptr [rbp - 36]
	add	eax, 1
	mov	dword ptr [rbp - 44], eax
.LBB4_15:                               #   Parent Loop BB4_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 44]
	cmp	eax, dword ptr [rbp - 32]
	jge	.LBB4_20
# %bb.16:                               #   in Loop: Header=BB4_15 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 36]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB4_18
# %bb.17:                               #   in Loop: Header=BB4_15 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 48]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [rbp - 48]
	add	ecx, 1
	mov	dword ptr [rbp - 48], ecx
	jmp	.LBB4_19
.LBB4_18:                               #   in Loop: Header=BB4_15 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 52]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [rbp - 52]
	add	ecx, 1
	mov	dword ptr [rbp - 52], ecx
.LBB4_19:                               #   in Loop: Header=BB4_15 Depth=2
	mov	eax, dword ptr [brojac]
	add	eax, 1
	mov	dword ptr [brojac], eax
	mov	eax, dword ptr [rbp - 44]
	add	eax, 1
	mov	dword ptr [rbp - 44], eax
	jmp	.LBB4_15
.LBB4_20:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [rbp - 36]
	mov	dword ptr [rbp - 44], eax
.LBB4_21:                               #   Parent Loop BB4_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 44]
	cmp	eax, dword ptr [rbp - 32]
	jge	.LBB4_23
# %bb.22:                               #   in Loop: Header=BB4_21 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + pomocni]
	movsxd	rax, dword ptr [rbp - 44]
	mov	dword ptr [4*rax + original], ecx
	mov	ecx, dword ptr [rbp - 44]
	add	ecx, 1
	mov	dword ptr [rbp - 44], ecx
	jmp	.LBB4_21
.LBB4_23:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [rbp - 40]
	mov	ecx, dword ptr [rbp - 32]
	sub	ecx, 1
	cmp	eax, ecx
	jge	.LBB4_25
# %bb.24:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 40]
	add	eax, 1
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 32]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_25:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [rbp - 40]
	mov	ecx, dword ptr [rbp - 36]
	add	ecx, 1
	cmp	eax, ecx
	jle	.LBB4_27
# %bb.26:                               #   in Loop: Header=BB4_8 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 36]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 40]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_27:                               #   in Loop: Header=BB4_8 Depth=1
	jmp	.LBB4_8
.LBB4_28:
	mov	al, 0
	call	clock
	sub	rax, qword ptr [rbp - 24]
	mov	qword ptr [rbp - 24], rax
	mov	dword ptr [rbp - 56], 0
.LBB4_29:                               # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 56]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB4_32
# %bb.30:                               #   in Loop: Header=BB4_29 Depth=1
	movsxd	rax, dword ptr [rbp - 56]
	mov	esi, dword ptr [4*rax + original]
	movabs	rdi, offset .L.str.1
	mov	al, 0
	call	printf
# %bb.31:                               #   in Loop: Header=BB4_29 Depth=1
	mov	eax, dword ptr [rbp - 56]
	add	eax, 1
	mov	dword ptr [rbp - 56], eax
	jmp	.LBB4_29
.LBB4_32:
	xor	eax, eax
	add	rsp, 128
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.type	vrh_stoga,@object       # @vrh_stoga
	.bss
	.globl	vrh_stoga
	.p2align	2
vrh_stoga:
	.long	0                       # 0x0
	.size	vrh_stoga, 4

	.type	brojac,@object          # @brojac
	.globl	brojac
	.p2align	2
brojac:
	.long	0                       # 0x0
	.size	brojac, 4

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%d"
	.size	.L.str, 3

	.type	original,@object        # @original
	.comm	original,131072,16
	.type	razvrstanost,@object    # @razvrstanost
	.comm	razvrstanost,4,4
	.type	polinomPodApsolutnom,@object # @polinomPodApsolutnom
	.comm	polinomPodApsolutnom,4,4
	.type	eNaKoju,@object         # @eNaKoju
	.comm	eNaKoju,4,4
	.type	ocekivaniBrojUsporedbi,@object # @ocekivaniBrojUsporedbi
	.comm	ocekivaniBrojUsporedbi,4,4
	.type	stog_s_donjim_granicama,@object # @stog_s_donjim_granicama
	.comm	stog_s_donjim_granicama,131072,16
	.type	stog_s_gornjim_granicama,@object # @stog_s_gornjim_granicama
	.comm	stog_s_gornjim_granicama,131072,16
	.type	pomocni,@object         # @pomocni
	.comm	pomocni,131072,16
	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4


	.ident	"clang version 9.0.0 (tags/RELEASE_900/final)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym log
	.addrsig_sym exp
	.addrsig_sym pow
	.addrsig_sym scanf
	.addrsig_sym clock
	.addrsig_sym printf
	.addrsig_sym vrh_stoga
	.addrsig_sym brojac
	.addrsig_sym original
	.addrsig_sym razvrstanost
	.addrsig_sym polinomPodApsolutnom
	.addrsig_sym eNaKoju
	.addrsig_sym ocekivaniBrojUsporedbi
	.addrsig_sym stog_s_donjim_granicama
	.addrsig_sym stog_s_gornjim_granicama
	.addrsig_sym pomocni
