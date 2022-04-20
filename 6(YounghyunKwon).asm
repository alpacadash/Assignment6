TITLE Boolean Calculator (6(YounghyunKwon).asm)
;a program that functions as a simple Boolean calculator for 32-bit integers

; Younghyun Kwon
INCLUDE Irvine32.inc

.DATA

	calc BYTE "-----------------", 0dh, 0ah
		BYTE "Boolean Caculator", 0dh, 0ah
		BYTE "-----------------", 0

	menuMsg BYTE "1. x AND y", 0dh, 0ah
		 BYTE "2. x OR y", 0dh, 0ah
		 BYTE "3. NOT x", 0dh, 0ah
		 BYTE "4. x XOR y", 0dh, 0ah
		 BYTE "5. Exit the program", 0dh, 0ah
		 BYTE 0dh, 0ah
		 BYTE "Enter the number: ", 0

	first BYTE "Enter the first 32-bit integer: ", 0
	second BYTE "Enter the second 32-bit integer: ", 0
	result BYTE "The result is ", 0
	CaseTable BYTE '1'								;lookup value
		DWORD Process_AND							;address of procedure
		EntrySize = ($ - caseTable)					;size of entries
		BYTE '2'
		DWORD Process_OR
		BYTE '3'
		DWORD Process_NOT
		BYTE '4'
		DWORD Process_XOR
		BYTE '5'
		DWORD exitProgram

	NumberOfEntries = ($ - CaseTable) / EntrySize	;find a number of entries by size of entries

.CODE
main	PROC
	
	call Clrscr				;clear the console
	mov edx, OFFSET calc	;move the address of the name of calculator into edx
	call WriteString		;display the name of calculator
MenuLoop:
	
	call Crlf				;end line
	call Menu				;call Menu procedure
	call Crlf				;end line

	jmp MenuLoop			;go back to L1

main	ENDP

Menu	PROC				;Menu Procedure
	
	mov edx, OFFSET menuMsg	;move the address of the menuMsg into edx
	call WriteString		;display the menuMsg
L1:
	call ReadChar			;read input from user
	cmp al, '5'				;compare input and 5
	ja L1					;jump if above 5, go back to L1
	cmp al, '1'				;compare input and 1
	jb L1					;jump if below 1, go back to L1
	mov edx, eax			;move the user input into edx
	call WriteChar			;display the user input
	call Crlf				;end line

	call Crlf				;end line
	call Selection			;call Selection Procedure
	
	ret						;return from procedure

Menu	ENDP

Selection PROC					;Selection Procedure

	push ebx					;save ebx onto stack
	push ecx					;save ecx onto stack
	mov ebx, OFFSET CaseTable	;point ebx to the case table
	mov ecx, NumberOfEntries	;loop counter
	
L1:	cmp al, [ebx]				;match found?
	jne L2						;no: continue
	call NEAR PTR [ebx + 1]		;yes: call the procedure
	jmp L3						;and exit the loop

L2: add ebx, EntrySize			;point to the next entry
	loop L1						;repeat until ecx = 0

L3: pop ebx						;restore ebx
	pop ecx						;restore ecx

	ret							;return from procedure

Selection ENDP

Process_AND PROC				;AND Procedure

	pushad						;push all registers onto stack
	mov edx, OFFSET first		;move address of first into edx
	call WriteString			;display first
	call ReadDec				;read first integer from user
	mov ebx, eax				;move first integer to ebx

	mov edx, OFFSET second		;move address of second into edx
	call WriteString			;display second
	call ReadDec				;read second integer from user
	call Crlf					;end line

	and eax, ebx				;AND instruction

	mov edx, OFFSET result		;move address of result into edx
	call WriteString			;display result
	call WriteDec				;display the output of AND instruction

	popad						;restore all registers from stack
	ret							;return from procedure

Process_AND ENDP

Process_OR PROC					;OR Procedure

	pushad						;push all registers onto stack
	mov edx, OFFSET first		;move address of first into edx
	call WriteString			;display first
	call ReadDec				;read first integer from user
	mov ebx, eax				;move first integer to ebx

	mov edx, OFFSET second		;move address of second into edx
	call WriteString			;display second
	call ReadDec				;read second integer from user
	call Crlf					;end line

	or eax, ebx					;OR instruction

	mov edx, OFFSET result		;move address of result into edx
	call WriteString			;display result
	call WriteDec				;display the output of OR instruction

	popad						;restore all registers from stack
	ret							;return from procedure

Process_OR ENDP

Process_NOT PROC				;NOT Procedure

	pushad						;push all registers onto stack
	mov edx, OFFSET first		;move address of first into edx
	call WriteString			;display first
	call ReadDec				;read first integer from user
	call Crlf					;end line

	not eax						;NOT instruction

	mov edx, OFFSET result		;move address of result into edx
	call WriteString			;display result
	call WriteDec				;display the output of NOT instruction

	popad						;restore all registers from stack
	ret							;return from procedure

Process_NOT ENDP

Process_XOR PROC				;XOR Procedure

	pushad						;push all registers onto stack
	mov edx, OFFSET first		;move address of first into edx
	call WriteString			;display first
	call ReadDec				;read first integer from user
	mov ebx, eax				;move first integer to ebx

	mov edx, OFFSET second		;move address of second into edx
	call WriteString			;display second
	call ReadDec				;read second integer from user
	call Crlf					;end line

	xor eax, ebx				;XOR instruction

	mov edx, OFFSET result		;move address of result into edx
	call WriteString			;display result
	call WriteDec				;display the output of XOR instruction

	popad						;restore all registers from stack
	ret							;return from procedure

Process_XOR ENDP

exitProgram PROC				;exitProgram Procedure

	exit						;terminate the program
	ret							;return from procedure

exitProgram ENDP

		END		main
