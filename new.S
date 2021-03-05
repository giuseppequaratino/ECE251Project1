/* -- printf01.S */
.data

/* First message */
.balign 4
scanf_msg: .asciz "Hey, type a number: "


.balign 4
printf_msg: .asciz "I read the number: %s\n"

/* Format pattern for scanf */
.balign 4
scan_pattern: .asciz "%[0-9a-zA-Z ]"

.balign 4
scan_pattern2: .asciz "%[0-9a-zA-Z ]"

/* Where scanf will store the number read */
.balign 4
number_read: .space 16

.balign 4
number_read2: .space 16

.text
.global main
.global printf
.global scanf

main: 

	ldr r0, address_of_scanf_msg /* r0 is the first argument of printf */ 
	bl printf /* updates lr the next instruction, and it jumps to the label */

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_number_read
	bl scanf

	ldr r0, address_of_printf_msg
	ldr r1, address_of_number_read
	bl printf

	mov r10, #0
	ldr r1, = number_read
	ldrb r0, [r1]
	cmp r0, #0
	beq second_message
	add r10, r10, #1
	
loop:
	ldrb r0, [r1, #+1]
	add r1, r1, #1
	cmp r0, #0
	beq second_message
	cmp r10, #13
	beq error
	add r10, r10, #1
	b loop


second_message:

        ldr r0, address_of_scanf_msg /* r0 is the first argument of printf */
        bl printf /* updates lr the next instruction, and it jumps to the label */

        ldr r0, address_of_scan_pattern2
        ldr r1, address_of_number_read2
        bl scanf

        ldr r0, address_of_printf_msg
        ldr r1, address_of_number_read2
        bl printf

	mov r5, #0
        ldr r1, = number_read2
	ldrb r2, [r1]
        cmp r2, #0
        beq end
        add r5, r5, #1
	
loop2:
	ldrb r2, [r1, #+1]
	add r1, r1, #1
	cmp r2, #0
	beq end
	cmp r5, #13
	beq error
	add r5, r5, #1
	b loop2



error:
	mov r0, #7
        mov r7, #1
        swi 0

end:
	add r0, r10, r5
	mov r7, #1
	swi 0

address_of_printf_msg: .word printf_msg
address_of_scanf_msg: .word scanf_msg
address_of_scan_pattern: .word scan_pattern
address_of_scan_pattern2: .word scan_pattern2
address_of_number_read: .word number_read
address_of_number_read2: .word number_read2
