
.option norelax

.globl    array_size
.globl    array_start

.text
.globl _start

_start:

    la a0, array_start // adresa prvniho prvku pole
    la a1, array_size
    lw a1, 0(a1) // a1 je pocet prvku v poli
    addi s0, x0, 0 // s0 je index k inkrementaci

main_loop:
    slli t1, a1, 2 // velikost pole v bajtech
    beq s0, t1, _end  // kontroluju, jestli jsem dosel na konec pole

    add t0, a0, s0 // t0 je adresa v soucasnosi zkoumaneho elementu
    lw s4, 0(t0) // minimum rn
    add s3, s0, x0 // s3 je adresa minima
    addi s2, s0, 4 // s2 je pocatecni index pro vnitrni loop

inner_loop:
    slli t2, a1, 2 
    beq s2, t2, inner_loop_done

    add t0, a0, s2
    lw s5, 0(t0) // stejne jako s5 = array[s2]

    slt t0, s5, s4 // s5 < s4 ? t0 = 1 : t0 = 0
    beq t0, x0, not_minimum

    addi s4, s5, 0 // s4 je ted nove minimum
    addi s3, s2, 0 // s3 je index noveho minima

not_minimum:
    addi s2, s2, 4 // posun indexace
    j inner_loop
    
inner_loop_done:

    add t0, a0, s0
    lw s5, 0(t0) // s5 = array[s0]
    sw s4, 0(t0) // minimum = array[s0]
    add t0, a0, s3
    sw s5, 0(t0)

    addi s0, s0, 4 // inkrementace
    j main_loop

_end:
    fence
    ebreak
    j _end
    
.org 0x400

.data

array_size:
.word   15
array_start:
.word   5, 3, 4, 1, 15, 8, 9, 2, 10, 6, 11, 1, 6, 9, 12
