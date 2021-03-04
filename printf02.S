/* -- printf01.S */
.data

/* First message */
.balign 32
scanf_msg: .asciz "Hey, type a string: "

/* Second message */
.balign 32
printf_msg: .asciz "I read the string %c\n"

/*Third message */
.balign 32
printf_msg2: .asciz "Concatenated String %c%c\n"

/* Format pattern for scanf */
.balign 32
scan_pattern: .asciz "%s"

/* Where scanf will store the number read */
.balign 32
number_read: .word 0

.balign 32
number_read2: .word 0

.balign 32
return: .word 0

.text
.global main
main:

	ldr r1, address_of_return 
	str lr, [r1] /* store link register to exit out of main later. lr ==> address of function after main */

first_string:

	ldr r0, address_of_scanf_msg /* r0 is the first argument of printf */ 
	bl printf /* updates lr the next instruction, and it jumps to the label */
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read
	bl scanf
	
	ldr r0, address_of_printf_msg
	ldr r1, address_of_number_read
	ldr r1, [r1]
	bl printf

	ldr r2, address_of_number_read /* stores str1[0] in r2 */

second_string:

	ldr r0, address_of_scanf_msg /* r0 is the first argument of printf */ 
	bl printf

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read2
	bl scanf	

	ldr r0, address_of_printf_msg  /* test case print nothing */
	ldr r1, address_of_number_read2 
	ldr r1, [r1]
	bl printf

	ldr r3, address_of_number_read2 /* stores str2[0] in r3 */

print:
	ldr r0, address_of_printf_msg2
	ldr r1, address_of_number_read
	ldr r2, address_of_number_read2
	ldr r1, [r1, #+1]
	ldr r2, [r2]
	bl printf

end:
	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr 	


address_of_printf_msg: .word printf_msg
address_of_printf_msg2: .word printf_msg2
address_of_scanf_msg: .word scanf_msg
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_number_read2: .word number_read2
address_of_return: .word return


/* External */
.global printf
.global scanf
