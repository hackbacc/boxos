[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000 ; set stack to free space, why manually?
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

    ; mov ebx, MSG_PROT_MODE
    ; call print_string_pm

call load_kernel
call switch_to_pm
JMP $

; need to be defined in non cpu accessible area
%include "print/print_string.asm"
%include "gdt.asm"
%include "print/print_string_pm.asm"
%include "switch_to_pm.asm"
%include "disk/disk_load.asm"

[bits 16]

load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret


[bits 32]

BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET
JMP $

MSG_REAL_MODE db "Started in 16 bit real mode\n", 0
MSG_PROT_MODE db "Started in 32 bit prot mode\n", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0
BOOT_DRIVE db 0x0

times 510-($-$$) db 0
dw 0xaa55
