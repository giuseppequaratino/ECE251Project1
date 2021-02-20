/* -- sum.S */
.data
string:
.asciz "abcdefghijklmnop"

.text
.global main

main:
	mov r10, #0  		 /* initialize index register */
	ldr r1, =string		/* load address of char[0] in r1 */
	ldrb r0, [r1]     /* loads char[1] into r0 */ 
	cmp r0, #0
	beq end
	add r10, r10, #1

loop:
	ldrb r0, [r1, #+1]     /* loads char[1] into r0 */ 
	add r1, r1, #1 
	cmp r0, #0 
	beq end
	cmp r10, #12
	beq end
	add r10, r10, #1
	b loop 

end: 
	mov r0, r10	
	bx lr
