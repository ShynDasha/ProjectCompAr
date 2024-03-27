.model small
.stack 100h

.data
oneChar db 0 
numbers dw 10 dup(2)
arrayIndex dw 0
countt db 0
power dw 0
inputBuffer dw 0
separate db 0
valueNegative db 0
sumL dw 0
sumH dw 0
сWords dw 0
   
.code
    main proc 
        mov ax, @data
        mov ds, ax 
        
        ; call methods
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
        
    powerOfTen endp

    input proc
       inputStart:
         mov ah,3Fh
         mov bx, 0h 
         mov cx, 1
         mov dx, offset oneChar
         int 21h

         or ax,ax
         jz skip

         mov inputBuffer, ax

         mov ah, 02h
         mov dl, oneChar
         int 21h

         cmp oneChar, '-'
         jne sCheck
         mov valueNegative, 1
         jmp inputStart

      sCheck:
         cmp oneChar, 0ah
         je popCharacters 
         cmp oneChar, 0dh
         je popCharacters 
         cmp oneChar, 20h
         je popCharacters 

         mov separate, 0

         push dx
         inc countt
         jmp inputEnd

      skip:
         jmp popCharacters

      inputEnd:
         mov ax, inputBuffer
         or ax, ax
         jnz inputStart

         cmp countt, 0
         jne progJump ; pcJump
         jmp calculationSrart
        
      progJump:
         jmp popCharacters

      popCharacters:
         inc separate
         cmp separate, 2 
         jne popLoopFirst ; popLoopStart
         jmp calculationSrart

      popLoopFirst:
         mov cl, countt
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

         inc power

         loop popLoop

       popLoopEnd:
         mov countt, 0
         mov power, 0

         call floor
         cmp valueNegative, 1
         jne sum
         neg dx

      sum:
        call addToArray
         
         mov sumH, 0
         add sumL, dx 
         adc sumH, 0

         mov dx, 0
         mov valueNegative, 0

         jmp inputEnd
         

    input endp

    floor proc
      cmp dx, 32767
      jno endFloor
      mov dx, 32767

      endFloor:
      
         
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
    bubbleSort endp

    clearRegist proc 
       xor ax,ax
       xor bx, bx
       xor cx, cx 
       xor dx, dx
       xor si, si 
       
    clearRegist endp

    calculation proc 
      calculationSrart:
        mov ah, 02h
        mov dl, "g"
        int 21h 
        
    calculation endp 

    calculateMed proc
       call clearRegist

       mov bx, сWords
       mov ax, bx
       and ax, 1
       jz evenAmount
       jnz oddAmound

       evenAmount:
       shr bx, 1
       lea si, numbers

       mov dx, [si+bx]
       add dx, [si+bx-2]

       jmp medianEnd

       oddAmound:
       shr bx, 1
       inc bx
       lea si, numbers

       mov dx, [si+bx]

       medianEnd:
       add dx, "0"
       mov ah, 02h
       int 21h

      
    calculateMed endp

    calculateAv proc
       call clearRegist

       mov dx, sumH
       mov ax, sumL
       mov bx, сWords

      cwd 
      idiv bx
      mov dx, ax
      
      add dx, "0"
      mov ah, 02h
      int 21h
     
    calculateAv endp
  
    mov ax, 4c00h      ; DOS exit function
    int 21h            ; Exit program
   end main

