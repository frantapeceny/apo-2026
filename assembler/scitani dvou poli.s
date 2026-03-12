// Directives to make interesting windows visible
#pragma qtrvsim show registers
#pragma qtrvsim show memory

.option norelax
.globl  array
.globl  _start

.text
_start:

  la   x4, array_a
  la   x5, array_b
  la   x6, array_c

  addi x7, zero, 8  

main_cycle:
  lw   x8, 0(x4)
  lw   x9, 0(x5)
  add  x8, x8, x9
  sw   x8, 0(x6)
  addi x4, x4, 4
  addi x5, x5, 4
  addi x6, x6, 4
  addi x7, x7, -1
  bne  x7, x0, main_cycle

  ebreak           // stop the simulator

.org 0x400

.data
array_a:
.word    5, 3, 4, 1, 7, 8, 1 ,5
array_b:
.word    1, 1, 1, 2, 2, 2, 3, 3
array_c:
.word    0, 0, 0, 0, 0, 0, 0, 0

// Specify location to show in memory window
#pragma qtrvsim focus memory array


//cache setup:
// number of sets: pocet radku bloku (kazdy storne 32bitove slovo)
// block size: kolik bloku chceme
// degree of associativity: 