
  la    s3, pole 
  addi  t1, zero, 5
  addi  s2, s3, 20*4
l2:
  add   s1, s3, zero 
loop: 	
  lw    t0, 0(s1)     // t0 <- pole[j]
  addi  t0, t0, 1     // s0++
  sw    t0, 0(s1)     // pole[j] <- s0
  addi  s1, s1, 4     // j++
  bne   s1, s2, loop  // pole + j != pole + 20
  addi  t1, t1, -1
  bne   t1, zero, l2
  ebreak
  nop
  
.data
.org 0x4000
pole:;
.word 0,1,2,3,4,5,6,7,8,9
.word 10,11,12,13,14,15,16,17,18,19