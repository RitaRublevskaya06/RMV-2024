.586P
.model flat, stdcall
includelib libucrt.lib
includelib kernel32.lib
includelib ..\Debug\Library.lib
ExitProcess PROTO :DWORD

EXTRN CONCAT: proc
EXTRN LINELEN: proc
EXTRN RANDOM: proc
EXTRN SQRT: proc
EXTRN OutNumber: proc
EXTRN OutLine: proc
EXTRN OutBool: proc
EXTRN OutNumberLn: proc
EXTRN OutLineLn: proc
EXTRN OutBoolLn: proc

.stack 4096

.const
	null_division BYTE "Exception: ������� �� ����", 0
	lit1	SWORD 2
	lit2	SWORD 0
	lit3	SWORD 1
	lit4	BYTE "����� ������ ��������� �������!", 0
	lit5	BYTE "��� ����� �����: ", 0
	lit6	BYTE "7 � ������� 3 = ", 0
	lit7	SWORD 7
	lit8	SWORD 3
	lit9	BYTE "��������� ���������� ��������� �������������? - ", 0
	lit10	SWORD -10
	lit11	BYTE "��������� ���: ", 0
	lit12	BYTE "Petrov Peter", 0
	lit13	BYTE "��� ������ (� $): ", 0
	lit14	SWORD 10
	lit15	SWORD 100
	lit16	SWORD 5
	lit17	BYTE "���������� ������ �� 16 ����� 3? - ", 0
	lit18	SWORD 16
	lit19	BYTE "��", 0
	lit20	BYTE "���", 0
	lit21	BYTE "����� ������ ����� 0? - ", 0
	lit22	BYTE "abcdef", 0
	lit23	BYTE "Hello, ", 0
	lit24	BYTE "this is the language of the RMV-2024!", 0

.data
	buffer BYTE 256 dup(0)
	power_i	SWORD 0
	power_res	SWORD 0
	program_resPow	SWORD 0
	program_expr	SWORD 0
	program_resNeg	SWORD 0
	program_login	DWORD ?
	program_balance	SWORD 0
	program_resSqrt	SWORD 0
	program_lineA	DWORD ?
	program_lengthA	SWORD 0
	program_resA	SWORD 0
	program_resConcat	DWORD ?

.code

power PROC power_a : SWORD, power_b : SWORD
	push lit1
	pop power_i
	push power_a
	pop power_res
	mov ax, power_b
	cmp ax, lit2
	je m0
	jne m1
m0:
	push 1
	jmp local0
m1:
	mov ax, power_i
	cmp ax, power_b
	jle cycle0
	jmp cyclenext0
cycle0:
	push power_res
	push power_a
	pop ax
	pop bx
	mul bx
	push ax
	pop power_res
	push power_i
	push lit3
	pop ax
	pop bx
	add ax, bx
	push ax
	pop power_i
	mov ax, power_i
	cmp ax, power_b
	jle cycle0
cyclenext0:
	push power_res
	jmp local0
local0:
	pop eax
	ret
power ENDP

yourLogin PROC yourLogin_login : DWORD
	push offset lit4
	call OutLineLn
	push offset lit5
	call OutLine
	push yourLogin_login
	call OutLineLn
local1:
	pop eax
	ret
	ret
yourLogin ENDP

program PROC
	push offset lit6
	call OutLine
	push lit7
	push lit8
	pop dx
	pop dx
	movsx eax, lit8
	push eax
	movsx eax, lit7
	push eax
	call power
	push ax
	pop program_resPow
	movsx eax, program_resPow
	push eax
	call OutNumberLn
	push offset lit9
	call OutLine
	push lit10
	push lit1
	pop bx
	pop ax
	cmp bx, 0
	je nulldiv
	cwd
	idiv bx
	push ax
	push lit7
	push lit1
	pop bx
	pop ax
	cmp bx, 0
	je nulldiv
	cwd
	idiv bx
	push dx
	pop bx
	pop ax
	sub ax, bx
	push ax
	pop program_expr
	push program_expr
	push lit2
	pop bx
	pop ax
	cmp ax, bx
	jle l0
	jg l1
l0:
	mov ax, 1
	push ax
	jmp endofexpr0
l1:
	mov ax, 0
	push ax

endofexpr0:
	pop ax
	cmp ax, 0
	je l2
	jne l3
l2:
	mov ax, 0
	push ax
	jmp endofexpr1
l3:
	mov ax, 1
	push ax

endofexpr1:
	pop program_resNeg
	movsx eax, program_resNeg
	push eax
	call OutBoolLn
	push offset lit11
	call OutLine
	movsx eax, program_expr
	push eax
	call OutNumberLn
	push offset lit12
	pop program_login
	push program_login
	call yourLogin
	push offset lit13
	call OutLine
	push lit14
	push lit15
	pop dx
	pop dx
	movsx eax, lit15
	push eax
	movsx eax, lit14
	push eax
	call RANDOM
	push ax
	push lit16
	pop ax
	pop bx
	add ax, bx
	push ax
	pop program_balance
	movsx eax, program_balance
	push eax
	call OutNumberLn
	push offset lit17
	call OutLine
	push lit18
	pop dx
	movsx eax, lit18
	push eax
	call SQRT
	push ax
	pop program_resSqrt
	mov ax, program_resSqrt
	cmp ax, lit8
	je m2
	jne m3
m2:
	push offset lit19
	call OutLineLn
	jmp e0
m3:
	push offset lit20
	call OutLineLn
e0:
	push offset lit21
	call OutLine
	push offset lit22
	pop program_lineA
	push program_lineA
	pop dx
	push program_lineA
	call LINELEN
	push ax
	pop program_lengthA
	push program_lengthA
	push lit2
	pop bx
	pop ax
	cmp ax, bx
	jne l4
	je l5
l4:
	mov ax, 1
	push ax
	jmp endofexpr2
l5:
	mov ax, 0
	push ax

endofexpr2:
	pop ax
	cmp ax, 0
	je l6
	jne l7
l6:
	mov ax, 0
	push ax
	jmp endofexpr3
l7:
	mov ax, 1
	push ax

endofexpr3:
	pop program_resA
	mov ax, program_resA
	cmp ax, 0
	jnz m4
	jz m5
m4:
	push offset lit20
	call OutLineLn
	jmp e1
m5:
	push offset lit19
	call OutLineLn
e1:
	push offset lit23
	push offset lit24
	pop dx
	pop dx
	push offset lit24
	push offset lit23
	push offset buffer
	call CONCAT
	push eax
	pop program_resConcat
	push program_resConcat
	call OutLineLn
theend:
	push 0
	call ExitProcess
nulldiv:
	push offset null_division
	call OutLineLn
	push -1
	call ExitProcess
program ENDP
end program