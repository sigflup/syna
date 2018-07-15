	.file	"syna.c"
	.globl	drum_sequence
	.data
	.align 32
	.type	drum_sequence, @object
	.size	drum_sequence, 132
drum_sequence:
	.long	16
	.long	784
	.long	784
	.long	16
	.long	0
	.long	0
	.long	0
	.long	0
	.long	16
	.long	784
	.long	784
	.long	16
	.long	0
	.long	0
	.long	0
	.long	0
	.long	16
	.long	784
	.long	784
	.long	16
	.long	0
	.long	0
	.long	0
	.long	0
	.long	16
	.long	784
	.long	784
	.long	16
	.long	0
	.long	0
	.long	0
	.long	0
	.long	-1
	.globl	snare_sequence
	.align 32
	.type	snare_sequence, @object
	.size	snare_sequence, 128
snare_sequence:
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1284
	.long	1332
	.long	1333
	.long	1285
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1284
	.long	1332
	.long	1333
	.long	1285
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1284
	.long	1332
	.long	1333
	.long	1285
	.long	0
	.long	0
	.long	0
	.long	0
	.globl	hi_sequence
	.align 32
	.type	hi_sequence, @object
	.size	hi_sequence, 128
hi_sequence:
	.long	1039
	.long	1039
	.long	1039
	.long	1039
	.long	0
	.long	0
	.long	0
	.long	0
	.long	1039
	.long	1039
	.long	1039
	.long	1039
	.long	4369
	.long	30583
	.long	4369
	.long	6001
	.long	1039
	.long	1039
	.long	1039
	.long	1039
	.long	21845
	.long	65535
	.long	21845
	.long	21845
	.long	1039
	.long	1039
	.long	1039
	.long	1039
	.long	0
	.long	0
	.long	0
	.long	0
	.globl	and_sequence
	.align 32
	.type	and_sequence, @object
	.size	and_sequence, 56
and_sequence:
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.value	4095
	.value	3276
	.value	3276
	.value	3276
	.value	3276
	.value	8191
	.value	8191
	.value	8191
	.value	8191
	.value	-1
	.value	-1
	.value	-1
	.value	-1
	.globl	beeps_sequence
	.align 32
	.type	beeps_sequence, @object
	.size	beeps_sequence, 32
beeps_sequence:
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.text
	.globl	seed
	.type	seed, @function
seed:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	8(%ebp), %eax
	movw	%ax, -2(%ebp)
	movzwl	-2(%ebp), %eax
	sall	$3, %eax
	addl	$3, %eax
	movw	%ax, rnd_x
	movzwl	-2(%ebp), %eax
	sall	%eax
	incl	%eax
	movw	%ax, rnd_y
	movw	-2(%ebp), %ax
	orl	$1, %eax
	movw	%ax, rnd_z
	leave
	ret
	.size	seed, .-seed
	.globl	rnd
	.type	rnd, @function
rnd:
	pushl	%ebp
	movl	%esp, %ebp
	movw	rnd_x, %ax
	imulw	rnd_y, %ax
	movw	%ax, rnd_v
	movw	rnd_y, %ax
	movw	%ax, rnd_x
	movw	rnd_v, %ax
	movw	%ax, rnd_y
	movzwl	rnd_x, %eax
	movl	%eax, %ecx
	andl	$32767, %ecx
	movl	%ecx, %eax
	sall	$8, %eax
	addl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	movl	%eax, %edx
	sall	$4, %edx
	subl	%eax, %edx
	sall	%edx
	addl	%ecx, %edx
	movw	rnd_z, %ax
	shrw	$8, %ax
	leal	(%eax,%edx), %eax
	movw	%ax, rnd_z
	movw	rnd_z, %ax
	addw	rnd_y, %ax
	movzwl	%ax, %eax
	leave
	ret
	.size	rnd, .-rnd
	.section	.rodata
	.align 4
.LC0:
	.long	1132462080
	.align 4
.LC1:
	.long	1056964608
	.align 4
.LC3:
	.long	1061158912
	.align 8
.LC4:
	.long	1413754136
	.long	1075388923
	.align 4
.LC5:
	.long	1199570944
	.align 4
.LC6:
	.long	1045220557
	.align 4
.LC7:
	.long	2143289344
	.text
	.globl	osc
	.type	osc, @function
osc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
	cmpl	$1, -24(%ebp)
	je	.L26
	cmpl	$1, -24(%ebp)
	jg	.L30
	cmpl	$0, -24(%ebp)
	je	.L25
	jmp	.L21
.L30:
	cmpl	$2, -24(%ebp)
	je	.L22
	cmpl	$3, -24(%ebp)
	je	.L27
	jmp	.L21
.L22:
	fildl	syna_clock
	fmuls	12(%ebp)
	fnstcw	-10(%ebp)
	movw	-10(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -12(%ebp)
	fldcw	-12(%ebp)
	fistpl	-16(%ebp)
	fldcw	-10(%ebp)
	movl	-16(%ebp), %edx
	movl	$255, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	pushl	%edx
	fildl	(%esp)
	leal	4(%esp), %esp
	flds	.LC0
	fdivrp	%st, %st(1)
	fstps	-4(%ebp)
	flds	-4(%ebp)
	flds	.LC1
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L24
	jmp	.L23
.L24:
	fld1
	fsubs	-4(%ebp)
	fstps	-4(%ebp)
.L23:
	flds	-4(%ebp)
	flds	.LC3
	fsubrp	%st, %st(1)
	fadd	%st(0), %st
	fstps	-20(%ebp)
	jmp	.L20
.L25:
	fildl	syna_clock
	fmuls	12(%ebp)
	fnstcw	-10(%ebp)
	movw	-10(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -12(%ebp)
	fldcw	-12(%ebp)
	fistpl	-16(%ebp)
	fldcw	-10(%ebp)
	movl	-16(%ebp), %edx
	movl	$255, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	pushl	%edx
	fildl	(%esp)
	leal	4(%esp), %esp
	flds	.LC0
	fdivrp	%st, %st(1)
	flds	.LC1
	fsubrp	%st, %st(1)
	fstps	-20(%ebp)
	jmp	.L20
.L26:
	subl	$8, %esp
	fildl	syna_clock
	flds	.LC0
	fdivrp	%st, %st(1)
	fmuls	12(%ebp)
	fldl	.LC4
	fmulp	%st, %st(1)
	leal	-8(%esp), %esp
	fstpl	(%esp)
	call	sin
	addl	$16, %esp
	fstps	-8(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, -20(%ebp)
	jmp	.L20
.L27:
	call	rnd
	movzwl	%ax, %eax
	pushl	%eax
	fildl	(%esp)
	leal	4(%esp), %esp
	flds	.LC5
	fdivrp	%st, %st(1)
	flds	.LC6
	fmulp	%st, %st(1)
	fstps	-20(%ebp)
	jmp	.L20
.L21:
	flds	.LC7
	fstp	%st(0)
.L20:
	flds	-20(%ebp)
	leave
	ret
	.size	osc, .-osc
	.section	.rodata
	.align 4
.LC10:
	.long	2143289344
	.text
	.globl	env
	.type	env, @function
env:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, -4(%ebp)
	cmpl	$1, -4(%ebp)
	je	.L36
	cmpl	$1, -4(%ebp)
	jg	.L44
	cmpl	$0, -4(%ebp)
	je	.L33
	jmp	.L32
.L44:
	cmpl	$2, -4(%ebp)
	je	.L39
	jmp	.L32
.L33:
	movl	8(%ebp), %ecx
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	flds	12(%eax)
	fadds	(%edx)
	fstps	12(%ecx)
	movl	8(%ebp), %eax
	flds	12(%eax)
	fld1
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$5, %ah
	je	.L35
	jmp	.L32
.L35:
	movl	8(%ebp), %eax
	movl	$0x3f800000, %edx
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	$1, 16(%eax)
	jmp	.L32
.L36:
	movl	8(%ebp), %ecx
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	flds	12(%eax)
	fsubs	4(%edx)
	fstps	12(%ecx)
	movl	8(%ebp), %eax
	flds	12(%eax)
	fldz
	fucompp
	fnstsw	%ax
	testb	$5, %ah
	je	.L38
	jmp	.L32
.L38:
	movl	8(%ebp), %edx
	movl	$0x0, %eax
	movl	%eax, 12(%edx)
	jmp	.L32
.L39:
	movl	8(%ebp), %ecx
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	flds	12(%eax)
	fsubs	8(%edx)
	fstps	12(%ecx)
	movl	8(%ebp), %eax
	flds	12(%eax)
	fldz
	fucompp
	fnstsw	%ax
	testb	$5, %ah
	je	.L41
	jmp	.L32
.L41:
	movl	8(%ebp), %eax
	movl	$0x0, %edx
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	$3, 16(%eax)
.L32:
	flds	.LC10
	leave
	ret
	.size	env, .-env
	.globl	D1
	.data
	.align 4
	.type	D1, @object
	.size	D1, 4
D1:
	.long	0
	.globl	D2
	.align 4
	.type	D2, @object
	.size	D2, 4
D2:
	.long	0
	.text
	.globl	filter
	.type	filter, @function
filter:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	flds	12(%ebp)
	fld1
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L47
	jmp	.L46
.L47:
	flds	12(%ebp)
	fld1
	fsubrp	%st, %st(1)
	fstps	-4(%ebp)
	jmp	.L48
.L46:
	movl	12(%ebp), %eax
	movl	%eax, -4(%ebp)
.L48:
	flds	fil_f
	fmuls	-4(%ebp)
	fstps	-8(%ebp)
	flds	-8(%ebp)
	fmuls	D1
	flds	D2
	faddp	%st, %st(1)
	fstps	-12(%ebp)
	flds	8(%ebp)
	fsubs	-12(%ebp)
	flds	fil_q
	fmuls	D1
	fsubrp	%st, %st(1)
	fstps	-16(%ebp)
	flds	-8(%ebp)
	fmuls	-16(%ebp)
	flds	D1
	faddp	%st, %st(1)
	fstps	D1
	movl	-12(%ebp), %eax
	movl	%eax, D2
	flds	12(%ebp)
	fld1
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L50
	jmp	.L49
.L50:
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	jmp	.L45
.L49:
	movl	-12(%ebp), %eax
	movl	%eax, -20(%ebp)
.L45:
	flds	-20(%ebp)
	leave
	ret
	.size	filter, .-filter
	.section	.rodata
	.align 4
.LC13:
	.long	1008981770
	.align 4
.LC15:
	.long	1048576000
	.align 4
.LC16:
	.long	1056964608
	.align 4
.LC17:
	.long	1092616192
	.align 4
.LC18:
	.long	1069547520
	.align 4
.LC19:
	.long	-1077936128
	.align 4
.LC21:
	.long	1032805417
	.text
	.globl	proc_accum
	.type	proc_accum, @function
proc_accum:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$32, %esp
	movl	$0, -12(%ebp)
.L53:
	cmpl	$511, -12(%ebp)
	jle	.L56
	jmp	.L52
.L56:
	movl	-12(%ebp), %ebx
	subl	$8, %esp
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$4095, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	sall	%eax
	addl	-24(%ebp), %eax
	sall	$2, %eax
	pushl	beeps_song+8(%eax)
	pushl	$0
	call	osc
	addl	$16, %esp
	fstps	accum(,%ebx,4)
	movl	-12(%ebp), %ebx
	movl	-12(%ebp), %esi
	subl	$8, %esp
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$4095, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	sall	%eax
	addl	-24(%ebp), %eax
	sall	$2, %eax
	flds	beeps_song+8(%eax)
	flds	.LC13
	faddp	%st, %st(1)
	leal	-4(%esp), %esp
	fstps	(%esp)
	pushl	$0
	call	osc
	addl	$16, %esp
	flds	accum(,%esi,4)
	faddp	%st, %st(1)
	fstps	accum(,%ebx,4)
	movl	-12(%ebp), %ebx
	movl	-12(%ebp), %ecx
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$4095, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	sall	%eax
	addl	-24(%ebp), %eax
	sall	$2, %eax
	fildl	beeps_song(%eax)
	fmuls	beeps+12
	flds	accum(,%ecx,4)
	fmulp	%st, %st(1)
	fstps	accum(,%ebx,4)
	movl	-12(%ebp), %ebx
	movl	-12(%ebp), %ecx
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$4095, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	sall	%eax
	addl	-24(%ebp), %eax
	sall	$2, %eax
	flds	accum(,%ecx,4)
	fmuls	beeps_song+4(%eax)
	fstps	accum(,%ebx,4)
	movl	-12(%ebp), %ebx
	subl	$8, %esp
	movl	$0x3b449ba6, %eax
	pushl	%eax
	pushl	$1
	call	osc
	addl	$8, %esp
	fadd	%st(0), %st
	fabs
	fstps	-20(%ebp)
	movl	-20(%ebp), %eax
	pushl	%eax
	movl	-12(%ebp), %eax
	pushl	accum(,%eax,4)
	call	filter
	addl	$16, %esp
	fstps	accum(,%ebx,4)
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$8191, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%edx, %ebx
	movl	-12(%ebp), %esi
	movl	syna_clock, %eax
	movl	%eax, -24(%ebp)
	movl	$8191, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%edx, %ecx
	movl	syna_clock, %edx
	movl	$65535, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %edx
	movzwl	and_sequence(%edx,%edx), %eax
	andl	%ecx, %eax
	flds	delay(,%eax,4)
	flds	.LC15
	fmulp	%st, %st(1)
	flds	accum(,%esi,4)
	faddp	%st, %st(1)
	fstps	delay(,%ebx,4)
	movl	-12(%ebp), %ebx
	movl	-12(%ebp), %ecx
	movl	syna_clock, %edx
	incl	%edx
	movl	$8191, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	flds	accum(,%ecx,4)
	fadds	delay(,%edx,4)
	fstps	accum(,%ebx,4)
	movl	-12(%ebp), %esi
	movl	-12(%ebp), %ebx
	subl	$8, %esp
	movl	$0x3f000000, %eax
	pushl	%eax
	pushl	$1
	call	osc
	addl	$16, %esp
	fmuls	beeps+12
	movl	syna_clock, %edx
	movl	%edx, -24(%ebp)
	movl	$4095, -28(%ebp)
	movl	-24(%ebp), %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	sall	%eax
	addl	-24(%ebp), %eax
	sall	$2, %eax
	fildl	beeps_song(%eax)
	fmulp	%st, %st(1)
	flds	accum(,%ebx,4)
	faddp	%st, %st(1)
	fstps	accum(,%esi,4)
	movl	syna_clock, %edx
	movl	$4095, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	testl	%edx, %edx
	jne	.L57
	movl	$0, beeps+16
.L57:
	subl	$12, %esp
	pushl	$beeps
	call	env
	fstp	%st(0)
	addl	$16, %esp
	subl	$8, %esp
	movl	$0x3f000000, %eax
	pushl	%eax
	pushl	$2
	call	osc
	addl	$16, %esp
	fmuls	bass_drum+12
	flds	.LC17
	fmulp	%st, %st(1)
	fstps	-16(%ebp)
	flds	-16(%ebp)
	flds	.LC18
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L59
	jmp	.L58
.L59:
	movl	$0x3fc00000, %eax
	movl	%eax, -16(%ebp)
.L58:
	flds	-16(%ebp)
	flds	.LC19
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L61
	jmp	.L60
.L61:
	movl	$0xbfc00000, %eax
	movl	%eax, -16(%ebp)
.L60:
	movl	-12(%ebp), %edx
	movl	-12(%ebp), %eax
	flds	-16(%ebp)
	flds	.LC16
	fmulp	%st, %st(1)
	flds	accum(,%eax,4)
	faddp	%st, %st(1)
	fstps	accum(,%edx,4)
	subl	$8, %esp
	movl	$0x3eae147b, %eax
	pushl	%eax
	pushl	$2
	call	osc
	addl	$8, %esp
	leal	-4(%esp), %esp
	fstps	(%esp)
	pushl	$2
	call	osc
	addl	$16, %esp
	flds	snare_drum+12
	fmulp	%st, %st(1)
	fstps	-16(%ebp)
	movl	-12(%ebp), %edx
	movl	-12(%ebp), %eax
	flds	-16(%ebp)
	flds	.LC21
	fmulp	%st, %st(1)
	flds	accum(,%eax,4)
	faddp	%st, %st(1)
	fstps	accum(,%edx,4)
	movl	-12(%ebp), %esi
	movl	-12(%ebp), %ebx
	subl	$8, %esp
	movl	$0x3f800000, %eax
	pushl	%eax
	pushl	$3
	call	osc
	addl	$16, %esp
	fmuls	hi_drum+12
	flds	accum(,%ebx,4)
	faddp	%st, %st(1)
	fstps	accum(,%esi,4)
	movl	syna_clock, %edx
	movl	$2047, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	testl	%edx, %edx
	jne	.L62
	movl	syna_clock, %edx
	movl	$65535, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ebx
	movl	syna_clock, %edx
	movl	$2047, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ecx
	movl	drum_sequence(,%ebx,4), %eax
	shrl	%cl, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L63
	movl	$0, bass_drum+16
.L63:
	movl	syna_clock, %edx
	movl	$65535, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ebx
	movl	syna_clock, %edx
	movl	$2047, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ecx
	movl	snare_sequence(,%ebx,4), %eax
	shrl	%cl, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L64
	movl	$0, snare_drum+16
.L64:
	movl	syna_clock, %edx
	movl	$65535, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ebx
	movl	syna_clock, %edx
	movl	$2047, -28(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-28(%ebp)
	movl	%eax, %ecx
	movl	hi_sequence(,%ebx,4), %eax
	shrl	%cl, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L62
	movl	$0, hi_drum+16
.L62:
	subl	$12, %esp
	pushl	$bass_drum
	call	env
	fstp	%st(0)
	addl	$16, %esp
	subl	$12, %esp
	pushl	$snare_drum
	call	env
	fstp	%st(0)
	addl	$16, %esp
	subl	$12, %esp
	pushl	$hi_drum
	call	env
	fstp	%st(0)
	addl	$16, %esp
	incl	syna_clock
	leal	-12(%ebp), %eax
	incl	(%eax)
	jmp	.L53
.L52:
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.size	proc_accum, .-proc_accum
	.section	.rodata
	.align 4
.LC24:
	.long	1069547520
	.align 4
.LC25:
	.long	-1077936128
	.align 4
.LC26:
	.long	1184645120
	.text
	.globl	syna_lump
	.type	syna_lump, @function
syna_lump:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	proc_accum
	subl	$512, syna_clock
	movl	$0, -8(%ebp)
	movl	$0, -4(%ebp)
.L67:
	cmpl	$511, -4(%ebp)
	jle	.L70
	jmp	.L68
.L70:
	movl	syna_clock, %edx
	movl	$65535, -24(%ebp)
	movl	%edx, %eax
	cltd
	idivl	-24(%ebp)
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	cmpl	$-1, drum_sequence(,%eax,4)
	jne	.L71
	movl	$1, -20(%ebp)
	jmp	.L66
.L71:
	movl	-4(%ebp), %eax
	flds	accum(,%eax,4)
	flds	.LC24
	fxch	%st(1)
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L73
	jmp	.L72
.L73:
	movl	-4(%ebp), %edx
	movl	$0x3fc00000, %eax
	movl	%eax, accum(,%edx,4)
.L72:
	movl	-4(%ebp), %eax
	flds	accum(,%eax,4)
	flds	.LC25
	fucompp
	fnstsw	%ax
	testb	$69, %ah
	je	.L75
	jmp	.L74
.L75:
	movl	-4(%ebp), %edx
	movl	$0xbfc00000, %eax
	movl	%eax, accum(,%edx,4)
.L74:
	movl	-4(%ebp), %eax
	flds	accum(,%eax,4)
	flds	.LC26
	fmulp	%st, %st(1)
	fnstcw	-14(%ebp)
	movw	-14(%ebp), %ax
	movb	$12, %ah
	movw	%ax, -16(%ebp)
	fldcw	-16(%ebp)
	fistpl	-12(%ebp)
	fldcw	-14(%ebp)
	movl	-8(%ebp), %eax
	movl	%eax, %edx
	addl	8(%ebp), %edx
	movb	$-1, %al
	andl	-12(%ebp), %eax
	movb	%al, (%edx)
	leal	-8(%ebp), %eax
	incl	(%eax)
	movl	-8(%ebp), %eax
	movl	%eax, %edx
	addl	8(%ebp), %edx
	movl	-12(%ebp), %eax
	andl	$65280, %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	leal	-8(%ebp), %eax
	incl	(%eax)
	incl	syna_clock
	leal	-4(%ebp), %eax
	incl	(%eax)
	jmp	.L67
.L68:
	movl	$0, -20(%ebp)
.L66:
	movl	-20(%ebp), %eax
	leave
	ret
	.size	syna_lump, .-syna_lump
	.section	.rodata
	.align 4
.LC37:
	.long	1199570944
	.align 4
.LC38:
	.long	1182793728
	.text
	.globl	syna_init
	.type	syna_init, @function
syna_init:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	$1, syna_clock
	movl	$0x3f800000, %eax
	movl	%eax, fil_f
	movl	$0x3fb33333, %eax
	movl	%eax, fil_q
	movl	$0x3a83126f, %eax
	movl	%eax, bass_drum
	movl	$0x391d4952, %eax
	movl	%eax, bass_drum+4
	movl	$0x3e19999a, %eax
	movl	%eax, bass_drum+8
	movl	$0x0, %eax
	movl	%eax, bass_drum+12
	subl	$4, %esp
	pushl	$20
	pushl	$bass_drum
	pushl	$snare_drum
	call	memcpy
	addl	$16, %esp
	subl	$4, %esp
	pushl	$20
	pushl	$bass_drum
	pushl	$hi_drum
	call	memcpy
	addl	$16, %esp
	movl	$0x3f4ccccd, %eax
	movl	%eax, hi_drum+4
	movl	$0x3b83126f, %eax
	movl	%eax, snare_drum
	movl	$0x3b83126f, %eax
	movl	%eax, beeps
	movl	$0x3927c5ac, %eax
	movl	%eax, beeps+4
	movl	$0x3f800000, %eax
	movl	%eax, beeps+8
	movl	$0x0, %eax
	movl	%eax, beeps+12
	movl	$3, beeps+16
	movl	$0, -8(%ebp)
.L77:
	cmpl	$511, -8(%ebp)
	jle	.L80
	jmp	.L76
.L80:
	movl	-8(%ebp), %eax
	andl	$15, %eax
	testl	%eax, %eax
	jne	.L81
	subl	$12, %esp
	movl	-8(%ebp), %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jns	.L82
	addl	$15, -12(%ebp)
.L82:
	movl	-12(%ebp), %eax
	sarl	$4, %eax
	movzbl	beeps_sequence(%eax), %eax
	pushl	%eax
	call	seed
	addl	$16, %esp
.L81:
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	leal	0(,%eax,4), %ebx
	call	rnd
	movzwl	%ax, %eax
	andl	$1, %eax
	movl	%eax, beeps_song(%ebx)
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	leal	0(,%eax,4), %ebx
	call	rnd
	movzwl	%ax, %eax
	pushl	%eax
	fildl	(%esp)
	leal	4(%esp), %esp
	flds	.LC37
	fdivrp	%st, %st(1)
	fstps	beeps_song+4(%ebx)
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	leal	0(,%eax,4), %ebx
	call	rnd
	movzwl	%ax, %eax
	pushl	%eax
	fildl	(%esp)
	leal	4(%esp), %esp
	flds	.LC38
	fdivrp	%st, %st(1)
	fstps	beeps_song+8(%ebx)
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	.L77
.L76:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	syna_init, .-syna_init
	.comm	syna_clock,4,4
	.comm	rnd_x,2,2
	.comm	rnd_y,2,2
	.comm	rnd_z,2,2
	.comm	rnd_v,2,2
	.comm	delay,32764,32
	.comm	accum,2048,32
	.comm	beeps,20,4
	.comm	bass_drum,20,4
	.comm	snare_drum,20,4
	.comm	hi_drum,20,4
	.comm	beeps_song,6156,32
	.comm	fil_f,4,4
	.comm	fil_q,4,4
