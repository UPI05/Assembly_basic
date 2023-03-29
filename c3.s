.section .data
	ipstr:
		.string "Enter a number (1-digit): "
	output:
		.string "Count 4x: "
	cnt:
		.int 0

.section .text
	.globl _start
_start:
	# Xuất ra dòng chữ "Enter a number (1-digit): "
	mov $4, %eax
	mov $1, %ebx
	mov $ipstr, %ecx
	mov $26, %edx
	int $0x80

	# Đọc giá trị của a
	mov $3, %eax
	mov $0, %ebx
	mov $a, %ecx
	mov $2, %edx	
	int $0x80

	# Chuyển đổi từ dạng ascii sang số để thực hiện tính toán
	subb $48, a

	# Thực hiện chia a cho 4
	mov $0, %edx
	mov a, %eax
	mov $4, %ecx
	div %ecx

	# Kiểm tra nếu chia hết thì tăng biến cnt lên 1, ngược lại đọc tiếp giá trị b
	cmpl $0, %edx
	jne Exit1
	
	addl $1, cnt

	Exit1:
	
	# Xuất ra dòng chữ "Enter a number (1-digit): "
	mov $4, %eax
	mov $1, %ebx
	mov $ipstr, %ecx
	mov $26, %edx
	int $0x80

	# Đọc giá trị của b
	mov $3, %eax
	mov $0, %ebx
	mov $b, %ecx
	mov $2, %edx	
	int $0x80

	# Chuyển đổi từ dạng ascii sang số để thực hiện tính toán
	subb $48, b

	# Thực hiện chia b cho 4
	mov $0, %edx
	mov b, %eax
	mov $4, %ecx
	div %ecx

	# Kiểm tra nếu chia hết thì tăng biến cnt lên 1, ngược lại đọc tiếp giá trị c
	cmpl $0, %edx
	jne Exit2
	
	addl $1, cnt
	
	Exit2:
	
	# Xuất ra dòng chữ "Enter a number (1-digit): "
	mov $4, %eax
	mov $1, %ebx
	mov $ipstr, %ecx
	mov $26, %edx
	int $0x80

	# Đọc giá trị của c
	mov $3, %eax
	mov $0, %ebx
	mov $c, %ecx
	mov $2, %edx	
	int $0x80

	# Chuyển đổi từ dạng ascii sang số để thực hiện tính toán
	subb $48, c

	# Thực hiện chia c cho 4
	mov $0, %edx
	mov c, %eax
	mov $4, %ecx
	div %ecx

	# Kiểm tra nếu chia hết thì tăng biến cnt lên 1, ngược lại đọc tiếp giá trị d
	cmpl $0, %edx
	jne Exit3
	
	addl $1, cnt
	
	Exit3:
	
	# Xuất ra dòng chữ "Enter a number (1-digit): "
	mov $4, %eax
	mov $1, %ebx
	mov $ipstr, %ecx
	mov $26, %edx
	int $0x80

	# Đọc giá trị của d
	mov $3, %eax
	mov $0, %ebx
	mov $d, %ecx
	mov $2, %edx	
	int $0x80

	# Chuyển đổi từ dạng ascii sang số để thực hiện tính toán
	subb $48, d

	# Thực hiện chia d cho 4
	mov $0, %edx
	mov d, %eax
	mov $4, %ecx
	div %ecx

	# Kiểm tra nếu chia hết thì tăng biến cnt lên 1, ngược lại đọc tiếp giá trị e
	cmpl $0, %edx
	jne Exit4
	
	addl $1, cnt
	
	Exit4:
	
	# Xuất ra dòng chữ "Enter a number (1-digit): "
	mov $4, %eax
	mov $1, %ebx
	mov $ipstr, %ecx
	mov $26, %edx
	int $0x80

	# Đọc giá trị của e
	mov $3, %eax
	mov $0, %ebx
	mov $e, %ecx
	mov $2, %edx	
	int $0x80

	# Chuyển đổi từ dạng ascii sang số để thực hiện tính toán
	subb $48, e

	# Thực hiện chia e cho 4
	mov $0, %edx
	mov e, %eax
	mov $4, %ecx
	div %ecx

	# Kiểm tra nếu chia hết thì tăng biến cnt lên 1, ngược lại xuất ra biến cnt và kết thúc
	cmpl $0, %edx
	jne Exit5
	
	addl $1, cnt
	
	Exit5:
	
	mov $4, %eax
	mov $1, %ebx
	mov $output, %ecx
	mov $10, %edx
	int $0x80

	# Chuyển đổi cnt sang ascii để in
	addl $48, cnt

	# Xuất ra vùng nhớ cnt là số lượng bội của 4 tìm được
	mov $4, %eax
	mov $1, %ebx
	mov $cnt, %ecx
	mov $4, %edx
	int $0x80

	Exit:
	mov $1, %eax
	int $0x80


.section .bss
	.lcomm a, 1
	.lcomm b, 1
	.lcomm c, 1
	.lcomm d, 1
	.lcomm e, 1
