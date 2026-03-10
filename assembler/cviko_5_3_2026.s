.globl _start
.option norelax

.text

_start:
loop:
    //la x3, vect_a           # load ADDRESS of vect_a into x3 (use la, not lw)
    la x3, k_serazeni
    
    addi x5, x0, 0 // i = 0
    addi x6, x0, 7 // pocet cyklu
    
    
bubble_loop:

	beq x5, x6, end
	
	//nactu hodnoty z pameti do registru
	lw x2, 0(x3) // x2 = k_serazeni
	lw x4 , 0x4(x3) // x4 = k_serazeni + 4
	
	bge x4, x2, skip
	sw x2, 0x4(x3)
	sw x4, 0(x3)
	
	
skip:
	
    addi x3, x3, 4
    addi x5, x5, 1
    j bubble_loop
    
    
end:
    
    //prohozeni hodnot z adres vect_a a vect_a+4, pokud je druha hodnota vetsi nez prvni
//    lw x1, 0x0(x3) //nactu hodnotu z prvni adresy vect_a
//    lw x2, 0x4(x3) //nactu hodnotu z druhe adresy vect_a
//    
//    slt x4, x1, x2 // if (x1 < x2) x4 = 1 else x4 = 0
//    beq x4, x0, skip //if (x4 = 0) goto skip
//    //predesle dva radky by slo tez napsat: bge x1, x2, skip (= if (x1 >= x2) goto skip
//    
//    sw x2, 0x0(x3)
//    sw x1, 0x4(x3)
    
    
//    la x8, vect_b
//
//    addi x1, x0, 0          # x1 = i = 0  (was x2, should be x0)
//    addi x2, x0, 8          # x2 = limit = 8
//    addi x4, x0, 0          # x4 = sum = 0
//
//my_loop:
//    lw x5, 0(x3)            # load vect_a[i] into x5
//    sw x8, 0x0(x3)
//    
//    add x4, x4, x5          # sum += x5
//    addi x3, x3, 4          # advance pointer by 4 bytes (YOU WERE MISSING THIS)
//    addi x8, x8, 4x;
//    addi x1, x1, 1          # i++
//    bne x1, x2, my_loop     # if (i != 8) goto my_loop
//	
//	// prumer = sum / 8... deleni mocninou dvou je stejne jako posun o exp te dvojky
//	srli x6, x4, 3
//	
//	la x8, prumer
//	sw x6, 0(x8)
//	
//	
//skip:

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