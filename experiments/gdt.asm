gdt_start:

gdt_null: ; null desc
    dd 0x0
    dd 0x0

gdt_code:
    ; segment 1
    dw 0xffff ; limit
    dw 0x0 ; base

    ;segment 2
    db 0x0 ; base
    db 10011010b
    ; 1 for code, since this is a code segment
    ; Conforming: 0, by not corming it means code in a segment with a lower privilege may not call code in this segment - this a key to memory protection
    ; Readable: 1, 1 if readible, 0 if execute-only. Readible allows us to read constants defined in the code.
    ; Accessed: 0 This is often used for debugging and virtual memory techniques, since the CPU sets the bit when it accesses the segment
    db 11001111b
    ; Granularity: 1, if set, this multiplies our limit by 4 K (i.e. 16*16*16), so our 0xfffff would become 0xfffff000 (i.e. shift 3 hex digits to the left), allowing our segment to span 4 Gb of memory
    ; 32-bit default: 1, since our segment will hold 32-bit code, otherwise we’d use 0 for 16-bit code. This actually sets the default data unit size for operations (e.g. push 0x4 would expand to a 32-bit number ,etc.)
    ; 64-bit code segment: 0, unused on 32-bit processor
    ; AVL: 0, We can set this for our own uses (e.g. debugging) but we will not use it
    db 0x0 ;base

gdt_data:
    dw 0xffff ; limit
    dw 0x0 ; base

    ;segment 2
    db 0x0 ; base
    db 10010010b
    ; 0 for code, since this is a data segment
    ; Expand down: 0 . This allows the segment to expand down -
    ; Writable: 1. This allows the data segment to be written to, otherwise it would be read only
    ; Accessed: 0 This is often used for debugging and virtual memory techniques, since the CPU sets the bit when it accesses the segment
    db 11001111b
    ; Granularity: 1, if set, this multiplies our limit by 4 K (i.e. 16*16*16), so our 0xfffff would become 0xfffff000 (i.e. shift 3 hex digits to the left), allowing our segment to span 4 Gb of memory
    ; 32-bit default: 1, since our segment will hold 32-bit code, otherwise we’d use 0 for 16-bit code. This actually sets the default data unit size for operations (e.g. push 0x4 would expand to a 32-bit number ,etc.)
    ; 64-bit code segment: 0, unused on 32-bit processor
    ; AVL: 0, We can set this for our own uses (e.g. debugging) but we will not use it
    db 0x0 ;base

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; ; Size of our GDT , always less one ??
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
