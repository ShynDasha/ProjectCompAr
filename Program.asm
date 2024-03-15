section .data
    inputBuffer resb 256     ; Буфер для зберігання введення
    numbers       dd 10000 dup(0)   ; Масив для зберігання десяткових чисел
    count         dd 0         ; Кількість зчитаних чисел

section .text
    extern read_input
    extern convert_to_binary
    extern bubble_sort
    extern calculate_median
    extern calculate_average

global _start
_start:
    ; Зчитування введення зі стандартного вводу
    mov rsi, inputBuffer   ;  буфер для зберігання введення
    call read_input         ;  для зчитування вводу