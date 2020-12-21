SYS_WRITE equ 4
SYS_READ equ 3 
SYS_STDIN equ 0
SYS_STDOUT equ 1
SYS_EXIT equ 1
MEMO_SIZE equ 2 
section .text
	global _start
_start:
	; This program retusn the sum of two digits in which the sum is less then 10

	mov eax, SYS_WRITE
	mov ebx, SYS_STDOUT 
	mov ecx, msg1
	mov edx, msg1Len
	int 0x80 

	mov eax, SYS_READ 
	mov ebx, SYS_STDIN 
	mov ecx, numA 
	mov edx, MEMO_SIZE 
	int 0x80

	mov eax, SYS_WRITE 
	mov ebx, SYS_STDOUT 
	mov ecx, msg2
	mov edx, msg2Len
	int 0x80 

	mov eax, SYS_READ 
	mov ebx, SYS_STDIN 
	mov ecx, numB
	mov edx, MEMO_SIZE	
	int 0x80

	call calc

	mov eax, SYS_WRITE 
	mov ebx, SYS_STDOUT 
	mov ecx, msg3
	mov edx, msg3Len
	int 0x80
	
	mov ecx, sum 
	mov eax, SYS_WRITE 
	mov ebx, SYS_STDOUT 
	mov edx, MEMO_SIZE 
	int 0x80

	mov eax, '1'
	sub eax, '0' 
	int 0x80
calc:
	mov eax, [numA]
	sub eax, '0'
	mov ebx, [numB]
	sub ebx, '0'
	add eax, ebx
	add eax, '0'
	mov dword [sum], eax
	ret
section .bss
	numA resb MEMO_SIZE 
	numB resb MEMO_SIZE 
	sum resb MEMO_SIZE 
section .data
	msg1 db 'Type the first digit:', 0xa 
	msg1Len equ $ - msg1
	msg2 db 'Type the second one:', 0xa
	msg2Len equ $ - msg2
	msg3 db 'The sum of two digits:', 0xa
	msg3Len equ $ - msg3
