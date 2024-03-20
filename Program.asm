

.model small
.stack 100h

.data
    charArray db 1000 dup(0) 

.code
start PROC
    mov ax, @data
    mov ds, ax

  
    mov cx, 1000 
    lea bx, charArray 
    readChars:
        mov ah, 01h 
        int 21h 
        mov [bx], al 
        inc bx 
        loop readChars 


   
    mov cx, 1000
    lea bx, charArray 
    writeChars:
        mov dl, [bx] 
        mov ah, 02h 
        int 21h 
        inc bx 
        loop writeChars 

   
    mov ax, 4c00h 
    int 21h 
start ENDP

END start