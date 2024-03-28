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
    lea bx, [numbersArray]  
    add bx, arrayIndex     
    mov [bx], dx             
    inc arrayIndex          
    inc arrayIndex          
    inc wordCount            
    ret                     
  addToArray endp

  powerOfTen proc
    powerOfTen: 
    mov cx, [powerCounter]   
    mov bx, 10              

    cmp cx, 0                 
    je endPowerOfTen         

    powerLoop:
    mul bx                    
    loop powerLoop            

    endPowerOfTen:
    ret                        
  powerOfTen endp

  floor proc
      cmp dx, 32767
      jno endFloor
      mov dx, 32767

      endFloor:
      ret
         
  floor endp

  input proc
    inputStart:
        mov ah, 3Fh          ; читання символу
        mov bx, 0h 
        mov cx, 1
        mov dx, offset oneChar
        int 21h

        or ax, ax
        jz skip

        mov inputValue, ax 

        mov ah, 02h        
        mov dl, oneChar
        int 21h

        cmp oneChar, '-'
        jne checkSpecialCharacters
        mov isNegative, 1   
        jmp inputStart

    checkSpecialCharacters:
        cmp oneChar, 0ah  
        je popCharacters 
        cmp oneChar, 0dh  
        je popCharacters 
        cmp oneChar, 20h   
        je popCharacters 

        mov spaceCount, 0   

        push dx              ; збереження символу у стеку
        inc digitCount     
        jmp endInput

    skip:
        jmp popCharacters

    endInput:
        mov ax, inputValue
        or ax, ax
        jnz inputStart      ; повторення вводу, якщо введений символ не дорівнює нулю

        cmp digitCount, 0  
        jne progJump        
        jmp calculationSrart

    progJump:
        jmp popCharacters

    popCharacters:
        inc spaceCount
        cmp spaceCount, 2   
        jne popLoopFirst   
        jmp calculationSrart

    popLoopFirst:
        mov cl, digitCount 
        xor ax, ax         
        xor dx, dx         

    popLoop:
        pop ax             
        sub ax, '0'        

        push cx           
        push dx            
        call powerOfTen    
        pop dx             
        pop cx            

        add dx, ax        

        inc powerCounter  
        loop popLoop      

    popLoopEnd:
        mov digitCount, 0   
        mov powerCounter, 0 ; обнулення лічильника ступеня десятки

        call floor          
        cmp isNegative, 1  
        jne calculateSum    
        neg dx            

    calculateSum:
        call addToArray   

        mov sumHigh, 0     
        add sumLow, dx      
        adc sumHigh, 0      

        mov dx, 0         
        mov isNegative, 0   

        jmp endInput        

        ret
    input endp

  
        
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

