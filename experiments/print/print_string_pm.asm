[bits 32]

%define VIDEO_MEMORY 0xb8000
%define WHITE_ON_BLACK 0x0f

print_string_pm:

; ebx stores the null terminated string
    pusha
    mov edx, VIDEO_MEMORY

    .loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK
    cmp al, 0
    JE .break

    mov [edx], ax

    inc ebx ; inc string pointer
    inc edx ; increase vid mem pointer
    inc edx
    JMP .loop

.break:
    popa
    ret
