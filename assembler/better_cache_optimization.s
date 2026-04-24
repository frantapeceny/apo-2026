
#pragma cache:lru,4,2,2,wb
#pragma qtrvsim show registers
#pragma qtrvsim show memory

.option norelax

.globl array_start
.globl array_size
.text
.globl _start

_start:

    la a0, array_start
    la a1, array_size
    lw a1, 0(a1)          // a1 = pocet prvku
    addi s0, x0, 0        // s0 = levy index
    slli t3, a1, 2
    addi t3, t3, -4       // t3 = pravy index (posledni prvek)

main_loop:

    bge s0, t3, _end      // checkuju, jestli uz je serazeno

    // inicializuji minimum i maximum na prvni prvek
    add t0, a0, s0
    lw s4, 0(t0)          // s4 je minimum
    addi s3, s0, 0        // s3 je index minima
    lw s6, 0(t0)          // s6 je maximum
    addi s7, s0, 0        // s7 je index maxima

    addi s2, s0, 4        // s2 je aktualni index vnitrni smycky

inner_loop:

    bge s2, t3, inner_loop_check_last  // zpracuj posledni prvek zvlast
    add t0, a0, s2
    lw s5, 0(t0)          // s5 = array[s2]

    slt t0, s5, s4
    beq t0, x0, check_max
    addi s4, s5, 0        // nove minimum
    addi s3, s2, 0        // index minima
    
check_max:
    slt t0, s6, s5
    beq t0, x0, not_max
    addi s6, s5, 0        // nove maximum
    addi s7, s2, 0        // index maxima
    
not_max:
    addi s2, s2, 4
    j inner_loop

inner_loop_check_last:

    add t0, a0, t3
    lw s5, 0(t0)
    slt t0, s5, s4
    beq t0, x0, check_max2
    addi s4, s5, 0
    addi s3, t3, 0
    
check_max2:
    slt t0, s6, s5
    beq t0, x0, inner_loop_done
    addi s6, s5, 0
    addi s7, t3, 0

inner_loop_done:
    // vloz minimum na levy kraj (s0)
    add t0, a0, s0
    lw t1, 0(t0)          // t1 = array[s0]
    // pokud je maximum na pozici s0, bude presunut na s3 - oprav index
    beq s7, s0, fix_max_idx
    j do_min_swap
fix_max_idx:
    addi s7, s3, 0        // maximum se presune tam, kde bylo minimum
do_min_swap:
    sw s4, 0(t0)          // array[s0] = minimum
    add t0, a0, s3
    sw t1, 0(t0)          // array[s3] = stary array[s0]

    // vloz maximum na pravy kraj (t3)
    add t0, a0, t3
    lw t1, 0(t0)          // t1 = array[t3]
    sw s6, 0(t0)          // array[t3] = maximum
    add t0, a0, s7
    sw t1, 0(t0)          // array[s7] = stary array[t3]

    addi s0, s0, 4        // posun leveho indexu doprava
    addi t3, t3, -4       // posun praveho indexu doleva
    j main_loop

_end:
    #fence
    ebreak
    j _end

.data
array_size:
.word   15
array_start:
.word   5, 3, 4, 1, 15, 8, 9, 2, 10, 6, 11, 1, 6, 9, 12
#pragma qtrvsim focus memory array_size