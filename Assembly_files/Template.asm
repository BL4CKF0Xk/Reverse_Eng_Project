; Program Name: template.s 
; Author: Charles Kann 
; Date: 9/19/2020 
; Purpose: This program is template that can be used to start ARM assembly 
; program using gcc 

; Include data of the program
section .data
        text db "Hello World!", 10       ; 10 means New Line 

; Executable part of program
section .text 
        global _start                    ; Telling to start at _start label
 
_start:
    ; Enter your program here.
    mov rax, 1                           ; Syscall number for sys_write
    mov rdi, 1                           ; File descriptor 1 (stdout)
    mov rsi, text                        ; Address of the data
    mov rdx, 15                          ; Length of data
    syscall  
    
    ; Return to the OS 
    mov rax, 60                          ; Syscall number for sys_exit
    mov rdi, 0                           ; exit status (normal) [can be also done with "xor rdi, rdi"
    syscall 

