disk_load:
    push dx
    ; read certain length of code from 0x8000 into RAM
    ; each sector is of 512B sector 0 is boot loader at 0x7C00, sector 1 is the rest of the 512B and usable space starts at 0x8000ie sector 2
    mov cl, 0x02 ; each sec
    mov ch, 0x00 ; cylinder number (first cylinder)
    ;mov dl, xxx ; drive number is auto filled upon reset in dl
    mov al, dh ; n of sectors to read
    mov ah, 0x02 ; read disk sectors from drive into memory. 
    mov dh, 0x00 ; head number (first head)
    ;mov bx; address of the available user space
    int 0x13

    jc disk_error ; jump if error

    pop dx
    cmp dh, al ; if al != dh, not all sectors read
    jne disk_error
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG db "Disk read err", 0
