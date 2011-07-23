/*******************************************************************************
 HARPtools by Chad D. Kersey, Summer 2011
********************************************************************************

 Sample HARP assmebly programs. These should work on anything from a 4x up.

*******************************************************************************/
/* Library: print decimals and strings! */
.perm x
.global
printdec:    ldi %r8, #1;
             shli %r8, %r8, (__WORD*8 - 1);
             and %r6, %r8, %r7;
             rtop @p0, %r6;
       @p0 ? ldi %r6, #0x2d;
       @p0 ? st %r6, %r8, #0;
       @p0 ? neg %r7, %r7;
printdec_l1: modi %r6, %r7, #10;
             divi %r7, %r7, #10;
             addi %r6, %r6, #0x30;
             st   %r6, %r9, digstack;
             addi %r9, %r9, __WORD;
             rtop @p0, %r7;
       @p0 ? jmpi printdec_l1;
printdec_l2: subi %r9, %r9, __WORD;
             ld %r6, %r9, digstack;
             st %r6, %r8, #0;
             rtop @p0, %r9;
       @p0 ? jmpi printdec_l2;
             ldi %r6, #0x0a;
             st %r6, %r8, #0;
             jmpr %r5

.global
puts:        ldi %r8, #1;
             shli %r8, %r8, (__WORD*8 - 1);

puts_l:      ld   %r6, %r7, #0;
             andi %r6, %r6, #0xff;
             rtop @p0, %r6;
             notp @p0, @p0;
       @p0 ? jmpi puts_end;
             st %r6, %r8, #0;
             addi %r7, %r7, #1;
             jmpi puts_l;
puts_end:    jmpr %r5

.perm rw
.word digstack 0
.word 9