.section .data
	inputstr:
		.string "Enter a grade (0-100): "
	a:
		.int 0
	xuatSac:
		.string "Xuat sac"
	gioi:
		.string "Gioi"
	dat:
		.string "Dat"
	khongDat:
		.string "Khong dat"	

.section .text
	.globl _start
_start:
	# Ý tưởng: Vì mặc định nhập từ 0-100 (không cần kiểm tra định dạng input có đúng hay không). Nên nếu kí tự thứ hai là 0xA (line feed) thì số nhập vào có 1 chữ số, nếu kí tự thứ ba là line feed thì kí tự nhập vào có hai chữ số, ngược lại ta xem kí tự nhập vào có 1 chữ số.

	# Xuất dòng chữ "Enter a grade (0-100): "
	mov $4, %eax
	mov $1, %ebx
	mov $inputstr, %ecx
	mov $23, %edx
	int $0x80

	# Đọc giá trị input
	mov $3, %eax
	mov $0, %ebx
	mov $input, %ecx
	mov $4, %edx
	int $0x80

	# Kiểm tra kí tự thứ hai có phải line feed không
	mov $input, %eax
	add $1, %eax
	
	cmpb $10, (%eax) 	
	jne Label1
	
	# Là line feed thì số nhập vào có một chữ số, nên chỉ cần gán a bằng chữ số đó	
	sub $1, %eax
	mov (%eax), %bh 
	movl $0, tmp
	mov %bh, tmp
	mov tmp, %eax
	sub $48, %eax
	add %eax, a

	jmp Main

	Label1:

	# Tiếp tục kiểm tra kí tự thứ ba có phải line feed không

	mov $input, %eax
	add $2, %eax

	cmpb $10, (%eax)
	jne Label2

	# Là line feed nên số nhập vào là số có hai chữ số. Do đó gán a = chữ số đầu tiên * 10 + chữ số thứ hai

	sub $2, %eax
	mov (%eax), %bh 
	movl $0, tmp
	mov %bh, tmp
	mov tmp, %eax
	sub $48, %eax
	add %eax, a
	mov a, %eax
	imul $10, %eax 
	mov %eax, a

	mov $input, %eax
	add $1, %eax
	mov (%eax), %bh 
	movl $0, tmp
	mov %bh, tmp
	mov tmp, %eax
	sub $48, %eax
	add %eax, a

	jmp Main

	Label2:
	
	# Nếu kí tự thứ hai và ba đều không phải là line feed thì nó là số có ba chữ số. Hay là số 100.
	movl $100, a 	

	Main:

	# Đến đây tiến hành so sánh a để xuất các kết quả "Xuất sắc", "Giỏi", "Đạt", "Không đạt"	

	cmpl $90, a
	jl Label3
	
	mov $4, %eax
	mov $1, %ebx
	mov $xuatSac, %ecx
	mov $8, %edx
	int $0x80
	
	jmp Exit		
	
	Label3:

	cmpl $80, a
	jl Label4

	mov $4, %eax
	mov $1, %ebx
	mov $gioi, %ecx
	mov $4, %edx
	int $0x80
	
	jmp Exit

	Label4:

	cmpl $55, a
	jl Label5
	
	mov $4, %eax
	mov $1, %ebx
	mov $dat, %ecx
	mov $3, %edx
	int $0x80

	jmp Exit

	Label5:

	mov $4, %eax
	mov $1, %ebx
	mov $khongDat, %ecx
	mov $9, %edx
	int $0x80

	Exit:
	mov $1, %eax
	int $0x80

.section .bss
	.lcomm input, 3
	.lcomm tmp, 4
