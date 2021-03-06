.data

.balign 4
        pattern: .asciz "%[^\n]%*c"
.balign 4
        message: .asciz "Input a string that is at most 12 characters:\n"
.balign 4
        output: .asciz "Here's the concatenated string: %s%s\nIt has %d characters.\n"
.balign 4
        errorM1: .asciz "Error code 7: The string has more than 12 characters.\n"
.balign 4
        errorM2: .asciz "Error code 8: The string has more than 12 characters.\n"
.balign 4
        string1: .space 16
.balign 4
        string2: .space 16
.balign 4
        return: .word 0

.text
.global main
.global printf
.global scanf

main:
        ldr r1, =return
        str lr, [r1]

        ldr r0, =message
        bl printf

        ldr r0, addr_of_pattern
        ldr r1, addr_of_string1
        bl scanf


        mov r10,#0
        ldr r1, addr_of_string1
        ldrb r0, [r1]
        cmp r0, #0
        beq printConcat
        add r10, r10, #1
loop:
        cmp r10, #13
        beq firsterror
        ldrb r0, [r1, #+1]
        add r1, r1, #1
        cmp r0, #0
        beq second
        add r10, r10, #1
        b loop

second:
        ldr r0, =message
        bl printf

        ldr r0, addr_of_pattern
        ldr r1, addr_of_string2
        bl scanf

        mov r11, #0
        ldr r2, addr_of_string2
        ldrb r3, [r2]
        cmp r3, #0
        beq end
        add r11, r11, #1

loop2:
        cmp r11, #13
        beq seconderror
        ldrb r3, [r2, #+1]
        add r2, r2, #1
        cmp r3, #0
        beq printConcat
        add r11, r11, #1
        b loop2        

printConcat:
        ldr r0, =output
        ldr r1, =string1
        ldr r2, =string2
        add r3,r10,r11
        mov r4, r3
        bl printf
        mov r0, r3
        b end

firsterror:
        ldr r0, addr_of_errorM1
        bl printf
        mov r0, #7
        b end

seconderror:
        ldr r0, addr_of_errorM2
        bl printf
        mov r0, #8
        b end

end:
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
