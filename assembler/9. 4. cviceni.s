#li x1, 0xffffc104
#li x2, 0xaaaaaaaa
#sw x2, 0(x1)
#ebreak

# ---------------------------------------- 

#lui t0, 0xffffc
#ori t0, t0, 0x100

#addi t1, zero, 5
#addi x2, zero, 29	

#loop:
#	sw t1, 4(t0)
#	slli t1, t1, 1
#	addi x2, x2, -1
#	bne x2, zero, loop
#	addi x2, zero, 30
	
#loop_2:
#	sw t1, 4(t0)
#	srli t1, t1, 1
#	addi x2, x2, -1
#	bne x2, zero, loop_2
	
#ebreak

# ---------------------------------------- 

#  li t0, 0xffffc000   // base address into memory mapped I/O area
#  addi t1, zero, 48
#  addi t6, zero, 1234
#  addi t2, zero, 10
#loop:
#  lw   t3, 0x08(t0)
#  andi t3, t3, 1
#  beq  t3, zero, loop  
#  sw   t1, 0x0c(t0)
#  addi t1, t1, 1
#  addi t2, t2, -1
#  bne  t2, zero, loop
#  ebreak
  
# ---------------------------------------- 
  
  li t0, 0xffffc000   // base address into memory mapped I/O area
  addi t1, zero, 48
  addi t6, zero, 1234
  addi t2, zero, 10
  lui x2, 0xffffc
  ori x2, x2, 0x100 
  
loop_rx:
  lw   t3, 0x0(t0)
  andi t3, t3, 1
  beq  t3, zero, loop_rx
  lw   t1, 4(t0)  
loop_tx:
  addi x1, t1, -0x30 // prevod ascii hodnotu 48 na decimalni hodnotu
  addi t1, zero, 1
  sw x0, 4(x2)
cyklus:
	beq x1, zero, end
	sw t1, 4(x2)
	slli t1, t1, 1
	ori t1, t1, 1
	addi x1, x1, -1
	j cyklus
	
end:
	bne t2, zero, loop_rx
	ebreak

ebreak
  
  
  