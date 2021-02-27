.data
.balign 4
        format: .asciz "%[^ ]"
.balign 4
        string: .asciz "I read the word: %s\n"
.balign
        prompt: .asciz "Hey, give me a word\n"

storage: .space 80

.text

.global main
.global printf
.global scanf
main:

        ldr r0, addr_prompt     /*loading address of prompt message in r0*/
        bl printf
        ldr r0, addr_format     /*loading first parameter of scanf*/
        ldr r1, addr_storage
        bl scanf

        ldr r1, addr_storage
        ldr r0, addr_string
        bl printf

        mov r0, #0
        mov r7, #1
        swi 0

addr_prompt: .word prompt
addr_format: .word format
addr_string: .word string
addr_storage: .word storage                         
