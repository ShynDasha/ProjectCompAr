.model small
.stack 100h

.data
oneChar db 0 ; змінна для зберігання символу
numbersArray dw 10 dup(2) ; масив чисел
powerCounter dw 0         ; лічильник ступеня десятки
inputValue dw 0           ; буфер для зберігання числа
arrayIndex dw 0           ; індекс для масиву
digitCount db 0           ; лічильник введених цифр
spaceCount db 0           ; лічильник пробілів
isNegative db 0           ; прапорець для визначення, чи від'ємне число введено
sumLow dw 0               ; нижнє слово для суми
sumHigh dw 0              ; верхнє слово для суми
wordCount dw 0            ; лічильник слів

   
.code
    main proc 
        mov ax, @data
        mov ds, ax 
        
        ;call methods
        call input
        call bubbleSort
        call calculateMed
        call calculateAv
    main endp

    addToArray proc
       lea bx, [numbers]
       add bx, arrayIndex
       mov [bx], dx
       inc arrayIndex
       inc arrayIndex
       inc сWords
       ret
    addToArray endp

    powerOfTen proc
        powerOfTen: 
        mov cx, [power]
        mov bx, 10

        cmp cx, 0
        je endPowerOfTen 

        powerLoop:
        mul bx
        loop powerLoop

        endPowerOfTen:
        ret 
    powerOfTen endp

    input proc
     
    input endp

    floor proc
      cmp dx, 32767
      jno endFloor
      mov dx, 32767

      endFloor:
      ret
         
    floor endp
        
    bubbleSort proc 
       call clearRegist
       mov cx, word ptr сWords
       dec cx  ; count-1

      outerLoop:
       push cx
       lea si, numbers

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

      ret
    bubbleSort endp

    clearRegist proc ;обнулення регістрів
       xor ax,ax
       xor bx, bx
       xor cx, cx 
       xor dx, dx
       xor si, si 
       ret
    clearRegist endp

    calculation proc 
     
    calculation endp 

    calculateMed proc
      
    calculateMed endp

    calculateAv proc
       
    calculateAv endp
    mov ax, 4c00h      ; DOS exit function
    int 21h            ; Exit program
   end main

