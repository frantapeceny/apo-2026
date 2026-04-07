// apo-sort.S file template, rename and implement the algorithm
// Test algorithm in qtrvsim_gui program
// Select the CPU core configuration with delay-slot
// This setups requires (for simplicity) one NOP instruction after
// each branch and jump instruction (more during lecture about pipelining)
// The code will be compiled and tested by external riscv64-unknown-elf-gcc
// compiler by teachers, you can try make in addition, but testing
// by internal assembler should be enough

// copy directory with the project to your repository to
// the directory work/apo-sort
// critical is location of the file work/apo-sort/apo-sort.S
// and cache parameters work/apo-sort/d-cache.par
// which is checked by the scripts

// The file d-cache.par specifies D cache parameters in the form
//   <policy>,<#sets>,<#words in block>,<#ways>,<write method>
// The example is
//   lru,1,1,1,wb
// The cache size is limited to 16 words maximum.

// Directives to make interesting windows visible
#pragma qtrvsim show registers
#pragma qtrvsim show memory

.option norelax

.globl    array_size
.globl    array_start

.text
.globl _start

_start:

	la   a0, array_start //adresa prvniho prvku pole
	la   a1, array_size 
	lw   a1, 0(a1) // number of elements in the array
	addi s0, x0, 0 // misto na ulozeni nejmensi hodnoty pole
	addi s1, x0, 0 // current index
	srli s2, a1, 2 // nejvetsi mozny index

main_cycle:
        beq  s0, s1, main_cycle_end

        add  t0, a0, s0
        lw   s4, 0(t0)   // lw  s4, array(s0)
        add  s3, s0, zero
        add  s2, s0, zero

inner_cycle:
        beq  s2, s1, inner_cycle_end
                add  t0, a0, s2
                lw   s5, 0(t0) // lw s5, array(s2)

                // expand bgt s5, s4, not_minimum
                slt  t0, s4, s5
                bne  t0, zero, not_minimum

                        addi s3, s2, 0
                        addi s4, s5, 0
not_minimum:
                addi s2, s2, 4
                j inner_cycle
inner_cycle_end:
        add  t0, a0, s0
        lw   s5, 0(t0)  // lw s5, array(s0)
        sw   s4, 0(t0)  // sw s4, array(s0)
        add  t0, a0, s3
        sw   s5, 0(t0)  // sw s5, array(s3)

        addi s0, s0, 4
        j main_cycle
main_cycle_end:
	

end_loop:
	fence           // flush cache memory
	ebreak          // stop the simulator
	j end_loop

.org 0x400

.data

array_size:
.word	15
array_start:
.word	5, 3, 4, 1, 15, 8, 9, 2, 10, 6, 11, 1, 6, 9, 12

// Specify location to show in memory window
#pragma qtrvsim focus memory array_size
