.model small
.stack 100h

.data
ARY1 DB 4, 6, 7, 9, 2
SUM DB 

R DB (?)
Q DB (?)

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov si, offset (ARY1)
    mov cx, 5

    L1:
    mov dl, [si]
    add sum, dl
    inc si

    loop L1

    mov al, sum 
    mov ah, 0

    mov bl, 5
    div bl

    mov Q, al
    mov R, ah

  

    mov ax, 4c00h
    int 21h
main endp
end main
