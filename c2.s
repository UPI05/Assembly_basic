.section .data
	inform:
		.string "Enter a string (3 characters): "	
	output:
		.string "Result: "
	cnt:
		.int 0 

.section .text
	.globl _start

_start:
	# In ra dòng chữ "Enter a string (3 characters): "
	mov $4, %eax
	mov $1, %ebx
	mov $inform, %ecx
	mov $31, %edx 
	int $0x80

	# Đọc dữ liệu vào vùng nhớ input	
	mov $4, %edx
	mov $input, %ecx
	mov $3, %eax
	mov $0, %ebx
	int $0x80

	# In ra dòng chữ "Result: "
	mov $4, %eax
	mov $1, %ebx
	mov $output, %ecx
	mov $9, %edx
	int $0x80

	Start:
	# Copy ký tự ở vị trí cnt từ vùng nhớ input sang char để tính toán
	mov $input, %eax
	add cnt, %eax
	movb (%eax), %bl
	movb %bl, char

	# Nếu kí tự char nằm ngoài vùng [a, z] thì nhảy đến Label print để in, ngược lại thì thực hiện ép sang kí tự in hoa (char - 32)	
	cmpb $0x61, char
	jl Print 
	cmpb $0x7a, char
	jg Print	
	
	# Ép sang kí tự in hoa
	subb $32, char		

	Print:
	# In ra kí tự char
	mov $4, %eax
	mov $1, %ebx
	mov $char, %ecx
	mov $1, %edx
	int $0x80

	# Kiểm tra vị trí của cnt, nếu lớn hơn bằng 2 tức là đã duyệt hết 3 kí tự input nên sẽ thực hiện thoát. Ngược lại thì thì duyệt kí tự tiếp theo nên thực hiện tăng cnt lên 1 và nhảy lên label Start để lặp lại các bước trên với kí tự tiếp theo của vùng nhớ input	
	cmpl $2, cnt
	jge Exit	
	addl $1, cnt	
	jmp Start 

	Exit:
	mov $1, %eax
	int $0x80

.section .bss
	.lcomm input, 4 
	.lcomm char, 1
