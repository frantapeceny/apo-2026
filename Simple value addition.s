.globl _start
.option norelax

.text

_start:
	addi a1, x0, 10
	addi a2, x0, 12
	
loop:
	
	add a3, a1, a2
	
	nop
    nop
    ebreak	

.data

.org 0x400



vect_a:
    .word 1, 2, 3, 4, 5, 6, 7, 8
    
.org 0x500
k_serazeni:
	.word 5, 2, 4, 8, 6, 1, 7, 3
prumer:
    .word 0
vect_b:
    .word 0, 0, 0, 0, 0, 0, 0, 0

src_val:
    .word 0x12345678
dst_val:
    .word 0