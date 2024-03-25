.model small
.stack 100h

.data
array DW 3, 2, 6, 4, 1
count DW 5

.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, word ptr count
    dec cx  ; count-1

outerLoop:
    push cx
    lea si, array

innerLoop:
    mov ax, [si]
    cmp ax, [si+2]
    jl nextStep
    xchg [si+2], ax
    mov [si], ax

nextStep:
    add si, 2
    loop innerLoop

    pop cx
    loop outerLoop

    mov ax, 4c00h
    int 21h
main endp
end main
