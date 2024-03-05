; Harold, Mojica | Yung Cheng, Adrian | S15
%include "io64.inc"

section .data
inputChoices db "[1] Y [2] N", 0
inputContinue db "Do you want to continue? (Y/N): ", 0
continue db 0


section .text
global main
main: 

    ; Ask user if they want to continue
    PRINT_STRING inputChoices
    PRINT_STRING inputContinue
    GET_STRING Continue, 1
    NEWLINE
    mov rax, [Continue]
    cmp rax, 1
    je main

    xor rax, rax
    ret