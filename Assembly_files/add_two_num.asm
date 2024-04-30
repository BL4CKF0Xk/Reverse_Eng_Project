section .data
	enter_num db "Enter First Number: ", 0
	enter_num_len equ $ - enter_num

	enter_sec_num db "Enter Second Number: ", 0
	enter_sec_num_len equ $ - enter_sec_num

	buffer1 times 3 db 0
	buffer2 times 3 db 0
	result times 4 db 0

section .text
	global _start

;_add:
;	; Add two numbers
;	mov rax, qword [buffer1]
;	add rax, qword [buffer2]
;	mov qword [result], rax
;	ret	

_start:
	; Print the Enter Number Prompt
	mov rax, 1			; sys_write 
	mov rdi, 1			; stdout
	mov rsi, enter_num		; address of data
	mov rdx, enter_num_len		; length of data
	syscall

	; Get User Input
	mov rax, 0			; sys_read
	mov rdi, 0			; stdin
	mov rsi, buffer1		; address to write
	mov rdx, 2			; length
	syscall
	
	; Get Second Number
	mov rax, 1
	mov rdi, 1
	mov rsi, enter_sec_num
	mov rdx, enter_sec_num_len
	syscall

	; Get Second User Input
	mov rax, 0 
	mov rdi, 0
	mov rsi, buffer2
	mov rdx, 2
	syscall
	
	mov rax, [buffer1]
	sub rax, '0'
	mov rbx, [buffer2]
	sub rbx, '0'
	
	; Call _add func
	add rax, rbx
	add rax, '0'

	mov [result], rax

	; Print Result
	 ; Determine length of the result
    	;mov rcx, 0
;.next_digit:
    	;inc rcx
    	;cmp byte [result + rcx], 0
    	;jne .next_digit
    
    	mov rax, 1
	mov rdi, 1
	mov rsi, result
	mov rdx, 2
    	syscall

	; Exit
	mov rax, 60			; sys_exit
	xor rdi, rdi			; make rdi 0
	syscall
