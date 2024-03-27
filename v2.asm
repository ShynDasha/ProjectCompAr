.model small
.stack 100h

.data
power dw 0
iBuffer dw 0
isSpace db 0
isNegative db 0
sumL dw 0
sumH dw 0
totalWords dw 0
   
.code
    main proc 
        mov ax, @data
        mov dx, ax
        ; виклик методів
        call inputElem 
        call bubbleSort
        call calculateMed
        call calculateAv

    main endp

    addToArray proc

    addToArray endp

    powerOfTen ;description
    powerOfTen PROC
      
    powerOfTen ENDP

    inputElem proc
    
    inputElem endp
    
    bubbleSort proc
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


    bubbleSort endp

    calculateMed proc
    calculateMed endp

    calculateAv proc
    calculateAv endp

    


    


    end 
