;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Program Name: Pushing value to stack
; Author: bl4ckf0xk
; Date: 01/05/2024
; Purpose: Count the input in assembly programming
; program using nasm and ld
;------------------------------------------------------------------------------------------------------------------------------------------------------


section .data
    prompt db "Enter the text: ", 0
    prompt_len equ $ - prompt

    prompt_2 db "Count is: ", 0
    prompt_2_len equ $ - prompt_2

section .bss
    buffer resb 256           ; Reserve 256 bytes for input buffer.
    count_str resb 12         ; Reserve 12 bytes for the count string.

section .text
    global _start

_start:
    ; Print the prompt
    mov rax, 1                ; sys_write
    mov rdi, 1                ; stdout
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Read input from stdin
    mov rax, 0                ; sys_read
    mov rdi, 0                ; stdin
    mov rsi, buffer
    mov rdx, 256
    syscall

    ; Check if last character is newline, if yes, subtract one
    mov rdi, rax              ; Number of bytes read
    cmp byte [buffer + rdi - 1], 0x0A
    je decrement
    jmp continue_count
decrement:
    dec rdi
continue_count:
    mov r12, rdi              ; Store the adjusted length

    ; Convert the length to string
    mov rdi, count_str        ; Pointer to buffer for string
    mov rsi, r12              ; The count
    call int_to_string

    ; Print the "Count" prompt
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_2
    mov rdx, prompt_2_len
    syscall

    ; Print the converted string
    mov rax, 1                ; sys_write
    mov rdi, 1                ; stdout
    mov rsi, count_str
    mov rdx, r13              ; Length of the string
    syscall

    ; Exit the program
    mov rax, 60               ; sys_exit
    xor rdi, rdi
    syscall

; Converts an integer in RSI to a string at RDI
int_to_string:
    mov rax, rsi              ; Move the integer to RAX for division
    mov rcx, 10               ; Divider (base 10)
    lea rbx, [rdi + 11]       ; Point RBX to the end of the target buffer
    mov byte [rbx], 0         ; Null-terminate the string
    sub rbx, 1                ; Move back one byte

.convert_loop:
    xor rdx, rdx              ; Clear RDX before division
    div rcx                   ; RAX / 10, result in RAX, remainder in RDX
    add dl, '0'               ; Convert remainder to ASCII
    mov [rbx], dl             ; Store ASCII character
    dec rbx                   ; Move back one byte
    test rax, rax             ; Check if quotient is zero
    jnz .convert_loop         ; Continue if not zero

    mov rdi, rbx              ; Start of number string
    inc rdi                   ; Adjust RDI to point to the first digit
    mov rsi, rdi              ; Prepare RSI for return
    lea r13, [rdi + 11]       ; Calculate the length of the string
    sub r13, rsi
    ret

