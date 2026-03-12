# this code is a curtesy of Karel Koci
# can you find bugs in selection sort algorithm?

.text

__start:
_start:
	la x1, arr  # Pointer na zacatek pole
	la x2, end  # Pointer na konec pole
	addi x2, x2, -0x4
	
	// x3 
	
sort:
	mv x3, x1
	mv x4, x1 # x4 = x1 - pointer na potencialne nejmensi hodnotu

inner:
	addi x3, x3, 0x4 # x3 = x3 + 4
	lw x5, 0(x3) # x5 = *x3 - aktualni hodnota
	lw x6, 0(x4) # x6 = *x4 - nejmensi hodnota
	slt x7, x5, x6 # x7 = x5 < x6 ? 1 : 0
	beq x7, x0, if # if (x5 >= x6) goto if
		mv x4, x3  # x4 = x3 - nasli jsme jeste mensi hodnotu
if:
	bne x3, x2, inner  # do {...} while (x3 != x2)

	lw x5, 0(x4) # x5 = *x4
	lw x6, 0(x1) # x6 = *x1
	sw x6, 0(x4) # *x4 = x6
	sw x5, 0(x1) # *x1 = x5
	addi x1, x1, 0x4  # x1 += 4

	bne x1, x2, sort  # do {...} while (x1 != x2)


loop:	ebreak
        beq     zero, zero, loop

.data
.org 0x400

arr:
.word    5, 3, 4, 1, 15, 8, 9, 2, 10, 6, 11, 1, 6, 9, 12
end:
