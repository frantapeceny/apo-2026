.globl _start

.option norelax

.text
_start:

main:

    addi  x2,  x0, 10
    addi  x5,  x0, varx
    nop # musim pockat, nez se mi zapise hodnota x2, nez ji budu na dalsim radku pouzivat
    add   x11, x0, x2   // A : x11<-x2
    lw    x1, 0(x5)     // x1 = *((int*)$5);
    add   x12, x0, x2   // B : x12<-x2
    add   x13, x0, x2   // C : x13<-x2

la_auipc_inst_addr:
    //la x5, varx  // $5 = (byte*) &varx; 
    // The macro-instruction la is compiled as two following instructions:
    //auipc x5, %pcrel_hi(varx) // load the upper part of address
    //addi  x5, x5, %pcrel_lo(la_auipc_inst_addr) // append the lower part of address
    // they compute and load address as relative to the PC, absolute load address alternative
    //lui   x5, %hi(varx) // load the upper part of address
    //addi  x5, x5, %lo(varx) // append the lower part of address
    // It can be replaced by simple single addi if varx is located lower than 0x800
    #addi  x5,  x0, varx

    add   x15, x0, x1   // D : x15<-x1
    add   x16, x0, x1   // E : x16<-x1
    add   x17, x0, x1   // F : x17<-x1
loop:
    ebreak
    beq    x0, x0, loop
    nop

.data
.org 0x400
varx:
	.word  0x1234