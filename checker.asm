; Harold, Mojica | Yung Cheng, Adrian | S15
%include "io64.inc"

section .data

inputSadNumberPrompt dq "Enter a sad number: ", 0

inputContinuePrompt dq "Do you want to continue? (Y/N): ", 0

printNegative dq "Error: negative number detected", 0

printInvalid dq "Error: Invalid input", 0

charEnterHolder dq 0
continue dq 0
sadNumber dq 0
currentIteration dq 0

section .text
global main
main:
    ; Get Sad Number
    PRINT_STRING inputSadNumberPrompt
    GET_DEC 8, sadNumber
    PRINT_DEC 8, [sadNumber]
    NEWLINE
    ; Check if number is negative
    cmp qword [sadNumber], 0
    jl negative_input
    ; Check if number is an integer or not
    ; TODO: implement invalid input check

    ; If input is valid
    mov rbx, 1 ; serves as counter. Max of 20 iterations
    mov rax, [sadNumber] ; move Number
    mov qword [currentIteration], 0
    jmp for_loop
    
for_loop:
    ; Check if iterations is greater than 20
    cmp rbx, 20
    jge not_sad
    
    ; PRINT_STRING "Counter: "
    ; PRINT_DEC 8, rbx
    ; NEWLINE
    
    ; Else if currentInteration is 1
    cmp qword [currentIteration], 1
    je sad

    ; Else
    
    ; If Current Number is not 0
    cmp rax, 0
    jne while_loop

    ; Else
    mov rax, [currentIteration]
    mov qword [currentIteration], 0
    

while_loop:
    ; Divide, acquire quotient and remainder
    mov rcx, 10
    mov rdx, 0
    div rcx
    
    ; PRINT_STRING "Current Quotient: "
    ; PRINT_DEC 8, rax
    ; NEWLINE
    
    ; PRINT_STRING "Current Remainder: "
    ; PRINT_DEC 8, rdx
    ; NEWLINE
    
    ; Square Remainder
    imul rdx, rdx
    
    ; PRINT_STRING "Current Remainder Squared: "
    ; PRINT_DEC 8, rdx
    ; NEWLINE
    
    ; Add Squared Remainder to Current Number
    add [currentIteration], rdx
    
    ; PRINT_STRING "Current Digit Squared Sum: "
    ; PRINT_DEC 8, [currentIteration]
    ; NEWLINE
    
    cmp rax, 0
    jne while_loop
    jmp end_of_while
    
end_of_while:
    inc rbx ; increment counter
    jmp for_loop
    

not_sad:
    PRINT_STRING "Sad Number: No"
    NEWLINE
    jmp prompt
    
sad:
    PRINT_STRING "Sad Number: Yes"
    NEWLINE
    jmp prompt

prompt:
    ; Ask user if they want to continue
    PRINT_STRING inputContinuePrompt
    ; Store Enter key to charEnterHolder
    GET_CHAR charEnterHolder
    GET_CHAR continue
    PRINT_CHAR [continue]
    NEWLINE
    mov al, [continue]
    ; Check if input is valid (only Y or N)
    cmp al, 'Y'
    je main
    cmp al, 'N'
    je end_program
    
    ; If input is invalid
    jmp invalid_input_choice

end_program: 
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

invalid_input_choice:
    PRINT_STRING printInvalid
    NEWLINE
    jmp prompt