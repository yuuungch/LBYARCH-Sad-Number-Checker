; Harold, Mojica | Yung Cheng, Adrian | S15
%include "io64.inc"

section .data

inputSadNumberPrompt dq "Enter a sad number: ", 0

inputContinuePrompt dq "Do you want to continue? (Y/N): ", 0

printIterations dq "Iterations: ", 0

printNegative dq "Error: negative number input", 0

printInvalid dq "Error: Invalid input", 0

printTerminate dq "Enter any key to exit...", 0


charEnterBurner dq 0
invalid dq 0
continue dq 0
sadNumber dq 0
previousSadNumber dq 0
currentIteration dq 0

section .text
global main
main:
    ; Get Sad Number
    call reset_variables
    PRINT_STRING inputSadNumberPrompt
    GET_DEC 8, [sadNumber]
    GET_CHAR charEnterBurner
    ; Check if number is negative
    cmp qword [sadNumber], 0
    jl negative_input
    ; Check if number is an integer or not
    cmp qword [charEnterBurner], 0xA
    jne invalid_input
    
    ; If current sad number is same as previous
    mov rax, [previousSadNumber]
    cmp qword [sadNumber], rax
    je invalid_input

    ; If input is valid
    
    ; PRINT_DEC 8, [sadNumber]
    NEWLINE
    mov rbx, 1 ; serves as counter. Max of 20 iterations
    mov rax, [sadNumber] ; move Number
    mov [previousSadNumber], rax
    mov qword [currentIteration], 0
    PRINT_STRING printIterations
    PRINT_DEC 8, rax
    PRINT_STRING ", "
    jmp for_loop
    
for_loop:
    ; Check if iterations is greater than 20
    cmp rbx, 20
    jge sad
    
    ; PRINT_STRING "Counter: "
    ; PRINT_DEC 8, rbx
    ; NEWLINE
    
    ; Else if currentInteration is 1
    cmp qword [currentIteration], 1
    je not_sad

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
    PRINT_DEC 8, [currentIteration]
    cmp qword [currentIteration], 1
    jne print_comma

    inc rbx ; increment counter
    jmp for_loop

print_comma:
    inc rbx ; increment counter
    cmp rbx, 20
    je for_loop

    PRINT_STRING ", "
    jmp for_loop
    

not_sad:
    NEWLINE
    PRINT_STRING "Sad Number: No"
    NEWLINE
    call reset_variables
    jmp prompt
    
sad:
    NEWLINE
    PRINT_STRING "Sad Number: Yes"
    NEWLINE
    call reset_variables
    jmp prompt

prompt:
    ; Ask user if they want to continue
    call reset_variables
    PRINT_STRING inputContinuePrompt
    GET_CHAR [continue]
    ; Check if next character is a newline
    cmp qword [continue], 0x0A
    je burn_newline
    jmp prompt_continue
    
burn_newline:
    GET_CHAR [continue]
    jmp prompt_continue
    
prompt_continue:
    call reset_variables
    
    ; PRINT_CHAR [continue]
    NEWLINE
    ; Check if input is valid (only Y or N)
    cmp qword [continue], 'Y'
    je main
    cmp qword [continue], 'N'
    je end_program
    
    ; If input is invalid
    jmp invalid_input_choice

end_program: 
    GET_CHAR [charEnterBurner]
    PRINT_STRING printTerminate
    GET_CHAR [charEnterBurner]
    xor rax, rax
    ret

negative_input:
    ; PRINT_DEC 8, [sadNumber]
    NEWLINE
    PRINT_STRING printNegative
    NEWLINE
    jmp prompt
    
invalid_input:
    ; PRINT_CHAR charEnterBurner
    burn_characters:
        GET_CHAR [invalid]
        ; PRINT_CHAR [invalid]
        
        cmp qword [invalid], 0xA
        jne burn_characters
    NEWLINE
    PRINT_STRING printInvalid
    NEWLINE
    jmp prompt

reset_variables:
    mov qword [sadNumber], 0
    mov rax, 0
    ret
    

invalid_input_choice:
    PRINT_STRING printInvalid
    NEWLINE
    jmp prompt