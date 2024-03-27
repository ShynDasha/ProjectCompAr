.model small
.stack 100h

.data
ARY1 DB 10, 2, 0
SUM DB (?)

R DB (?) ; остачу
Q DB (?) ; цілу частину

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov si, offset (ARY1)
    mov cx, 3

    L1:
    mov dl, [si]
    add sum, dl
    inc si

    loop L1

    mov al, sum 
    mov ah, 0

    mov bl, 3
    div bl

    mov Q, al
    mov R, ah

    ; Display average
    mov ah, 02h        ; DOS display function
    mov dl, byte ptr [Q]    ; Load the average into dl
    add dl, '0'        ; Convert average to ASCII
    int 21h            ; Display the average

    mov ax, 4c00h      ; DOS exit function
    int 21h            ; Exit program
main endp
end main