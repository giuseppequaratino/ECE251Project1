/* -- printf01.S */
.data

/* First message */
.balign 4
scanf_msg: .asciz "Hey, type a number: "

/* Second message */
.balign 4
printf_msg: .asciz "I read the number %d\n"

/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%d"

/* Where scanf will store the number read */
.balign 4
number_read: .word 0

.balign 4
return: .word 0

.text
.global main
main:
	ldr r1, address_of_return 
	str lr, [r1] /* store link register to exit out of main later. lr ==> address of function after main */

	ldr r0, address_of_scanf_msg /* r0 is the first argument of printf */ 
	bl printf /* updates lr the next instruction, and it jumps to the label */

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read
	bl scanf

	ldr r0, address_of_printf_msg
	ldr r1, address_of_number_read
	ldr r1, [r1]
	bl printf

	ldr r0, address_of_number_read
	ldr r0, [r0]

	ldr lr, address_of_return
	ldr lr,[lr]
	bx lr

address_of_printf_msg: .word printf_msg
address_of_scanf_msg: .word scanf_msg
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_return: .word return


/* External */
.global printf
.global scanf
