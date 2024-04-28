;-------------------------------------------------------------------------------------------------------------------------------------------------------
; Program Name: Pushing value to stack
; Author: bl4ckf0xk
; Date: 28/04/2024
; Purpose: Testing how stack push playout in assembly programming
; program using nasm and ld
;------------------------------------------------------------------------------------------------------------------------------------------------------

section .text 
	global _start 
 
_start:
	; making the stack by setting base pointer at stack pointer
	mov rbp, rsp

	; moving chars to rax reg and then push it to stack ( if we do this mannualy we only can push 4, this way 8)
	mov rax, 'st.'
	push rax
	mov rax, 'Stack te'
	push rax
	mov rax, 'This is '
	push rax

	; sys_write call
	mov rax, 1		 ; sys_write 
	mov rdi, 1		 ; stdout
	lea rsi, [rbp-24]        ; pointing the exact point to first character in stack
	mov rdx, 20              ; lenght of value to be retrieved
    	syscall 

    	; Return to the OS 
    	mov rax, 60 
    	mov rdi, 0 
    	syscall 
