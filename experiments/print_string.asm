print_string:
    pusha

    .loop:
    mov al, [bx]
    mov ah, 0x0e
    cmp al, 0
    JE .break
    int 0x10
    inc bx

    JMP .loop

.break:
    popa
    ret
