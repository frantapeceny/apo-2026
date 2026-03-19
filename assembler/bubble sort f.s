
.globl array_size
array_size:
	.word 0
	
.globl array_start
array_start:
	.space 200

#.section .text
.option norelax
.globl _start

_start:
    la x1, array_size # x1 = adresa array_size (zpocatku nevim, kolik je, tak nemuzu nacist rovnou 
	lw x2, 0(x1) # x2 = pocet prvku v poli
	la x3, array_start
	addi x4, x2, -1 # x4 = kolikrat potrebuju projit pole

_outer_loop:

	beq x4, x0, _end
	mv x5, x4 # x5 = kolik kroku mi chybi k projiti pole - cim vyssi, tim nizsi x6
	mv x6, x3 # x6 = prvni adresa, od ktere chci kontrolovat - cim vyssi, tim nizsi ze x5

_inner_loop:
	beq x5, x0, _outer_next 
	
	lw x7, 0(x6)
	lw x8, 4(x6)
	
	slt x10, x8, x7
	bne x10, x0, _prohod
	
	addi x6, x6, 4
	addi x5, x5, -1
	
	j _inner_loop

_prohod:
	sw x7, 4(x6)
	sw x8, 0(x6)
	
	addi x6, x6, 4 // posunuji ukazatel na prvni kontrolovane pole o jedno misto = 4 byte
	addi x5, x5, -1 // o krok mene ke konci pole
	
	j _inner_loop

_outer_next:
	addi x4, x4, -1
	j _outer_loop

_end:
    ebreak
    
    