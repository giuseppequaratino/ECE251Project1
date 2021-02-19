/* -- sum.S */
.data
string:
.asciz "l0d"

.text
.global main

main:
	ldr r1, =string	/* r1 <- 3 */
	ldrb r0, [r1, #+1]	
	bx lr		
