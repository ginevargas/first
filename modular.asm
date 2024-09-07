section .data
    ; Prompt for the program
    promptMsg db 'Hi! This is Group 8 and we are here to help you determine the LCD and GCF for two-digit numbers (1 to 99).', 10, 0
    promptBy db '==== LCD and GCF CALCULATOR by Group 8 ====', 10, 0
    promptExit db '[0] Exit', 10, 0 
    promptLcd db '[1] LCD', 10, 0
    promptGcf db '[2] GCF', 10, 0

    enterChoice db 'Enter choice: ', 0    
    input_choice db '%d', 0 

    prompt_lcd db '==== LCD ====', 10, 0      ; Operation-specific prompts
    prompt_gcf db '==== GCF ====', 10, 0

    firstNum db 'Enter the first number: ', 0       ; User input prompts
    first_Num db "%d", 0

    secondNum db 'Enter the second number: ', 0
    second_Num db "%d", 0

    ; Results and messages
    result_lcd db 'LCD: %d', 10, 0 
    result_gcf db 'GCF: %d', 10, 0
    thank_you_msg db 'Thank you!', 10, 0

    prompt_invalid_input db 'Input should only be between 1 to 99. Please enter again a valid input.', 10, 0
    prompt_invalid_choice db 'Entered Choice is not on the menu. Please enter a valid choice.', 10, 0

section .bss
    ; Buffer for user input
    choices resb 100
    firstnum resd 1
    secondnum resd 1

section .text  
    global _main
    extern _printf, _scanf, _exit, _gcd, _lcm

_gcd:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]

.gcd_loop:
    cmp ebx, 0
    je .gcd_done

    xor edx, edx
    idiv ebx
    mov eax, ebx
    mov ebx, edx

    jmp .gcd_loop

.gcd_done:
    mov [ebp + 16], eax  ; Result (GCD)
    pop ebp
    ret

_lcm:
    ; Inputs:
    ;   [ebp + 8] - First number
    ;   [ebp + 12] - Second number
    ; Outputs:
    ;   eax - Result (LCM)

    push ebp
    mov ebp, esp

    ; Get the values from the stack
    mov eax, [ebp + 8]  ; First number
    mov ebx, [ebp + 12] ; Second number

    ; Calculate the GCD
    push eax
    push ebx
    call _gcd  ; Call a function to calculate the greatest common divisor (GCD)
    pop ebx
    pop eax

    ; Preserve the values of eax and ebx before the division
    push eax
    push ebx

    ; Calculate the LCM: (|First Number * Second Number|) / GCD
    imul eax, ebx  ; eax = First Number * Second Number

    ; Restore the preserved values of eax and ebx
    pop ebx
    pop ecx

    idiv ecx            ; Divide by GCD, result in eax

    ; Take the absolute value of the result
    test eax, eax      ; Check the sign bit
    jns .lcm_done      ; If it's not negative, skip the negation
    neg eax            ; Negate the result

.lcm_done:
    pop ebp
    ret





_main:
    ; Display the introduction message
    push promptMsg       
    call _printf
    add esp, 4

.choice_loop:
    ; Display the program name and options
    push promptBy
    call _printf
    add esp, 4

    push promptExit
    call _printf
    add esp, 4

    push promptLcd
    call _printf
    add esp, 4

    push promptGcf
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
    cmp eax, 1                ; LCD
    je .lcd
    cmp eax, 2                ; GCF
    je .gcf
    cmp eax, 0 ; Exit
    je .exit
    jmp .invalid_choice      ; Jump to invalid choice handling

.invalid_choice:
    ; Display the invalid choice message
    push prompt_invalid_choice
    call _printf
    add esp, 4
    jmp .choice_loop

.exit:
    ; Display a thank-you message and exit the program
    push thank_you_msg
    call _printf
    add esp, 4
    call _exit

.lcd:
    push prompt_lcd
    call _printf
    add esp, 4

    ; Prompt the user for the first number
.get_first_num_lcd:
    push firstNum
    call _printf
    add esp, 4
    push firstnum
    push first_Num
    call _scanf
    add esp, 8

    ; Check if the first number is within the valid range (1 to 99)
    mov eax, [firstnum]
    cmp eax, 1
    jl .invalid_first_num_lcd
    cmp eax, 99
    jg .invalid_first_num_lcd

    ; Prompt the user for the second number
.get_second_num_lcd:
    push secondNum
    call _printf
    add esp, 4
    push secondnum
    push second_Num
    call _scanf
    add esp, 8

    ; Check if the second number is within the valid range (1 to 99)
    mov eax, [secondnum]
    cmp eax, 1
    jl .invalid_second_num_lcd
    cmp eax, 99
    jg .invalid_second_num_lcd

    ; Call the LCD function with pass-by-value
    push dword [firstnum]
    push dword [secondnum]
    call _lcm  ; Call the function to calculate the LCD

    ; Display the result
    push eax
    push result_lcd
    call _printf
    add esp, 8
    jmp .choice_loop

.gcf:
    push prompt_gcf
    call _printf
    add esp, 4

    ; Prompt the user for the first number
.get_first_num_gcf:
    push firstNum
    call _printf
    add esp, 4
    push firstnum
    push first_Num
    call _scanf
    add esp, 8

    ; Check if the first number is within the valid range (1 to 99)
    mov eax, [firstnum]
    cmp eax, 1
    jl .invalid_first_num_gcf
    cmp eax, 99
    jg .invalid_first_num_gcf

    ; Prompt the user for the second number
.get_second_num_gcf:
    push secondNum
    call _printf
    add esp, 4
    push secondnum
    push second_Num
    call _scanf
    add esp, 8

    ; Check if the second number is within the valid range (1 to 99)
    mov eax, [secondnum]
    cmp eax, 1
    jl .invalid_second_num_gcf
    cmp eax, 99
    jg .invalid_second_num_gcf

    ; Calculate the GCD using a function
    push dword [firstnum]
    push dword [secondnum]
    call _gcd
    add esp, 8

    ; Display the result
    push eax
    push result_gcf
    call _printf
    add esp, 8
    jmp .choice_loop

.invalid_first_num_lcd:
    ; print error message for lcd
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .get_first_num_lcd

.invalid_second_num_lcd:
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .get_second_num_lcd

.invalid_first_num_gcf:
    ; print error message for gcf
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .get_first_num_gcf

.invalid_second_num_gcf:
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .get_second_num_gcf