.data

/* specifier only reads in 14 characters*/
/* doesn't read in the new line character */
.balign 4
	pattern: .asciz "%14[^\n]%*c"
.balign 4
	message: .asciz "Input a string that is at most 12 characters:\n"
	
/* program's output string. Gives concatenated string & total number of characters */
.balign 4
	output: .asciz "Here's the concatenated string:\n%s%s\nIt has %d characters.\n"

/* If scanf reads in more than 14 characters, program prints out these error messages */

/* for string1 */
.balign 4
	errorM1: .asciz "Error code 7: The string has more than 12 characters.\n"
	
/* for string2 */
.balign 4
	errorM2: .asciz "Error code 8: The string has more than 12 characters.\n"
	
/* allocates 16 bytes of memory for string1 and string2 */
.balign 4 
	string1: .space 16

.balign 4
	string2: .space 32

.balign 4
	return: .word 0

.text
.global main
.global printf
.global scanf

main:

/* loads contents of link register to return variable */
	ldr r1, =return
	str lr, [r1]

first:	

/* prompts user for first string and scans it in */
	ldr r0, =message
	bl printf

	ldr r0, addr_of_pattern
	ldr r1, addr_of_string1
	bl scanf

/* sets up loop to find string length */
/* r10 contains current index, r1 the address of the first character of string1, */
/* and r0, the first character of string */

	mov r10,#0
	ldr r1, addr_of_string1
	ldrb r0, [r1]
	
	/* if string is empty skip to second branch */
	cmp r0, #0
	beq second
	
	/* else set r10 to 1 */
	add r10, r10, #1

loop:
	/* checks to see if index > 13 */
	/* if it is give error */
	
	cmp r10, #13
	beq firsterror
	
	/* load next character onto r0 */
	ldrb r0, [r1, #+1]
	
	/* have r1 store address of next string*/
	add r1, r1, #1
	
	/* check to see if you have reached end of string */
	cmp r0, #0
	
	/* if so move on to second branch */
	beq second
	
	/* else increment index by 1 */
	add r10, r10, #1
	
	/* and continue */
	b loop

second:

/* essentially the same process as first branch */
/* except if string is 0 move to concatenation branch */

	ldr r0, =message
        bl printf

        ldr r0, addr_of_pattern
	ldr r1, addr_of_string2
        bl scanf

/* r11: index, r2: address of first char of string2, & r3 first char */

        mov r11, #0
	ldr r2, addr_of_string2
	ldrb r3, [r2]
	cmp r3, #0
	beq printConcat
	add r11, r11, #1

loop2:

/* if index is greater than 13 go to seconderror branch */
/* rest of loop2 branch is same as the loop branch */

	cmp r11, #13
        beq seconderror
        ldrb r3, [r2, #+1]
	add r2, r2, #1
	cmp r3, #0
	beq printConcat
        add r11, r11, #1
        b loop2

printConcat: 

/* load arguments for printing output variable */

/* r0 is the output variable itself */
	ldr r0, =output
	
/* r1 (string1) substitute for first specifier */
	ldr r1, =string1
	
/* r2(string2) for second specifier*/
	ldr r2, =string2

/* r3 (total length) for third */

	add r3,r10,r11
	mov r4, r3
	bl printf
/* stores combined length in r0 for error code */
	add r0, r10, r11
	b end

firsterror:

/* print out errorM1 message */
	ldr r0, addr_of_errorM1
	bl printf
/* store 7 in r0 for error code */

        mov r0, #7
        b end

seconderror:

/* print out errorM1 message */
        ldr r0, addr_of_errorM2
        bl printf
	
/* store 7 in r0 for error code */
        mov r0, #8
        b end

end:

/* restore link register */
	ldr lr, =return
	ldr lr, [lr]
	bx lr


addr_of_output: .word output
addr_of_message: .word message
addr_of_string1: .word string1
addr_of_string2: .word string2
addr_of_return: .word return
addr_of_errorM1: .word errorM1
addr_of_errorM2: .word errorM2
addr_of_pattern: .word pattern
