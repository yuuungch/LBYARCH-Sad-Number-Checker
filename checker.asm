; Harold, Mojica | Yung Cheng, Adrian | S15
%include "io64.inc"

section .data

inputSadNumber db "Enter a sad number: ", 0

sadNumber db 0

currentSadNumber db 0
currentIteration db 0

inputChoices db "[1] Y [0] N", 0
inputContinue db "Do you want to continue? (1/0): ", 0
continue db 0

printNegative db "Error: negative number detected", 0

printInvalid db "Error: Invalid input", 0

section .text
global main
main:
    ; Get Sad Number
    PRINT_STRING inputSadNumber
    GET_DEC 8, sadNumber
    PRINT_DEC 8, [sadNumber]
    NEWLINE
    ; Check if number is negative
    cmp qword [sadNumber], 0
    jl negative_input
    ; Check if number is an integer or not
    ; TODO: Implement invalid_input
    ; jmp invalid_input

    ; If input is valid
    mov rbx, 1 ; serves as counter. Max of 20 iterations
    mov rax, [sadNumber] ; move Number
    mov qword [currentIteration], 0
    jmp for_loop
    
for_loop:
    ; Check if iterations is greater than 20
    cmp rbx, 20
    jge not_sad
    
    PRINT_STRING "Counter: "
    PRINT_DEC 8, rbx
    NEWLINE
    ; else if currentInteration is 1
    cmp qword [currentIteration], 1
    je sad

    ; Else
    cmp rax, 0
    jne while_loop

    mov rax, [currentIteration]
    mov qword [currentIteration], 0
    

while_loop:
    mov rcx, 10
    mov rdx, 0
    div rcx
    PRINT_STRING "Current Quotient: "
    PRINT_DEC 8, rax
    NEWLINE
    PRINT_STRING "Current Remainder: "
    PRINT_DEC 8, rdx
    NEWLINE
    ; Square Remainder
    imul rdx, rdx
    PRINT_STRING "Current Remainder Squared: "
    PRINT_DEC 8, rdx
    NEWLINE
    add [currentIteration], rdx
    PRINT_STRING "Current Digit Squared Sum: "
    PRINT_DEC 8, [currentIteration]
    NEWLINE
    cmp rax, 0
    jne while_loop
    jmp end_of_while
    
end_of_while:
    inc rbx ; increment counter
    jmp for_loop
    

not_sad:
    PRINT_STRING "Number is not a sad number"
    jmp prompt
    
sad:
    PRINT_STRING "Number is a sad number"
    jmp prompt

prompt:
    ; Ask user if they want to continue
    PRINT_STRING inputChoices
    NEWLINE
    PRINT_STRING inputContinue
    GET_DEC 8, continue
    PRINT_DEC 8, [continue]
    NEWLINE
    mov rax, [continue]
    cmp rax, 1
    je main

    xor rax, rax
    ret

negative_input:
    PRINT_STRING printNegative
    NEWLINE
    jmp main

invalid_input:
    PRINT_STRING printInvalid
    NEWLINE
    jmp main