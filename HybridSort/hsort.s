	.text
	.intel_syntax noprefix
	.file	"hsort.c"
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
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function main
.LCPI4_0:
	.long	1065353216              # float 1
.LCPI4_17:
	.long	1073741824              # float 2
.LCPI4_18:
	.long	3212836864              # float -1
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI4_1:
	.quad	4611686018427387904     # double 2
.LCPI4_3:
	.quad	4605651194926711439     # double 0.82999999999999996
.LCPI4_4:
	.quad	4607407598781385933     # double 1.05
.LCPI4_5:
	.quad	4599348299161815373     # double 0.31511899999999998
.LCPI4_6:
	.quad	4591041352003055263     # double 0.088497699999999999
.LCPI4_7:
	.quad	4595193548361580996     # double 0.167242
.LCPI4_8:
	.quad	4613937818241073152     # double 3
.LCPI4_9:
	.quad	4600384451335283758     # double 0.372637
.LCPI4_10:
	.quad	4616189618054758400     # double 4
.LCPI4_11:
	.quad	4611105234219442205     # double 1.87104
.LCPI4_12:
	.quad	4617315517961601024     # double 5
.LCPI4_13:
	.quad	4598792356809414250     # double 0.28425800000000001
.LCPI4_14:
	.quad	4618441417868443648     # double 6
.LCPI4_15:
	.quad	4612560932726997170     # double 2.3885399999999999
.LCPI4_16:
	.quad	4619567317775286272     # double 7
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_2:
	.quad	9223372036854775807     # double NaN
	.quad	9223372036854775807     # double NaN
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
	mov	dword ptr [i], 0
	xorps	xmm0, xmm0
	movss	dword ptr [razvrstanost], xmm0
.LBB4_5:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [i]
	mov	ecx, dword ptr [rbp - 8]
	sub	ecx, 1
	cmp	eax, ecx
	jge	.LBB4_7
# %bb.6:                                #   in Loop: Header=BB4_5 Depth=1
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + original]
	mov	edx, dword ptr [i]
	add	edx, 1
	movsxd	rax, edx
	cmp	ecx, dword ptr [4*rax + original]
	setl	sil
	and	sil, 1
	movzx	ecx, sil
	cvtsi2ss	xmm0, ecx
	addss	xmm0, dword ptr [razvrstanost]
	movss	dword ptr [razvrstanost], xmm0
	mov	ecx, dword ptr [i]
	add	ecx, 1
	mov	dword ptr [i], ecx
	mov	ecx, dword ptr [brojac]
	add	ecx, 1
	mov	dword ptr [brojac], ecx
	jmp	.LBB4_5
.LBB4_7:
	movsd	xmm1, qword ptr [rip + .LCPI4_16] # xmm1 = mem[0],zero
	movss	xmm0, dword ptr [rip + .LCPI4_0] # xmm0 = mem[0],zero,zero,zero
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
	movsd	xmm1, qword ptr [rip + .LCPI4_14] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_15] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movss	xmm0, dword ptr [razvrstanost] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	movsd	qword ptr [rbp - 48], xmm2 # 8-byte Spill
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_12] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_13] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 48] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	subsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 56], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_10] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_11] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 56] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	subsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 64], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_8] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_9] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 64] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 72], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_1] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_7] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 72] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	movss	xmm2, dword ptr [razvrstanost] # xmm2 = mem[0],zero,zero,zero
	cvtss2sd	xmm2, xmm2
	movsd	qword ptr [rbp - 80], xmm0 # 8-byte Spill
	movaps	xmm0, xmm2
	call	pow
	movsd	xmm1, qword ptr [rip + .LCPI4_5] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_6] # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 80] # 8-byte Reload
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
	movsd	qword ptr [rbp - 88], xmm0 # 8-byte Spill
	movaps	xmm0, xmm1
	call	log
	call	log
	movsd	xmm1, qword ptr [rip + .LCPI4_4] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rbp - 88] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	addsd	xmm2, xmm0
	mulsd	xmm2, xmm1
	cvtsi2sd	xmm0, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 96], xmm2 # 8-byte Spill
	call	log
	cvtsi2sd	xmm1, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 104], xmm0 # 8-byte Spill
	movaps	xmm0, xmm1
	call	log
	call	log
	movsd	xmm1, qword ptr [rip + .LCPI4_3] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rbp - 104] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	subsd	xmm2, xmm0
	mulsd	xmm2, xmm1
	movss	xmm0, dword ptr [polinomPodApsolutnom] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	movaps	xmm1, xmmword ptr [rip + .LCPI4_2] # xmm1 = [NaN,NaN]
	pand	xmm0, xmm1
	mulsd	xmm2, xmm0
	movsd	xmm0, qword ptr [rbp - 96] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	addsd	xmm0, xmm2
	cvtsd2ss	xmm0, xmm0
	movss	dword ptr [eNaKoju], xmm0
	movss	xmm0, dword ptr [eNaKoju] # xmm0 = mem[0],zero,zero,zero
	cvtss2sd	xmm0, xmm0
	call	exp
	cvtsd2ss	xmm0, xmm0
	movss	dword ptr [kolikoUsporedbiOcekujemoOdQuickSorta], xmm0
	mov	eax, dword ptr [rbp - 8]
	shl	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, dword ptr [rbp - 8]
	movsd	qword ptr [rbp - 112], xmm0 # 8-byte Spill
	movaps	xmm0, xmm1
	call	log
	movsd	xmm1, qword ptr [rip + .LCPI4_1] # xmm1 = mem[0],zero
	movsd	xmm2, qword ptr [rbp - 112] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	mulsd	xmm2, xmm0
	movaps	xmm0, xmm1
	movsd	qword ptr [rbp - 120], xmm2 # 8-byte Spill
	call	log
	movss	xmm1, dword ptr [rip + .LCPI4_0] # xmm1 = mem[0],zero,zero,zero
	movsd	xmm2, qword ptr [rbp - 120] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	divsd	xmm2, xmm0
	cvtsd2ss	xmm0, xmm2
	movss	dword ptr [kolikoUsporedbiOcekujemoOdMergeSorta], xmm0
	movss	xmm0, dword ptr [razvrstanost] # xmm0 = mem[0],zero,zero,zero
	ucomiss	xmm0, xmm1
	jne	.LBB4_9
	jp	.LBB4_9
# %bb.8:
	jmp	.LBB4_62
.LBB4_9:
	movss	xmm0, dword ptr [rip + .LCPI4_18] # xmm0 = mem[0],zero,zero,zero
	movss	xmm1, dword ptr [razvrstanost] # xmm1 = mem[0],zero,zero,zero
	ucomiss	xmm1, xmm0
	jne	.LBB4_17
	jp	.LBB4_17
# %bb.10:
	mov	dword ptr [i], 0
.LBB4_11:                               # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB4_13
# %bb.12:                               #   in Loop: Header=BB4_11 Depth=1
	mov	eax, dword ptr [rbp - 8]
	sub	eax, dword ptr [i]
	sub	eax, 1
	movsxd	rcx, eax
	mov	eax, dword ptr [4*rcx + original]
	movsxd	rcx, dword ptr [i]
	mov	dword ptr [4*rcx + pomocni], eax
	mov	eax, dword ptr [i]
	add	eax, 1
	mov	dword ptr [i], eax
	mov	eax, dword ptr [brojac]
	add	eax, 1
	mov	dword ptr [brojac], eax
	jmp	.LBB4_11
.LBB4_13:
	mov	dword ptr [i], 0
.LBB4_14:                               # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB4_16
# %bb.15:                               #   in Loop: Header=BB4_14 Depth=1
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + pomocni]
	movsxd	rax, dword ptr [i]
	mov	dword ptr [4*rax + original], ecx
	mov	ecx, dword ptr [i]
	add	ecx, 1
	mov	dword ptr [i], ecx
	jmp	.LBB4_14
.LBB4_16:
	jmp	.LBB4_61
.LBB4_17:
	movss	xmm0, dword ptr [kolikoUsporedbiOcekujemoOdQuickSorta] # xmm0 = mem[0],zero,zero,zero
	movss	xmm1, dword ptr [kolikoUsporedbiOcekujemoOdMergeSorta] # xmm1 = mem[0],zero,zero,zero
	ucomiss	xmm1, xmm0
	jbe	.LBB4_40
# %bb.18:
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], 0
	mov	eax, dword ptr [rbp - 8]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_19:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_21 Depth 2
                                        #     Child Loop BB4_26 Depth 2
                                        #     Child Loop BB4_32 Depth 2
	cmp	dword ptr [vrh_stoga], 0
	je	.LBB4_39
# %bb.20:                               #   in Loop: Header=BB4_19 Depth=1
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	dword ptr [gornja_granica], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_donjim_granicama]
	mov	dword ptr [donja_granica], ecx
	mov	ecx, dword ptr [vrh_stoga]
	add	ecx, -1
	mov	dword ptr [vrh_stoga], ecx
	mov	ecx, dword ptr [donja_granica]
	mov	dword ptr [gdje_je_pivot], ecx
	mov	ecx, dword ptr [donja_granica]
	add	ecx, 1
	mov	dword ptr [i], ecx
.LBB4_21:                               #   Parent Loop BB4_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_25
# %bb.22:                               #   in Loop: Header=BB4_21 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [donja_granica]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB4_24
# %bb.23:                               #   in Loop: Header=BB4_21 Depth=2
	mov	eax, dword ptr [gdje_je_pivot]
	add	eax, 1
	mov	dword ptr [gdje_je_pivot], eax
.LBB4_24:                               #   in Loop: Header=BB4_21 Depth=2
	mov	eax, dword ptr [i]
	add	eax, 1
	mov	dword ptr [i], eax
	jmp	.LBB4_21
.LBB4_25:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [donja_granica]
	mov	dword ptr [stavi_manje], eax
	mov	eax, dword ptr [gdje_je_pivot]
	add	eax, 1
	mov	dword ptr [stavi_vece], eax
	movsxd	rcx, dword ptr [donja_granica]
	mov	eax, dword ptr [4*rcx + original]
	movsxd	rcx, dword ptr [gdje_je_pivot]
	mov	dword ptr [4*rcx + pomocni], eax
	mov	eax, dword ptr [donja_granica]
	add	eax, 1
	mov	dword ptr [i], eax
.LBB4_26:                               #   Parent Loop BB4_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_31
# %bb.27:                               #   in Loop: Header=BB4_26 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [donja_granica]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB4_29
# %bb.28:                               #   in Loop: Header=BB4_26 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [stavi_manje]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [stavi_manje]
	add	ecx, 1
	mov	dword ptr [stavi_manje], ecx
	jmp	.LBB4_30
.LBB4_29:                               #   in Loop: Header=BB4_26 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [stavi_vece]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [stavi_vece]
	add	ecx, 1
	mov	dword ptr [stavi_vece], ecx
.LBB4_30:                               #   in Loop: Header=BB4_26 Depth=2
	mov	eax, dword ptr [brojac]
	add	eax, 1
	mov	dword ptr [brojac], eax
	mov	eax, dword ptr [i]
	add	eax, 1
	mov	dword ptr [i], eax
	jmp	.LBB4_26
.LBB4_31:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [donja_granica]
	mov	dword ptr [i], eax
.LBB4_32:                               #   Parent Loop BB4_19 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_34
# %bb.33:                               #   in Loop: Header=BB4_32 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + pomocni]
	movsxd	rax, dword ptr [i]
	mov	dword ptr [4*rax + original], ecx
	mov	ecx, dword ptr [i]
	add	ecx, 1
	mov	dword ptr [i], ecx
	jmp	.LBB4_32
.LBB4_34:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [gdje_je_pivot]
	mov	ecx, dword ptr [gornja_granica]
	sub	ecx, 1
	cmp	eax, ecx
	jge	.LBB4_36
# %bb.35:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [gdje_je_pivot]
	add	eax, 1
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [gornja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_36:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [gdje_je_pivot]
	mov	ecx, dword ptr [donja_granica]
	add	ecx, 1
	cmp	eax, ecx
	jle	.LBB4_38
# %bb.37:                               #   in Loop: Header=BB4_19 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [donja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [gdje_je_pivot]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
.LBB4_38:                               #   in Loop: Header=BB4_19 Depth=1
	jmp	.LBB4_19
.LBB4_39:
	jmp	.LBB4_60
.LBB4_40:
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], 0
	mov	eax, dword ptr [rbp - 8]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
.LBB4_41:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_47 Depth 2
                                        #     Child Loop BB4_55 Depth 2
	cmp	dword ptr [vrh_stoga], 0
	je	.LBB4_59
# %bb.42:                               #   in Loop: Header=BB4_41 Depth=1
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	dword ptr [gornja_granica], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_donjim_granicama]
	mov	dword ptr [donja_granica], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove]
	mov	dword ptr [rbp - 28], ecx
	mov	ecx, dword ptr [vrh_stoga]
	add	ecx, -1
	mov	dword ptr [vrh_stoga], ecx
	mov	ecx, dword ptr [donja_granica]
	add	ecx, dword ptr [gornja_granica]
	mov	eax, ecx
	cdq
	mov	ecx, 2
	idiv	ecx
	mov	dword ptr [rbp - 32], eax
	cmp	dword ptr [rbp - 28], 0
	jne	.LBB4_46
# %bb.43:                               #   in Loop: Header=BB4_41 Depth=1
	mov	eax, dword ptr [gornja_granica]
	sub	eax, dword ptr [donja_granica]
	cmp	eax, 1
	jle	.LBB4_45
# %bb.44:                               #   in Loop: Header=BB4_41 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [donja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [gornja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [donja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 32]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 32]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [gornja_granica]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
.LBB4_45:                               #   in Loop: Header=BB4_41 Depth=1
	jmp	.LBB4_58
.LBB4_46:                               #   in Loop: Header=BB4_41 Depth=1
	mov	eax, dword ptr [donja_granica]
	mov	dword ptr [i], eax
	mov	eax, dword ptr [donja_granica]
	mov	dword ptr [gdje_smo_u_prvom_nizu], eax
	mov	eax, dword ptr [rbp - 32]
	mov	dword ptr [gdje_smo_u_drugom_nizu], eax
.LBB4_47:                               #   Parent Loop BB4_41 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_54
# %bb.48:                               #   in Loop: Header=BB4_47 Depth=2
	mov	eax, dword ptr [gdje_smo_u_prvom_nizu]
	cmp	eax, dword ptr [rbp - 32]
	je	.LBB4_50
# %bb.49:                               #   in Loop: Header=BB4_47 Depth=2
	movsxd	rax, dword ptr [gdje_smo_u_drugom_nizu]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [gdje_smo_u_prvom_nizu]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB4_52
.LBB4_50:                               #   in Loop: Header=BB4_47 Depth=2
	mov	eax, dword ptr [gdje_smo_u_drugom_nizu]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_52
# %bb.51:                               #   in Loop: Header=BB4_47 Depth=2
	movsxd	rax, dword ptr [gdje_smo_u_drugom_nizu]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [i]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [gdje_smo_u_drugom_nizu]
	add	ecx, 1
	mov	dword ptr [gdje_smo_u_drugom_nizu], ecx
	jmp	.LBB4_53
.LBB4_52:                               #   in Loop: Header=BB4_47 Depth=2
	movsxd	rax, dword ptr [gdje_smo_u_prvom_nizu]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [i]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [gdje_smo_u_prvom_nizu]
	add	ecx, 1
	mov	dword ptr [gdje_smo_u_prvom_nizu], ecx
.LBB4_53:                               #   in Loop: Header=BB4_47 Depth=2
	mov	eax, dword ptr [i]
	add	eax, 1
	mov	dword ptr [i], eax
	mov	eax, dword ptr [brojac]
	add	eax, 1
	mov	dword ptr [brojac], eax
	jmp	.LBB4_47
.LBB4_54:                               #   in Loop: Header=BB4_41 Depth=1
	mov	eax, dword ptr [donja_granica]
	mov	dword ptr [i], eax
.LBB4_55:                               #   Parent Loop BB4_41 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [i]
	cmp	eax, dword ptr [gornja_granica]
	jge	.LBB4_57
# %bb.56:                               #   in Loop: Header=BB4_55 Depth=2
	movsxd	rax, dword ptr [i]
	mov	ecx, dword ptr [4*rax + pomocni]
	movsxd	rax, dword ptr [i]
	mov	dword ptr [4*rax + original], ecx
	mov	ecx, dword ptr [brojac]
	add	ecx, 1
	mov	dword ptr [brojac], ecx
	mov	ecx, dword ptr [i]
	add	ecx, 1
	mov	dword ptr [i], ecx
	jmp	.LBB4_55
.LBB4_57:                               #   in Loop: Header=BB4_41 Depth=1
	jmp	.LBB4_58
.LBB4_58:                               #   in Loop: Header=BB4_41 Depth=1
	jmp	.LBB4_41
.LBB4_59:
	jmp	.LBB4_60
.LBB4_60:
	jmp	.LBB4_61
.LBB4_61:
	jmp	.LBB4_62
.LBB4_62:
	mov	al, 0
	call	clock
	sub	rax, qword ptr [rbp - 24]
	mov	qword ptr [rbp - 24], rax
	mov	dword ptr [rbp - 36], 0
.LBB4_63:                               # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 36]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB4_66
# %bb.64:                               #   in Loop: Header=BB4_63 Depth=1
	movsxd	rax, dword ptr [rbp - 36]
	mov	esi, dword ptr [4*rax + original]
	movabs	rdi, offset .L.str.1
	mov	al, 0
	call	printf
# %bb.65:                               #   in Loop: Header=BB4_63 Depth=1
	mov	eax, dword ptr [rbp - 36]
	add	eax, 1
	mov	dword ptr [rbp - 36], eax
	jmp	.LBB4_63
.LBB4_66:
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
	.type	i,@object               # @i
	.comm	i,4,4
	.type	razvrstanost,@object    # @razvrstanost
	.comm	razvrstanost,4,4
	.type	polinomPodApsolutnom,@object # @polinomPodApsolutnom
	.comm	polinomPodApsolutnom,4,4
	.type	eNaKoju,@object         # @eNaKoju
	.comm	eNaKoju,4,4
	.type	kolikoUsporedbiOcekujemoOdQuickSorta,@object # @kolikoUsporedbiOcekujemoOdQuickSorta
	.comm	kolikoUsporedbiOcekujemoOdQuickSorta,4,4
	.type	kolikoUsporedbiOcekujemoOdMergeSorta,@object # @kolikoUsporedbiOcekujemoOdMergeSorta
	.comm	kolikoUsporedbiOcekujemoOdMergeSorta,4,4
	.type	pomocni,@object         # @pomocni
	.comm	pomocni,131072,16
	.type	stog_s_donjim_granicama,@object # @stog_s_donjim_granicama
	.comm	stog_s_donjim_granicama,131072,16
	.type	stog_s_gornjim_granicama,@object # @stog_s_gornjim_granicama
	.comm	stog_s_gornjim_granicama,131072,16
	.type	gornja_granica,@object  # @gornja_granica
	.comm	gornja_granica,4,4
	.type	donja_granica,@object   # @donja_granica
	.comm	donja_granica,4,4
	.type	gdje_je_pivot,@object   # @gdje_je_pivot
	.comm	gdje_je_pivot,4,4
	.type	stavi_manje,@object     # @stavi_manje
	.comm	stavi_manje,4,4
	.type	stavi_vece,@object      # @stavi_vece
	.comm	stavi_vece,4,4
	.type	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove,@object # @stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
	.comm	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove,131072,16
	.type	gdje_smo_u_prvom_nizu,@object # @gdje_smo_u_prvom_nizu
	.comm	gdje_smo_u_prvom_nizu,4,4
	.type	gdje_smo_u_drugom_nizu,@object # @gdje_smo_u_drugom_nizu
	.comm	gdje_smo_u_drugom_nizu,4,4
	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4

	.type	sredina_niza,@object    # @sredina_niza
	.comm	sredina_niza,4,4
	.type	treba_li_spajati_ili_razdvajati,@object # @treba_li_spajati_ili_razdvajati
	.comm	treba_li_spajati_ili_razdvajati,4,4

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
	.addrsig_sym i
	.addrsig_sym razvrstanost
	.addrsig_sym polinomPodApsolutnom
	.addrsig_sym eNaKoju
	.addrsig_sym kolikoUsporedbiOcekujemoOdQuickSorta
	.addrsig_sym kolikoUsporedbiOcekujemoOdMergeSorta
	.addrsig_sym pomocni
	.addrsig_sym stog_s_donjim_granicama
	.addrsig_sym stog_s_gornjim_granicama
	.addrsig_sym gornja_granica
	.addrsig_sym donja_granica
	.addrsig_sym gdje_je_pivot
	.addrsig_sym stavi_manje
	.addrsig_sym stavi_vece
	.addrsig_sym stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
	.addrsig_sym gdje_smo_u_prvom_nizu
	.addrsig_sym gdje_smo_u_drugom_nizu
