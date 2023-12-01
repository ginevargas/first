; VARGAS, REGINE B. BSCS-3A
; BASIC ASSEMBLY INSTRUCTION PART2

section .data 
    ; Prompt for the program
    prompt db 'This program computes for the average of 3 two-digit numbers (00-55).', 0xA, 0x0

	first_num db 'Enter the first number: ', 0xA, 0x0       ; Prompt for entering the first number
    input_firstNum db '%d', 0
    second_num db 'Enter the second number: ', 0xA, 0x0     ; Prompt for entering the second number
    input_secondNum db '%d', 0
    third_num db 'Enter the second number: ', 0xA, 0x0      ; Prompt for entering the third number
    input_thirdNum db '%d', 0

    avg db 'Average is: %d', 0xA, 0x0       ; Message to display the average
    rem db 'With remainder: %d', 0xA, 0x0    ; Message to display the remainder

    firstnum times 4 db 0   ; Initialize variables to store user inputs
    secondnum times 4 db 0
    thirdnum times 4 db 0
    newline db 0xA, 0x0     ; Define a newline character

section .bss
    sum resb 4  ; Variable to store the sum

section .text 
    global _main
    extern _printf
    extern _scanf

_main:
    ; Display the initial program prompt
    push prompt
    call _printf
    add esp, 4

    ; Display a newline
    push newline
    call _printf
    add esp, 4

    ; Display a prompt for the first number
    push first_num
    call _printf
    add esp, 4

    ; Read the first_num input
    push firstnum
    push input_firstNum
    call _scanf
    add esp, 8

    ; Display a prompt for the second number
    push second_num
    call _printf
    add esp, 4

    ; Read the second_num input
    push secondnum
    push input_secondNum
    call _scanf
    add esp, 8

    ; Display a prompt for the third number
    push third_num
    call _printf
    add esp, 4

    ; Read the third_num input
    push thirdnum
    push input_thirdNum
    call _scanf
    add esp, 8

    ; Calculate the sum of the three numbers
    mov eax, dword [firstnum]
    add eax, dword [secondnum]
    add eax, dword [thirdnum]
    mov [sum], eax

    ; Divide the sum by 3
    mov ebx, 3
    mov edx, 0
    div ebx

    ; Display the calculated average
    push eax
    push avg
    call _printf
    add esp, 8

    ; Calculate the remainder
    mov eax, dword [firstnum]
    add eax, dword [secondnum]
    add eax, dword [thirdnum]
    mov edx, 0
    div ebx

    ; Display the remainder
    push edx
    push rem
    call _printf
    add esp, 8

    ret     ; Return from the main function