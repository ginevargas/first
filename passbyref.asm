; CS 318 – Architecture and Organization
; BSCS 3A
; Group 8
; GROUP MEMBERS: Braga, Angelika V. 
;				 Labios, Justine D.
;		         Vargas, Regine B.

; Structured Assembly Language Part 2 – Modular Programming   
; This is an Assembly programs that implements pass-by-reference to determine the LCD or GCF of two-digit numbers.
 
section .data
    ; Prompt for the program
    promptMsg db 'Hi! This is Group 8 and I am here to help you determine the LCD and GCF for two-digit numbers (1 to 99).', 10, 0
    promptBy db '==== LCD and GCF CALCULATOR by Group 8 ====', 10, 0
    promptExit db '[0] Exit', 10, 0 
    promptLcd db '[1] LCD', 10, 0
    promptGcf db '[2] GCF', 10, 0

    enterChoice db 'Enter choice: ', 0   
    input_choice db '%d', 0
 
    prompt_lcd db '==== LCD ====', 10, 0      ; Operation-specific prompts
    prompt_gcf db '==== GCF ====', 10, 0

    firstNum db 'Enter the first number: ', 0       ; User input prompts
	secondNum db 'Enter the second number: ', 0
    input_numbers db '%d', 0 

    ; Results and message
    result_lcd db 'LCD: %d',10, 0 
    result_gcf db 'GCF: %d',10, 0
    thank_you_msg db 'Thank you!', 10, 0

section .bss
    ; Buffer for user input
    choices resd 1
    firstnum resd 1
    secondnum resd 1
    lcd_result resd 1
    gcf_result resd 1

section .text 
    global _main
    extern _printf
    extern _scanf
    extern _exit

; Calculate the GCD (Greatest Common Divisor) 
gcd:
    push ebp
    mov ebp, esp
    mov eax, [firstnum]  ; First number
    mov ebx, [secondnum]  ; Second number

    .gcd_loop:
        cmp ebx, 0
        je .gcd_done
        xor edx, edx
        div ebx
        mov eax, ebx
        mov ebx, edx
        jmp .gcd_loop

    .gcd_done:
    mov [lcd_result], eax  ; LCD Result store in eax
    mov [gcf_result], eax  ; GCF Result store in eax
    pop ebp
    ret

; Function to calculate LCD
calculate_lcd:
    push dword [firstnum]
    push dword [secondnum]
    call gcd

    pop ebx
    pop eax
    imul eax, ebx               ; Multiply the numbers
    idiv dword [lcd_result]     ; Divide by the GCD result

    ; Display the result
    push eax
    push result_lcd
    call _printf
    add esp, 8
    jmp choice_loop

; Function to calculate GCF
calculate_gcf:
    push dword [firstnum]
    push dword [secondnum]
    call gcd

    ; Display the result
    push dword [gcf_result]
    push result_gcf
    call _printf
    add esp, 8
    jmp choice_loop
 
_main:
    ; Display the introduction message
    push promptMsg       
    call _printf
    add esp, 4

    ; The program loops
choice_loop: 
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
    cmp eax, 1    ; LCD
    je .lcd
    cmp eax, 2    ; GCF
    je .gcf
    cmp eax, 0    ; Exit
    je .exit
    
    ; Invalid choice, display a message and loop again
    push invalid_choice_msg
    call _printf
    add esp, 4
    jmp .enter_choice    ; ask the user to "Enter choice:" again
    jmp choice_loop

.exit:      ; Display a thank-you message and exit the program
    push thank_you_msg
    call _printf
    add esp, 4
    call _exit

.lcd:
    push prompt_lcd     ; Display the LCD prompt
    call _printf
    add esp, 4

    .read_first_num_lcd:   ; Prompt the user for the first number
        push firstNum
        call _printf
        add esp, 4

        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, 1
        jl .invalid_first_num_lcd
        cmp eax, 99
        jg .invalid_first_num_lcd

    .read_second_num_lcd:   ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4

        push secondnum
        push input_numbers
        call _scanf
        add esp, 8
        
        ; Check if the second number is within the valid range
        mov eax, [secondnum] 
        cmp eax, 1
        jl .invalid_second_num_lcd
        cmp eax, 99
        jg .invalid_second_num_lcd
    
        ; Call the function to calculate the LCD
        jmp calculate_lcd    

.gcf:
    push prompt_gcf
    call _printf
    add esp, 4

    .read_first_num_gcf:    ; Prompt the user for the first number
        push firstNum
        call _printf
        add esp, 4

        push firstnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the first number is within the valid range
        mov eax, [firstnum]
        cmp eax, 1
        jl .invalid_first_num_gcf
        cmp eax, 99
        jg .invalid_first_num_gcf

    .read_second_num_gcf:     ; Prompt the user for the second number
        push secondNum
        call _printf
        add esp, 4

        push secondnum
        push input_numbers
        call _scanf
        add esp, 8

        ; Check if the second number is within the valid range
        mov eax, [secondnum]
        cmp eax, 1
        jl .invalid_second_num_gcf
        cmp eax, 99
        jg .invalid_second_num_gcf

        ; Call the function to calculate the GCF
        jmp calculate_gcf


.invalid_first_num_lcd:       ; print error message for lcd
	push prompt_invalid_input
	call _printf
	add	esp, 4
	jmp .read_first_num_lcd

.invalid_second_num_lcd:           
	push prompt_invalid_input
	call _printf
	add	esp, 4
	jmp .read_second_num_lcd

.invalid_first_num_gcf:    ; print error message for gcf
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_first_num_gcf

.invalid_second_num_gcf:     
    push prompt_invalid_input
    call _printf
    add esp, 4
    jmp .read_second_num_gcf

; Error prompts
invalid_choice_msg:
    db 'Entered Choice is not on the menu. Please enter a valid choice', 10, 0
prompt_invalid_input:
	db 'Input should only be between 1 to 99. Please enter again a valid input', 10, 0