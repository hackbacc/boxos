[org 0x7c00]

mov bp, 0x9000 ; set stack to free space, why manually?
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

    ; mov ebx, MSG_PROT_MODE
    ; call print_string_pm

call switch_to_pm
JMP $

; need to be defined in non cpu accessible area
%include "print_string.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

;[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
JMP $

MSG_REAL_MODE db "Started in 16 bit real mode", 0
MSG_PROT_MODE db "Started in 32 bit prot mode", 0
times 510-($-$$) db 0
dw 0xaa55
