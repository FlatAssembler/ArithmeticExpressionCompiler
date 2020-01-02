	.text
	.intel_syntax noprefix
	.file	"msort.c"
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
	.globl	main                    # -- Begin function main
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
	sub	rsp, 64
	mov	dword ptr [rbp - 4], 0
	movabs	rdi, offset .L.str
	lea	rsi, [rbp - 8]
	mov	al, 0
	call	scanf
	mov	dword ptr [rbp - 12], 0
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 12]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB1_4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	movsxd	rax, dword ptr [rbp - 12]
	shl	rax, 2
	movabs	rcx, offset original
	add	rcx, rax
	movabs	rdi, offset .L.str
	mov	rsi, rcx
	mov	al, 0
	call	scanf
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	mov	eax, dword ptr [rbp - 12]
	add	eax, 1
	mov	dword ptr [rbp - 12], eax
	jmp	.LBB1_1
.LBB1_4:
	mov	al, 0
	call	clock
	mov	qword ptr [rbp - 24], rax
	mov	ecx, dword ptr [vrh_stoga]
	add	ecx, 1
	mov	dword ptr [vrh_stoga], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	dword ptr [4*rax + stog_s_donjim_granicama], 0
	mov	ecx, dword ptr [rbp - 8]
	movsxd	rax, dword ptr [vrh_stoga]
	mov	dword ptr [4*rax + stog_s_gornjim_granicama], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	dword ptr [4*rax + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
.LBB1_5:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_11 Depth 2
                                        #     Child Loop BB1_19 Depth 2
	cmp	dword ptr [vrh_stoga], 0
	je	.LBB1_23
# %bb.6:                                #   in Loop: Header=BB1_5 Depth=1
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_gornjim_granicama]
	mov	dword ptr [rbp - 28], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_donjim_granicama]
	mov	dword ptr [rbp - 32], ecx
	movsxd	rax, dword ptr [vrh_stoga]
	mov	ecx, dword ptr [4*rax + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove]
	mov	dword ptr [rbp - 36], ecx
	mov	ecx, dword ptr [vrh_stoga]
	add	ecx, -1
	mov	dword ptr [vrh_stoga], ecx
	mov	ecx, dword ptr [rbp - 32]
	add	ecx, dword ptr [rbp - 28]
	mov	eax, ecx
	cdq
	mov	ecx, 2
	idiv	ecx
	mov	dword ptr [rbp - 40], eax
	cmp	dword ptr [rbp - 36], 0
	jne	.LBB1_10
# %bb.7:                                #   in Loop: Header=BB1_5 Depth=1
	mov	eax, dword ptr [rbp - 28]
	sub	eax, dword ptr [rbp - 32]
	cmp	eax, 1
	jle	.LBB1_9
# %bb.8:                                #   in Loop: Header=BB1_5 Depth=1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 32]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 28]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 1
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 32]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 40]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
	mov	eax, dword ptr [vrh_stoga]
	add	eax, 1
	mov	dword ptr [vrh_stoga], eax
	mov	eax, dword ptr [rbp - 40]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_donjim_granicama], eax
	mov	eax, dword ptr [rbp - 28]
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_gornjim_granicama], eax
	movsxd	rcx, dword ptr [vrh_stoga]
	mov	dword ptr [4*rcx + stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove], 0
.LBB1_9:                                #   in Loop: Header=BB1_5 Depth=1
	jmp	.LBB1_22
.LBB1_10:                               #   in Loop: Header=BB1_5 Depth=1
	mov	eax, dword ptr [rbp - 32]
	mov	dword ptr [rbp - 44], eax
	mov	eax, dword ptr [rbp - 32]
	mov	dword ptr [rbp - 48], eax
	mov	eax, dword ptr [rbp - 40]
	mov	dword ptr [rbp - 52], eax
.LBB1_11:                               #   Parent Loop BB1_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 44]
	cmp	eax, dword ptr [rbp - 28]
	jge	.LBB1_18
# %bb.12:                               #   in Loop: Header=BB1_11 Depth=2
	mov	eax, dword ptr [rbp - 48]
	cmp	eax, dword ptr [rbp - 40]
	je	.LBB1_14
# %bb.13:                               #   in Loop: Header=BB1_11 Depth=2
	movsxd	rax, dword ptr [rbp - 52]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 48]
	cmp	ecx, dword ptr [4*rax + original]
	jge	.LBB1_16
.LBB1_14:                               #   in Loop: Header=BB1_11 Depth=2
	mov	eax, dword ptr [rbp - 52]
	cmp	eax, dword ptr [rbp - 28]
	jge	.LBB1_16
# %bb.15:                               #   in Loop: Header=BB1_11 Depth=2
	movsxd	rax, dword ptr [rbp - 52]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 44]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [rbp - 52]
	add	ecx, 1
	mov	dword ptr [rbp - 52], ecx
	jmp	.LBB1_17
.LBB1_16:                               #   in Loop: Header=BB1_11 Depth=2
	movsxd	rax, dword ptr [rbp - 48]
	mov	ecx, dword ptr [4*rax + original]
	movsxd	rax, dword ptr [rbp - 44]
	mov	dword ptr [4*rax + pomocni], ecx
	mov	ecx, dword ptr [rbp - 48]
	add	ecx, 1
	mov	dword ptr [rbp - 48], ecx
.LBB1_17:                               #   in Loop: Header=BB1_11 Depth=2
	mov	eax, dword ptr [rbp - 44]
	add	eax, 1
	mov	dword ptr [rbp - 44], eax
	mov	eax, dword ptr [brojac]
	add	eax, 1
	mov	dword ptr [brojac], eax
	jmp	.LBB1_11
.LBB1_18:                               #   in Loop: Header=BB1_5 Depth=1
	mov	eax, dword ptr [rbp - 32]
	mov	dword ptr [rbp - 44], eax
.LBB1_19:                               #   Parent Loop BB1_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 44]
	cmp	eax, dword ptr [rbp - 28]
	jge	.LBB1_21
# %bb.20:                               #   in Loop: Header=BB1_19 Depth=2
	movsxd	rax, dword ptr [rbp - 44]
	mov	ecx, dword ptr [4*rax + pomocni]
	movsxd	rax, dword ptr [rbp - 44]
	mov	dword ptr [4*rax + original], ecx
	mov	ecx, dword ptr [brojac]
	add	ecx, 1
	mov	dword ptr [brojac], ecx
	mov	ecx, dword ptr [rbp - 44]
	add	ecx, 1
	mov	dword ptr [rbp - 44], ecx
	jmp	.LBB1_19
.LBB1_21:                               #   in Loop: Header=BB1_5 Depth=1
	jmp	.LBB1_22
.LBB1_22:                               #   in Loop: Header=BB1_5 Depth=1
	jmp	.LBB1_5
.LBB1_23:
	mov	al, 0
	call	clock
	sub	rax, qword ptr [rbp - 24]
	mov	qword ptr [rbp - 24], rax
	mov	dword ptr [rbp - 56], 0
.LBB1_24:                               # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 56]
	cmp	eax, dword ptr [rbp - 8]
	jge	.LBB1_27
# %bb.25:                               #   in Loop: Header=BB1_24 Depth=1
	movsxd	rax, dword ptr [rbp - 56]
	mov	esi, dword ptr [4*rax + original]
	movabs	rdi, offset .L.str.1
	mov	al, 0
	call	printf
# %bb.26:                               #   in Loop: Header=BB1_24 Depth=1
	mov	eax, dword ptr [rbp - 56]
	add	eax, 1
	mov	dword ptr [rbp - 56], eax
	jmp	.LBB1_24
.LBB1_27:
	mov	eax, dword ptr [rbp - 4]
	add	rsp, 64
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
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
	.type	stog_s_donjim_granicama,@object # @stog_s_donjim_granicama
	.comm	stog_s_donjim_granicama,131072,16
	.type	stog_s_gornjim_granicama,@object # @stog_s_gornjim_granicama
	.comm	stog_s_gornjim_granicama,131072,16
	.type	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove,@object # @stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
	.comm	stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove,131072,16
	.type	pomocni,@object         # @pomocni
	.comm	pomocni,131072,16
	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%d\n"
	.size	.L.str.1, 4


	.ident	"clang version 9.0.0 (tags/RELEASE_900/final)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym scanf
	.addrsig_sym clock
	.addrsig_sym printf
	.addrsig_sym vrh_stoga
	.addrsig_sym brojac
	.addrsig_sym original
	.addrsig_sym stog_s_donjim_granicama
	.addrsig_sym stog_s_gornjim_granicama
	.addrsig_sym stog_s_podacima_treba_li_petlja_razdvajati_ili_spajati_nizove
	.addrsig_sym pomocni
