.data
.balign 4
        format: .asciz "%s"
.balign 4
        string: .asciz "I read the word: %s\n"
.balign 4 
	concat: .asciz "Concatenated string: %s%s\n"
.balign 4
        prompt: .asciz "Hey, give me a word\n"
.balign 4
        storage_str1: .space 16
.balign 4 
	storage_str2: .space 16
.balign 4
	return: .word 0

.text
.global main
.global printf
.global scanf
main:
	
	ldr r1, addr_return
	str lr, [r1]	
	mov r10, #0       /* initialize index register */

        ldr r0, addr_prompt     /*loading address of prompt message in r0*/
        bl printf
        ldr r0, addr_format     /*loading first parameter of scanf*/
        ldr r1, addr_storage_str1
        bl scanf

        ldr r0, addr_prompt     /*loading address of prompt message in r0*/
        bl printf
        ldr r0, addr_format     /*loading first parameter of scanf*/
        ldr r1, addr_storage_str2
        bl scanf

	ldr r1, addr_storage_str1
	ldrb r0, [r1]
	cmp r0, #0
	beq print
	add r10, r10, #1

loop:
	ldrb r0, [r1, #+1]
	add r1, r1, #1
	cmp r0, #0
	beq print
	cmp r10, #12
	beq end
	add r10, r10, #1
	b loop
	 
print:

	ldr r0, addr_string
	ldr r1, addr_storage_str1
	bl printf

	ldr r0, addr_string
	ldr r1, addr_storage_str2
	bl printf

        ldr r0, addr_concat
        ldr r1, addr_storage_str1
	ldr r2, addr_storage_str2
        bl printf

end:
        mov r0, r10

	ldr lr, addr_return
	ldr lr, [lr]
        bx lr

addr_prompt: .word prompt
addr_format: .word format
addr_string: .word string
addr_concat: .word concat
addr_storage_str1: .word storage_str1
addr_storage_str2: .word storage_str2
addr_return: .word return
