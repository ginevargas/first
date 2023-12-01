; CS 318 – Architecture and Organization
; Vargas, Regine B. BSCS-3A

; Structured Assembly Language Part1    
; This is an Assembly program to add, subtract, multiply and divide 2 signed two-digit numbers.

section .data
    ; Prompt for the program
    promptMsg db 'Hi! This is Gine and I am here to help you perform operations for 2 signed two-digit numbers (-99 to 99).', 10, 0
    promptBy db '==== SIMPLE CALCULATOR by Gine ====', 10, 0
    promptExit db '[0] Exit', 10, 0
    promptAdd db '[1] Add', 10, 0
    promptSub db '[2] Subtract', 10, 0
    promptMul db '[3] Multiply', 10, 0
    promptDiv db '[4] Divide', 10, 0  

    enterChoice db 'Enter choice: ', 0    ; User input formats
    input_choice db '%d', 0 

    prompt_add db '==== ADDITION ====', 10, 0      ; Operation-specific prompts
    prompt_sub db '==== SUBTRACTION ====', 10, 0
    prompt_multi db '==== MULTIPLICATION ====', 10, 0 
    prompt_divi db '==== DIVISION ====', 10, 0

    firstNum db 'Enter the first number: ', 0       ; User input prompts
	secondNum db 'Enter the second number: ', 0
    input_numbers db '%d', 0 

    ; Results and message
    sum db 'Sum: %d',10, 0 
    difference db 'Difference: %d',10, 0
    product db 'Product: %d',10, 0
    quotient db 'Quotient: %d',10, 0
    remainder db 'Remainder: %d',10, 0
    thank_you_msg db 'Thank you!', 10, 0

section .bss
    ; Buffer for user input
    choices resb 100
    firstnum resd 1
    secondnum resd 1

section .text 
    global _main
    extern _atoi
    extern _printf
    extern _scanf
    extern _exit

_main:
    ; Display the introduction message
    push promptMsg       
    call _printf
    add esp, 4

.choice_loop:       ;the program loops
    ; Display the program name and options
    push promptBy
    call _printf
    add esp, 4

    push promptExit
    call _printf
    add esp, 4

    push promptAdd
    call _printf
    add esp, 4

    push promptSub
    call _printf
    add esp, 4

    push promptMul
    call _printf
    add esp, 4

    push promptDiv
    call _printf
    add esp, 4

    ; Display the choice prompt
.enter_choice:
    push enterChoice
    call _printf
    add esp, 4

    ; Read the input choice
    push choices
    push input_choice
    call _scanf
    add esp, 8
    
    ; Check the input choice
    mov eax, [choices]
    cmp eax, 1                ; Add
    je .addition
    cmp eax, 2                ; Subtract
    je .subtraction
    cmp eax, 3                ; Multiply
    je .multiplication 
    cmp eax, 4                ; Divide
    je .division
    cmp eax, 0 ; Exit
    je .exit

    ; Invalid choice, display a message and loop again
    push invalid_choice_msg
    call _printf
    add esp, 4
    jmp .enter_choice    ; ask the user to "Enter choice:" again
    jmp .choice_loop 

.exit:      ; Display a thank-you message and exit the program
    push thank_you_msg
    call _printf
    add esp, 4
    call _exit

.addition:
    push prompt_add     ; Display the addition prompt
    call _printf
    add esp, 4

    .read_first_num_addition:   ; Prompt the user for the first number
        push firstNum
        call _printf
        add esp, 4
        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, -99
        jl .invalid_first_num_addition
        cmp eax, 99
        jg .invalid_first_num_addition

    .read_second_num_addition:   ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4
        push secondnum
        push input_numbers
        call _scanf
        add esp, 8
        
        ; Check if the second number is within the valid range
        mov eax, [secondnum]
        cmp eax, -99
        jl .invalid_second_num_addition
        cmp eax, 99
        jg .invalid_second_num_addition

    ; Perform addition
    mov eax, [firstnum]
    add eax, [secondnum]
    push eax
    push sum
    call _printf
    add esp, 8
    jmp .choice_loop

.subtraction:
    push prompt_sub
    call _printf
    add esp, 4

    .read_first_num_subtraction:    ; Prompt the user for the first number
        push firstNum
        call _printf
        add esp, 4
        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, -99
        jl .invalid_first_num_subtraction
        cmp eax, 99
        jg .invalid_first_num_subtraction

    .read_second_num_subtraction:     ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4
        push secondnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the second number is within the valid range
        mov eax, [secondnum]
        cmp eax, -99
        jl .invalid_second_num_subtraction
        cmp eax, 99
        jg .invalid_second_num_subtraction

    ; Perform subtraction
    mov eax, [firstnum]
    sub eax, [secondnum]
    push eax
    push difference
    call _printf
    add esp, 8
    jmp .choice_loop

.multiplication:
    push prompt_multi
    call _printf
    add esp, 4

    .read_first_num_multiplication:     ; Prompt the user for the first number   
        push firstNum
        call _printf
        add esp, 4
        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, -99
        jl .invalid_first_num_multiplication
        cmp eax, 99
        jg .invalid_first_num_multiplication
    
    .read_second_num_multiplication:    ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4
        push secondnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the second number is within the valid range
        mov eax, [secondnum]
        cmp eax, -99
        jl .invalid_second_num_multiplication
        cmp eax, 99
        jg .invalid_second_num_multiplication

    ; Perform multiplication
    mov eax, [firstnum]      
    imul eax, [secondnum]
    push eax
    push product
    call _printf
    add esp, 8
    jmp .choice_loop

.division:
    push prompt_divi
    call _printf
    add esp, 4

    .read_first_num_division:   ; Prompt the user for the first number
        push firstNum
        call _printf
        add esp, 4
        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, -99
        jl .invalid_first_num_division
        cmp eax, 99
        jg .invalid_first_num_division

    .read_second_num_division:    ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4
        push secondnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the second number is within the valid range
        mov eax, [secondnum]
        cmp eax, -99
        jl .invalid_second_num_division
        cmp eax, 99
        jg .invalid_second_num_division

        mov eax, [secondnum]
        cmp eax, 0
        je .invalid_divisor

    ; Perform division
    mov eax, [firstnum]
    cdq  ; Sign-extend eax into edx
    mov ebx, [secondnum]
    idiv ebx

    ; Quotient
    push eax
    push quotient
    call _printf
    add esp, 8

    ; Calculate and display the remainder
    mov eax, dword [firstnum]
    add eax, dword [secondnum]
    mov edx, 0
    div ebx

    ; Remainder
    push edx
    push remainder
    call _printf
    add esp, 8
    jmp .choice_loop

.invalid_first_num_addition:       ; print error message for addition
	push prompt_invalid_input
	call _printf
	add	esp, 4
	jmp .read_first_num_addition

.invalid_second_num_addition:           
	push prompt_invalid_input
	call _printf
	add	esp, 4
	jmp .read_second_num_addition

.invalid_first_num_subtraction:    ; print error message for subtraction
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_first_num_subtraction

.invalid_second_num_subtraction:     
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_second_num_subtraction

.invalid_first_num_multiplication:    ; print error message for multiplication
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_first_num_multiplication

.invalid_second_num_multiplication: 
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_second_num_multiplication

.invalid_first_num_division:      ; print error message division
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_first_num_division

.invalid_second_num_division:       
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_second_num_division

.invalid_divisor:                ; print error message invalid divisor
    push prompt_invalid_divisor
    call _printf
    add esp, 4
    jmp .read_second_num_division

; Error prompts
invalid_choice_msg:
    db '-Entered Choice is not on the menu. Please enter a valid choice-', 10, 0
prompt_invalid_input:
	db '-Input should only be between -99 to 99. Please enter again a valid input-', 10, 0
prompt_invalid_divisor:
	db	'-You cannot divide by 0. Please enter a valid divisor-', 10, 0