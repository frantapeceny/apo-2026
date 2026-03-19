
.globl array_size
array_size:
	.word 0
	
.globl array_start
array_start:
	.space 200

//.section .text
.option norelax
.globl _start

_start:
	la x1, array_size // x1 = adresa array_size (zpocatku nevim, kolik je, tak nemuzu nacist rovnou 
	lw x2, 0(x1) // x2 = pocet prvku v poli
	la x3, array_start
	//addi x4, x2, -1 // x4 = kolikrat potrebuju projit pole
	//addi x18, x4, 0 // kopiruju x4 do x18 - pocitadla potrebuji dve - jedno pro kazdy loop

_external_loop:
	mv x14, x0 // zresetuju pozici pro internal loop
	addi x4, x2, -1
	
	// x3 je pevna adresa prvniho prvku pole
	add x11, x3, x12
	lw x5, 0(x11) // x5 = v poradi prvni hodnota pole
	addi x6, x11, 0x4 //x6 = adresa druhe hodnoty pole
	lw x7, 0(x16) // x7 = v poradi druha hodnota pole
	
	slt x8, x7, x5 // x8 = x7 < x5 ? 1 : 0
	bne x8, x0, _internal_loop
	
	addi x12, x12, 0x4
	beq x18, x0, _end
	
	j _external_loop

_internal_loop:
	mv x12, x0 // zresetuju pozici pro external loop
	addi x18, x2, -1
	
	add x13, x3, x14 // x13 = adresa prvniho prvku pole
	
	lw x15, 0(x13) // x15 = v poradi prvni hodnota pole
	addi x16, x13, 0x4 //x6 = adresa v poradi druhe hodnoty pole
	lw x17, 0(x16) // x7 = v poradi druha hodnota pole
	
	slt x10, x17, x15 // x8 = x7 < x5 ? 1 : 0
	bne x10, x0, _prohod
	
	addi x14, x14, 0x4
	addi x4, x4, -1
	beq x4, x0, _external_loop
	
	j _internal_loop
	
_prohod:

	mv x19, x15 // ulozim si hodnotu x5 do x9
	sw x17, 0(x13)
	sw x9, 4(x13)
	
	addi x14, x14, 0x4 // posunu se na dalsi polozku pole
	j _internal_loop

_end:
	nop
    nop
    ebreak	

.data

.org 0x400

	