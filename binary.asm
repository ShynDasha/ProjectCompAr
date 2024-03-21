.model small

.data
MESSAGE DB "A NUMBER: $"
MESSAGE1 DB 10, 13, "Binary number is $"
.code
.startup 

mov ah, 09h
mov dx, offset MESSAGE
int 21h

mov bl, 0

mov ah, 01h
int 21h
mov bl, al

mov ah, 09h 
mov dx,  offset MESSAGE1
int 21h

mov cl, 8 
loopOver:
mov ah, 02h
shl bl, 1 
jc printOne
mov dl, 48
jmp justPrint
printOne:
mov dl, 49
justPrint:
int 21h
loop loopOver

mov ah, 4ch
int 21h

END
.exit
