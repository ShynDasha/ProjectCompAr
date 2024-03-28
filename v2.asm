.model small
.stack 100h

.data
oneChar db 0              ; змінна для зберігання символу
numbersArray dw 10000 dup(?) ; масив чисел
powerCounter dw 0         ; лічильник ступеня десятки
inputValue dw 0           ; буфер для зберігання числа
arrayIndex dw 0           ; індекс для масиву
digitCount db 0           ; лічильник цифр
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
        call calculateMedian
        call calculateAverage
       
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
        jz skip  ; перехід, якщо символ дорівнює нулю

        mov inputValue, ax 

        mov ah, 02h        
        mov dl, oneChar
        int 21h

        cmp oneChar, '-'    ; перевірка, чи символ є мінусом
        jne checkSpecialCharacters
        mov isNegative, 1   ; позначення числа як від'ємного
        jmp inputStart

    checkSpecialCharacters:
        cmp oneChar, 0ah   
        je popCharacters   
        cmp oneChar, 0dh   
        je popCharacters    
        cmp oneChar, 20h    
        je popCharacters    

        mov spaceCount, 0   ; обнулення лічильника пробілів

        push dx             ; збереження символу у стеку
        inc digitCount      ; інкремент лічильника цифр
        jmp endInput        ; перехід до завершення вводу

    skip:
        jmp popCharacters   ; перехід до обробки символів

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
        jmp calculationSrart ;перехід до обчислення суми

    popLoopFirst:
        mov cl, digitCount  ; завантаження лічильника цифр у регістр cl
        xor ax, ax         ; обнулення ax
        xor dx, dx         ; обнулення dx

    popLoop:
        pop ax             ; вилучення символу зі стеку
        sub ax, '0'        ; перетворення символу на відповідну цифру

        push cx          
        push dx            ; збереження значення dx у стеку
        call powerOfTen    
        pop dx             
        pop cx             ; відновлення лічильника циклу із стеку

        add dx, ax         ; додавання числа до суми

        inc powerCounter   
        loop popLoop       ; повторення циклу для кожної введеної цифри

    popLoopEnd:
        mov digitCount, 0  
        mov powerCounter, 0 

        call floor         
        cmp isNegative, 1  
        jne calculateSum 
        neg dx             

    calculateSum:
        call addToArray    ; виклик процедури додавання до масиву

        mov sumHigh, 0     
        add sumLow, dx     ; додавання до нижнього слова суми
        adc sumHigh, 0     ; додавання переносу до верхнього слова суми

        mov dx, 0          
        mov isNegative, 0  

        jmp endInput       

    ret
input endp


  
        
bubbleSort proc 
    call clearRegisters   ; очищення регістрів
    mov cx, word ptr wordCount  ; завантаження кількості слів
    dec cx            

    outerLoop:
        push cx           ; збереження cx у стеку
        lea si, numbersArray ; завантаження 'numbersArray' у регістр si

        innerLoop:
            mov ax, [si]      ; завантаження значення з пам'яті, на яку вказує si
            cmp ax, [si+2]   ; порівняння з наступним елементом
            jl nextStep      ; перехід до наступного кроку, якщо значення менше
            xchg [si+2], ax  ; обмін значень
            mov [si], ax    
        nextStep:
            add si, 2        ; збільшення si для переходу до наступного елементу
            loop innerLoop   ; повторення циклу

        pop cx                ; відновлення cx зі стеку
        loop outerLoop        ; повторення  циклу

    ret
bubbleSort endp

 clearRegisters proc ;обнулення регістрів
       xor ax,ax
       xor bx, bx
       xor cx, cx 
       xor dx, dx
       xor si, si 
       ret
clearRegisters endp

calculation proc 
    calculationSrart:
        mov ah, 02h        ; виведення символу
        mov dl, "r"
        int 21h            ; виклик DOS
        ret                ; повер
calculation endp 


calculateMedian proc
    call clearRegisters    ; Очищення регістрів

    mov bx, wordCount      ; Завантаження кількості слів в регістр bx
    mov ax, bx
    and ax, 1              ; Перевірка на парність кількості слів
    jz evenAmount          ;  якщо кількість парна
    jnz oddAmount          ;  якщо кількість непарна

  evenAmount:
    shr bx, 1              ; Зменшення кількості слів удвічі
    lea si, numbersArray   ; масиву 'numbersArray' в регістр si

    mov dx, [si+bx]      ; Завантаження значення з середини масиву
    add dx, [si+bx-2]    ; Додавання до нього попереднього значення

    jmp medianEnd          

  oddAmount:
    shr bx, 1              ; Зменшення кількості слів на одиницю
    inc bx                 ; Збільшення кількості слів на одиницю
    lea si, numbersArray   ; 'numbersArray' в регістр si

    mov dx, [si+bx]      ; Завантаження значення з середини масиву

  medianEnd:
    add dx, '0'          ; Перетворення числа у символьне представлення
    mov ah, 02h            ; Виведення символу
    int 21h                ; Виклик DOS

    ret
calculateMedian endp


calculateAverage proc
    call clearRegisters    ; Очищення регістрів

       mov dx, sumHigh        ; Завантаження верхнього слова суми у регістр dx
       mov ax, sumLow         ; Завантаження нижнього слова суми у регістр ax
       mov bx, wordCount      ; Завантаження кількості слів у регістр bx

       cwd                     ; Знакове розширення ax , convert byte to word
       idiv bx                 ; Ділення на bx (кількість слів)
       mov dx, ax              ; Переміщення результату ділення у dx

       add dx, '0'            ; Перетворення числа у символьне представлення
       mov ah, 02h             ; Виведення символу
       int 21h                 ; Виклик DOS

       ret
 calculateAverage endp

    mov ax, 4c00h      ; DOS exit function
    int 21h            ; Exit program
end main

