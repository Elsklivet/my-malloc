	.file	"my-malloc.c"
	.text
.Ltext0:
	.comm	head,8,8
	.comm	tail,8,8
	.comm	global_malloc_lock,40,32
	.globl	get_free_block
	.type	get_free_block, @function
get_free_block:
.LFB0:
	.file 1 "my-malloc.c"
	.loc 1 44 38
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	.loc 1 45 13
	movq	head@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 46 8
	jmp	.L2
.L5:
	.loc 1 48 15
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	.loc 1 48 7
	testl	%eax, %eax
	je	.L3
	.loc 1 48 34 discriminator 1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 48 24 discriminator 1
	cmpq	%rax, -24(%rbp)
	ja	.L3
	.loc 1 48 56 discriminator 2
	movq	-8(%rbp), %rax
	jmp	.L4
.L3:
	.loc 1 49 10
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -8(%rbp)
.L2:
	.loc 1 46 8
	cmpq	$0, -8(%rbp)
	jne	.L5
	.loc 1 51 10
	movl	$0, %eax
.L4:
	.loc 1 52 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	get_free_block, .-get_free_block
	.globl	malloc
	.type	malloc, @function
malloc:
.LFB1:
	.loc 1 54 26
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	.loc 1 60 5
	cmpq	$0, -40(%rbp)
	jne	.L7
	.loc 1 60 20 discriminator 1
	movl	$0, %eax
	jmp	.L8
.L7:
	.loc 1 63 3
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_lock@PLT
	.loc 1 65 12
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	get_free_block@PLT
	movq	%rax, -24(%rbp)
	.loc 1 67 5
	cmpq	$0, -24(%rbp)
	je	.L9
	.loc 1 69 23
	movq	-24(%rbp), %rax
	movl	$0, 8(%rax)
	.loc 1 71 5
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 73 12
	movq	-24(%rbp), %rax
	addq	$24, %rax
	jmp	.L8
.L9:
	.loc 1 77 14
	movq	-40(%rbp), %rax
	addq	$24, %rax
	movq	%rax, -16(%rbp)
	.loc 1 78 11
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	.loc 1 80 5
	cmpq	$-1, -8(%rbp)
	jne	.L10
	.loc 1 82 5
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 83 12
	movl	$0, %eax
	jmp	.L8
.L10:
	.loc 1 86 10
	movq	-8(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 87 18
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 88 21
	movq	-24(%rbp), %rax
	movl	$0, 8(%rax)
	.loc 1 89 18
	movq	-24(%rbp), %rax
	movq	$0, 16(%rax)
	.loc 1 91 6
	movq	head@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	.loc 1 91 5
	testq	%rax, %rax
	jne	.L11
	.loc 1 91 18 discriminator 1
	movq	head@GOTPCREL(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
.L11:
	.loc 1 93 6
	movq	tail@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	.loc 1 93 5
	testq	%rax, %rax
	je	.L12
	.loc 1 93 16 discriminator 1
	movq	tail@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	.loc 1 93 25 discriminator 1
	movq	-24(%rbp), %rdx
	movq	%rdx, 16(%rax)
.L12:
	.loc 1 95 8
	movq	tail@GOTPCREL(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 97 3
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 98 10
	movq	-24(%rbp), %rax
	addq	$24, %rax
.L8:
	.loc 1 100 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	malloc, .-malloc
	.globl	free
	.type	free, @function
free:
.LFB2:
	.loc 1 103 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	.loc 1 108 5
	cmpq	$0, -40(%rbp)
	je	.L22
	.loc 1 112 3
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_lock@PLT
	.loc 1 114 10
	movq	-40(%rbp), %rax
	subq	$24, %rax
	movq	%rax, -16(%rbp)
	.loc 1 115 18
	movl	$0, %edi
	call	sbrk@PLT
	movq	%rax, -8(%rbp)
	.loc 1 118 31
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	.loc 1 118 20
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	.loc 1 118 5
	cmpq	%rax, -8(%rbp)
	jne	.L16
	.loc 1 120 13
	movq	head@GOTPCREL(%rip), %rax
	movq	(%rax), %rdx
	movq	tail@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	.loc 1 120 7
	cmpq	%rax, %rdx
	jne	.L17
	.loc 1 122 19
	movq	tail@GOTPCREL(%rip), %rax
	movq	$0, (%rax)
	.loc 1 122 12
	movq	tail@GOTPCREL(%rip), %rax
	movq	(%rax), %rdx
	movq	head@GOTPCREL(%rip), %rax
	movq	%rdx, (%rax)
	jmp	.L18
.L17:
	.loc 1 126 11
	movq	head@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	.loc 1 127 12
	jmp	.L19
.L21:
	.loc 1 129 18
	movq	-24(%rbp), %rax
	movq	16(%rax), %rdx
	.loc 1 129 24
	movq	tail@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	.loc 1 129 11
	cmpq	%rax, %rdx
	jne	.L20
	.loc 1 131 23
	movq	-24(%rbp), %rax
	movq	$0, 16(%rax)
	.loc 1 132 16
	movq	tail@GOTPCREL(%rip), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, (%rax)
.L20:
	.loc 1 134 13
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -24(%rbp)
.L19:
	.loc 1 127 12
	cmpq	$0, -24(%rbp)
	jne	.L21
.L18:
	.loc 1 138 42
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 138 31
	movq	$-24, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	.loc 1 138 5
	movq	%rax, %rdi
	call	sbrk@PLT
	.loc 1 139 5
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	.loc 1 140 5
	jmp	.L13
.L16:
	.loc 1 143 21
	movq	-16(%rbp), %rax
	movl	$1, 8(%rax)
	.loc 1 144 3
	movq	global_malloc_lock@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	jmp	.L13
.L22:
	.loc 1 109 5
	nop
.L13:
	.loc 1 145 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	free, .-free
	.globl	calloc
	.type	calloc, @function
calloc:
.LFB3:
	.loc 1 148 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 151 5
	cmpq	$0, -24(%rbp)
	je	.L24
	.loc 1 151 11 discriminator 2
	cmpq	$0, -32(%rbp)
	jne	.L25
.L24:
	.loc 1 151 29 discriminator 3
	movl	$0, %eax
	jmp	.L26
.L25:
	.loc 1 152 8
	movq	-24(%rbp), %rax
	imulq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 154 20
	movq	-16(%rbp), %rax
	movl	$0, %edx
	divq	-24(%rbp)
	.loc 1 154 5
	cmpq	%rax, -32(%rbp)
	je	.L27
	.loc 1 154 34 discriminator 1
	movl	$0, %eax
	jmp	.L26
.L27:
	.loc 1 155 11
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 156 5
	cmpq	$0, -8(%rbp)
	jne	.L28
	.loc 1 156 21 discriminator 1
	movl	$0, %eax
	jmp	.L26
.L28:
	.loc 1 157 3
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	.loc 1 158 10
	movq	-8(%rbp), %rax
.L26:
	.loc 1 159 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	calloc, .-calloc
	.globl	realloc
	.type	realloc, @function
realloc:
.LFB4:
	.loc 1 162 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 165 5
	cmpq	$0, -24(%rbp)
	je	.L30
	.loc 1 165 13 discriminator 2
	cmpq	$0, -32(%rbp)
	jne	.L31
.L30:
	.loc 1 165 30 discriminator 3
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	jmp	.L32
.L31:
	.loc 1 166 10
	movq	-24(%rbp), %rax
	subq	$24, %rax
	movq	%rax, -16(%rbp)
	.loc 1 168 15
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	.loc 1 168 5
	cmpq	%rax, -32(%rbp)
	ja	.L33
	.loc 1 168 37 discriminator 1
	movq	-24(%rbp), %rax
	jmp	.L32
.L33:
	.loc 1 170 18
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 171 5
	cmpq	$0, -8(%rbp)
	je	.L34
	.loc 1 173 5
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memcpy@PLT
	.loc 1 174 5
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
.L34:
	.loc 1 176 10
	movq	-8(%rbp), %rax
.L32:
	.loc 1 177 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	realloc, .-realloc
.Letext0:
	.file 2 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h"
	.file 4 "/usr/include/unistd.h"
	.file 5 "/usr/include/x86_64-linux-gnu/bits/getopt_core.h"
	.file 6 "/usr/include/time.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/thread-shared-types.h"
	.file 8 "/usr/include/x86_64-linux-gnu/bits/struct_mutex.h"
	.file 9 "/usr/include/x86_64-linux-gnu/bits/pthreadtypes.h"
	.file 10 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 11 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 12 "/usr/include/stdio.h"
	.file 13 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x706
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF101
	.byte	0xc
	.long	.LASF102
	.long	.LASF103
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF1
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x4
	.long	.LASF7
	.byte	0x2
	.byte	0x98
	.byte	0x19
	.long	0x5e
	.uleb128 0x4
	.long	.LASF8
	.byte	0x2
	.byte	0x99
	.byte	0x1b
	.long	0x5e
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x85
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF9
	.uleb128 0x7
	.long	0x85
	.uleb128 0x4
	.long	.LASF10
	.byte	0x3
	.byte	0xd1
	.byte	0x17
	.long	0x42
	.uleb128 0x8
	.long	.LASF11
	.byte	0x4
	.value	0x21f
	.byte	0xf
	.long	0xaa
	.uleb128 0x6
	.byte	0x8
	.long	0x7f
	.uleb128 0x9
	.long	.LASF12
	.byte	0x5
	.byte	0x24
	.byte	0xe
	.long	0x7f
	.uleb128 0x9
	.long	.LASF13
	.byte	0x5
	.byte	0x32
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF14
	.byte	0x5
	.byte	0x37
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF15
	.byte	0x5
	.byte	0x3b
	.byte	0xc
	.long	0x57
	.uleb128 0x6
	.byte	0x8
	.long	0x8c
	.uleb128 0x7
	.long	0xe0
	.uleb128 0xa
	.long	0x7f
	.long	0xfb
	.uleb128 0xb
	.long	0x42
	.byte	0x1
	.byte	0
	.uleb128 0x9
	.long	.LASF16
	.byte	0x6
	.byte	0x9f
	.byte	0xe
	.long	0xeb
	.uleb128 0x9
	.long	.LASF17
	.byte	0x6
	.byte	0xa0
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF18
	.byte	0x6
	.byte	0xa1
	.byte	0x11
	.long	0x5e
	.uleb128 0x9
	.long	.LASF19
	.byte	0x6
	.byte	0xa6
	.byte	0xe
	.long	0xeb
	.uleb128 0x9
	.long	.LASF20
	.byte	0x6
	.byte	0xae
	.byte	0xc
	.long	0x57
	.uleb128 0x9
	.long	.LASF21
	.byte	0x6
	.byte	0xaf
	.byte	0x11
	.long	0x5e
	.uleb128 0xc
	.long	.LASF25
	.byte	0x10
	.byte	0x7
	.byte	0x31
	.byte	0x10
	.long	0x16b
	.uleb128 0xd
	.long	.LASF22
	.byte	0x7
	.byte	0x33
	.byte	0x23
	.long	0x16b
	.byte	0
	.uleb128 0xd
	.long	.LASF23
	.byte	0x7
	.byte	0x34
	.byte	0x23
	.long	0x16b
	.byte	0x8
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x143
	.uleb128 0x4
	.long	.LASF24
	.byte	0x7
	.byte	0x35
	.byte	0x3
	.long	0x143
	.uleb128 0xc
	.long	.LASF26
	.byte	0x28
	.byte	0x8
	.byte	0x16
	.byte	0x8
	.long	0x1f3
	.uleb128 0xd
	.long	.LASF27
	.byte	0x8
	.byte	0x18
	.byte	0x7
	.long	0x57
	.byte	0
	.uleb128 0xd
	.long	.LASF28
	.byte	0x8
	.byte	0x19
	.byte	0x10
	.long	0x3b
	.byte	0x4
	.uleb128 0xd
	.long	.LASF29
	.byte	0x8
	.byte	0x1a
	.byte	0x7
	.long	0x57
	.byte	0x8
	.uleb128 0xd
	.long	.LASF30
	.byte	0x8
	.byte	0x1c
	.byte	0x10
	.long	0x3b
	.byte	0xc
	.uleb128 0xd
	.long	.LASF31
	.byte	0x8
	.byte	0x20
	.byte	0x7
	.long	0x57
	.byte	0x10
	.uleb128 0xd
	.long	.LASF32
	.byte	0x8
	.byte	0x22
	.byte	0x9
	.long	0x50
	.byte	0x14
	.uleb128 0xd
	.long	.LASF33
	.byte	0x8
	.byte	0x23
	.byte	0x9
	.long	0x50
	.byte	0x16
	.uleb128 0xd
	.long	.LASF34
	.byte	0x8
	.byte	0x24
	.byte	0x14
	.long	0x171
	.byte	0x18
	.byte	0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF35
	.uleb128 0xe
	.byte	0x28
	.byte	0x9
	.byte	0x43
	.byte	0x9
	.long	0x228
	.uleb128 0xf
	.long	.LASF36
	.byte	0x9
	.byte	0x45
	.byte	0x1c
	.long	0x17d
	.uleb128 0xf
	.long	.LASF37
	.byte	0x9
	.byte	0x46
	.byte	0x8
	.long	0x228
	.uleb128 0xf
	.long	.LASF38
	.byte	0x9
	.byte	0x47
	.byte	0xc
	.long	0x5e
	.byte	0
	.uleb128 0xa
	.long	0x85
	.long	0x238
	.uleb128 0xb
	.long	0x42
	.byte	0x27
	.byte	0
	.uleb128 0x4
	.long	.LASF39
	.byte	0x9
	.byte	0x48
	.byte	0x3
	.long	0x1fa
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF40
	.uleb128 0xc
	.long	.LASF41
	.byte	0xd8
	.byte	0xa
	.byte	0x31
	.byte	0x8
	.long	0x3d2
	.uleb128 0xd
	.long	.LASF42
	.byte	0xa
	.byte	0x33
	.byte	0x7
	.long	0x57
	.byte	0
	.uleb128 0xd
	.long	.LASF43
	.byte	0xa
	.byte	0x36
	.byte	0x9
	.long	0x7f
	.byte	0x8
	.uleb128 0xd
	.long	.LASF44
	.byte	0xa
	.byte	0x37
	.byte	0x9
	.long	0x7f
	.byte	0x10
	.uleb128 0xd
	.long	.LASF45
	.byte	0xa
	.byte	0x38
	.byte	0x9
	.long	0x7f
	.byte	0x18
	.uleb128 0xd
	.long	.LASF46
	.byte	0xa
	.byte	0x39
	.byte	0x9
	.long	0x7f
	.byte	0x20
	.uleb128 0xd
	.long	.LASF47
	.byte	0xa
	.byte	0x3a
	.byte	0x9
	.long	0x7f
	.byte	0x28
	.uleb128 0xd
	.long	.LASF48
	.byte	0xa
	.byte	0x3b
	.byte	0x9
	.long	0x7f
	.byte	0x30
	.uleb128 0xd
	.long	.LASF49
	.byte	0xa
	.byte	0x3c
	.byte	0x9
	.long	0x7f
	.byte	0x38
	.uleb128 0xd
	.long	.LASF50
	.byte	0xa
	.byte	0x3d
	.byte	0x9
	.long	0x7f
	.byte	0x40
	.uleb128 0xd
	.long	.LASF51
	.byte	0xa
	.byte	0x40
	.byte	0x9
	.long	0x7f
	.byte	0x48
	.uleb128 0xd
	.long	.LASF52
	.byte	0xa
	.byte	0x41
	.byte	0x9
	.long	0x7f
	.byte	0x50
	.uleb128 0xd
	.long	.LASF53
	.byte	0xa
	.byte	0x42
	.byte	0x9
	.long	0x7f
	.byte	0x58
	.uleb128 0xd
	.long	.LASF54
	.byte	0xa
	.byte	0x44
	.byte	0x16
	.long	0x3eb
	.byte	0x60
	.uleb128 0xd
	.long	.LASF55
	.byte	0xa
	.byte	0x46
	.byte	0x14
	.long	0x3f1
	.byte	0x68
	.uleb128 0xd
	.long	.LASF56
	.byte	0xa
	.byte	0x48
	.byte	0x7
	.long	0x57
	.byte	0x70
	.uleb128 0xd
	.long	.LASF57
	.byte	0xa
	.byte	0x49
	.byte	0x7
	.long	0x57
	.byte	0x74
	.uleb128 0xd
	.long	.LASF58
	.byte	0xa
	.byte	0x4a
	.byte	0xb
	.long	0x65
	.byte	0x78
	.uleb128 0xd
	.long	.LASF59
	.byte	0xa
	.byte	0x4d
	.byte	0x12
	.long	0x34
	.byte	0x80
	.uleb128 0xd
	.long	.LASF60
	.byte	0xa
	.byte	0x4e
	.byte	0xf
	.long	0x49
	.byte	0x82
	.uleb128 0xd
	.long	.LASF61
	.byte	0xa
	.byte	0x4f
	.byte	0x8
	.long	0x3f7
	.byte	0x83
	.uleb128 0xd
	.long	.LASF62
	.byte	0xa
	.byte	0x51
	.byte	0xf
	.long	0x407
	.byte	0x88
	.uleb128 0xd
	.long	.LASF63
	.byte	0xa
	.byte	0x59
	.byte	0xd
	.long	0x71
	.byte	0x90
	.uleb128 0xd
	.long	.LASF64
	.byte	0xa
	.byte	0x5b
	.byte	0x17
	.long	0x412
	.byte	0x98
	.uleb128 0xd
	.long	.LASF65
	.byte	0xa
	.byte	0x5c
	.byte	0x19
	.long	0x41d
	.byte	0xa0
	.uleb128 0xd
	.long	.LASF66
	.byte	0xa
	.byte	0x5d
	.byte	0x14
	.long	0x3f1
	.byte	0xa8
	.uleb128 0xd
	.long	.LASF67
	.byte	0xa
	.byte	0x5e
	.byte	0x9
	.long	0x7d
	.byte	0xb0
	.uleb128 0xd
	.long	.LASF68
	.byte	0xa
	.byte	0x5f
	.byte	0xa
	.long	0x91
	.byte	0xb8
	.uleb128 0xd
	.long	.LASF69
	.byte	0xa
	.byte	0x60
	.byte	0x7
	.long	0x57
	.byte	0xc0
	.uleb128 0xd
	.long	.LASF70
	.byte	0xa
	.byte	0x62
	.byte	0x8
	.long	0x423
	.byte	0xc4
	.byte	0
	.uleb128 0x4
	.long	.LASF71
	.byte	0xb
	.byte	0x7
	.byte	0x19
	.long	0x24b
	.uleb128 0x10
	.long	.LASF104
	.byte	0xa
	.byte	0x2b
	.byte	0xe
	.uleb128 0x11
	.long	.LASF72
	.uleb128 0x6
	.byte	0x8
	.long	0x3e6
	.uleb128 0x6
	.byte	0x8
	.long	0x24b
	.uleb128 0xa
	.long	0x85
	.long	0x407
	.uleb128 0xb
	.long	0x42
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x3de
	.uleb128 0x11
	.long	.LASF73
	.uleb128 0x6
	.byte	0x8
	.long	0x40d
	.uleb128 0x11
	.long	.LASF74
	.uleb128 0x6
	.byte	0x8
	.long	0x418
	.uleb128 0xa
	.long	0x85
	.long	0x433
	.uleb128 0xb
	.long	0x42
	.byte	0x13
	.byte	0
	.uleb128 0x9
	.long	.LASF75
	.byte	0xc
	.byte	0x89
	.byte	0xe
	.long	0x43f
	.uleb128 0x6
	.byte	0x8
	.long	0x3d2
	.uleb128 0x9
	.long	.LASF76
	.byte	0xc
	.byte	0x8a
	.byte	0xe
	.long	0x43f
	.uleb128 0x9
	.long	.LASF77
	.byte	0xc
	.byte	0x8b
	.byte	0xe
	.long	0x43f
	.uleb128 0x9
	.long	.LASF78
	.byte	0xd
	.byte	0x1a
	.byte	0xc
	.long	0x57
	.uleb128 0xa
	.long	0xe6
	.long	0x474
	.uleb128 0x12
	.byte	0
	.uleb128 0x7
	.long	0x469
	.uleb128 0x9
	.long	.LASF79
	.byte	0xd
	.byte	0x1b
	.byte	0x1a
	.long	0x474
	.uleb128 0x4
	.long	.LASF80
	.byte	0x1
	.byte	0x7
	.byte	0xe
	.long	0x491
	.uleb128 0xa
	.long	0x85
	.long	0x4a1
	.uleb128 0xb
	.long	0x42
	.byte	0xf
	.byte	0
	.uleb128 0xc
	.long	.LASF81
	.byte	0x18
	.byte	0x1
	.byte	0xb
	.byte	0xa
	.long	0x4d6
	.uleb128 0xd
	.long	.LASF82
	.byte	0x1
	.byte	0xd
	.byte	0xc
	.long	0x91
	.byte	0
	.uleb128 0xd
	.long	.LASF83
	.byte	0x1
	.byte	0xf
	.byte	0xe
	.long	0x3b
	.byte	0x8
	.uleb128 0xd
	.long	.LASF84
	.byte	0x1
	.byte	0x11
	.byte	0x16
	.long	0x4d6
	.byte	0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x4a1
	.uleb128 0x13
	.long	.LASF90
	.byte	0x18
	.byte	0x1
	.byte	0xa
	.byte	0x7
	.long	0x500
	.uleb128 0x14
	.string	"s"
	.byte	0x1
	.byte	0x12
	.byte	0x5
	.long	0x4a1
	.uleb128 0xf
	.long	.LASF85
	.byte	0x1
	.byte	0x13
	.byte	0x9
	.long	0x485
	.byte	0
	.uleb128 0x4
	.long	.LASF81
	.byte	0x1
	.byte	0x15
	.byte	0x16
	.long	0x4dc
	.uleb128 0x15
	.long	.LASF86
	.byte	0x1
	.byte	0x17
	.byte	0xb
	.long	0x522
	.uleb128 0x9
	.byte	0x3
	.quad	head
	.uleb128 0x6
	.byte	0x8
	.long	0x500
	.uleb128 0x15
	.long	.LASF87
	.byte	0x1
	.byte	0x17
	.byte	0x12
	.long	0x522
	.uleb128 0x9
	.byte	0x3
	.quad	tail
	.uleb128 0x15
	.long	.LASF88
	.byte	0x1
	.byte	0x19
	.byte	0x11
	.long	0x238
	.uleb128 0x9
	.byte	0x3
	.quad	global_malloc_lock
	.uleb128 0x16
	.long	.LASF92
	.byte	0x1
	.byte	0xa1
	.byte	0x7
	.long	0x7d
	.quad	.LFB4
	.quad	.LFE4-.LFB4
	.uleb128 0x1
	.byte	0x9c
	.long	0x5b3
	.uleb128 0x17
	.long	.LASF89
	.byte	0x1
	.byte	0xa1
	.byte	0x15
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x17
	.long	.LASF82
	.byte	0x1
	.byte	0xa1
	.byte	0x23
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.long	.LASF90
	.byte	0x1
	.byte	0xa3
	.byte	0xd
	.long	0x522
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x18
	.long	.LASF91
	.byte	0x1
	.byte	0xa4
	.byte	0x9
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x16
	.long	.LASF93
	.byte	0x1
	.byte	0x93
	.byte	0x7
	.long	0x7d
	.quad	.LFB3
	.quad	.LFE3-.LFB3
	.uleb128 0x1
	.byte	0x9c
	.long	0x612
	.uleb128 0x19
	.string	"num"
	.byte	0x1
	.byte	0x93
	.byte	0x15
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x17
	.long	.LASF94
	.byte	0x1
	.byte	0x93
	.byte	0x21
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.long	.LASF82
	.byte	0x1
	.byte	0x95
	.byte	0xa
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x18
	.long	.LASF89
	.byte	0x1
	.byte	0x96
	.byte	0x9
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1a
	.long	.LASF98
	.byte	0x1
	.byte	0x66
	.byte	0x6
	.quad	.LFB2
	.quad	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.long	0x66d
	.uleb128 0x17
	.long	.LASF89
	.byte	0x1
	.byte	0x66
	.byte	0x11
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x18
	.long	.LASF90
	.byte	0x1
	.byte	0x68
	.byte	0xd
	.long	0x522
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.string	"tmp"
	.byte	0x1
	.byte	0x68
	.byte	0x16
	.long	0x522
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.long	.LASF95
	.byte	0x1
	.byte	0x69
	.byte	0x9
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x16
	.long	.LASF96
	.byte	0x1
	.byte	0x36
	.byte	0x7
	.long	0x7d
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x6cc
	.uleb128 0x17
	.long	.LASF82
	.byte	0x1
	.byte	0x36
	.byte	0x15
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x18
	.long	.LASF97
	.byte	0x1
	.byte	0x37
	.byte	0xa
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x18
	.long	.LASF89
	.byte	0x1
	.byte	0x38
	.byte	0x9
	.long	0x7d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.long	.LASF90
	.byte	0x1
	.byte	0x39
	.byte	0xd
	.long	0x522
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1c
	.long	.LASF99
	.byte	0x1
	.byte	0x2c
	.byte	0xb
	.long	0x522
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x17
	.long	.LASF82
	.byte	0x1
	.byte	0x2c
	.byte	0x21
	.long	0x91
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.long	.LASF100
	.byte	0x1
	.byte	0x2d
	.byte	0xd
	.long	0x522
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF97:
	.string	"total_size"
.LASF90:
	.string	"header"
.LASF36:
	.string	"__data"
.LASF85:
	.string	"stub"
.LASF41:
	.string	"_IO_FILE"
.LASF78:
	.string	"sys_nerr"
.LASF53:
	.string	"_IO_save_end"
.LASF88:
	.string	"global_malloc_lock"
.LASF10:
	.string	"size_t"
.LASF96:
	.string	"malloc"
.LASF99:
	.string	"get_free_block"
.LASF63:
	.string	"_offset"
.LASF25:
	.string	"__pthread_internal_list"
.LASF47:
	.string	"_IO_write_ptr"
.LASF42:
	.string	"_flags"
.LASF39:
	.string	"pthread_mutex_t"
.LASF28:
	.string	"__count"
.LASF32:
	.string	"__spins"
.LASF5:
	.string	"short int"
.LASF54:
	.string	"_markers"
.LASF44:
	.string	"_IO_read_end"
.LASF67:
	.string	"_freeres_buf"
.LASF86:
	.string	"head"
.LASF20:
	.string	"daylight"
.LASF103:
	.string	"/home/gavin/coding/my-malloc"
.LASF94:
	.string	"nsize"
.LASF22:
	.string	"__prev"
.LASF21:
	.string	"timezone"
.LASF98:
	.string	"free"
.LASF80:
	.string	"ALIGN"
.LASF91:
	.string	"return_block"
.LASF23:
	.string	"__next"
.LASF77:
	.string	"stderr"
.LASF31:
	.string	"__kind"
.LASF40:
	.string	"long long int"
.LASF18:
	.string	"__timezone"
.LASF62:
	.string	"_lock"
.LASF17:
	.string	"__daylight"
.LASF6:
	.string	"long int"
.LASF59:
	.string	"_cur_column"
.LASF89:
	.string	"block"
.LASF81:
	.string	"header_t"
.LASF46:
	.string	"_IO_write_base"
.LASF58:
	.string	"_old_offset"
.LASF0:
	.string	"unsigned char"
.LASF87:
	.string	"tail"
.LASF95:
	.string	"programbreak"
.LASF12:
	.string	"optarg"
.LASF4:
	.string	"signed char"
.LASF64:
	.string	"_codecvt"
.LASF35:
	.string	"long long unsigned int"
.LASF101:
	.string	"GNU C17 9.3.0 -mtune=generic -march=x86-64 -g -O0 -fPIC -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF102:
	.string	"my-malloc.c"
.LASF2:
	.string	"unsigned int"
.LASF72:
	.string	"_IO_marker"
.LASF61:
	.string	"_shortbuf"
.LASF92:
	.string	"realloc"
.LASF19:
	.string	"tzname"
.LASF70:
	.string	"_unused2"
.LASF14:
	.string	"opterr"
.LASF37:
	.string	"__size"
.LASF50:
	.string	"_IO_buf_end"
.LASF9:
	.string	"char"
.LASF30:
	.string	"__nusers"
.LASF13:
	.string	"optind"
.LASF65:
	.string	"_wide_data"
.LASF66:
	.string	"_freeres_list"
.LASF93:
	.string	"calloc"
.LASF11:
	.string	"__environ"
.LASF68:
	.string	"__pad5"
.LASF83:
	.string	"is_free"
.LASF27:
	.string	"__lock"
.LASF29:
	.string	"__owner"
.LASF1:
	.string	"short unsigned int"
.LASF26:
	.string	"__pthread_mutex_s"
.LASF3:
	.string	"long unsigned int"
.LASF48:
	.string	"_IO_write_end"
.LASF8:
	.string	"__off64_t"
.LASF33:
	.string	"__elision"
.LASF56:
	.string	"_fileno"
.LASF55:
	.string	"_chain"
.LASF82:
	.string	"size"
.LASF24:
	.string	"__pthread_list_t"
.LASF69:
	.string	"_mode"
.LASF16:
	.string	"__tzname"
.LASF7:
	.string	"__off_t"
.LASF52:
	.string	"_IO_backup_base"
.LASF75:
	.string	"stdin"
.LASF49:
	.string	"_IO_buf_base"
.LASF57:
	.string	"_flags2"
.LASF73:
	.string	"_IO_codecvt"
.LASF45:
	.string	"_IO_read_base"
.LASF34:
	.string	"__list"
.LASF60:
	.string	"_vtable_offset"
.LASF74:
	.string	"_IO_wide_data"
.LASF51:
	.string	"_IO_save_base"
.LASF79:
	.string	"sys_errlist"
.LASF15:
	.string	"optopt"
.LASF71:
	.string	"FILE"
.LASF43:
	.string	"_IO_read_ptr"
.LASF38:
	.string	"__align"
.LASF76:
	.string	"stdout"
.LASF84:
	.string	"next"
.LASF104:
	.string	"_IO_lock_t"
.LASF100:
	.string	"curr"
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
