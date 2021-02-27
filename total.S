.data
string_1:
.asciz ""

string_2:

.asciz ""

.text
.global main

main:
	mov r10, #0  		 /* initialize index register */
	ldr r1, =string_1		/* load address of char[0] in r1 */
	ldrb r0, [r1]     /* loads char[1] into r0 */ 
	cmp r0, #0
	beq second
	add r10, r10, #1

loop:
	ldrb r0, [r1, #+1]     /* loads char[1] into r0 */ 
	add r1, r1, #1 
	cmp r0, #0 
	beq second
	cmp r10, #12
	beq error
	add r10, r10, #1
	b loop 

second:
	mov r11, #0
	ldr r2, =string_2
	ldrb r3, [r2]
	cmp r3, #0
	beq end
	add r11, r11, #1

loop2:
	ldrb r3, [r2, #+1]
	add r2, r2, #1
	cmp r3, #0
	beq end
	cmp r11, #12
	beq error
	add r11, r11, #1
	b loop2

error:
	mov r0, #7
	bx lr

end:
	add r0, r11, r10
	bx lr