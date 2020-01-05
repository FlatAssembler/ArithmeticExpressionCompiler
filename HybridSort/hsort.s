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
	.quad	-4661117527937406468    # double -0.001
	.text
	.globl	log
	.p2align	4, 0x90
	.type	log,@function
log:                                    # @log
	.cfi_startproc
# %bb.0:
	movsd	xmm2, qword ptr [rip + .LCPI0_0] # xmm2 = mem[0],zero
	ucomisd	xmm2, xmm0
	jbe	.LBB0_9
# %bb.1:
	ucomisd	xmm0, qword ptr [rip + .LCPI0_0]
	jbe	.LBB0_2
# %bb.5:
	je	.LBB0_6
# %bb.7:
	movsd	xmm2, qword ptr [rip + .LCPI0_0] # xmm2 = mem[0],zero
	movsd	xmm4, qword ptr [rip + .LCPI0_2] # xmm4 = mem[0],zero
	xorpd	xmm1, xmm1
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
	movapd	xmm5, xmm4
	divsd	xmm5, xmm2
	addsd	xmm1, xmm5
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm2, xmm0
	movapd	xmm4, xmm3
	jne	.LBB0_8
	jmp	.LBB0_12
.LBB0_9:
	xorpd	xmm1, xmm1
	ucomisd	xmm0, qword ptr [rip + .LCPI0_0]
	jbe	.LBB0_12
# %bb.10:
	movsd	xmm4, qword ptr [rip + .LCPI0_1] # xmm4 = mem[0],zero
	xorpd	xmm1, xmm1
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm5, xmm4
	divsd	xmm5, xmm2
	addsd	xmm1, xmm5
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm0, xmm2
	movapd	xmm4, xmm3
	ja	.LBB0_11
	jmp	.LBB0_12
.LBB0_2:
	xorpd	xmm1, xmm1
	movsd	xmm2, qword ptr [rip + .LCPI0_0] # xmm2 = mem[0],zero
	ucomisd	xmm2, xmm0
	jbe	.LBB0_12
# %bb.3:
	movsd	xmm4, qword ptr [rip + .LCPI0_2] # xmm4 = mem[0],zero
	xorpd	xmm1, xmm1
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB0_4:                                # =>This Inner Loop Header: Depth=1
	movapd	xmm5, xmm4
	divsd	xmm5, xmm2
	addsd	xmm1, xmm5
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm2, xmm0
	movapd	xmm4, xmm3
	ja	.LBB0_4
.LBB0_12:
	movapd	xmm0, xmm1
	ret
.LBB0_6:
	xorps	xmm1, xmm1
	movaps	xmm0, xmm1
	ret
.Lfunc_end0:
	.size	log, .Lfunc_end0-log
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3               # -- Begin function exp
.LCPI1_0:
	.quad	4607182418800017408     # double 1
.LCPI1_1:
	.quad	4562254508917369340     # double 0.001
.LCPI1_2:
	.quad	-4661117527937406468    # double -0.001
	.text
	.globl	exp
	.p2align	4, 0x90
	.type	exp,@function
exp:                                    # @exp
	.cfi_startproc
# %bb.0:
	xorps	xmm1, xmm1
	ucomisd	xmm1, xmm0
	jbe	.LBB1_5
# %bb.1:
	xorpd	xmm2, xmm2
	ucomisd	xmm0, xmm1
	jbe	.LBB1_8
# %bb.2:
	ucomisd	xmm0, xmm2
	je	.LBB1_13
# %bb.3:
	movsd	xmm4, qword ptr [rip + .LCPI1_2] # xmm4 = mem[0],zero
	movsd	xmm1, qword ptr [rip + .LCPI1_0] # xmm1 = mem[0],zero
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB1_4:                                # =>This Inner Loop Header: Depth=1
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	mulsd	xmm4, xmm1
	addsd	xmm1, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm2, xmm0
	movapd	xmm4, xmm3
	jne	.LBB1_4
	jmp	.LBB1_11
.LBB1_5:
	ucomisd	xmm0, xmm1
	jbe	.LBB1_13
# %bb.6:
	xorpd	xmm2, xmm2
	movsd	xmm4, qword ptr [rip + .LCPI1_1] # xmm4 = mem[0],zero
	movsd	xmm1, qword ptr [rip + .LCPI1_0] # xmm1 = mem[0],zero
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB1_7:                                # =>This Inner Loop Header: Depth=1
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	mulsd	xmm4, xmm1
	addsd	xmm1, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm0, xmm2
	movapd	xmm4, xmm3
	ja	.LBB1_7
	jmp	.LBB1_11
.LBB1_8:
	ucomisd	xmm2, xmm0
	jbe	.LBB1_13
# %bb.9:
	movsd	xmm4, qword ptr [rip + .LCPI1_2] # xmm4 = mem[0],zero
	movsd	xmm1, qword ptr [rip + .LCPI1_0] # xmm1 = mem[0],zero
	movapd	xmm3, xmm4
	.p2align	4, 0x90
.LBB1_10:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm2, xmm4
	addsd	xmm3, xmm2
	movapd	xmm5, xmm4
	addsd	xmm5, xmm4
	cmpeqsd	xmm3, xmm2
	andpd	xmm5, xmm3
	andnpd	xmm3, xmm4
	mulsd	xmm4, xmm1
	addsd	xmm1, xmm4
	orpd	xmm3, xmm5
	ucomisd	xmm2, xmm0
	movapd	xmm4, xmm3
	ja	.LBB1_10
.LBB1_11:
	movapd	xmm0, xmm1
	ret
.LBB1_13:
	movsd	xmm1, qword ptr [rip + .LCPI1_0] # xmm1 = mem[0],zero
	movaps	xmm0, xmm1
	ret
.Lfunc_end1:
	.size	exp, .Lfunc_end1-exp
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function fabs
.LCPI2_0:
	.quad	-9223372036854775808    # double -0
	.quad	-9223372036854775808    # double -0
	.text
	.globl	fabs
	.p2align	4, 0x90
	.type	fabs,@function
fabs:                                   # @fabs
	.cfi_startproc
# %bb.0:
	movapd	xmm2, xmmword ptr [rip + .LCPI2_0] # xmm2 = [-0.0E+0,-0.0E+0]
	xorpd	xmm2, xmm0
	xorpd	xmm3, xmm3
	movapd	xmm1, xmm0
	cmpltsd	xmm1, xmm3
	andpd	xmm2, xmm1
	andnpd	xmm1, xmm0
	orpd	xmm1, xmm2
	movapd	xmm0, xmm1
	ret
.Lfunc_end2:
	.size	fabs, .Lfunc_end2-fabs
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4               # -- Begin function pow
.LCPI3_0:
	.quad	9223372036854775807     # double NaN
	.quad	9223372036854775807     # double NaN
.LCPI3_4:
	.quad	-9223372036854775808    # double -0
	.quad	-9223372036854775808    # double -0
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI3_1:
	.quad	4607182418800017408     # double 1
.LCPI3_2:
	.quad	4562254508917369340     # double 0.001
.LCPI3_3:
	.quad	-4661117527937406468    # double -0.001
	.text
	.globl	pow
	.p2align	4, 0x90
	.type	pow,@function
pow:                                    # @pow
	.cfi_startproc
# %bb.0:
	xorpd	xmm2, xmm2
	ucomisd	xmm0, xmm2
	jne	.LBB3_1
	jnp	.LBB3_27
.LBB3_1:
	movapd	xmm2, xmmword ptr [rip + .LCPI3_0] # xmm2 = [NaN,NaN]
	andpd	xmm2, xmm0
	movsd	xmm4, qword ptr [rip + .LCPI3_1] # xmm4 = mem[0],zero
	ucomisd	xmm4, xmm2
	jbe	.LBB3_6
# %bb.2:
	ucomisd	xmm2, qword ptr [rip + .LCPI3_1]
	jbe	.LBB3_9
# %bb.3:
	je	.LBB3_18
# %bb.4:
	movsd	xmm4, qword ptr [rip + .LCPI3_1] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI3_3] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_5:                                # =>This Inner Loop Header: Depth=1
	movapd	xmm7, xmm6
	divsd	xmm7, xmm4
	addsd	xmm3, xmm7
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm4, xmm2
	movapd	xmm6, xmm5
	jne	.LBB3_5
	jmp	.LBB3_11
.LBB3_6:
	xorpd	xmm3, xmm3
	ucomisd	xmm2, qword ptr [rip + .LCPI3_1]
	jbe	.LBB3_11
# %bb.7:
	movsd	xmm6, qword ptr [rip + .LCPI3_2] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_8:                                # =>This Inner Loop Header: Depth=1
	movapd	xmm7, xmm6
	divsd	xmm7, xmm4
	addsd	xmm3, xmm7
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm2, xmm4
	movapd	xmm6, xmm5
	ja	.LBB3_8
	jmp	.LBB3_11
.LBB3_9:
	movsd	xmm4, qword ptr [rip + .LCPI3_1] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI3_3] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_10:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm7, xmm6
	divsd	xmm7, xmm4
	addsd	xmm3, xmm7
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm4, xmm2
	movapd	xmm6, xmm5
	ja	.LBB3_10
.LBB3_11:
	mulsd	xmm3, xmm1
	xorpd	xmm2, xmm2
	ucomisd	xmm2, xmm3
	jbe	.LBB3_19
.LBB3_12:
	xorpd	xmm4, xmm4
	ucomisd	xmm3, xmm2
	jbe	.LBB3_16
# %bb.13:
	ucomisd	xmm3, xmm4
	je	.LBB3_23
# %bb.14:
	movsd	xmm6, qword ptr [rip + .LCPI3_3] # xmm6 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI3_1] # xmm2 = mem[0],zero
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_15:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	mulsd	xmm6, xmm2
	addsd	xmm2, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm4, xmm3
	movapd	xmm6, xmm5
	jne	.LBB3_15
	jmp	.LBB3_24
.LBB3_16:
	movsd	xmm6, qword ptr [rip + .LCPI3_3] # xmm6 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI3_1] # xmm2 = mem[0],zero
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_17:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	mulsd	xmm6, xmm2
	addsd	xmm2, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm4, xmm3
	movapd	xmm6, xmm5
	ja	.LBB3_17
	jmp	.LBB3_24
.LBB3_18:
	xorpd	xmm3, xmm3
	mulsd	xmm3, xmm1
	xorpd	xmm2, xmm2
	ucomisd	xmm2, xmm3
	ja	.LBB3_12
.LBB3_19:
	ucomisd	xmm3, xmm2
	jbe	.LBB3_23
# %bb.20:
	xorpd	xmm4, xmm4
	movsd	xmm6, qword ptr [rip + .LCPI3_2] # xmm6 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI3_1] # xmm2 = mem[0],zero
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB3_21:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm7, xmm6
	addsd	xmm7, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm7, xmm5
	andnpd	xmm5, xmm6
	mulsd	xmm6, xmm2
	addsd	xmm2, xmm6
	orpd	xmm5, xmm7
	ucomisd	xmm3, xmm4
	movapd	xmm6, xmm5
	ja	.LBB3_21
	jmp	.LBB3_24
.LBB3_23:
	movsd	xmm2, qword ptr [rip + .LCPI3_1] # xmm2 = mem[0],zero
.LBB3_24:
	cvttsd2si	eax, xmm1
	xorps	xmm3, xmm3
	cvtsi2sd	xmm3, eax
	subsd	xmm1, xmm3
	andpd	xmm1, xmmword ptr [rip + .LCPI3_0]
	movsd	xmm3, qword ptr [rip + .LCPI3_2] # xmm3 = mem[0],zero
	ucomisd	xmm3, xmm1
	jbe	.LBB3_27
# %bb.25:
	test	al, 1
	jne	.LBB3_28
# %bb.26:
	movapd	xmm1, xmm2
	jmp	.LBB3_29
.LBB3_27:
	movapd	xmm0, xmm2
	ret
.LBB3_28:
	movapd	xmm1, xmmword ptr [rip + .LCPI3_4] # xmm1 = [-0.0E+0,-0.0E+0]
	xorpd	xmm1, xmm2
.LBB3_29:
	xorpd	xmm3, xmm3
	cmpltsd	xmm0, xmm3
	andpd	xmm1, xmm0
	andnpd	xmm0, xmm2
	orpd	xmm0, xmm1
	ret
.Lfunc_end3:
	.size	pow, .Lfunc_end3-pow
	.cfi_endproc
                                        # -- End function
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2               # -- Begin function main
.LCPI4_0:
	.long	1065353216              # float 1
.LCPI4_1:
	.long	1056964608              # float 0.5
.LCPI4_2:
	.long	3212836864              # float -1
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI4_3:
	.quad	4619567317775286272     # double 7
.LCPI4_4:
	.quad	4612560932726997170     # double 2.3885399999999999
.LCPI4_5:
	.quad	4618441417868443648     # double 6
.LCPI4_6:
	.quad	-4624579680045361558    # double -0.28425800000000001
.LCPI4_7:
	.quad	4617315517961601024     # double 5
.LCPI4_8:
	.quad	-4612266802635333603    # double -1.87104
.LCPI4_9:
	.quad	4616189618054758400     # double 4
.LCPI4_10:
	.quad	4600384451335283758     # double 0.372637
.LCPI4_11:
	.quad	4613937818241073152     # double 3
.LCPI4_12:
	.quad	4595193548361580996     # double 0.167242
.LCPI4_13:
	.quad	-4632330684851720545    # double -0.088497699999999999
.LCPI4_14:
	.quad	4599348299161815373     # double 0.31511899999999998
.LCPI4_15:
	.quad	4607182418800017408     # double 1
.LCPI4_16:
	.quad	4562254508917369340     # double 0.001
.LCPI4_17:
	.quad	-4661117527937406468    # double -0.001
.LCPI4_18:
	.quad	4607407598781385933     # double 1.05
.LCPI4_19:
	.quad	4605651194926711439     # double 0.82999999999999996
.LCPI4_21:
	.quad	4604418534313441775     # double 0.69314718055994529
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4
.LCPI4_20:
	.long	2147483647              # float NaN
	.long	2147483647              # float NaN
	.long	2147483647              # float NaN
	.long	2147483647              # float NaN
	.text
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	push	r15
	.cfi_def_cfa_offset 24
	push	r14
	.cfi_def_cfa_offset 32
	push	r13
	.cfi_def_cfa_offset 40
	push	r12
	.cfi_def_cfa_offset 48
	push	rbx
	.cfi_def_cfa_offset 56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	.cfi_offset rbx, -56
	.cfi_offset r12, -48
	.cfi_offset r13, -40
	.cfi_offset r14, -32
	.cfi_offset r15, -24
	.cfi_offset rbp, -16
	lea	rsi, [rsp + 12]
	mov	edi, offset .L.str
	xor	eax, eax
	call	scanf
	cmp	dword ptr [rsp + 12], 0
	jle	.LBB4_3
# %bb.1:
	mov	ebx, offset original
	xor	ebp, ebp
	.p2align	4, 0x90
.LBB4_2:                                # =>This Inner Loop Header: Depth=1
	mov	edi, offset .L.str
	mov	rsi, rbx
	xor	eax, eax
	call	scanf
	add	rbp, 1
	movsxd	rax, dword ptr [rsp + 12]
	add	rbx, 4
	cmp	rbp, rax
	jl	.LBB4_2
.LBB4_3:
	xor	eax, eax
	call	clock
	mov	dword ptr [rip + razvrstanost], 0
	movsxd	r14, dword ptr [rsp + 12]
	mov	rbp, r14
	add	rbp, -1
	test	ebp, ebp
	jle	.LBB4_6
# %bb.4:
	mov	r8d, dword ptr [rip + brojac]
	mov	ecx, dword ptr [rip + original]
	lea	rax, [rbp - 1]
	mov	edx, ebp
	and	edx, 3
	cmp	rax, 3
	jae	.LBB4_7
# %bb.5:
	xorps	xmm2, xmm2
	xor	edi, edi
	test	rdx, rdx
	jne	.LBB4_18
	jmp	.LBB4_23
.LBB4_6:
	xorps	xmm2, xmm2
	jmp	.LBB4_24
.LBB4_7:
	mov	rax, rbp
	sub	rax, rdx
	xorps	xmm2, xmm2
	xor	edi, edi
	movss	xmm0, dword ptr [rip + .LCPI4_0] # xmm0 = mem[0],zero,zero,zero
	mov	ebx, dword ptr [4*rdi + original+4]
	movaps	xmm1, xmm0
	cmp	ecx, ebx
	jl	.LBB4_11
	jmp	.LBB4_10
	.p2align	4, 0x90
.LBB4_8:                                #   in Loop: Header=BB4_11 Depth=1
	addss	xmm2, xmm1
	cmp	rax, rdi
	je	.LBB4_17
# %bb.9:                                #   in Loop: Header=BB4_11 Depth=1
	mov	ebx, dword ptr [4*rdi + original+4]
	movaps	xmm1, xmm0
	cmp	ecx, ebx
	jl	.LBB4_11
.LBB4_10:
	xorps	xmm1, xmm1
.LBB4_11:                               # =>This Inner Loop Header: Depth=1
	addss	xmm2, xmm1
	mov	esi, dword ptr [4*rdi + original+8]
	movaps	xmm1, xmm0
	cmp	ebx, esi
	jl	.LBB4_13
# %bb.12:                               #   in Loop: Header=BB4_11 Depth=1
	xorps	xmm1, xmm1
.LBB4_13:                               #   in Loop: Header=BB4_11 Depth=1
	addss	xmm2, xmm1
	mov	ebx, dword ptr [4*rdi + original+12]
	movaps	xmm1, xmm0
	cmp	esi, ebx
	jl	.LBB4_15
# %bb.14:                               #   in Loop: Header=BB4_11 Depth=1
	xorps	xmm1, xmm1
.LBB4_15:                               #   in Loop: Header=BB4_11 Depth=1
	addss	xmm2, xmm1
	mov	ecx, dword ptr [4*rdi + original+16]
	add	rdi, 4
	movaps	xmm1, xmm0
	cmp	ebx, ecx
	jl	.LBB4_8
# %bb.16:                               #   in Loop: Header=BB4_11 Depth=1
	xorps	xmm1, xmm1
	jmp	.LBB4_8
.LBB4_17:
	add	r8d, edi
	test	rdx, rdx
	je	.LBB4_23
.LBB4_18:
	lea	rdi, [4*rdi + original+4]
	xor	eax, eax
	movss	xmm0, dword ptr [rip + .LCPI4_0] # xmm0 = mem[0],zero,zero,zero
	jmp	.LBB4_20
	.p2align	4, 0x90
.LBB4_19:                               #   in Loop: Header=BB4_20 Depth=1
	addss	xmm2, xmm1
	add	rax, 1
	cmp	rdx, rax
	je	.LBB4_22
.LBB4_20:                               # =>This Inner Loop Header: Depth=1
	mov	esi, ecx
	mov	ecx, dword ptr [rdi + 4*rax]
	movaps	xmm1, xmm0
	cmp	esi, ecx
	jl	.LBB4_19
# %bb.21:                               #   in Loop: Header=BB4_20 Depth=1
	xorps	xmm1, xmm1
	jmp	.LBB4_19
.LBB4_22:
	add	r8d, eax
.LBB4_23:
	movss	dword ptr [rip + razvrstanost], xmm2
	mov	dword ptr [rip + brojac], r8d
.LBB4_24:
	xorps	xmm0, xmm0
	cvtsi2ss	xmm0, ebp
	mulss	xmm0, dword ptr [rip + .LCPI4_1]
	divss	xmm2, xmm0
	addss	xmm2, dword ptr [rip + .LCPI4_2]
	movss	dword ptr [rip + razvrstanost], xmm2
	movss	dword ptr [rsp + 36], xmm2 # 4-byte Spill
	xorps	xmm0, xmm0
	cvtss2sd	xmm0, xmm2
	movsd	qword ptr [rsp + 16], xmm0 # 8-byte Spill
	movsd	xmm1, qword ptr [rip + .LCPI4_3] # xmm1 = mem[0],zero
	call	pow
	mulsd	xmm0, qword ptr [rip + .LCPI4_4]
	movsd	qword ptr [rsp + 24], xmm0 # 8-byte Spill
	movsd	xmm1, qword ptr [rip + .LCPI4_5] # xmm1 = mem[0],zero
	movsd	xmm0, qword ptr [rsp + 16] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	call	pow
	mulsd	xmm0, qword ptr [rip + .LCPI4_6]
	addsd	xmm0, qword ptr [rsp + 24] # 8-byte Folded Reload
	movsd	qword ptr [rsp + 24], xmm0 # 8-byte Spill
	movsd	xmm1, qword ptr [rip + .LCPI4_7] # xmm1 = mem[0],zero
	movsd	xmm0, qword ptr [rsp + 16] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	call	pow
	mulsd	xmm0, qword ptr [rip + .LCPI4_8]
	addsd	xmm0, qword ptr [rsp + 24] # 8-byte Folded Reload
	movsd	qword ptr [rsp + 24], xmm0 # 8-byte Spill
	movsd	xmm1, qword ptr [rip + .LCPI4_9] # xmm1 = mem[0],zero
	movsd	xmm0, qword ptr [rsp + 16] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	call	pow
	mulsd	xmm0, qword ptr [rip + .LCPI4_10]
	addsd	xmm0, qword ptr [rsp + 24] # 8-byte Folded Reload
	movsd	qword ptr [rsp + 24], xmm0 # 8-byte Spill
	movsd	xmm1, qword ptr [rip + .LCPI4_11] # xmm1 = mem[0],zero
	movsd	xmm0, qword ptr [rsp + 16] # 8-byte Reload
                                        # xmm0 = mem[0],zero
	call	pow
	mulsd	xmm0, qword ptr [rip + .LCPI4_12]
	addsd	xmm0, qword ptr [rsp + 24] # 8-byte Folded Reload
	movsd	xmm2, qword ptr [rsp + 16] # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movapd	xmm1, xmm2
	mulsd	xmm1, xmm2
	mulsd	xmm1, qword ptr [rip + .LCPI4_13]
	mulsd	xmm2, qword ptr [rip + .LCPI4_14]
	addsd	xmm1, xmm0
	addsd	xmm2, xmm1
	cvtsd2ss	xmm8, xmm2
	movss	dword ptr [rip + polinomPodApsolutnom], xmm8
	cvtsi2sd	xmm9, r14d
	test	r14d, r14d
	jle	.LBB4_28
# %bb.25:
	xorpd	xmm3, xmm3
	xorpd	xmm2, xmm2
	cmp	r14d, 2
	jl	.LBB4_45
# %bb.26:
	movsd	xmm3, qword ptr [rip + .LCPI4_15] # xmm3 = mem[0],zero
	movsd	xmm5, qword ptr [rip + .LCPI4_16] # xmm5 = mem[0],zero
	xorpd	xmm2, xmm2
	movapd	xmm4, xmm5
	.p2align	4, 0x90
.LBB4_27:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm5
	divsd	xmm1, xmm3
	addsd	xmm2, xmm1
	addsd	xmm3, xmm5
	addsd	xmm4, xmm3
	movapd	xmm1, xmm5
	addsd	xmm1, xmm5
	cmpeqsd	xmm4, xmm3
	andpd	xmm1, xmm4
	andnpd	xmm4, xmm5
	orpd	xmm4, xmm1
	ucomisd	xmm9, xmm3
	movapd	xmm5, xmm4
	ja	.LBB4_27
	jmp	.LBB4_30
.LBB4_28:
	movsd	xmm3, qword ptr [rip + .LCPI4_15] # xmm3 = mem[0],zero
	movsd	xmm5, qword ptr [rip + .LCPI4_17] # xmm5 = mem[0],zero
	xorpd	xmm2, xmm2
	movapd	xmm4, xmm5
	.p2align	4, 0x90
.LBB4_29:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm5
	divsd	xmm1, xmm3
	addsd	xmm2, xmm1
	addsd	xmm3, xmm5
	addsd	xmm4, xmm3
	movapd	xmm1, xmm5
	addsd	xmm1, xmm5
	cmpeqsd	xmm4, xmm3
	andpd	xmm1, xmm4
	andnpd	xmm4, xmm5
	orpd	xmm4, xmm1
	ucomisd	xmm3, xmm9
	movapd	xmm5, xmm4
	ja	.LBB4_29
.LBB4_30:
	test	r14d, r14d
	jle	.LBB4_34
# %bb.31:
	xorpd	xmm3, xmm3
	cmp	r14d, 2
	jl	.LBB4_45
# %bb.32:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_16] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_33:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm6
	divsd	xmm1, xmm4
	addsd	xmm3, xmm1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm1, xmm6
	addsd	xmm1, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm1, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm1
	ucomisd	xmm9, xmm4
	movapd	xmm6, xmm5
	ja	.LBB4_33
	jmp	.LBB4_36
.LBB4_34:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_17] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_35:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm6
	divsd	xmm1, xmm4
	addsd	xmm3, xmm1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm1, xmm6
	addsd	xmm1, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm1, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm1
	ucomisd	xmm4, xmm9
	movapd	xmm6, xmm5
	ja	.LBB4_35
.LBB4_36:
	movsd	xmm5, qword ptr [rip + .LCPI4_15] # xmm5 = mem[0],zero
	ucomisd	xmm5, xmm3
	jbe	.LBB4_41
# %bb.37:
	ucomisd	xmm3, qword ptr [rip + .LCPI4_15]
	jbe	.LBB4_44
# %bb.38:
	je	.LBB4_51
# %bb.39:
	movsd	xmm5, qword ptr [rip + .LCPI4_15] # xmm5 = mem[0],zero
	movsd	xmm1, qword ptr [rip + .LCPI4_17] # xmm1 = mem[0],zero
	xorpd	xmm4, xmm4
	movapd	xmm6, xmm1
	.p2align	4, 0x90
.LBB4_40:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm7, xmm1
	divsd	xmm7, xmm5
	addsd	xmm4, xmm7
	addsd	xmm5, xmm1
	addsd	xmm6, xmm5
	movapd	xmm7, xmm1
	addsd	xmm7, xmm1
	cmpeqsd	xmm6, xmm5
	andpd	xmm7, xmm6
	andnpd	xmm6, xmm1
	orpd	xmm6, xmm7
	ucomisd	xmm5, xmm3
	movapd	xmm1, xmm6
	jne	.LBB4_40
	jmp	.LBB4_47
.LBB4_41:
	xorpd	xmm4, xmm4
	ucomisd	xmm3, qword ptr [rip + .LCPI4_15]
	jbe	.LBB4_47
# %bb.42:
	movsd	xmm1, qword ptr [rip + .LCPI4_16] # xmm1 = mem[0],zero
	xorpd	xmm4, xmm4
	movapd	xmm6, xmm1
	.p2align	4, 0x90
.LBB4_43:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm7, xmm1
	divsd	xmm7, xmm5
	addsd	xmm4, xmm7
	addsd	xmm5, xmm1
	addsd	xmm6, xmm5
	movapd	xmm7, xmm1
	addsd	xmm7, xmm1
	cmpeqsd	xmm6, xmm5
	andpd	xmm7, xmm6
	andnpd	xmm6, xmm1
	orpd	xmm6, xmm7
	ucomisd	xmm3, xmm5
	movapd	xmm1, xmm6
	ja	.LBB4_43
	jmp	.LBB4_47
.LBB4_44:
	xorpd	xmm4, xmm4
	movsd	xmm1, qword ptr [rip + .LCPI4_15] # xmm1 = mem[0],zero
	ucomisd	xmm1, xmm3
	jbe	.LBB4_47
.LBB4_45:
	movsd	xmm5, qword ptr [rip + .LCPI4_15] # xmm5 = mem[0],zero
	movsd	xmm7, qword ptr [rip + .LCPI4_17] # xmm7 = mem[0],zero
	xorpd	xmm4, xmm4
	movapd	xmm6, xmm7
	.p2align	4, 0x90
.LBB4_46:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm7
	divsd	xmm1, xmm5
	addsd	xmm4, xmm1
	addsd	xmm5, xmm7
	addsd	xmm6, xmm5
	movapd	xmm1, xmm7
	addsd	xmm1, xmm7
	cmpeqsd	xmm6, xmm5
	andpd	xmm1, xmm6
	andnpd	xmm6, xmm7
	orpd	xmm6, xmm1
	ucomisd	xmm5, xmm3
	movapd	xmm7, xmm6
	ja	.LBB4_46
.LBB4_47:
	addsd	xmm2, xmm4
	mulsd	xmm2, qword ptr [rip + .LCPI4_18]
	test	r14d, r14d
	jle	.LBB4_52
.LBB4_48:
	xorpd	xmm4, xmm4
	xorpd	xmm3, xmm3
	cmp	r14d, 2
	jl	.LBB4_69
# %bb.49:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_16] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_50:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm6
	divsd	xmm1, xmm4
	addsd	xmm3, xmm1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm1, xmm6
	addsd	xmm1, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm1, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm1
	ucomisd	xmm9, xmm4
	movapd	xmm6, xmm5
	ja	.LBB4_50
	jmp	.LBB4_54
.LBB4_51:
	xorpd	xmm4, xmm4
	addsd	xmm2, xmm4
	mulsd	xmm2, qword ptr [rip + .LCPI4_18]
	test	r14d, r14d
	jg	.LBB4_48
.LBB4_52:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_17] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_53:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm6
	divsd	xmm1, xmm4
	addsd	xmm3, xmm1
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm1, xmm6
	addsd	xmm1, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm1, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm1
	ucomisd	xmm4, xmm9
	movapd	xmm6, xmm5
	ja	.LBB4_53
.LBB4_54:
	test	r14d, r14d
	jle	.LBB4_58
# %bb.55:
	xorpd	xmm4, xmm4
	cmp	r14d, 2
	jl	.LBB4_69
# %bb.56:
	movsd	xmm5, qword ptr [rip + .LCPI4_15] # xmm5 = mem[0],zero
	movsd	xmm7, qword ptr [rip + .LCPI4_16] # xmm7 = mem[0],zero
	xorpd	xmm4, xmm4
	movapd	xmm6, xmm7
	.p2align	4, 0x90
.LBB4_57:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm7
	divsd	xmm1, xmm5
	addsd	xmm4, xmm1
	addsd	xmm5, xmm7
	addsd	xmm6, xmm5
	movapd	xmm1, xmm7
	addsd	xmm1, xmm7
	cmpeqsd	xmm6, xmm5
	andpd	xmm1, xmm6
	andnpd	xmm6, xmm7
	orpd	xmm6, xmm1
	ucomisd	xmm9, xmm5
	movapd	xmm7, xmm6
	ja	.LBB4_57
	jmp	.LBB4_60
.LBB4_58:
	movsd	xmm5, qword ptr [rip + .LCPI4_15] # xmm5 = mem[0],zero
	movsd	xmm7, qword ptr [rip + .LCPI4_17] # xmm7 = mem[0],zero
	xorpd	xmm4, xmm4
	movapd	xmm6, xmm7
	.p2align	4, 0x90
.LBB4_59:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm7
	divsd	xmm1, xmm5
	addsd	xmm4, xmm1
	addsd	xmm5, xmm7
	addsd	xmm6, xmm5
	movapd	xmm1, xmm7
	addsd	xmm1, xmm7
	cmpeqsd	xmm6, xmm5
	andpd	xmm1, xmm6
	andnpd	xmm6, xmm7
	orpd	xmm6, xmm1
	ucomisd	xmm5, xmm9
	movapd	xmm7, xmm6
	ja	.LBB4_59
.LBB4_60:
	movsd	xmm6, qword ptr [rip + .LCPI4_15] # xmm6 = mem[0],zero
	ucomisd	xmm6, xmm4
	jbe	.LBB4_65
# %bb.61:
	ucomisd	xmm4, qword ptr [rip + .LCPI4_15]
	jbe	.LBB4_68
# %bb.62:
	je	.LBB4_156
# %bb.63:
	movsd	xmm6, qword ptr [rip + .LCPI4_15] # xmm6 = mem[0],zero
	movsd	xmm0, qword ptr [rip + .LCPI4_17] # xmm0 = mem[0],zero
	xorpd	xmm5, xmm5
	movapd	xmm7, xmm0
	.p2align	4, 0x90
.LBB4_64:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm1, xmm0
	divsd	xmm1, xmm6
	addsd	xmm5, xmm1
	addsd	xmm6, xmm0
	addsd	xmm7, xmm6
	movapd	xmm1, xmm0
	addsd	xmm1, xmm0
	cmpeqsd	xmm7, xmm6
	andpd	xmm1, xmm7
	andnpd	xmm7, xmm0
	orpd	xmm7, xmm1
	ucomisd	xmm6, xmm4
	movapd	xmm0, xmm7
	jne	.LBB4_64
	jmp	.LBB4_71
.LBB4_65:
	xorpd	xmm5, xmm5
	ucomisd	xmm4, qword ptr [rip + .LCPI4_15]
	jbe	.LBB4_71
# %bb.66:
	movsd	xmm1, qword ptr [rip + .LCPI4_16] # xmm1 = mem[0],zero
	xorpd	xmm5, xmm5
	movapd	xmm7, xmm1
	.p2align	4, 0x90
.LBB4_67:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm0, xmm1
	divsd	xmm0, xmm6
	addsd	xmm5, xmm0
	addsd	xmm6, xmm1
	addsd	xmm7, xmm6
	movapd	xmm0, xmm1
	addsd	xmm0, xmm1
	cmpeqsd	xmm7, xmm6
	andpd	xmm0, xmm7
	andnpd	xmm7, xmm1
	orpd	xmm7, xmm0
	ucomisd	xmm4, xmm6
	movapd	xmm1, xmm7
	ja	.LBB4_67
	jmp	.LBB4_71
.LBB4_68:
	xorpd	xmm5, xmm5
	movsd	xmm1, qword ptr [rip + .LCPI4_15] # xmm1 = mem[0],zero
	ucomisd	xmm1, xmm4
	jbe	.LBB4_71
.LBB4_69:
	movsd	xmm6, qword ptr [rip + .LCPI4_15] # xmm6 = mem[0],zero
	movsd	xmm1, qword ptr [rip + .LCPI4_17] # xmm1 = mem[0],zero
	xorpd	xmm5, xmm5
	movapd	xmm7, xmm1
	.p2align	4, 0x90
.LBB4_70:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm0, xmm1
	divsd	xmm0, xmm6
	addsd	xmm5, xmm0
	addsd	xmm6, xmm1
	addsd	xmm7, xmm6
	movapd	xmm0, xmm1
	addsd	xmm0, xmm1
	cmpeqsd	xmm7, xmm6
	andpd	xmm0, xmm7
	andnpd	xmm7, xmm1
	orpd	xmm7, xmm0
	ucomisd	xmm6, xmm4
	movapd	xmm1, xmm7
	ja	.LBB4_70
.LBB4_71:
	subsd	xmm3, xmm5
	mulsd	xmm3, qword ptr [rip + .LCPI4_19]
	andps	xmm8, xmmword ptr [rip + .LCPI4_20]
	xorps	xmm0, xmm0
	cvtss2sd	xmm0, xmm8
	mulsd	xmm0, xmm3
	addsd	xmm2, xmm0
	cvtsd2ss	xmm2, xmm2
	movss	dword ptr [rip + eNaKoju], xmm2
	xorps	xmm1, xmm1
	cvtss2sd	xmm1, xmm2
	xorpd	xmm3, xmm3
	ucomiss	xmm3, xmm2
	jbe	.LBB4_76
# %bb.72:
	ucomiss	xmm2, xmm3
	jbe	.LBB4_79
# %bb.73:
	xorpd	xmm0, xmm0
	ucomiss	xmm2, xmm0
	je	.LBB4_82
# %bb.74:
	xorpd	xmm3, xmm3
	movsd	xmm5, qword ptr [rip + .LCPI4_17] # xmm5 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_15] # xmm2 = mem[0],zero
	movapd	xmm4, xmm5
	.p2align	4, 0x90
.LBB4_75:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm3, xmm5
	addsd	xmm4, xmm3
	movapd	xmm0, xmm5
	addsd	xmm0, xmm5
	cmpeqsd	xmm4, xmm3
	andpd	xmm0, xmm4
	andnpd	xmm4, xmm5
	mulsd	xmm5, xmm2
	addsd	xmm2, xmm5
	orpd	xmm4, xmm0
	ucomisd	xmm3, xmm1
	movapd	xmm5, xmm4
	jne	.LBB4_75
	jmp	.LBB4_83
.LBB4_76:
	ucomiss	xmm2, xmm3
	jbe	.LBB4_82
# %bb.77:
	xorpd	xmm3, xmm3
	movsd	xmm5, qword ptr [rip + .LCPI4_16] # xmm5 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_15] # xmm2 = mem[0],zero
	movapd	xmm4, xmm5
	.p2align	4, 0x90
.LBB4_78:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm3, xmm5
	addsd	xmm4, xmm3
	movapd	xmm0, xmm5
	addsd	xmm0, xmm5
	cmpeqsd	xmm4, xmm3
	andpd	xmm0, xmm4
	andnpd	xmm4, xmm5
	mulsd	xmm5, xmm2
	addsd	xmm2, xmm5
	orpd	xmm4, xmm0
	ucomisd	xmm1, xmm3
	movapd	xmm5, xmm4
	ja	.LBB4_78
	jmp	.LBB4_83
.LBB4_82:
	movsd	xmm2, qword ptr [rip + .LCPI4_15] # xmm2 = mem[0],zero
	jmp	.LBB4_83
.LBB4_79:
	xorpd	xmm3, xmm3
	movsd	xmm5, qword ptr [rip + .LCPI4_17] # xmm5 = mem[0],zero
	movsd	xmm2, qword ptr [rip + .LCPI4_15] # xmm2 = mem[0],zero
	movapd	xmm4, xmm5
	.p2align	4, 0x90
.LBB4_80:                               # =>This Inner Loop Header: Depth=1
	addsd	xmm3, xmm5
	addsd	xmm4, xmm3
	movapd	xmm0, xmm5
	addsd	xmm0, xmm5
	cmpeqsd	xmm4, xmm3
	andpd	xmm0, xmm4
	andnpd	xmm4, xmm5
	mulsd	xmm5, xmm2
	addsd	xmm2, xmm5
	orpd	xmm4, xmm0
	ucomisd	xmm3, xmm1
	movapd	xmm5, xmm4
	ja	.LBB4_80
.LBB4_83:
	lea	eax, [r14 + r14]
	xorps	xmm1, xmm1
	cvtsd2ss	xmm1, xmm2
	movd	dword ptr [rip + ocekivaniBrojUsporedbi], xmm1
	xorps	xmm2, xmm2
	cvtsi2sd	xmm2, eax
	test	r14d, r14d
	jle	.LBB4_87
# %bb.84:
	xorpd	xmm3, xmm3
	cmp	r14d, 2
	jl	.LBB4_89
# %bb.85:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_16] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_86:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm0, xmm6
	divsd	xmm0, xmm4
	addsd	xmm3, xmm0
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm0, xmm6
	addsd	xmm0, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm0, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm0
	ucomisd	xmm9, xmm4
	movapd	xmm6, xmm5
	ja	.LBB4_86
	jmp	.LBB4_89
.LBB4_87:
	movsd	xmm4, qword ptr [rip + .LCPI4_15] # xmm4 = mem[0],zero
	movsd	xmm6, qword ptr [rip + .LCPI4_17] # xmm6 = mem[0],zero
	xorpd	xmm3, xmm3
	movapd	xmm5, xmm6
	.p2align	4, 0x90
.LBB4_88:                               # =>This Inner Loop Header: Depth=1
	movapd	xmm0, xmm6
	divsd	xmm0, xmm4
	addsd	xmm3, xmm0
	addsd	xmm4, xmm6
	addsd	xmm5, xmm4
	movapd	xmm0, xmm6
	addsd	xmm0, xmm6
	cmpeqsd	xmm5, xmm4
	andpd	xmm0, xmm5
	andnpd	xmm5, xmm6
	orpd	xmm5, xmm0
	ucomisd	xmm4, xmm9
	movapd	xmm6, xmm5
	ja	.LBB4_88
.LBB4_89:
	mulsd	xmm3, xmm2
	divsd	xmm3, qword ptr [rip + .LCPI4_21]
	xorps	xmm0, xmm0
	cvtsd2ss	xmm0, xmm3
	movd	dword ptr [rip + ocekivanoOdMergeSorta], xmm0
	movd	xmm2, dword ptr [rsp + 36] # 4-byte Folded Reload
                                        # xmm2 = mem[0],zero,zero,zero
	ucomiss	xmm2, dword ptr [rip + .LCPI4_0]
	jne	.LBB4_94
	jp	.LBB4_94
.LBB4_90:
	xor	eax, eax
	call	clock
	cmp	dword ptr [rsp + 12], 0
	jle	.LBB4_93
.LBB4_91:
	xor	ebx, ebx
	.p2align	4, 0x90
.LBB4_92:                               # =>This Inner Loop Header: Depth=1
	mov	esi, dword ptr [4*rbx + original]
	mov	edi, offset .L.str.1
	xor	eax, eax
	call	printf
	add	rbx, 1
	movsxd	rax, dword ptr [rsp + 12]
	cmp	rbx, rax
	jl	.LBB4_92
.LBB4_93:
	xor	eax, eax
	add	rsp, 40
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	r12
	.cfi_def_cfa_offset 40
	pop	r13
	.cfi_def_cfa_offset 32
	pop	r14
	.cfi_def_cfa_offset 24
	pop	r15
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
.LBB4_94:
	.cfi_def_cfa_offset 96
	ucomiss	xmm2, dword ptr [rip + .LCPI4_2]
	jne	.LBB4_104
	jp	.LBB4_104
# %bb.95:
	test	r14d, r14d
	jle	.LBB4_90
# %bb.96:
	mov	edx, r14d
	mov	eax, dword ptr [rip + brojac]
	cmp	r14d, 7
	ja	.LBB4_134
# %bb.97:
	xor	ecx, ecx
.LBB4_98:
	xor	esi, esi
.LBB4_99:
	mov	rbp, rcx
	not	rbp
	test	dl, 1
	je	.LBB4_101
# %bb.100:
	mov	edi, esi
	not	edi
	add	edi, r14d
	movsxd	rdi, edi
	mov	edi, dword ptr [4*rdi + original]
	mov	dword ptr [4*rcx + pomocni], edi
	or	rcx, 1
	add	esi, 1
.LBB4_101:
	mov	rdi, rdx
	neg	rdi
	cmp	rbp, rdi
	je	.LBB4_163
# %bb.102:
	mov	ebp, r14d
	sub	ebp, esi
	add	ebp, -2
	.p2align	4, 0x90
.LBB4_103:                              # =>This Inner Loop Header: Depth=1
	lea	esi, [rbp + 1]
	movsxd	rsi, esi
	mov	esi, dword ptr [4*rsi + original]
	mov	dword ptr [4*rcx + pomocni], esi
	movsxd	rbp, ebp
	mov	esi, dword ptr [4*rbp + original]
	mov	dword ptr [4*rcx + pomocni+4], esi
	add	rcx, 2
	add	ebp, -2
	mov	rsi, rdi
	add	rsi, rcx
	jne	.LBB4_103
	jmp	.LBB4_163
.LBB4_104:
	movsxd	rax, dword ptr [rip + vrh_stoga]
	ucomiss	xmm0, xmm1
	lea	r15, [rax + 1]
	mov	dword ptr [rip + vrh_stoga], r15d
	mov	dword ptr [4*rax + stog_s_donjim_granicama+4], 0
	mov	dword ptr [4*rax + stog_s_gornjim_granicama+4], r14d
	jbe	.LBB4_139
# %bb.105:
	test	r15d, r15d
	je	.LBB4_90
# %bb.106:
	xor	r13d, r13d
	.p2align	4, 0x90
.LBB4_107:                              # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_111 Depth 2
                                        #     Child Loop BB4_117 Depth 2
	lea	r12d, [r13 + 1]
	movsxd	r10, r13d
	mov	r11d, dword ptr [4*r10 + original]
	cmp	r12d, r14d
	jge	.LBB4_127
# %bb.108:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	r8, r12d
	mov	edi, r14d
	sub	edi, r13d
	add	edi, -2
	add	rdi, 1
	mov	rsi, r8
	mov	ebx, r13d
	cmp	rdi, 8
	jb	.LBB4_116
# %bb.109:                              #   in Loop: Header=BB4_107 Depth=1
	mov	rsi, rdi
	and	rsi, -8
	movd	xmm0, r11d
	pshufd	xmm1, xmm0, 0           # xmm1 = xmm0[0,0,0,0]
	movd	xmm0, r13d
	lea	rax, [rsi - 8]
	mov	rcx, rax
	shr	rcx, 3
	add	rcx, 1
	mov	r9d, ecx
	and	r9d, 1
	test	rax, rax
	je	.LBB4_133
# %bb.110:                              #   in Loop: Header=BB4_107 Depth=1
	lea	rbx, [4*r8 + original+48]
	mov	rax, r9
	sub	rax, rcx
	pxor	xmm2, xmm2
	xor	edx, edx
	.p2align	4, 0x90
.LBB4_111:                              #   Parent Loop BB4_107 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movdqu	xmm3, xmmword ptr [rbx + 4*rdx - 48]
	movdqu	xmm4, xmmword ptr [rbx + 4*rdx - 32]
	movdqu	xmm5, xmmword ptr [rbx + 4*rdx - 16]
	movdqu	xmm6, xmmword ptr [rbx + 4*rdx]
	movdqa	xmm7, xmm1
	pcmpgtd	xmm7, xmm3
	psubd	xmm0, xmm7
	movdqa	xmm3, xmm1
	pcmpgtd	xmm3, xmm4
	psubd	xmm2, xmm3
	movdqa	xmm3, xmm1
	pcmpgtd	xmm3, xmm5
	psubd	xmm0, xmm3
	movdqa	xmm3, xmm1
	pcmpgtd	xmm3, xmm6
	psubd	xmm2, xmm3
	add	rdx, 16
	add	rax, 2
	jne	.LBB4_111
# %bb.112:                              #   in Loop: Header=BB4_107 Depth=1
	test	r9, r9
	je	.LBB4_114
.LBB4_113:                              #   in Loop: Header=BB4_107 Depth=1
	add	rdx, r8
	movdqu	xmm3, xmmword ptr [4*rdx + original+16]
	movdqa	xmm4, xmm1
	pcmpgtd	xmm4, xmm3
	psubd	xmm2, xmm4
	movdqu	xmm3, xmmword ptr [4*rdx + original]
	pcmpgtd	xmm1, xmm3
	psubd	xmm0, xmm1
.LBB4_114:                              #   in Loop: Header=BB4_107 Depth=1
	paddd	xmm0, xmm2
	pshufd	xmm1, xmm0, 78          # xmm1 = xmm0[2,3,0,1]
	paddd	xmm1, xmm0
	pshufd	xmm0, xmm1, 229         # xmm0 = xmm1[1,1,2,3]
	paddd	xmm0, xmm1
	movd	ebx, xmm0
	cmp	rdi, rsi
	je	.LBB4_118
# %bb.115:                              #   in Loop: Header=BB4_107 Depth=1
	add	rsi, r8
.LBB4_116:                              #   in Loop: Header=BB4_107 Depth=1
	mov	eax, r14d
	.p2align	4, 0x90
.LBB4_117:                              #   Parent Loop BB4_107 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	xor	ecx, ecx
	cmp	dword ptr [4*rsi + original], r11d
	setl	cl
	add	ebx, ecx
	add	rsi, 1
	cmp	eax, esi
	jne	.LBB4_117
.LBB4_118:                              #   in Loop: Header=BB4_107 Depth=1
	lea	ecx, [rbx + 1]
	movsxd	rax, ebx
	lea	rdi, [4*r10 + original]
	mov	dword ptr [4*rax + pomocni], r11d
	cmp	r12d, r14d
	jge	.LBB4_124
# %bb.119:                              #   in Loop: Header=BB4_107 Depth=1
	lea	esi, [r14 - 1]
	mov	r9d, dword ptr [rip + brojac]
	add	r9d, esi
	lea	r8, [4*r8 + original]
	sub	esi, r13d
	xor	edx, edx
	mov	dword ptr [rsp + 16], ecx # 4-byte Spill
	mov	ebp, ecx
	mov	ecx, r13d
	mov	eax, dword ptr [r8 + 4*rdx]
	cmp	eax, r11d
	jl	.LBB4_122
	.p2align	4, 0x90
.LBB4_120:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	rbp, ebp
	mov	dword ptr [4*rbp + pomocni], eax
	add	ebp, 1
	add	rdx, 1
	cmp	esi, edx
	je	.LBB4_123
.LBB4_121:                              #   in Loop: Header=BB4_107 Depth=1
	mov	eax, dword ptr [r8 + 4*rdx]
	cmp	eax, r11d
	jge	.LBB4_120
.LBB4_122:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	rcx, ecx
	mov	dword ptr [4*rcx + pomocni], eax
	add	ecx, 1
	add	rdx, 1
	cmp	esi, edx
	jne	.LBB4_121
.LBB4_123:                              #   in Loop: Header=BB4_107 Depth=1
	sub	r9d, r13d
	mov	dword ptr [rip + brojac], r9d
	mov	ecx, dword ptr [rsp + 16] # 4-byte Reload
.LBB4_124:                              #   in Loop: Header=BB4_107 Depth=1
	cmp	r13d, r14d
	jge	.LBB4_128
.LBB4_125:                              #   in Loop: Header=BB4_107 Depth=1
	lea	rsi, [4*r10 + pomocni]
	lea	ebp, [r14 - 1]
	mov	eax, ebp
	sub	eax, r13d
	lea	rdx, [4*rax + 4]
	mov	qword ptr [rsp + 16], r13 # 8-byte Spill
	mov	r13, r15
	mov	r15d, r12d
	mov	r12, r14
	mov	r14d, ecx
	call	memcpy
	mov	ecx, r14d
	mov	r14, r12
	mov	r12d, r15d
	mov	r15, r13
	mov	r13, qword ptr [rsp + 16] # 8-byte Reload
	cmp	ebx, ebp
	jl	.LBB4_129
.LBB4_126:                              #   in Loop: Header=BB4_107 Depth=1
	add	r15d, -1
	cmp	ebx, r12d
	jg	.LBB4_130
	jmp	.LBB4_131
	.p2align	4, 0x90
.LBB4_127:                              #   in Loop: Header=BB4_107 Depth=1
	lea	rdi, [4*r10 + original]
	mov	dword ptr [4*r10 + pomocni], r11d
	mov	ebx, r13d
	mov	ecx, r12d
	cmp	r13d, r14d
	jl	.LBB4_125
.LBB4_128:                              #   in Loop: Header=BB4_107 Depth=1
	lea	ebp, [r14 - 1]
	cmp	ebx, ebp
	jge	.LBB4_126
.LBB4_129:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	rax, r15d
	mov	dword ptr [4*rax + stog_s_donjim_granicama], ecx
	cmp	ebx, r12d
	jle	.LBB4_131
.LBB4_130:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	rax, r15d
	add	r15d, 1
	mov	dword ptr [4*rax + stog_s_donjim_granicama+4], r13d
	mov	dword ptr [4*rax + stog_s_gornjim_granicama+4], ebx
.LBB4_131:                              #   in Loop: Header=BB4_107 Depth=1
	test	r15d, r15d
	je	.LBB4_157
# %bb.132:                              #   in Loop: Header=BB4_107 Depth=1
	movsxd	rax, r15d
	mov	r14d, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	r13d, dword ptr [4*rax + stog_s_donjim_granicama]
	jmp	.LBB4_107
.LBB4_133:                              #   in Loop: Header=BB4_107 Depth=1
	pxor	xmm2, xmm2
	xor	edx, edx
	test	r9, r9
	jne	.LBB4_113
	jmp	.LBB4_114
.LBB4_134:
	lea	rsi, [rdx - 1]
	lea	ebp, [r14 - 1]
	mov	edi, ebp
	sub	edi, esi
	xor	ecx, ecx
	cmp	edi, ebp
	jg	.LBB4_98
# %bb.135:
	shr	rsi, 32
	mov	esi, 0
	jne	.LBB4_99
# %bb.136:
	mov	ecx, edx
	and	ecx, -8
	lea	rdi, [rcx - 8]
	mov	rsi, rdi
	shr	rsi, 3
	add	rsi, 1
	mov	r8d, esi
	and	r8d, 1
	test	rdi, rdi
	je	.LBB4_159
# %bb.137:
	lea	ebp, [r14 - 9]
	mov	rdi, r8
	sub	rdi, rsi
	xor	esi, esi
	.p2align	4, 0x90
.LBB4_138:                              # =>This Inner Loop Header: Depth=1
	lea	ebx, [rbp + 8]
	movsxd	rbx, ebx
	movdqu	xmm0, xmmword ptr [4*rbx + original-12]
	pshufd	xmm0, xmm0, 27          # xmm0 = xmm0[3,2,1,0]
	movdqu	xmm1, xmmword ptr [4*rbx + original-28]
	pshufd	xmm1, xmm1, 27          # xmm1 = xmm1[3,2,1,0]
	movdqa	xmmword ptr [4*rsi + pomocni], xmm0
	movdqa	xmmword ptr [4*rsi + pomocni+16], xmm1
	movsxd	rbp, ebp
	movdqu	xmm0, xmmword ptr [4*rbp + original-12]
	pshufd	xmm0, xmm0, 27          # xmm0 = xmm0[3,2,1,0]
	movdqu	xmm1, xmmword ptr [4*rbp + original-28]
	pshufd	xmm1, xmm1, 27          # xmm1 = xmm1[3,2,1,0]
	movdqa	xmmword ptr [4*rsi + pomocni+32], xmm0
	movdqa	xmmword ptr [4*rsi + pomocni+48], xmm1
	add	rsi, 16
	add	ebp, -16
	add	rdi, 2
	jne	.LBB4_138
	jmp	.LBB4_160
.LBB4_139:
	mov	dword ptr [4*rax + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove+4], 0
	test	r15d, r15d
	je	.LBB4_90
# %bb.140:
	xor	ecx, ecx
	xor	r13d, r13d
	.p2align	4, 0x90
.LBB4_141:                              # =>This Inner Loop Header: Depth=1
	lea	r12d, [r15 - 1]
	lea	edx, [r14 + r13]
	mov	eax, edx
	shr	eax, 31
	add	eax, edx
	sar	eax
	test	ecx, ecx
	je	.LBB4_152
# %bb.142:                              #   in Loop: Header=BB4_141 Depth=1
	mov	dword ptr [rip + gdje_smo_u_prvom_nizu], r13d
	mov	dword ptr [rip + gdje_smo_u_drugom_nizu], eax
	cmp	r14d, r13d
	jle	.LBB4_154
# %bb.143:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rdx, r13d
	mov	r8d, dword ptr [rip + brojac]
	add	r8d, r14d
	movsxd	rsi, r14d
	mov	edi, eax
	mov	ecx, r13d
	cmp	ecx, eax
	je	.LBB4_147
	jmp	.LBB4_146
	.p2align	4, 0x90
.LBB4_144:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rbp, edi
	mov	ebp, dword ptr [4*rbp + original]
	mov	dword ptr [4*rdx + pomocni], ebp
	add	edi, 1
	mov	dword ptr [rip + gdje_smo_u_drugom_nizu], edi
	add	rdx, 1
	cmp	rsi, rdx
	je	.LBB4_150
.LBB4_145:                              #   in Loop: Header=BB4_141 Depth=1
	cmp	ecx, eax
	je	.LBB4_147
.LBB4_146:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rbx, edi
	movsxd	rbp, ecx
	mov	ebp, dword ptr [4*rbp + original]
	cmp	dword ptr [4*rbx + original], ebp
	jge	.LBB4_149
.LBB4_147:                              #   in Loop: Header=BB4_141 Depth=1
	cmp	edi, r14d
	jl	.LBB4_144
# %bb.148:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rbp, ecx
	mov	ebp, dword ptr [4*rbp + original]
.LBB4_149:                              #   in Loop: Header=BB4_141 Depth=1
	mov	dword ptr [4*rdx + pomocni], ebp
	add	ecx, 1
	mov	dword ptr [rip + gdje_smo_u_prvom_nizu], ecx
	add	rdx, 1
	cmp	rsi, rdx
	jne	.LBB4_145
.LBB4_150:                              #   in Loop: Header=BB4_141 Depth=1
	sub	r8d, r13d
	mov	dword ptr [rip + brojac], r8d
	cmp	r14d, r13d
	jle	.LBB4_154
# %bb.151:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rax, r13d
	mov	ebp, dword ptr [rip + brojac]
	add	ebp, r14d
	lea	rdi, [4*rax + original]
	lea	rsi, [4*rax + pomocni]
	mov	eax, r13d
	not	eax
	add	eax, r14d
	lea	rdx, [4*rax + 4]
	call	memcpy
	sub	ebp, r13d
	mov	dword ptr [rip + brojac], ebp
	test	r12d, r12d
	jne	.LBB4_155
	jmp	.LBB4_158
	.p2align	4, 0x90
.LBB4_152:                              #   in Loop: Header=BB4_141 Depth=1
	mov	ecx, r14d
	sub	ecx, r13d
	cmp	ecx, 2
	jl	.LBB4_154
# %bb.153:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rcx, r15d
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 1
	mov	dword ptr [4*rcx + stog_s_donjim_granicama+4], r13d
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama+4], eax
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove+4], 0
	add	r15d, 2
	mov	dword ptr [4*rcx + stog_s_donjim_granicama+8], eax
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama+8], r14d
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove+8], 0
	mov	r12d, r15d
	.p2align	4, 0x90
.LBB4_154:                              #   in Loop: Header=BB4_141 Depth=1
	test	r12d, r12d
	je	.LBB4_158
.LBB4_155:                              #   in Loop: Header=BB4_141 Depth=1
	movsxd	rax, r12d
	mov	r14d, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	r13d, dword ptr [4*rax + stog_s_donjim_granicama]
	mov	ecx, dword ptr [4*rax + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove]
	mov	r15d, r12d
	jmp	.LBB4_141
.LBB4_156:
	xorpd	xmm5, xmm5
	jmp	.LBB4_71
.LBB4_157:
	mov	dword ptr [rip + gdje_je_pivot], ebx
.LBB4_158:
	mov	dword ptr [rip + gornja_granica], r14d
	mov	dword ptr [rip + donja_granica], r13d
	mov	dword ptr [rip + vrh_stoga], 0
	xor	eax, eax
	call	clock
	cmp	dword ptr [rsp + 12], 0
	jg	.LBB4_91
	jmp	.LBB4_93
.LBB4_159:
	xor	esi, esi
.LBB4_160:
	test	r8, r8
	je	.LBB4_162
# %bb.161:
	mov	edi, esi
	not	edi
	add	edi, r14d
	movsxd	rdi, edi
	movdqu	xmm0, xmmword ptr [4*rdi + original-12]
	pshufd	xmm0, xmm0, 27          # xmm0 = xmm0[3,2,1,0]
	movdqu	xmm1, xmmword ptr [4*rdi + original-28]
	pshufd	xmm1, xmm1, 27          # xmm1 = xmm1[3,2,1,0]
	movdqa	xmmword ptr [4*rsi + pomocni], xmm0
	movdqa	xmmword ptr [4*rsi + pomocni+16], xmm1
.LBB4_162:
	mov	esi, ecx
	cmp	rcx, rdx
	jne	.LBB4_99
.LBB4_163:
	add	eax, r14d
	mov	dword ptr [rip + brojac], eax
	test	r14d, r14d
	jle	.LBB4_90
# %bb.164:
	shl	rdx, 2
	mov	edi, offset original
	mov	esi, offset pomocni
	call	memcpy
	xor	eax, eax
	call	clock
	cmp	dword ptr [rsp + 12], 0
	jg	.LBB4_91
	jmp	.LBB4_93
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
	.type	ocekivanoOdMergeSorta,@object # @ocekivanoOdMergeSorta
	.comm	ocekivanoOdMergeSorta,4,4
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
	.type	i,@object               # @i
	.comm	i,4,4
	.type	treba_li_spajati_ili_razdvajati,@object # @treba_li_spajati_ili_razdvajati
	.comm	treba_li_spajati_ili_razdvajati,4,4

	.ident	"clang version 9.0.0 (tags/RELEASE_900/final)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym original
